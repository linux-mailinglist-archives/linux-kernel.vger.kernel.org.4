Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA5170F33F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjEXJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjEXJmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:42:02 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7730FE76
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:41:44 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1q1kzr-00083c-1y;
        Wed, 24 May 2023 09:41:31 +0000
Date:   Wed, 24 May 2023 10:41:24 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/4] mtd: ubi: block: don't return on error when removing
Message-ID: <ZG3bxMFxYM-dfN4r@makrotopia.org>
References: <cover.1683043928.git.daniel@makrotopia.org>
 <4bca8ffa66fa094da37625e66f3a2681058531d6.1683043928.git.daniel@makrotopia.org>
 <89f2a4a9-6054-80a8-285f-2be6c57c299d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89f2a4a9-6054-80a8-285f-2be6c57c299d@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 09:09:49PM +0800, Zhihao Cheng wrote:
> 在 2023/5/3 0:48, Daniel Golle 写道:
> > There is no point on returning the error from ubiblock_remove in case
> > it is being called due to a volume removal event -- the volume is gone,
> > we should destroy and remove the ubiblock device no matter what.
> > 
> > Introduce a new boolean parameter 'force' to tell ubiblock_remove to go
> > on even in case the ubiblock device is still busy. Use that new option
> > when calling ubiblock_remove due to a UBI_VOLUME_REMOVED event.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >   drivers/mtd/ubi/block.c | 6 +++---
> >   drivers/mtd/ubi/cdev.c  | 2 +-
> >   drivers/mtd/ubi/ubi.h   | 4 ++--
> >   3 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> > index 3711d7f746003..6f5804f4b8f55 100644
> > --- a/drivers/mtd/ubi/block.c
> > +++ b/drivers/mtd/ubi/block.c
> > @@ -457,7 +457,7 @@ static void ubiblock_cleanup(struct ubiblock *dev)
> >   	idr_remove(&ubiblock_minor_idr, dev->gd->first_minor);
> >   }
> > -int ubiblock_remove(struct ubi_volume_info *vi)
> > +int ubiblock_remove(struct ubi_volume_info *vi, bool force)
> >   {
> >   	struct ubiblock *dev;
> >   	int ret;
> > @@ -471,7 +471,7 @@ int ubiblock_remove(struct ubi_volume_info *vi)
> >   	/* Found a device, let's lock it so we can check if it's busy */
> >   	mutex_lock(&dev->dev_mutex);
> > -	if (dev->refcnt > 0) {
> > +	if (dev->refcnt > 0 && !force) {
> >   		ret = -EBUSY;
> >   		goto out_unlock_dev;
> >   	}
> 
> After looking through this series, I think we should pay attention to one
> problem: The lifetime of mtd device and ubi things(ubi device/volume/block
> device). It's difficult to decide whether or not to destroy ubi things when
> mtd driver is removed.
> If we destroy ubi things, one application may have opened an ubi volume
> early, then ubi device and all its volumes are destroyed by
> ubi_notify_remove(), later volume accessing by the application will trigger
> an UAF problem in kernel.
>       App              driver_remove
> fd = ubi_open_volume
>                    ubi_notify_remove
>                     ubi_detach_mtd_dev
>                      vfree(ubi->vtbl)
> ioctl(fd, UBI_IOCVOLUP)
>  ubi_start_update
>   set_update_marker
>    vtbl_rec = ubi->vtbl[vol->vol_id]  // UAF!
> 
> If we reserve ubi things even mtd driver is removed. There exists mtd
> drivers releasing mtd device (eg. phram_remove), then upper application
> could accessing released mtd device by the ubi device, which also triggers
> UAF in kernel.

I agree this is a problem, and I also agree it is not a new problem
introduced by this series, but rather already exists in the kernel for
many years.

An idea to get closer to a good state would be to try dropping the
'anyway' parameter from ubi_detach_mtd_dev which is currently only
used in the module_exit. To avoid this, we should make sure the
module's refcnt is increased/decreased together with ubi->ref_count.

When it comes to the to-be-introduced ubi_notify_remove we still
face another problem, see below...

> 
> After looking at nvme_free_ctrl, I found that nvme_dev is released when
> device refcnt becomes zero, so block device and nvme_dev won't be freed
> immediately when pci driver removed if upper filesystem being mounted on
> nvme device. And the mtd device's refcnt is held by ubi too, we may follow
> this method, but investigating all mtd drivers looks like unrealistic.

A good start would be deciding on and defining the way it should be.
I agree with your suggestion above, however, also note that in case of
MTD (in contrast to block devices) we have only a 'remove' notification
call returning void, see include/linux/mtd/mtd.h

struct mtd_notifier {
        void (*add)(struct mtd_info *mtd);
        void (*remove)(struct mtd_info *mtd);
        struct list_head list;
};

Also see del_mtd_device in drivers/mtd/mtdcore.c:
[...]
        /* No need to get a refcount on the module containing
                the notifier, since we hold the mtd_table_mutex */
        list_for_each_entry(not, &mtd_notifiers, list)
                not->remove(mtd);

        if (mtd->usecount) {
                printk(KERN_NOTICE "Removing MTD device #%d (%s) with use count %d\n",
                       mtd->index, mtd->name, mtd->usecount);
                ret = -EBUSY;
        } else {
[...]

So remove is called despite usecount could still be > 0.

Looks a bit like I've opened a can of worms...


> 
> > @@ -546,7 +546,7 @@ static int ubiblock_notify(struct notifier_block *nb,
> >   		 */
> >   		break;
> >   	case UBI_VOLUME_REMOVED:
> > -		ubiblock_remove(&nt->vi);
> > +		ubiblock_remove(&nt->vi, true);
> >   		break;
> >   	case UBI_VOLUME_RESIZED:
> >   		ubiblock_resize(&nt->vi);
> > diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
> > index f43430b9c1e65..bb55e863dd296 100644
> > --- a/drivers/mtd/ubi/cdev.c
> > +++ b/drivers/mtd/ubi/cdev.c
> > @@ -572,7 +572,7 @@ static long vol_cdev_ioctl(struct file *file, unsigned int cmd,
> >   		struct ubi_volume_info vi;
> >   		ubi_get_volume_info(desc, &vi);
> > -		err = ubiblock_remove(&vi);
> > +		err = ubiblock_remove(&vi, false);
> >   		break;
> >   	}
> > diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> > index c8f1bd4fa1008..44c0eeaf1e1b0 100644
> > --- a/drivers/mtd/ubi/ubi.h
> > +++ b/drivers/mtd/ubi/ubi.h
> > @@ -979,7 +979,7 @@ static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
> >   int ubiblock_init(void);
> >   void ubiblock_exit(void);
> >   int ubiblock_create(struct ubi_volume_info *vi);
> > -int ubiblock_remove(struct ubi_volume_info *vi);
> > +int ubiblock_remove(struct ubi_volume_info *vi, bool force);
> >   #else
> >   static inline int ubiblock_init(void) { return 0; }
> >   static inline void ubiblock_exit(void) {}
> > @@ -987,7 +987,7 @@ static inline int ubiblock_create(struct ubi_volume_info *vi)
> >   {
> >   	return -ENOSYS;
> >   }
> > -static inline int ubiblock_remove(struct ubi_volume_info *vi)
> > +static inline int ubiblock_remove(struct ubi_volume_info *vi, bool force)
> >   {
> >   	return -ENOSYS;
> >   }
> > 
> 
