Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51C56B2F81
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCIVXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCIVXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:23:32 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7212822D;
        Thu,  9 Mar 2023 13:23:29 -0800 (PST)
Date:   Thu, 9 Mar 2023 21:23:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678397007;
        bh=GrC8UO3MRO30WqZh4ZE+sZ9XOWxhBf0m/DVAmL383do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZS/IytsmBRrdRPyl0/XQIXpPeTiDVVSZd9Q8ktF3hlkmO/sBf//twEb9jfEj7fOFm
         sETwZfYT1VjFEsEkWlX6de5LwCI+GwP9cyJfQwmtC09GI6AqRBeBRuk+mzQOM/kZIH
         tWsYO0rnXinCh75xRsx1Ll5Rwbi6IQtJW1kzpve8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] block: don't embed integrity_kobj into gendisk
Message-ID: <0ac9777c-7586-494f-bbc5-87f14f645b12@t-8ch.de>
References: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
 <d85ba503-d93c-3483-25e1-6043d4af444f@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d85ba503-d93c-3483-25e1-6043d4af444f@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Andy

Answer below.

On Thu, Mar 09, 2023 at 10:05:32PM +0100, Mirsad Goran Todorovac wrote:
> On 09. 03. 2023. 21:23, Thomas Weißschuh wrote:
> > A struct kobject is only supposed to be embedded into objects which
> > lifetime it will manage.
> > Objects of type struct gendisk however are refcounted by their part0
> > block_device.
> > Therefore the integrity_kobj should not be embedded but split into its
> > own independently managed object.
> > 
> > This will also provide a proper .release function for the ktype which
> > avoid warnings like the following:
> > kobject: 'integrity' (000000005198bea8): does not have a release() function, it is broken and must be fixed.
> > 
> > While modifying blk_integrity_del() also drop the explicit call to
> > kobject_uevent(KOBJ_REMOVE) as the driver care will do this
> > automatically.
> > 
> > Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> > Link: https://lore.kernel.org/lkml/60b2b66c-22c9-1d38-ed1c-7b7d95e32720@alu.unizg.hr/
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  block/blk-integrity.c  | 32 ++++++++++++++++++++++++--------
> >  include/linux/blkdev.h |  2 +-
> >  2 files changed, 25 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> > index 8f01d786f5cb..40adf33f5535 100644
> > --- a/block/blk-integrity.c
> > +++ b/block/blk-integrity.c
> > @@ -218,10 +218,15 @@ struct integrity_sysfs_entry {
> >  	ssize_t (*store)(struct blk_integrity *, const char *, size_t);
> >  };
> >  
> > +static inline struct gendisk *integrity_kobj_to_disk(struct kobject *kobj)
> > +{
> > +	return dev_to_disk(kobj_to_dev(kobj->parent));
> > +}
> > +
> >  static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
> >  				   char *page)
> >  {
> > -	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
> > +	struct gendisk *disk = integrity_kobj_to_disk(kobj);
> >  	struct blk_integrity *bi = &disk->queue->integrity;
> >  	struct integrity_sysfs_entry *entry =
> >  		container_of(attr, struct integrity_sysfs_entry, attr);
> > @@ -233,7 +238,7 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
> >  				    struct attribute *attr, const char *page,
> >  				    size_t count)
> >  {
> > -	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
> > +	struct gendisk *disk = integrity_kobj_to_disk(kobj);
> >  	struct blk_integrity *bi = &disk->queue->integrity;
> >  	struct integrity_sysfs_entry *entry =
> >  		container_of(attr, struct integrity_sysfs_entry, attr);
> > @@ -356,9 +361,15 @@ static const struct sysfs_ops integrity_ops = {
> >  	.store	= &integrity_attr_store,
> >  };
> >  
> > +static void integrity_release(struct kobject *kobj)
> > +{
> > +	kfree(kobj);
> > +}
> > +
> >  static const struct kobj_type integrity_ktype = {
> >  	.default_groups = integrity_groups,
> >  	.sysfs_ops	= &integrity_ops,
> > +	.release        = integrity_release,
> >  };
> >  
> >  static blk_status_t blk_integrity_nop_fn(struct blk_integrity_iter *iter)
> > @@ -442,16 +453,21 @@ int blk_integrity_add(struct gendisk *disk)
> >  {
> >  	int ret;
> >  
> > -	ret = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
> > +	disk->integrity_kobj = kmalloc(sizeof(*disk->integrity_kobj), GFP_KERNEL);
> > +	if (!disk->integrity_kobj)
> > +		return -ENOMEM;
> > +
> > +	ret = kobject_init_and_add(disk->integrity_kobj, &integrity_ktype,
> >  				   &disk_to_dev(disk)->kobj, "%s", "integrity");
> > -	if (!ret)
> > -		kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
> > +	if (ret)
> > +		kobject_put(disk->integrity_kobj);
> > +	else
> > +		kobject_uevent(disk->integrity_kobj, KOBJ_ADD);
> > +
> >  	return ret;
> >  }
> >  
> >  void blk_integrity_del(struct gendisk *disk)
> >  {
> > -	kobject_uevent(&disk->integrity_kobj, KOBJ_REMOVE);
> > -	kobject_del(&disk->integrity_kobj);
> > -	kobject_put(&disk->integrity_kobj);
> > +	kobject_put(disk->integrity_kobj);
> >  }
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index d1aee08f8c18..2fbfb3277a2b 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -164,7 +164,7 @@ struct gendisk {
> >  	atomic_t sync_io;		/* RAID */
> >  	struct disk_events *ev;
> >  #ifdef  CONFIG_BLK_DEV_INTEGRITY
> > -	struct kobject integrity_kobj;
> > +	struct kobject *integrity_kobj;
> >  #endif	/* CONFIG_BLK_DEV_INTEGRITY */
> >  
> >  #ifdef CONFIG_BLK_DEV_ZONED
> > 
> > ---
> > base-commit: 44889ba56cbb3d51154660ccd15818bc77276696
> > change-id: 20230309-kobj_release-gendisk_integrity-e26c0bc126aa
> > 
> > Best regards,
> 
> Hello Thomas,
> 
> Thank you for Cc:-ing me on this.
> 
> The patch applied successfully against 6.3-rc1 commit 44889ba56cbb Merge tag 'net-6.3-rc2'
> and I'm just in a build with
> 
> CONFIG_DEBUG_KOBJECT=y
> CONFIG_DEBUG_KOBJECT_RELEASE=y
> 
> However, I can see remotely whether the kernel is operating, but not these special messages
> that are emitted past rsyslog's end of lifetime. It looks like it will require physical
> access to the box tomorrow morning, Lord willing.
> 
> I hate to object to your solution, still, I fail to see how it releases 
> 
> security/integrity/iint.c:
> 175 static int __init integrity_iintcache_init(void)
> 176 {
> 177         iint_cache =
> 178             kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
> 179                               0, SLAB_PANIC, init_once);
> 180         return 0;
> 181 }
> 182 DEFINE_LSM(integrity) = {
> 183         .name = "integrity",
> 184         .init = integrity_iintcache_init,
> 185 };
> 
> It is declared here:
> 
> 26 static struct kmem_cache *iint_cache __read_mostly;
> 
> so it ought to be kmem_cache_destroy()-ed from this module, unless there is something that
> is not obvious nor transparent.
> 
> Can you help me see what I'm doing wrong?

I think this has nothing to do with security/integrity/iint.c.

Instead the problem are these snippets from block/blk-integrity.c:

/* line 359: kobj_type without .release */
static const struct kobj_type integrity_ktype = {
	.default_groups = integrity_groups,
	.sysfs_ops	= &integrity_ops,
};

/* line 445: registration of kobject "integrity" with that type */
ret = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
			   &disk_to_dev(disk)->kobj, "%s", "integrity");

These kobjects represent the directories /sys/block/*/integrity/.

The patch below can be used to easily diagnose this during kobject
initialization instead of cleanup, which seems much more useful.

It probably makes sense to move the
pr_debug("does not have a release() function");
to kobject_init() in general.

diff --git a/lib/kobject.c b/lib/kobject.c
index 6e2f0bee3560..2708f8344e9b 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -341,6 +341,8 @@ void kobject_init(struct kobject *kobj, const struct kobj_type *ktype)
 		dump_stack();
 	}
 
+	WARN(!ktype->release, "KOBJECT %p, %p: no release function\n", kobj, ktype);
+
 	kobject_init_internal(kobj);
 	kobj->ktype = ktype;
 	return;
