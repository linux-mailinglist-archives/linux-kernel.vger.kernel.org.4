Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907E66101AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiJ0Tae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiJ0Tab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:30:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E366938A0B;
        Thu, 27 Oct 2022 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666899030; x=1698435030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xFp5AHBEoE8rNzDe/zETFp3RudK9uoaP5P3Wmzrbr0Q=;
  b=AB7LEnoEg5G1+vetPCd1OO6owIQ4Vq9423ktgkJiUJqqCGvkUVZgMk7h
   k0zMi2gdWPkA/tWMMSfb6UtUqStA3R2Dl9cUn0/cDnLn1MjuvYBr9twDs
   cStTSIAva1Ei6Zi1twuqQPzCeCiG3eI4TGJ/woibgmh90ZnTkpcjyIG9m
   OdWsyNusu2e6yu3v4FZjX/XoTWp9g3C8h1rILoE/Bv1LsjkAcnMBzl0ws
   OsofcxNooakhSXhIIL1r2svK6t7RCsuRBpHj2rHl10gEJhGDnl6rMFGpN
   wKKNcqQJEDDTGhNkVE7BWrSKoxUFyq9LLwZXI3q8hcRH2SaRVvqgg6C2e
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="394637697"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="394637697"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 12:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="695941078"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="695941078"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2022 12:30:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oo8aA-003KCy-0E;
        Thu, 27 Oct 2022 22:30:26 +0300
Date:   Thu, 27 Oct 2022 22:30:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH -next] pinctrl: qcom: Include bitfield.h in
 pinctrl-lpass-lpi.c
Message-ID: <Y1rcUbCVJi7QhcFK@smile.fi.intel.com>
References: <20221027191625.1738204-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221027191625.1738204-1-nathan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 12:16:25PM -0700, Nathan Chancellor wrote:
> When building ARCH=arm allmodconfig, the following error occurs:
> 
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c: In function ‘lpi_gpio_set_mux’:
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:102:9: error: implicit declaration of function ‘u32p_replace_bits’ [-Werror=implicit-function-declaration]
>     102 |         u32p_replace_bits(&val, i, LPI_GPIO_FUNCTION_MASK);
>         |         ^~~~~~~~~~~~~~~~~
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c: In function ‘lpi_config_get’:
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:127:16: error: implicit declaration of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
>     127 |         pull = FIELD_GET(LPI_GPIO_PULL_MASK, ctl_reg);
>         |                ^~~~~~~~~
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c: In function ‘lpi_config_set’:
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:233:23: error: implicit declaration of function ‘u32_encode_bits’ [-Werror=implicit-function-declaration]
>     233 |                 val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
>         |                       ^~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
> 
> bitfield.h was included via pinctrl-lpass-lpi.h but another change
> removed that include to restrict what was being included. Add bitfield.h
> back to pinctrl-lpass-lpi.c, as it is needed there.

Thanks, https://lore.kernel.org/linux-gpio/20221027184145.2533-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko


