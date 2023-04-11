Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2186DDC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDKNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDKNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:37:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694135B5;
        Tue, 11 Apr 2023 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681220254; x=1712756254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lPs4hL2dArfIqO5UhCss13DB9x7JVqdkB3GyJ1laCgQ=;
  b=ZhWTpUXnZSELPRAxq6P2gAn+/EXBjbEwI+nUeQKXrP5vRHX3pLj4ZaXg
   ASSv/FQUCuk1FHAqVBGwJe4gCTm1/NOVAFiC78Ta04oBeFNSvPtxZDTSP
   kTfozzEsa1BEAMnxkvO/N6Rmpu1UdajLW6iSxcSuheTIvFtysC5RhbP/r
   NrpWtXeU24lbWNAnLP4sW1+TGbuP2Q07yzENgtZ/Q/U4MmnVqFmVMluuD
   awwGAFk3JM3HcSR9bHtNGlCm6uGZuqnXbyWBdQlk9FkJzxG4QQNprCfcK
   OEyjVV4ZT59iXcjV3yPtUAATh8NdRFqQYCIaQLupKpMg6zEziR1DoaPsw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="371465716"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="371465716"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 06:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="862862819"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="862862819"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2023 06:37:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pmEBf-00FHXC-0e;
        Tue, 11 Apr 2023 16:37:31 +0300
Date:   Tue, 11 Apr 2023 16:37:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org
Subject: Re: selftests/gpio: gpio-sim.sh: BUG: test FAILED due to recent
 change in sh source
Message-ID: <ZDVimnlgMYmeOj5L@smile.fi.intel.com>
References: <fe030b8e-0573-93de-88ae-38ee48d6c89f@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe030b8e-0573-93de-88ae-38ee48d6c89f@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 06:51:09PM +0100, Mirsad Todorovac wrote:
> Hi,
> 
> The gpio-sim.sh test appears to FAIL in a wrong way due to missing initialisation
> of shell variables:
> 
> $ sudo gpio-sim.sh
> .
> .
> .
> 4. Simulated GPIO chips are functional
> 4.1. Values can be read from sysfs
> 4.2. Bias settings work correctly
> cat: /sys/devices/platform/gpio-sim.0/gpiochip18/sim_gpio0/value: No such file or directory
> ./gpio-sim.sh: line 393: test: =: unary operator expected
> bias setting does not work
> GPIO gpio-sim test FAIL
> $
> 
> This patch fixed the issue:
> 
> diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
> index 9f539d454ee4..fa2ce2b9dd5f 100755
> --- a/tools/testing/selftests/gpio/gpio-sim.sh
> +++ b/tools/testing/selftests/gpio/gpio-sim.sh
> @@ -389,6 +389,9 @@ create_chip chip
>  create_bank chip bank
>  set_num_lines chip bank 8
>  enable_chip chip
> +DEVNAME=`configfs_dev_name chip`
> +CHIPNAME=`configfs_chip_name chip bank`
> +SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
>  $BASE_DIR/gpio-mockup-cdev -b pull-up /dev/`configfs_chip_name chip bank` 0
>  test `cat $SYSFS_PATH` = "1" || fail "bias setting does not work"
>  remove_chip chip
> 
> ... after which the test passed:
> 
> 4. Simulated GPIO chips are functional
> 4.1. Values can be read from sysfs
> 4.2. Bias settings work correctly
> GPIO gpio-sim test PASS
> 
> Which I believe proves that the bug was in the script and not in the gpio-sim driver.

I agree with the analysis. Bart, seems to me that it might be the case, but
I want to amend the fix a bit.

-- 
With Best Regards,
Andy Shevchenko


