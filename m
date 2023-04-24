Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40FB6ECCA1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjDXNIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXNIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:08:19 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B476149DD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:08:09 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pqvv9-00024Z-1L;
        Mon, 24 Apr 2023 15:07:55 +0200
Date:   Mon, 24 Apr 2023 14:06:08 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] mtd: ubi: attach MTD partition from device-tree
Message-ID: <ZEZ-wLMxJvDAqrx6@makrotopia.org>
References: <ZEA8hX9UjX9S0NUm@makrotopia.org>
 <9c622f92-382d-8b0d-a438-c7eea0e89b80@huawei.com>
 <ZEW8VS4Y-dVRcGGy@makrotopia.org>
 <f50a0d60-356a-6206-3363-e0f80870c754@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f50a0d60-356a-6206-3363-e0f80870c754@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 11:26:13AM +0800, Zhihao Cheng wrote:
> 在 2023/4/24 7:16, Daniel Golle 写道:
> > Hi Zhihao,
> > 
> > thank you for taking the time to review this patch.
> > 
> > On Sun, Apr 23, 2023 at 04:35:28PM +0800, Zhihao Cheng wrote:
> > > Hi Daniel,
> > > > Split ubi_init() function into early function to be called by
> > > > device_initcall() and keep cmdline attachment in late_initcall().
> > > > (when building ubi as module, both is still done in a single
> > > > module_init() call)
> > > > 
> > > > Register MTD notifier and attach MTD devices which are marked as
> > > > compatible with 'linux,ubi' in OF device-tree when being added, detach
> > > > UBI device from MTD device when it is being removed.
> > > > 
> > > > Keep behavior regarding ubiblock creation and attaching of UBI device
> > > > from kernel or module cmdline unchanged.
> > > > 
> > > > For existing users this should not change anything besides automatic
> > > > removal of (dead) UBI devices when their underlying MTD devices are
> > > > already gone, e.g. in case of MTD driver module or (SPI) bus driver
> > > > module being removed.
> > > > 
> > > > For new users this opens up the option to attach UBI using device-tree
> > > > which then happens early and in parallel with other drivers being
> > > > probed which slightly reduces the total boot time.
> > > > 
> > > > Attachment no longer happening late is also a requirement for other
> > > > drivers to make use of UBI, e.g. drivers/nvmem/u-boot-env.c can now
> > > > be extended to support U-Boot environment stored in UBI volumes.
> > > > 
> > > 
> > > Let me try to understand this patch, the main purpose is to add a new way to
> > > load ubi according to device tree, am I right?
> > 
> > You are right about one aspect of this patch, yes it does add another
> > way to attach MTD devices, by utilizing a devicetree compatible
> > 'linux,ubi' which can be set for MTD devices (or partitions).
> > The other, and maybe even more significant aspect is that it moves
> > attaching the MTD device from being a late_initcall() to rather register
> > an MTD user driver instead and hence happen as a direct consequence of
> > the MTD device showing up.
> 
> It means mtd device probing and loading will autimically triggers ubi
> attaching by ubi_notify_add(), right?
> If so, I thought of a scenario like this: The mtd device probing/removing
> will autimically loading/removing UBI device, now it can be done without any
> orders(cmdlines/ioctl) in running time. I think it's valuable.
> 
> > This will be important when using UBI e.g. as an NVMEM provider:
> > E.g. on Wi-Fi routers it has become common for vendors to store the
> > bootloader environment, Ethernet MAC addresses or Wi-Fi calibration
> > data inside an UBI volume (and I don't mean as a file inside a
> > filesystem, but really just the UBI volume exposing nvmem cells for
> > other drivers). See [1] for an example.
> > 
> 
> Thanks for introducing the background.
> 
> > > 
> > > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > > ---
> > > >    drivers/mtd/ubi/block.c |  20 ++---
> > > >    drivers/mtd/ubi/build.c | 163 +++++++++++++++++++++++++++++-----------
> > > >    drivers/mtd/ubi/cdev.c  |   2 +-
> > > >    drivers/mtd/ubi/ubi.h   |   4 +-
> > > >    4 files changed, 132 insertions(+), 57 deletions(-)
> > > > 
> > > > diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> > > > index 3711d7f746003..b24b8b8f54b77 100644
> > > > --- a/drivers/mtd/ubi/block.c
> > > > +++ b/drivers/mtd/ubi/block.c
> > > > @@ -65,10 +65,10 @@ struct ubiblock_pdu {
> > > >    };
> > > >    /* Numbers of elements set in the @ubiblock_param array */
> > > > -static int ubiblock_devs __initdata;
> > > > +static int ubiblock_devs;
> > > >    /* MTD devices specification parameters */
> > > > -static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES] __initdata;
> > > > +static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES];
> > > >    struct ubiblock {
> > > >    	struct ubi_volume_desc *desc;
> > > > @@ -582,7 +582,7 @@ open_volume_desc(const char *name, int ubi_num, int vol_id)
> > > >    		return ubi_open_volume(ubi_num, vol_id, UBI_READONLY);
> > > >    }
> > > > -static void __init ubiblock_create_from_param(void)
> > > > +void ubiblock_create_from_param(void)
> > > >    {
> > > >    	int i, ret = 0;
> > > >    	struct ubiblock_param *p;
> > > > @@ -611,9 +611,10 @@ static void __init ubiblock_create_from_param(void)
> > > >    		ret = ubiblock_create(&vi);
> > > >    		if (ret) {
> > > > -			pr_err(
> > > > -			       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
> > > > -			       vi.name, p->ubi_num, p->vol_id, ret);
> > > > +			if (ret != -EEXIST && ret != -ENOENT)
> > > 
> > > The EEXIST and ENOENT types of error messages are filtered, why? After this
> > > patch applied, the user won't be aware of which ubi volume failed to create
> > > ubiblock.
> > 
> > The EEXIST and ENOENT errors as filtered as they may happen now without
> > that actually being an error.
> > ubiblock_create_from_param is potentially being called multiple times,
> > each time a new UBI device is attached in the "new" MTD user/device-tree
> > way, and also once in "classic" late_initcall way.
> > 
> 
> I agree, the second caller could trigger EEXIST. But how ENOENT happens, do
> you mean ubi_notify_add->ubiblock_create_from_param->open_volume_desc? Could
> you show me path?

You are right, EEXIST will actually never happen. If at all then we
should check if open_volume_desc returns ERR_PTR(-ENODEV).
However, we can never know if the UBI device containing the volume we want to
have exposed as ubiblock device is still going to be added later when the
driver module for the MTD device is loaded. Hence I suggest to simply
not call pr_err(...) in case open_volume_desc returns ERR_PTR(-ENODEV)
as well as for the case that ubiblock_create returns -EEXIST.
 
> > One way to partially resolve this could be to add a boolean parameter to
> > ubiblock_create_from_param which indicates if -ENOENT should be treated
> > as an error, and set that parameter only when calling from
> > late_initcall.
> > 
> > Being able to warn users if they added the same ubiblock device more
> > than once **on the cmdline or module parameter** is more tricky and
> > would require tracking why a ubiblock device has previously been
> > created. However, I don't think that emitting a warning in this case
> > is crucial at all, the user definitely wanted the ubiblock device to be
> > created and saying that more than once is unneccesary but yet also
> > doesn't leave room for any interpretation other than just that the user
> > *really* wants the ubiblock to be created.
> 
> Emm, I prefer to fix it, it's weird that ubiblock_create_from_param() being
> executed multiple times(Each ubi_notify_add() will call once, late_initcall
> will call it again). User could see many false positive error messages.

Given my suggestion above (not printing error in case the UBI device or
volume doesn't exist as well as in case in case the ubiblock device has
already been created) there won't be any false positives.
What is still true is that other errors (eg. invalid string format of
the ubiblock parameter) will be printed multiple times.

Do you think it is worth putting much effort into avoiding that?
If so, any idea how?

> 
> > 
> > > 
> > > > +				pr_err(
> > > > +				       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
> > > > +				       vi.name, p->ubi_num, p->vol_id, ret);
> > > >    			continue;
> > > >    		}
> > > >    	}
> > > > @@ -644,13 +645,6 @@ int __init ubiblock_init(void)
> > > >    	if (ubiblock_major < 0)
> > > >    		return ubiblock_major;
> > > > -	/*
> > > > -	 * Attach block devices from 'block=' module param.
> > > > -	 * Even if one block device in the param list fails to come up,
> > > > -	 * still allow the module to load and leave any others up.
> > > > -	 */
> > > > -	ubiblock_create_from_param();
> > > > -
> > > >    	/*
> > > >    	 * Block devices are only created upon user requests, so we ignore
> > > >    	 * existing volumes.
> > > > diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> > > > index 9cd565daad368..a764f97eee791 100644
> > > > --- a/drivers/mtd/ubi/build.c
> > > > +++ b/drivers/mtd/ubi/build.c
> > > > @@ -27,6 +27,7 @@
> > > >    #include <linux/log2.h>
> > > >    #include <linux/kthread.h>
> > > >    #include <linux/kernel.h>
> > > > +#include <linux/of.h>
> > > >    #include <linux/slab.h>
> > > >    #include <linux/major.h>
> > > >    #include "ubi.h"
> > > > @@ -1065,6 +1066,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
> > > >     * ubi_detach_mtd_dev - detach an MTD device.
> > > >     * @ubi_num: UBI device number to detach from
> > > >     * @anyway: detach MTD even if device reference count is not zero
> > > > + * @have_lock: called by MTD notifier holding mtd_table_mutex
> > > >     *
> > > >     * This function destroys an UBI device number @ubi_num and detaches the
> > > >     * underlying MTD device. Returns zero in case of success and %-EBUSY if the
> > > > @@ -1074,7 +1076,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
> > > >     * Note, the invocations of this function has to be serialized by the
> > > >     * @ubi_devices_mutex.
> > > >     */
> > > > -int ubi_detach_mtd_dev(int ubi_num, int anyway)
> > > > +int ubi_detach_mtd_dev(int ubi_num, int anyway, bool have_lock)
> > > >    {
> > > >    	struct ubi_device *ubi;
> > > > @@ -1108,7 +1110,7 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
> > > >    	 * EC updates that have been made since the last written fastmap.
> > > >    	 * In case of fastmap debugging we omit the update to simulate an
> > > >    	 * unclean shutdown. */
> > > > -	if (!ubi_dbg_chk_fastmap(ubi))
> > > > +	if (!have_lock && !ubi_dbg_chk_fastmap(ubi))
> > > >    		ubi_update_fastmap(ubi);
> > > 
> > > Why do you skip updating fastmap if ubi is detached in mtd notification way?
> > 
> > The reason here is simple: Once we receive a notification about the MTD
> > device being removed it is too late to update fastmap. The device is
> > gone, nothing we can do about that any more. Just like removing a
> > device holding a filesystem without having priorly unmounted it, e.g.
> > if you 'rmmod usb-storage' (just that block devices unfortunately still
> > lack notifications about removal or size changes...)
> > 
> 
> Another path still operate mtd device:
> ubi_detach_mtd_dev -> ubi_wl_close -> shutdown_work -> wrk->func ->
> erase_worker -> sync_erase -> ubi_io_sync_erase/ubi_io_write_ec_hdr.

True, but I didn't see this being a problem, at least in the sense
that I didn't see a kernel panic. We could try to make
ubi_update_fastmap more robust to gracefully return in case the device
is already gone.

> 
> Besides, can we remove any mtd specific driver(eg. phram/nandsim) by rmmod?

My test-case was to remove the SPI bus driver on which the SPI-NAND chip
is connected to. Afaik there is also no way to prevent this at this
point, we'd have to propagate the usecount of the MTD device down to
the SPI bus hosting it.

> I notice that get_mtd_device(called before ubi attaching) will increase
> specific mtd driver's module refcnt.
> If we physically remove the mtd device, will it trigger del_mtd_device()?

Yes, in case what you mean is an SPI-NAND flash connected to an SPI-USB
adapter, and then pulling the USB device.

> For example, when is phram_remove() called?

From what I can see:
phram_remove -> mtd_device_unregister -> del_mtd_device -> [for all
elements of list mtd_notifiers call their 'remove' function]

After this we should always end up with mtd->usecount == 0 and hence
proceed. If usecount != 0 at this point there is currently no meaningful
error handling in mtdcore.c as far as my interpretation goes.

