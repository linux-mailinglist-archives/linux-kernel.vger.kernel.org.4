Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0330F649B10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiLLJYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiLLJYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:24:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610E7F53;
        Mon, 12 Dec 2022 01:24:10 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="319665590"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="319665590"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 01:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="736903233"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="736903233"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2022 01:24:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1p4f2b-008Oim-0a;
        Mon, 12 Dec 2022 11:24:05 +0200
Date:   Mon, 12 Dec 2022 11:24:04 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jean Delvare <jdelvare@suse.de>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] media: rc: Drop obsolete dependencies on COMPILE_TEST
Message-ID: <Y5bzNH2tYeFUIGnI@smile.fi.intel.com>
References: <20221121170911.7cd72bfc@endymion.delvare>
 <20221211205648.hdv5haufqwfoxzu2@pengutronix.de>
 <20221211231435.43c4f361@endymion.delvare>
 <20221212075907.4iwjsib5nrk7eqr2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212075907.4iwjsib5nrk7eqr2@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 08:59:07AM +0100, Uwe Kleine-König wrote:
> On Sun, Dec 11, 2022 at 11:14:35PM +0100, Jean Delvare wrote:
> > On Sun, 11 Dec 2022 21:56:48 +0100, Uwe Kleine-König wrote:
> > > On Mon, Nov 21, 2022 at 05:09:11PM +0100, Jean Delvare wrote:

...

> > > > -		.of_match_table = of_match_ptr(pwm_ir_of_match),
> > > > +		.of_match_table = pwm_ir_of_match,

> > > That hunk makes sense even without the Kconfig change. ACPI makes use of
> > > .of_match_table, so
> > > 
> > > 	.of_match_table = of_match_ptr(pwm_ir_of_match),
> > > 
> > > is (almost?) always wrong.
> > 
> > Should we just get rid of this macro altogether then?
> > 
> > (Somehow I have a strange feeling that we already had this
> > discussion...)
> 
> Might be. But for me this is only second hand knowledge, too. Maybe
> someone of the new recipents in this thread feels competent to comment
> here?!

Pros of of_match_ptr() / ACPI_PTR():
- saves a few dozens of bytes in the module ID tables
- doesn't show ACPI ID for non-ACPI platform or OF ID on non-OF platforms

Cons:
- prevents from using OF IDs on ACPI platforms
- doesn't show ACPI ID for non-ACPI platform or OF ID on non-OF platforms
- makes error prone for the compiler to have the variable unused
- makes code uglier

(I left the second in the both because I find useful to have all supported IDs
 to be listed even if the system is compiled with OF/ACPI opted-out.)

Personally I remove the of_match_ptr()/ACPI_PTR() from drivers that can be used
on OF or ACPI platforms, which leaves us only with the drivers we are 100% sure
that they won't ever be used on non-OF platforms. BUT, I do not see any sense
to have of_match_ptr() that either in use, because the driver in question is
100% for OF platform, or not when it's compile tested, which means it reduces
test coverage anyway. All the same for ACPI_PTR().

TL;DR: I don't see any [big] usefulness of keeping those macros.

-- 
With Best Regards,
Andy Shevchenko


