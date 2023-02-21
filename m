Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26C69E5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjBUROt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjBUROp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:14:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AA91167E;
        Tue, 21 Feb 2023 09:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676999681; x=1708535681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KfbwTghgO0/3M+21sjRPn9tYjmtct1z1AlbCtPRgaz8=;
  b=EnbSwDqp0WBmllxdsk04x5WVmDqD3MB4iwg0NwB1H0LCVCaYcPW5/ZSq
   AbL+5f8GLJ/GpiHgKl5pBmtD4C4LikRTbnOKjte9IeN9tvE+mryzBpXav
   KTiH+7rRHBobeKMvmQ8Z6TDH8ZTDt+XvZ4y81nCwZZZPXi71ONTbVtYmO
   q5r4yMLYEJ2b9TyyDJRIdyUnlmuqiScwX0OIUA3Oa1uOmfySfG8amkvHL
   8myucGRvzJb4D2XUUUaGda3b+7SWhNNzCqqF5ABA6o2N+gcbo05FYrShc
   u6LBA3Eso6jCMBZWc6iB0uVIw7BNAPXembXKoVoYONwpJSRtjT4hyZAne
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="418918247"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="418918247"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 09:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="795587674"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="795587674"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2023 09:13:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUWCp-00A35j-07;
        Tue, 21 Feb 2023 19:13:31 +0200
Date:   Tue, 21 Feb 2023 19:13:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Ferry Toth <fntoth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, warthog618@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: arm64: libgpiod: refcount_t: underflow; use-after-free.
Message-ID: <Y/T7unUf10Wis59a@smile.fi.intel.com>
References: <CA+G9fYs4JsmNxX4+W=wijfSPdDsOy=SWLBSitZper5ncPpdxqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs4JsmNxX4+W=wijfSPdDsOy=SWLBSitZper5ncPpdxqA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 08:29:27PM +0530, Naresh Kamboju wrote:
> Following kernel warning notices on qemu-arm64, qemu-arm and also on devices
> running Linux version v6.2.0 while running libgpiod tests.
> 
> + ./gpiod.sh /opt/libgpiod/bin/
>   [INFO]    libgpiod test suite
>   [INFO]    117 tests registered
>   [INFO]    checking the linux kernel version
>   [INFO]    kernel release is v6.2.0 - ok to run tests
>   [INFO]    using gpio-tools from '/usr/bin'
> [   10.499036] ------------[ cut here ]------------
> [   10.499656] refcount_t: underflow; use-after-free.
> [   10.500264] WARNING: CPU: 2 PID: 291 at lib/refcount.c:28
> refcount_warn_saturate+0xf4/0x144
> [   10.501306] Modules linked in: gpio_mockup(-) cfg80211 bluetooth
> rfkill crct10dif_ce fuse drm
> [   10.502364] CPU: 2 PID: 291 Comm: gpiod-test Not tainted 6.2.0 #1
> [   10.503229] Hardware name: linux,dummy-virt (DT)
> [   10.503883] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   10.505331] pc : refcount_warn_saturate+0xf4/0x144
> [   10.505723] lr : refcount_warn_saturate+0xf4/0x144
> [   10.506115] sp : ffff800008983cd0
> [   10.506391] x29: ffff800008983cd0 x28: ffff0000c4c4c100 x27: 0000000000000000
> [   10.506961] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> [   10.507533] x23: 0000000000000200 x22: ffff0000c4e66800 x21: ffff0000c7734640
> [   10.508104] x20: 0000000000000001 x19: ffff0000c7734600 x18: ffffffffffffffff
> [   10.508677] x17: 3d4d455453595342 x16: ffffcf0234432020 x15: ffff800088983957
> [   10.509424] x14: 0000000000000000 x13: 2e656572662d7265 x12: 7466612d65737520
> [   10.510003] x11: 3b776f6c66726564 x10: ffffcf02365db580 x9 : ffffcf0233b20138
> [   10.510575] x8 : 00000000ffffefff x7 : ffffcf02365db580 x6 : 0000000000000001
> [   10.511145] x5 : ffffcf023655f000 x4 : ffffcf023655f2e8 x3 : 0000000000000000
> [   10.511721] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c4c4c100
> [   10.512294] Call trace:
> [   10.512494]  refcount_warn_saturate+0xf4/0x144
> [   10.512971]  kobject_put+0x164/0x220
> [   10.513224]  fwnode_remove_software_node+0x44/0x60
> [   10.513554]  gpio_mockup_unregister_pdevs+0x54/0x70 [gpio_mockup]
> [   10.513970]  gpio_mockup_exit+0x10/0x328 [gpio_mockup]
> [   10.514322]  __arm64_sys_delete_module+0x190/0x2a0
> [   10.514653]  invoke_syscall+0x50/0x120
> [   10.514915]  el0_svc_common.constprop.0+0x104/0x124
> [   10.515277]  do_el0_svc+0x44/0xcc
> [   10.515541]  el0_svc+0x30/0x94
> [   10.515788]  el0t_64_sync_handler+0xbc/0x13c
> [   10.516126]  el0t_64_sync+0x190/0x194
> [   10.516419] ---[ end trace 0000000000000000 ]---
> 
> 
> Build and test logs,
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/testrun/14856342/suite/libgpiod/test/ctxless-get-value-single-line/log
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/testrun/14856342/suite/libgpiod/tests/

Can you give a try of the patch below?

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 77510e4f47de..1807678f032b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -557,7 +557,7 @@ static void platform_device_release(struct device *dev)
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
 
-	of_node_put(pa->pdev.dev.of_node);
+	fwnode_handle_put(dev_fwnode(&pa->pdev.dev));
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
@@ -814,8 +814,7 @@ struct platform_device *platform_device_register_full(
 		return ERR_PTR(-ENOMEM);
 
 	pdev->dev.parent = pdevinfo->parent;
-	pdev->dev.fwnode = pdevinfo->fwnode;
-	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
+	device_set_node(&pdev->dev, fwnode_handle_get(pdevinfo->fwnode));
 	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
 
 	if (pdevinfo->dma_mask) {
@@ -844,8 +843,8 @@ struct platform_device *platform_device_register_full(
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
-		ACPI_COMPANION_SET(&pdev->dev, NULL);
 		platform_device_put(pdev);
+		fwnode_handle_put(pdevinfo->fwnode);
 		return ERR_PTR(ret);
 	}
 
-- 
With Best Regards,
Andy Shevchenko


