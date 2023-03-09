Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A924C6B2F3C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCIVFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCIVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:05:41 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A92F7EDD;
        Thu,  9 Mar 2023 13:05:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 990F3604FA;
        Thu,  9 Mar 2023 22:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678395936; bh=qQPbkr5OXoSZCu1Cm9eaL2wmT8GuciMElwAaQGa+yK8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n9Fy91zG0amZ0tSOOJQyg587k3v6bpCv7FE8YxUZhc1+uXWKcKqX7jr3tm4M+8mtX
         lK78cjAXjH4aZ63Auc7licef7kKx2IjNS0wVHBPhym7w87tHwivRSat40bcNJbjX4p
         jk8p6RQLIZsRCcRQFosmQ+TcUaX/HWt2EBYW8vASkXs32KKWygRJ/UX1s8bt8EXGQS
         O/chsJHf7JddKbCgb9PUz2ibIsZd4zad/DkfAmzd008MHiSft0TZ9p17o9EvJtaB4p
         MFHhEGOyh6oAFIDtKzNkHpicUfqPkuTQbINuaHzLe/nrYkvdkIR1j1thoKbHW7qVvW
         KOSAsvITN06tA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GxgLvk3dFiYw; Thu,  9 Mar 2023 22:05:33 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id 417FE604F9;
        Thu,  9 Mar 2023 22:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678395933; bh=qQPbkr5OXoSZCu1Cm9eaL2wmT8GuciMElwAaQGa+yK8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qw3X4TJClqf0E5plN1fsNSobqK+IXK1L7QzygNFhoyvYCLn8YsehOFJs4Ksie6v/4
         6q7uT14rUtfY9wEYkX4fQ3gtUfXbQrO32Fpik81myyMd573vq1y7IVFAN6ozOKkCKo
         eRzXcPf8y+utdW/qXv2Z5iSCfAl5h/xZJ7pW6yupFq8mm1di8R6JQarl2NFMh19FAh
         1HvSPJpUQcgyKloFnXW2H2FACPQKctrBCfxaJC5MY+jiRYm3eLctk1G4J6PUXW1H/3
         4qsk5uS+sqYJHh8SIIDUdHFVm+AZ1nBXR3h0Nc90QhTUMRaKYNByb+KpJ4RGGQCSbR
         6v84BD5MkoRDw==
Message-ID: <d85ba503-d93c-3483-25e1-6043d4af444f@alu.unizg.hr>
Date:   Thu, 9 Mar 2023 22:05:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] block: don't embed integrity_kobj into gendisk
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 03. 2023. 21:23, Thomas Weißschuh wrote:
> A struct kobject is only supposed to be embedded into objects which
> lifetime it will manage.
> Objects of type struct gendisk however are refcounted by their part0
> block_device.
> Therefore the integrity_kobj should not be embedded but split into its
> own independently managed object.
> 
> This will also provide a proper .release function for the ktype which
> avoid warnings like the following:
> kobject: 'integrity' (000000005198bea8): does not have a release() function, it is broken and must be fixed.
> 
> While modifying blk_integrity_del() also drop the explicit call to
> kobject_uevent(KOBJ_REMOVE) as the driver care will do this
> automatically.
> 
> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Link: https://lore.kernel.org/lkml/60b2b66c-22c9-1d38-ed1c-7b7d95e32720@alu.unizg.hr/
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  block/blk-integrity.c  | 32 ++++++++++++++++++++++++--------
>  include/linux/blkdev.h |  2 +-
>  2 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index 8f01d786f5cb..40adf33f5535 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -218,10 +218,15 @@ struct integrity_sysfs_entry {
>  	ssize_t (*store)(struct blk_integrity *, const char *, size_t);
>  };
>  
> +static inline struct gendisk *integrity_kobj_to_disk(struct kobject *kobj)
> +{
> +	return dev_to_disk(kobj_to_dev(kobj->parent));
> +}
> +
>  static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
>  				   char *page)
>  {
> -	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
> +	struct gendisk *disk = integrity_kobj_to_disk(kobj);
>  	struct blk_integrity *bi = &disk->queue->integrity;
>  	struct integrity_sysfs_entry *entry =
>  		container_of(attr, struct integrity_sysfs_entry, attr);
> @@ -233,7 +238,7 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
>  				    struct attribute *attr, const char *page,
>  				    size_t count)
>  {
> -	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
> +	struct gendisk *disk = integrity_kobj_to_disk(kobj);
>  	struct blk_integrity *bi = &disk->queue->integrity;
>  	struct integrity_sysfs_entry *entry =
>  		container_of(attr, struct integrity_sysfs_entry, attr);
> @@ -356,9 +361,15 @@ static const struct sysfs_ops integrity_ops = {
>  	.store	= &integrity_attr_store,
>  };
>  
> +static void integrity_release(struct kobject *kobj)
> +{
> +	kfree(kobj);
> +}
> +
>  static const struct kobj_type integrity_ktype = {
>  	.default_groups = integrity_groups,
>  	.sysfs_ops	= &integrity_ops,
> +	.release        = integrity_release,
>  };
>  
>  static blk_status_t blk_integrity_nop_fn(struct blk_integrity_iter *iter)
> @@ -442,16 +453,21 @@ int blk_integrity_add(struct gendisk *disk)
>  {
>  	int ret;
>  
> -	ret = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
> +	disk->integrity_kobj = kmalloc(sizeof(*disk->integrity_kobj), GFP_KERNEL);
> +	if (!disk->integrity_kobj)
> +		return -ENOMEM;
> +
> +	ret = kobject_init_and_add(disk->integrity_kobj, &integrity_ktype,
>  				   &disk_to_dev(disk)->kobj, "%s", "integrity");
> -	if (!ret)
> -		kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
> +	if (ret)
> +		kobject_put(disk->integrity_kobj);
> +	else
> +		kobject_uevent(disk->integrity_kobj, KOBJ_ADD);
> +
>  	return ret;
>  }
>  
>  void blk_integrity_del(struct gendisk *disk)
>  {
> -	kobject_uevent(&disk->integrity_kobj, KOBJ_REMOVE);
> -	kobject_del(&disk->integrity_kobj);
> -	kobject_put(&disk->integrity_kobj);
> +	kobject_put(disk->integrity_kobj);
>  }
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d1aee08f8c18..2fbfb3277a2b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -164,7 +164,7 @@ struct gendisk {
>  	atomic_t sync_io;		/* RAID */
>  	struct disk_events *ev;
>  #ifdef  CONFIG_BLK_DEV_INTEGRITY
> -	struct kobject integrity_kobj;
> +	struct kobject *integrity_kobj;
>  #endif	/* CONFIG_BLK_DEV_INTEGRITY */
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> 
> ---
> base-commit: 44889ba56cbb3d51154660ccd15818bc77276696
> change-id: 20230309-kobj_release-gendisk_integrity-e26c0bc126aa
> 
> Best regards,

Hello Thomas,

Thank you for Cc:-ing me on this.

The patch applied successfully against 6.3-rc1 commit 44889ba56cbb Merge tag 'net-6.3-rc2'
and I'm just in a build with

CONFIG_DEBUG_KOBJECT=y
CONFIG_DEBUG_KOBJECT_RELEASE=y

However, I can see remotely whether the kernel is operating, but not these special messages
that are emitted past rsyslog's end of lifetime. It looks like it will require physical
access to the box tomorrow morning, Lord willing.

I hate to object to your solution, still, I fail to see how it releases 

security/integrity/iint.c:
175 static int __init integrity_iintcache_init(void)
176 {
177         iint_cache =
178             kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
179                               0, SLAB_PANIC, init_once);
180         return 0;
181 }
182 DEFINE_LSM(integrity) = {
183         .name = "integrity",
184         .init = integrity_iintcache_init,
185 };

It is declared here:

26 static struct kmem_cache *iint_cache __read_mostly;

so it ought to be kmem_cache_destroy()-ed from this module, unless there is something that
is not obvious nor transparent.

Can you help me see what I'm doing wrong?

(Many thanks to Mr. Andy Schevchenko from Intel who narrowed the search for the bug to
security/integrity/iint.c.)

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

