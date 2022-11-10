Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393616241D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiKJMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKJMAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:00:35 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDAF21E0F;
        Thu, 10 Nov 2022 04:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668081633; x=1699617633;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MXjGcSIK04ScLohpdYFk9DXdIqTJwmlzr90IomobVJ4=;
  b=mK84qeq0hs/hmQbjjt7IWEwlOtGMvlpr4F/xQ7hdhwDn0Jdb7BUCasVG
   ZkQV/eB1DS5acBoLjM8bjC9FCAgGaQmS6VzOM3S8GrpKwe8I8e8gvAX1Z
   1plu74LaomWdSmnR18ck5L4roPEWLsbeD5W7M2vSyGDaVHoD6QkE5J7ek
   imwrq8hCWM/WRp6qeloSf3mKqIpKnhkoeFBn7Eq9YQP12AT95eX6frQqO
   FfDKrayLmwWO3K4yQT3r/0b8Cu32GKg9Fbk0NsfidRcDCUv92c89tw9Ob
   BZRLbylUsE2dPCtAg6AtIOQlbBrRI/dqW1Un4WA3RVAYz4f0FKNzyeaCX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="373410977"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="373410977"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 04:00:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="588152059"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="588152059"
Received: from jvpendej-mobl2.gar.corp.intel.com ([10.214.150.188])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 04:00:28 -0800
Message-ID: <1d8ad923707b1c6347d830088a410c31b794968c.camel@intel.com>
Subject: Re: [PATCH v2 0/5] rtc: rtc-cmos: Assorted ACPI-related cleanups
 and fixes
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Date:   Thu, 10 Nov 2022 20:00:25 +0800
In-Reply-To: <5640233.DvuYhMxLoT@kreacher>
References: <5640233.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-09 at 13:05 +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is a v2 of the series previously posted as
> 
> https://lore.kernel.org/linux-acpi/2276401.ElGaqSPkdT@kreacher/
> 
> The first three patches in the series have not changed since then (I
> have
> considered moving the last patch, which is a fix, to the front, but
> that turns
> out to be a bit cumbersome and not really worth the effort).
> 
> This series of patches does some assorted ACPI-related cleanups to
> the CMOS RTC
> driver:
> - redundant static variable is dropped,
> - code duplication is reduced,
> - code is relocated so as to drop a few unnecessary forward
> declarations of
>   functions,
> - functions are renamed to avoid confusion,
> and fixes up an issue in the driver removal path.
> 
> 
> 

Reviewed-by: Zhang Rui <rui.zhang@intel.com>

And I have tested the patch series on a platform with both
use_acpi_alarm parameter set and cleared, the ACPI RTC fixed event
works as expected, for both runtime and suspend wakeups.

So
Tested-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui


