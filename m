Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69BA5F989A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiJJGuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiJJGtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:49:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4337C17A88
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665384586; x=1696920586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dDQtaRTCnXAhK8VR9vgFzDe3WUSmC6hAYRMwNSjoqzg=;
  b=SkgEh9BzyODjdR44GJaK1dq0mbHQZPRDPBXT5ihg9svW3xQjbTTKTs68
   VQQQQb1M3GRiutZMn5eVYOQSJIq1YogmIQEhgFSakuYVQKp2smaWd4F9u
   OzC+bXfLiDdjQwoKuzY2O62J1LGzqsR1P8/49A1A/eSuXWYOEW9QTs2Eg
   hpiiqLZLCwcXi9aZcTOlMMxwfo3RzPjanrL13wdK5kCHChU6kHoscvbAZ
   oByUBtZBjZ0t8oewlGXIMtDoSGXp3meinSd642xwYpRl1F3iSiPom9aW0
   7fQGUC8lsIUMKgXob28kZ5KrFWoAkDrMltUT6cFqGr6cXYKTGm2Dzjisr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="305183350"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="305183350"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 23:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="688680101"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="688680101"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2022 23:49:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohmbZ-004kvk-1x;
        Mon, 10 Oct 2022 09:49:37 +0300
Date:   Mon, 10 Oct 2022 09:49:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, regressions@lists.linux.dev
Subject: Re: [PATCH v1 1/1] mfd: syscon: Remove repetition of the
 regmap_get_val_endian()
Message-ID: <Y0PAgTLg85No6e/Q@smile.fi.intel.com>
References: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
 <20221009163942.GA630814@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009163942.GA630814@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 09:39:42AM -0700, Guenter Roeck wrote:
> On Mon, Aug 08, 2022 at 05:08:11PM +0300, Andy Shevchenko wrote:
> > Since the commit 0dbdb76c0ca8 ("regmap: mmio: Parse endianness
> > definitions from DT") regmap MMIO parses DT itsef, no need to
> > repeat this in the caller(s).
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This patch results in reboot failures for all big endian mips emulations.
> 
> Sample log:
> 
> Network interface test passed
> Boot successful.
> Rebooting
> reboot: Restarting system
> Unable to restart system
> Reboot failed -- System halted
> 
> The problem is not seen with little endian mips emulations. Reverting
> this patch fixes the problem. Bisect log attached.
> 
> #regzbot introduced: 72a95859728a
> #regzbot title: Reboot failure on big endian mips systems

Right, Jason sent a revert already, but Linus asked for the proper submission.

-- 
With Best Regards,
Andy Shevchenko


