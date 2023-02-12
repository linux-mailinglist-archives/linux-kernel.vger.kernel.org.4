Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2924F69374A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 13:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBLMiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 07:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 07:38:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF0F126E9;
        Sun, 12 Feb 2023 04:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676205495; x=1707741495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=32TVTeLwLIlSiDD3YGyzTZy2H8xmzMHLUS9EFUgtc08=;
  b=Eb86tULjUULSA6UZpt8AZ7ita1ulUXFfj11UQuORXag6Oy6slhaVydrE
   UvU98vj5wI5wR64zxiVvxc2lJSCXI+v7vnB6yJV8jvkNTqSsb1mSnoQPA
   ywFFQowgj4VccuQpHV+AgcUr1hT62GYsxxQD7p7zbZUOHYVhs9RVww1qx
   50HjpdIr1uNLzvEAJlC+SWv6gkLVFTPvcuctMy422ku8TVCs3NQnIDaw4
   TN2tHArdWtJZO5cktg5KyZUssI7eLTWqAsd6Nwkb+lGWbOdp2vlehW8yI
   5NiH2t57x0hqGh1YmfNa1E5GaNVLt6tf8+J4M4zeIa+9SZPUXRVSrmgyh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="310345430"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="310345430"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 04:38:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="668539167"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="668539167"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 12 Feb 2023 04:38:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pRBcR-005rUz-11;
        Sun, 12 Feb 2023 14:38:11 +0200
Date:   Sun, 12 Feb 2023 14:38:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Niall Leonard <nl250060@ncr.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gpio: mmio: Use new flag BGPIOF_NO_INPUT.
Message-ID: <Y+jds9U1PgYpXBHT@smile.fi.intel.com>
References: <20230126-gpio-mmio-fix-v2-0-38397aace340@ncr.com>
 <20230126-gpio-mmio-fix-v2-2-38397aace340@ncr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126-gpio-mmio-fix-v2-2-38397aace340@ncr.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:49:38PM +0000, Niall Leonard wrote:
> Add new flag BGPIOF_NO_INPUT to header file.
> Use the existing shadow data register 'bgpio_data' to allow
> the last written value to be returned by the read operation
> when BGPIOF_NO_INPUT flag is set.
> Ensure this change only applies to the specific binding "wd,mbl-gpio".

I'm wondering why do we need that.

I mean the reading back the (possible cached) output value is the right thing
to do by default for GPIO (in output mode) or GPO. So, instead you can simply
check the current direction of the pin and return (cached) value.

Or did I miss something?

-- 
With Best Regards,
Andy Shevchenko


