Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2861F1C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKGL0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiKGLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:25:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9DC183B9;
        Mon,  7 Nov 2022 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667820359; x=1699356359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TUWjLMO8b5X2Wi6JEaFyhDkc/iYbh5AfbKM0PwS5UM0=;
  b=OiZOktChuLRz6qLnoH9A9AJn77qjotD8LzI2khmcalfFZjp79uGgsmKB
   t5ZSUxFcyy0Yr6l2WjdWJmXT8KTPm8QY80H8wNP1OfXGuPKhNbrq/+NzV
   30HsVQqx4MK31kUlG+N9KkO9JDq8NtNXTJeRosXnIPyQHS4LJWzpDgrpo
   0VwvsB0jCUs01LEYMmSOc6sAvxrm8/Ng29Inhg4089kEWl0kUIRjfNDx+
   xsGIlwM+slEYa+mg8T9JQiETdjWN8ci5mhmcYkY+MDKYEaGW6OuQpQk65
   j8hE0uKdrnT5lZ1zD7uunQoQtsIDmL17Ve8b7ISH/ZYi0vNb2Dm64WAhW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="308011142"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="308011142"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="741456055"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="741456055"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2022 03:25:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os0GI-008bhU-1u;
        Mon, 07 Nov 2022 13:25:54 +0200
Date:   Mon, 7 Nov 2022 13:25:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     linux-usb@vger.kernel.org, Sven Peter <sven@svenpeter.de>,
        stable@kernel.org, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: dwc3: Do not get extcon device when
 usb-role-switch is used
Message-ID: <Y2jrQgj53z/mhHmm@smile.fi.intel.com>
References: <20221106214804.2814-1-j@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106214804.2814-1-j@jannau.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 10:48:04PM +0100, Janne Grunau wrote:
> The change breaks device tree based platforms with PHY device and use
> usb-role-switch instead of an extcon switch. extcon_find_edev_by_node()
> will return EPROBE_DEFER if it can not find a device so probing without
> an extcon device will be deferred indefinitely. Fix this by
> explicitly checking for usb-role-switch.
> At least the out-of-tree USB3 support on Apple silicon based platforms
> using dwc3 with tipd USB Type-C and PD controller is affected by this
> issue.

We don't care about out-of-tree modules, do we?

OTOH, the problem you are trying to workaround is probably in a (mis)use of
deferred probe somewhere.

Btw, does it prevent the system boot or you just see the extcon in the list of
deferred devices after booting?

-- 
With Best Regards,
Andy Shevchenko


