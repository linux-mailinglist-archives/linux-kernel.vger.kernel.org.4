Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B678773A10A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFVMgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjFVMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:36:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E6B4;
        Thu, 22 Jun 2023 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687437400; x=1718973400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FbiQ+LDZQhs9twCAnMTqrC8VC4gQAZYtj3pxvOTr2x8=;
  b=DBuTzQwcx00G3QWPm8J8ksn8AgsOUSuKSyp2jCIxBeGVrJvL7Y5bYpHF
   3AThMyYNjDNyL2MNNLn1suuzJlJl2oaizm9bEA8xkXhblwwJPt7J8dvs1
   xiKlmU/0szTXaubYmALTHtAe2xSz4F7HuDfYnMa2wahrua/DwSBXDCMRw
   Gtwl5z0kWbr1pRFrGATJZqf+AwLEDriUy4KnZLXjJpi261wXFBXfbbtAL
   B+ZzNORpTiSqxErtAvW8BN3eWZChgcyjaTWLPg5UiQKUYIeDbSGCwLLMV
   h1Z1SFbeQIo560BLnUHQ4rghIe/G+6IZq2ScM1R4reKo9tqd7kBYq9OIq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360492240"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="360492240"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="839031995"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="839031995"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2023 05:36:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qCJY6-005lUY-0x;
        Thu, 22 Jun 2023 15:36:30 +0300
Date:   Thu, 22 Jun 2023 15:36:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, beanhuo@micron.com,
        nipun.gupta@amd.com, linus.walleij@linaro.org, mwen@igalia.com,
        bvanassche@acm.org, arnd@arndb.de, ogabbay@kernel.org,
        linux@zary.sk, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv4 0/4] Wiegand bus driver and GPIO bitbanged Wiegand
Message-ID: <ZJRATnQ6R+EYnUok@smile.fi.intel.com>
References: <20230510162243.95820-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510162243.95820-1-m.zatovic1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 06:22:39PM +0200, Martin Zaťovič wrote:
> Hello,
> 
> thank you for the feedback regarding the previous version of this patch series.
> I have tried to follow all of the advice I got and fix all the pointed issues.
> One of the main issues was the usage of of API for device registration. This
> has now been fixed to use fwnode API, however I was not yet able to get rid of
> the of_device include, since it is required for of_driver_match_device. Please
> let me know if this is correct.

Since it is a bus, I think we need that.

> CHANGELOG:
> 
> wiegand.c:
> - changed ID allocation API from IDR to IDA, since the references associated to
> the IDs are not needed
> - removed the board_lock mutex, because it was only guarding the allocacion
> and freeing of IDs, which is already supported by IDA API
> - restructured the file, so that most functions are close to their caller, or
> defined them at the top for better code readability

> - in the function devm_wiegand_register_controller, the devres management of
> the pointer to wiegand_controller structure has been replaced with
> devm_add_action_or_reset function. It was intended to do the same with
> devm_wiegand_alloc_controller, however, the kernel kept panicing, despite the
> call order of the unregister and release functions being proper(same as with
> devres managed pointer). Please let me know if this is an absolute must, if so
> I will look into it further.

What panic? Can you elaborate?

> - moved the miscdevice from wiegand-gpio driver to be a part of the bus
> driver. Now every controller is associated a /dev file. The file operation
> functions were simply moved and renamed and the miscdevice structure was moved
> to be a part of wiegand_controller structure
> - since now every controller has a miscdevice assosciated, the data_buffer was
> also moved to be a part of the controller structure, and it was made a bitmap
> - used fwnode API for device registration instead of of API
> - removed warnings when driver fails to get wiegand properties, instead
> implemented mechanism for setting a default value similar I2C
> - removed the driver matching code in register driver, as
> of_driver_match_device does that already
> - made wiegand_device and opaque pointer
> - changed the terminology to primary and secondary

-- 
With Best Regards,
Andy Shevchenko


