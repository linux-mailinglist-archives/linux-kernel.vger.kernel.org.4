Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03E26A717F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCAQqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCAQqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:46:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3247C48E38;
        Wed,  1 Mar 2023 08:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677689171; x=1709225171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Khm4OpKvM9LSJFOeszaRd9E2nr0NI46YJJX41b5nXo=;
  b=DCOiel61dF8LWK3ChYLHCZA96jYnM0wT6qRsd1tzvEReAflbQg2Vmym9
   nJVnWpkpshu2I87aPjpkjXdknvVluw8lESBcb8gB0rkahDGwnXgibFJE8
   1FYMMxfsZ/TABoZdbvDzZVAr5wZXRvsoPY0s7Ho+jZGRSLQzLPloXIkOg
   pGXrN9awPC9EGCptHjcmAv7t/brXJltcZuPmiC84934WcK6sTe2MiOVV7
   sunbldwz82T9wsLP9XO6eCTz39b0R5Ie6cLBtnfOR77bqiroxFaAGM2mO
   zSl4+j7D3ClKEWOiUwwRvCozX8l3CPD619SMTwpfKImrG3RfI98YWXzSo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="331936635"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="331936635"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 08:45:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="707039775"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="707039775"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2023 08:45:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXPaT-00Dpy3-2N;
        Wed, 01 Mar 2023 18:45:53 +0200
Date:   Wed, 1 Mar 2023 18:45:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Henning Schild <henning.schild@siemens.com>,
        Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds-gpio: split up into multiple
 drivers
Message-ID: <Y/+BQVBKJyps2GB4@smile.fi.intel.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
 <20230221122414.24874-3-henning.schild@siemens.com>
 <Y/TMR0GBUr69KiQ5@smile.fi.intel.com>
 <20230221154354.290ae938@md1za8fc.ad001.siemens.net>
 <Y/TaftuNMABevCWV@smile.fi.intel.com>
 <bf678bc5-9615-31a3-3039-5d013f9c9f25@redhat.com>
 <Y/938WpvjQ3HEOwD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/938WpvjQ3HEOwD@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 04:06:09PM +0000, Lee Jones wrote:
> On Wed, 01 Mar 2023, Hans de Goede wrote:

...

> Thanks for your reviews guys, I really appreciate the help.

You're welcome!

-- 
With Best Regards,
Andy Shevchenko


