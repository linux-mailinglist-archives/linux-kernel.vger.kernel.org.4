Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BAB731D16
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344135AbjFOPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbjFOPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:49:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A1DF;
        Thu, 15 Jun 2023 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686844178; x=1718380178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PFBtTtmWe3T3OLLflnk8WWM5W5odQPoBX/I7JOJDbQE=;
  b=dVXUZEjNZGynz3mqarh0IYhioTOFuJgFqzyHmguVsDgQ6e6ciik0g5CK
   RbVBRgmS0VKiHJII5dsmmaag6o+VyLNUHHit3d4om7yGOOZxhNDRRMevq
   pD/+ynPdrR67+SPxT47naStNAU2EihV7fDUgK9zGNbnGGlaQ9Tq0xSoHh
   Ga/wwzhAktfTM6iJaHXYT9FS1WOH9lLmo4ZHpQuasrA49vM2WozfYJLhA
   qDJ0/LFrVIWgvhPvxnBSvVqtcpPfAd756s+zLx8mLaOz+YoNeiB7jMF+w
   nxbbbSlDpHDpjwMKGQ1w4dKAx3roTLERfnW27H7LCYeVAhmtVNh7xONIf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424868043"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424868043"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="857019779"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="857019779"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2023 08:36:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9p15-003yU3-1z;
        Thu, 15 Jun 2023 18:36:07 +0300
Date:   Thu, 15 Jun 2023 18:36:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 3/5] gpio: aggregator: Prevent collisions between DT
 and user device IDs
Message-ID: <ZIsv51766AXAiQ7E@smile.fi.intel.com>
References: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
 <20230615132023.13801-4-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVAwKCUnOeuz_PE6ijtfTVf8a3rTQZ=JvThOmqytu5HCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVAwKCUnOeuz_PE6ijtfTVf8a3rTQZ=JvThOmqytu5HCA@mail.gmail.com>
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

On Thu, Jun 15, 2023 at 04:54:14PM +0200, Geert Uytterhoeven wrote:
> On Thu, Jun 15, 2023 at 3:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > In case we have a device instantiated via DT or other means than
> > via new_device sysfs node, the collision with the latter is possible.
> > Prevent such collisions by allocating user instantiated devices with
> > higher IDs, currently set to 1024.
> 
> Can you please elaborate? How exactly is this possible?
> 
> Aggregators instantiated through sysfs are named "gpio-aggregator.<n>",
> and are IDR-based.
> Aggregators instantiated from DT are named "<unit-address>.<node-name>".
> How can this conflict? When instantiated from ACPI?
> What am I missing?

Nothing. It's me who misunderstood how OF platform device naming schema works.

So this patch can be discarded as we never will have gpio-delay available for
removal via delete_device sysfs node.

Bart, tell me if you need a new version w/o this patch (but note that b4 can
handle this case with

	b4 -slt -P1,2,4,5 ...

).

-- 
With Best Regards,
Andy Shevchenko


