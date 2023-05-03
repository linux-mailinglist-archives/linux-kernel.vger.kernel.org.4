Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044EE6F589D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjECNJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjECNJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:09:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09ED4EEB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:09:54 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QBHHx2dhYz18Kpg;
        Wed,  3 May 2023 21:05:49 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 21:09:50 +0800
Subject: Re: [PATCH 1/4] mtd: ubi: block: don't return on error when removing
To:     Daniel Golle <daniel@makrotopia.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <cover.1683043928.git.daniel@makrotopia.org>
 <4bca8ffa66fa094da37625e66f3a2681058531d6.1683043928.git.daniel@makrotopia.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <89f2a4a9-6054-80a8-285f-2be6c57c299d@huawei.com>
Date:   Wed, 3 May 2023 21:09:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4bca8ffa66fa094da37625e66f3a2681058531d6.1683043928.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/5/3 0:48, Daniel Golle Ð´µÀ:
> There is no point on returning the error from ubiblock_remove in case
> it is being called due to a volume removal event -- the volume is gone,
> we should destroy and remove the ubiblock device no matter what.
> 
> Introduce a new boolean parameter 'force' to tell ubiblock_remove to go
> on even in case the ubiblock device is still busy. Use that new option
> when calling ubiblock_remove due to a UBI_VOLUME_REMOVED event.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/mtd/ubi/block.c | 6 +++---
>   drivers/mtd/ubi/cdev.c  | 2 +-
>   drivers/mtd/ubi/ubi.h   | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index 3711d7f746003..6f5804f4b8f55 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -457,7 +457,7 @@ static void ubiblock_cleanup(struct ubiblock *dev)
>   	idr_remove(&ubiblock_minor_idr, dev->gd->first_minor);
>   }
>   
> -int ubiblock_remove(struct ubi_volume_info *vi)
> +int ubiblock_remove(struct ubi_volume_info *vi, bool force)
>   {
>   	struct ubiblock *dev;
>   	int ret;
> @@ -471,7 +471,7 @@ int ubiblock_remove(struct ubi_volume_info *vi)
>   
>   	/* Found a device, let's lock it so we can check if it's busy */
>   	mutex_lock(&dev->dev_mutex);
> -	if (dev->refcnt > 0) {
> +	if (dev->refcnt > 0 && !force) {
>   		ret = -EBUSY;
>   		goto out_unlock_dev;
>   	}

After looking through this series, I think we should pay attention to 
one problem: The lifetime of mtd device and ubi things(ubi 
device/volume/block device). It's difficult to decide whether or not to 
destroy ubi things when mtd driver is removed.
If we destroy ubi things, one application may have opened an ubi volume 
early, then ubi device and all its volumes are destroyed by 
ubi_notify_remove(), later volume accessing by the application will 
trigger an UAF problem in kernel.
       App              driver_remove
fd = ubi_open_volume
                    ubi_notify_remove
                     ubi_detach_mtd_dev
                      vfree(ubi->vtbl)
ioctl(fd, UBI_IOCVOLUP)
  ubi_start_update
   set_update_marker
    vtbl_rec = ubi->vtbl[vol->vol_id]  // UAF!

If we reserve ubi things even mtd driver is removed. There exists mtd 
drivers releasing mtd device (eg. phram_remove), then upper application 
could accessing released mtd device by the ubi device, which also 
triggers UAF in kernel.

After looking at nvme_free_ctrl, I found that nvme_dev is released when 
device refcnt becomes zero, so block device and nvme_dev won't be freed 
immediately when pci driver removed if upper filesystem being mounted on 
nvme device. And the mtd device's refcnt is held by ubi too, we may 
follow this method, but investigating all mtd drivers looks like 
unrealistic.

> @@ -546,7 +546,7 @@ static int ubiblock_notify(struct notifier_block *nb,
>   		 */
>   		break;
>   	case UBI_VOLUME_REMOVED:
> -		ubiblock_remove(&nt->vi);
> +		ubiblock_remove(&nt->vi, true);
>   		break;
>   	case UBI_VOLUME_RESIZED:
>   		ubiblock_resize(&nt->vi);
> diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
> index f43430b9c1e65..bb55e863dd296 100644
> --- a/drivers/mtd/ubi/cdev.c
> +++ b/drivers/mtd/ubi/cdev.c
> @@ -572,7 +572,7 @@ static long vol_cdev_ioctl(struct file *file, unsigned int cmd,
>   		struct ubi_volume_info vi;
>   
>   		ubi_get_volume_info(desc, &vi);
> -		err = ubiblock_remove(&vi);
> +		err = ubiblock_remove(&vi, false);
>   		break;
>   	}
>   
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index c8f1bd4fa1008..44c0eeaf1e1b0 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -979,7 +979,7 @@ static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
>   int ubiblock_init(void);
>   void ubiblock_exit(void);
>   int ubiblock_create(struct ubi_volume_info *vi);
> -int ubiblock_remove(struct ubi_volume_info *vi);
> +int ubiblock_remove(struct ubi_volume_info *vi, bool force);
>   #else
>   static inline int ubiblock_init(void) { return 0; }
>   static inline void ubiblock_exit(void) {}
> @@ -987,7 +987,7 @@ static inline int ubiblock_create(struct ubi_volume_info *vi)
>   {
>   	return -ENOSYS;
>   }
> -static inline int ubiblock_remove(struct ubi_volume_info *vi)
> +static inline int ubiblock_remove(struct ubi_volume_info *vi, bool force)
>   {
>   	return -ENOSYS;
>   }
> 

