Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780806F6AE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjEDMKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjEDMKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:10:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBF75FC5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:10:08 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QBswV0pM9zpSt7;
        Thu,  4 May 2023 20:06:02 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 20:10:05 +0800
Subject: Re: [PATCH -next,V2 2/2] ubi: Correct the number of PEBs after a
 volume resize failure
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230504025354.3595768-1-wangzhaolong1@huawei.com>
 <20230504025354.3595768-2-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <95408e5b-312c-0b51-e5b4-41fb34f552cd@huawei.com>
Date:   Thu, 4 May 2023 20:10:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230504025354.3595768-2-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/5/4 10:53, ZhaoLong Wang Ð´µÀ:
> In the error handing path `out_acc` of the ubi_resize_volume(),
> when `pebs < 0`, it means that the volume table record fails to be
> updated when the volume is shrinked. In this case, the number of
> ubi->avail_pebs` and `ubi->rsvd_pebs` should also be restored,
> otherwise the UBI will display an incorrect number of available PEBs.
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/vmt.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 97294def01eb..990571287e84 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -515,13 +515,12 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
>   out_acc:
>   	spin_lock(&ubi->volumes_lock);
>   	vol->reserved_pebs = reserved_pebs - pebs;
> -	if (pebs > 0) {
> -		ubi->rsvd_pebs -= pebs;
> -		ubi->avail_pebs += pebs;
> +	ubi->rsvd_pebs -= pebs;
> +	ubi->avail_pebs += pebs;
> +	if (pebs > 0)
>   		ubi_eba_copy_table(vol, old_eba_tbl, vol->reserved_pebs);
> -	} else {
> +	else
>   		ubi_eba_copy_table(vol, old_eba_tbl, reserved_pebs);
> -	}
>   	vol->eba_tbl = old_eba_tbl;
>   	spin_unlock(&ubi->volumes_lock);
>   out_free:
> 

