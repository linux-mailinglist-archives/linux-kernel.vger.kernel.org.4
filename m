Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43723749815
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjGFJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjGFJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:16:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB45DAF;
        Thu,  6 Jul 2023 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688634992; x=1720170992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=faoPJTHDsIgiPgdXKYWozlz+vBxj4RZOGgol5Jaz2Q0=;
  b=SpM0hOzrcCWUNHs6PlIT+GxUDOHtnTMFjtgCM5/Xb6tUCc9L8z/kjqMj
   jI9fJcAkVgj301MWgICdV3AxHAAq2bWBT1fSem59IqCm6va/PGnJAej/V
   aQQZmY9y+AMlKkOiInPkPyfjJtK0wisH6qF2HmkqmupJPwSggLhTQdfFH
   uwtlwJQN4cVWWit5+pNNRk92V42eZyBYj53lViAfkIV9Jcjo+lNV8aKIf
   +PiO/X85OTl4swtaZoRQSgLikZWy9KTtMFQMcr2NsJlj1m1nttpQV/2Wa
   Gc5BjfqFv/VcAt1rG3aH4wi6gWWZxkCT04khHRwBNwK9hKIqZjoODA7VX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363578832"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="363578832"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 02:16:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719523904"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719523904"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2023 02:16:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qHL69-000TlH-2e;
        Thu, 06 Jul 2023 12:16:25 +0300
Date:   Thu, 6 Jul 2023 12:16:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        linus.walleij@linaro.org, npliashechnikov@gmail.com,
        nmschulte@gmail.com, friedrich.vock@gmx.de, dridri85@gmail.com,
        Hans de Goede <hdegoede@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        open list <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] pinctrl: amd: Use amd_pinconf_set() for all
 config options
Message-ID: <ZKaGaVYOouPgZTSj@smile.fi.intel.com>
References: <20230705133005.577-1-mario.limonciello@amd.com>
 <20230705133005.577-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705133005.577-3-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 08:30:03AM -0500, Mario Limonciello wrote:
> On ASUS TUF A16 it is reported that the ITE5570 ACPI device connected to
> GPIO 7 is causing an interrupt storm.  This issue doesn't happen on
> Windows.
> 
> Comparing the GPIO register configuration between Windows and Linux
> bit 20 has been configured as a pull up on Windows, but not on Linux.
> Checking GPIO declaration from the firmware it is clear it *should* have
> been a pull up on Linux as well.
> 
> ```
> GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
> 	 "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
> {   // Pin list
> 0x0007
> }
> ```
> 
> On Linux amd_gpio_set_config() is currently only used for programming
> the debounce. Actually the GPIO core calls it with all the arguments
> that are supported by a GPIO, pinctrl-amd just responds `-ENOTSUPP`.
> 
> To solve this issue expand amd_gpio_set_config() to support the other
> arguments amd_pinconf_set() supports, namely `PIN_CONFIG_BIAS_PULL_DOWN`,
> `PIN_CONFIG_BIAS_PULL_UP`, and `PIN_CONFIG_DRIVE_STRENGTH`.

...

> @@ -782,7 +770,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
>  }
>  
>  static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
> -				unsigned long *configs, unsigned num_configs)
> +			   unsigned long *configs, unsigned int num_configs)

Seems like a stray change.

>  {
>  	int i;
>  	u32 arg;

Otherwise entire series looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


