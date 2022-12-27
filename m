Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462B5656E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiL0TZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiL0TYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:24:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772AFD2F3;
        Tue, 27 Dec 2022 11:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672169051; x=1703705051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2BE9RH9bB4jftDqWDKVrmuMRF5jrC7+WeYWOKcz94t8=;
  b=N3piHIFRIWEqpZR6568tUGMxYFBeErNYFUfkn6C9ONFSmcJYVh7nilww
   xus2V8pdesLCQTgr43JISy64Y1cPo9gDQaY3R3cCxfmO4ayFz2F9KuQ22
   l+OtZdArzazs/61/frSVDmilZ/DM0IENVRZtRubY3EC0xHWwNus2rQ/u+
   ZdL33XGzZarzDxyXjJ5b1/4tSjDDAKUuG+5/dnayZ6v/VYTmPqtosLijs
   NEuh1B0o9fO+KdfBchoD43nqmSmMYuAZBYVXPDDF9a8ZMRZGVQnRutqBA
   pwX8vwYzICKWH1chGUuh40H1Q2NNlTHpDdqxZuqGeUkLhebtKPoE3ESl0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322726437"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="322726437"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:24:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="741820711"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="741820711"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2022 11:24:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAFYW-000CBo-1L;
        Tue, 27 Dec 2022 21:24:08 +0200
Date:   Tue, 27 Dec 2022 21:24:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/4] pinctrl: intel: Add default case to
 intel_config_set_pull()
Message-ID: <Y6tGWFqduPZxw5qs@smile.fi.intel.com>
References: <20221219123208.5505-1-andriy.shevchenko@linux.intel.com>
 <Y6B4HrOXNPXGBDWZ@smile.fi.intel.com>
 <Y6FTwscP2xOw5ADE@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6FTwscP2xOw5ADE@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 08:18:42AM +0200, Mika Westerberg wrote:
> On Mon, Dec 19, 2022 at 04:41:34PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 19, 2022 at 02:32:05PM +0200, Andy Shevchenko wrote:
> > > For the sake of symmetry with intel_config_get_pull(), add
> > > a default case to the outer switch.
> > 
> > The stats for the entire series:
> > 
> >  drivers/pinctrl/intel/pinctrl-intel.c | 45 +++++++++++++++++++++++++++------------------
> >   1 file changed, 27 insertions(+), 18 deletions(-)
> 
> Thanks!
> 
> For the series,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


