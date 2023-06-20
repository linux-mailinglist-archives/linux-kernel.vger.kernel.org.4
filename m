Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BD3736E44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjFTOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjFTOEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:04:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2BFA4;
        Tue, 20 Jun 2023 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687269854; x=1718805854;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ca7/yI4TqjzgeDR9K0z3MtWXnd6TYta8YQAkAFDWepg=;
  b=S2icewdk8aOdfcL/GVg0Xvpx8VYG9nWKfDxbmAG+HBPq99L0ncoBuZdb
   K/oxb/e/ojcQLKpb22aXztZhwhO21rYubkd7nuiX9G7LwaRURogj73CP1
   2hQhmhTU/Kl1WoZuuOS/2pIs4ScE6nt/5KP5viyUfL/+u1y041bYfhdkP
   Mml9Shm45dxUEDbG8sLw47/DOTFv2C/lFmdsFOmixHgoOO3QG4LDCLPg/
   eavAvk9lFYsTQRf79VYswSmHUwY8ZANfszu+Esg7p7OmbTM3+wbKczoZm
   U1DlQs98zeGx60x6wuh7FYHf6ivRbGJwykFnwdt2ikzTFlcJesjgTU9/y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="339478198"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="339478198"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 07:03:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="784078298"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="784078298"
Received: from mylly.fi.intel.com (HELO [10.237.72.161]) ([10.237.72.161])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2023 07:03:54 -0700
Message-ID: <32ddaa7b-53a8-d61f-d526-b545bd561337@linux.intel.com>
Date:   Tue, 20 Jun 2023 17:03:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] counter: i8254: Introduce the Intel 8254 interface
 library module
Content-Language: en-US
To:     William Breathitt Gray <wbg@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, andy.shevchenko@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
References: <cover.1681665189.git.william.gray@linaro.org>
 <f6fe32c2db9525d816ab1a01f45abad56c081652.1681665189.git.william.gray@linaro.org>
 <ZIHpGUWZ8wE7tkJP@ishi>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <ZIHpGUWZ8wE7tkJP@ishi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 6/8/23 17:43, William Breathitt Gray wrote:
> On Sun, Apr 16, 2023 at 01:36:53PM -0400, William Breathitt Gray wrote:
>> Exposes consumer library functions providing support for interfaces
>> compatible with the venerable Intel 8254 Programmable Interval Timer
>> (PIT).
>>
>> The Intel 8254 PIT first appeared in the early 1980s and was used
>> initially in IBM PC compatibles. The popularity of the original Intel
>> 825x family of chips led to many subsequent variants and clones of the
>> interface in various chips and integrated circuits. Although still
>> popular, interfaces compatible with the Intel 8254 PIT are nowdays
>> typically found embedded in larger VLSI processing chips and FPGA
>> components rather than as discrete ICs.
>>
>> A CONFIG_I8254 Kconfig option is introduced by this patch. Modules
>> wanting access to these i8254 library functions should select this
>> Kconfig option, and import the I8254 symbol namespace.
>>
>> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> 
> I've queued this patch to the counter-next branch of my Counter tree.
> 
> Jonathan, Bart, I've created an immutable branch with just this patch
> for you to pull which should allow you each to merge the other patch in
> this patchset for your respective tree.
> 
I noticed this patch cause in linux-next "Counter support" submenu to 
disappear and its menu entries are listed directly in "Device Drivers" menu.

Then I wonder why the CONFIG_I8254 has the help text defined since 
drivers should select it.

Or was the idea something like below?

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index bca21df51168..80631b5b0fc6 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -10,9 +10,10 @@ menuconfig COUNTER
           interface. You only need to enable this, if you also want to 
enable
           one or more of the counter device drivers below.

+if COUNTER
+
  config I8254
-       tristate
-       select COUNTER
+       tristate "i8254 interface library"
         select REGMAP
         help
           Enables support for the i8254 interface library functions. 
The i8254
@@ -25,8 +26,6 @@ config I8254

           If built as a module its name will be i8254.

-if COUNTER
-
  config 104_QUAD_8
         tristate "ACCES 104-QUAD-8 driver"
         depends on (PC104 && X86) || COMPILE_TEST
