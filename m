Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC56867DE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjBAOCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjBAOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:02:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A2A2D4A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:02:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0DCDB821A9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D56C433A8;
        Wed,  1 Feb 2023 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675260164;
        bh=NofUhqlqioT9sJdXMxrnix4dvCF6Bz1MGwAaZI6ykWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oyqet07DyQgt60sBQiAtNfN3RyCqBbUatjQWi66O/nbe5YXTc9KV4gBYAmyFOOPOy
         Ksztp3G/7dFfRTn66TLTMLZSiSv823dqblUUPkHNK80/PyO2o+iiMjhapuic+dfw7k
         P8eUSj71zDT5ikHOdtUd75K+Q08gVR9crQLMNTNs=
Date:   Wed, 1 Feb 2023 15:02:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     laurentiu.tudor@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ioana.ciornei@nxp.com
Subject: Re: [PATCH v2] bus: fsl-mc: don't assume child devices are all
 fsl-mc devices
Message-ID: <Y9pxARNSLHFxhwnL@kroah.com>
References: <20230201135145.18226-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201135145.18226-1-laurentiu.tudor@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 03:51:45PM +0200, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Changes in VFIO caused a pseudo-device to be created as child of
> fsl-mc devices causing a crash [1] when trying to bind a fsl-mc
> device to VFIO. Fix this by checking the device type when enumerating
> fsl-mc child devices.
> 
> [1]
> Modules linked in:
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> CPU: 6 PID: 1289 Comm: sh Not tainted 6.2.0-rc5-00047-g7c46948a6e9c #2
> Hardware name: NXP Layerscape LX2160ARDB (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mc_send_command+0x24/0x1f0
> lr : dprc_get_obj_region+0xfc/0x1c0
> sp : ffff80000a88b900
> x29: ffff80000a88b900 x28: ffff48a9429e1400 x27: 00000000000002b2
> x26: ffff48a9429e1718 x25: 0000000000000000 x24: 0000000000000000
> x23: ffffd59331ba3918 x22: ffffd59331ba3000 x21: 0000000000000000
> x20: ffff80000a88b9b8 x19: 0000000000000000 x18: 0000000000000001
> x17: 7270642f636d2d6c x16: 73662e3030303030 x15: ffffffffffffffff
> x14: ffffd59330f1d668 x13: ffff48a8727dc389 x12: ffff48a8727dc386
> x11: 0000000000000002 x10: 00008ceaf02f35d4 x9 : 0000000000000012
> x8 : 0000000000000000 x7 : 0000000000000006 x6 : ffff80000a88bab0
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80000a88b9e8
> x2 : ffff80000a88b9e8 x1 : 0000000000000000 x0 : ffff48a945142b80
> Call trace:
>  mc_send_command+0x24/0x1f0
>  dprc_get_obj_region+0xfc/0x1c0
>  fsl_mc_device_add+0x340/0x590
>  fsl_mc_obj_device_add+0xd0/0xf8
>  dprc_scan_objects+0x1c4/0x340
>  dprc_scan_container+0x38/0x60
>  vfio_fsl_mc_probe+0x9c/0xf8
>  fsl_mc_driver_probe+0x24/0x70
>  really_probe+0xbc/0x2a8
>  __driver_probe_device+0x78/0xe0
>  device_driver_attach+0x30/0x68
>  bind_store+0xa8/0x130
>  drv_attr_store+0x24/0x38
>  sysfs_kf_write+0x44/0x60
>  kernfs_fop_write_iter+0x128/0x1b8
>  vfs_write+0x334/0x448
>  ksys_write+0x68/0xf0
>  __arm64_sys_write+0x1c/0x28
>  invoke_syscall+0x44/0x108
>  el0_svc_common.constprop.1+0x94/0xf8
>  do_el0_svc+0x38/0xb0
>  el0_svc+0x20/0x50
>  el0t_64_sync_handler+0x98/0xc0
>  el0t_64_sync+0x174/0x178
> Code: aa0103f4 a9025bf5 d5384100 b9400801 (79401260)
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: 3c28a76124b2 ("vfio: Add struct device to vfio_device")
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/bus/fsl-mc/dprc-driver.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
> index 4c84be378bf2..ec5f26a45641 100644
> --- a/drivers/bus/fsl-mc/dprc-driver.c
> +++ b/drivers/bus/fsl-mc/dprc-driver.c
> @@ -45,6 +45,9 @@ static int __fsl_mc_device_remove_if_not_in_mc(struct device *dev, void *data)
>  	struct fsl_mc_child_objs *objs;
>  	struct fsl_mc_device *mc_dev;
>  
> +	if (!dev_is_fsl_mc(dev))
> +		return 0;
> +
>  	mc_dev = to_fsl_mc_device(dev);
>  	objs = data;
>  
> @@ -64,6 +67,9 @@ static int __fsl_mc_device_remove_if_not_in_mc(struct device *dev, void *data)
>  
>  static int __fsl_mc_device_remove(struct device *dev, void *data)
>  {
> +	if (!dev_is_fsl_mc(dev))
> +		return 0;
> +
>  	fsl_mc_device_remove(to_fsl_mc_device(dev));
>  	return 0;
>  }
> -- 
> 2.17.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
