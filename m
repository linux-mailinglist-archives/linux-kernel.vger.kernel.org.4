Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1B6D96E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbjDFMPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbjDFMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:14:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A614EE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 05:14:55 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PsgMg5Vb1z17MMg;
        Thu,  6 Apr 2023 20:11:27 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Apr 2023 20:14:53 +0800
Subject: Re: [PATCH 1/2] ubi: fix slab-out-of-bounds in
 ubi_eba_get_ldesc+0xfb/0x130
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230406071331.1247429-1-wangzhaolong1@huawei.com>
 <20230406071331.1247429-2-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <cdb047f0-c071-3263-0167-e9bce852b5d5@huawei.com>
Date:   Thu, 6 Apr 2023 20:14:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230406071331.1247429-2-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
> From: Guo Xuenan <guoxuenan@huawei.com>
> 
> When using ioctl interface to resize ubi volume, ubi_resize_volume will
> resize eba table first, but not change vol->reserved_pebs in the same
> atomic context which may cause concurrency access eba table.
> 
> For example, When user do shrink ubi volume A calling ubi_resize_volume,
> while the other thread is writing (volume B) and triggering wear-leveling,
> which may calling ubi_write_fastmap, under these circumstances, KASAN may
> report: slab-out-of-bounds in ubi_eba_get_ldesc+0xfb/0x130.
> 
[...]
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 2c867d16f89f..97294def01eb 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -408,6 +408,7 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
>   	struct ubi_device *ubi = vol->ubi;
>   	struct ubi_vtbl_record vtbl_rec;
>   	struct ubi_eba_table *new_eba_tbl = NULL;
> +	struct ubi_eba_table *old_eba_tbl = NULL;
>   	int vol_id = vol->vol_id;
>   
>   	if (ubi->ro_mode)
> @@ -453,10 +454,13 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
>   			err = -ENOSPC;
>   			goto out_free;
>   		}
> +
>   		ubi->avail_pebs -= pebs;
>   		ubi->rsvd_pebs += pebs;
>   		ubi_eba_copy_table(vol, new_eba_tbl, vol->reserved_pebs);
> -		ubi_eba_replace_table(vol, new_eba_tbl);
> +		old_eba_tbl = vol->eba_tbl;
> +		vol->eba_tbl = new_eba_tbl;
> +		vol->reserved_pebs = reserved_pebs;
>   		spin_unlock(&ubi->volumes_lock);
>   	}
>   
> @@ -471,7 +475,9 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
>   		ubi->avail_pebs -= pebs;
>   		ubi_update_reserved(ubi);
>   		ubi_eba_copy_table(vol, new_eba_tbl, reserved_pebs);
> -		ubi_eba_replace_table(vol, new_eba_tbl);
> +		old_eba_tbl = vol->eba_tbl;
> +		vol->eba_tbl = new_eba_tbl;
> +		vol->reserved_pebs = reserved_pebs;
>   		spin_unlock(&ubi->volumes_lock);
>   	}
>   
> @@ -493,7 +499,6 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
>   	if (err)
>   		goto out_acc;
>   
> -	vol->reserved_pebs = reserved_pebs;
>   	if (vol->vol_type == UBI_DYNAMIC_VOLUME) {
>   		vol->used_ebs = reserved_pebs;
>   		vol->last_eb_bytes = vol->usable_leb_size;
> @@ -501,19 +506,24 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
>   			(long long)vol->used_ebs * vol->usable_leb_size;
>   	}
>   
> +	/* destroy old table */
> +	ubi_eba_destroy_table(old_eba_tbl);
>   	ubi_volume_notify(ubi, vol, UBI_VOLUME_RESIZED);
>   	self_check_volumes(ubi);
>   	return err;
>   
>   out_acc:
> +	spin_lock(&ubi->volumes_lock);
> +	vol->reserved_pebs = reserved_pebs - pebs;
>   	if (pebs > 0) {
> -		spin_lock(&ubi->volumes_lock);
>   		ubi->rsvd_pebs -= pebs;
>   		ubi->avail_pebs += pebs;
> -		spin_unlock(&ubi->volumes_lock);
> +		ubi_eba_copy_table(vol, old_eba_tbl, vol->reserved_pebs);
> +	} else {
> +		ubi_eba_copy_table(vol, old_eba_tbl, reserved_pebs);
>   	}
> -	return err;
> -
> +	vol->eba_tbl = old_eba_tbl;
> +	spin_unlock(&ubi->volumes_lock);
>   out_free:
>   	ubi_eba_destroy_table(new_eba_tbl);
>   	return err;
> 


Besides that, it's better to protect 'vol->eba_tbl->entries' assignment 
like:
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 403b79d6efd5..5ae0c1bc6f41 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -1450,7 +1450,9 @@ int ubi_eba_copy_leb(struct ubi_device *ubi, int 
from, int to,
         }

         ubi_assert(vol->eba_tbl->entries[lnum].pnum == from);
+       spin_lock(&ubi->volumes_lock);
         vol->eba_tbl->entries[lnum].pnum = to;
+       spin_unlock(&ubi->volumes_lock);

  out_unlock_buf:
         mutex_unlock(&ubi->buf_mutex);

Otherwise, a race between wear_leveling_work and shrinking volume could 
happen:

  ubi_resize_volume         wear_leveling_worker
   ubi_eba_copy_table(vol, new_eba_tbl, reserved_pebs);
                               vol->eba_tbl->entries[lnum].pnum = to; // 
update old eba_tbl
   vol->eba_tbl = new_eba_tbl
