Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D374465735D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiL1GuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiL1GuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:50:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC11D112;
        Tue, 27 Dec 2022 22:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672210222; x=1703746222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kf04Gbkcu3mbsOOVYtXo6AR9vZw5hnzXfVA+UYMU+yk=;
  b=gHLorJnNttn5akqyp5yzB+kDJFOktBgD96Dy1+2C+2I+LRGHZVg8lPTa
   naLvunCLt8cu9/P7hE6L0CAiMYGwXtoMerMaDjl3sZCgQsQAaQus8FVwp
   x+tM8P6owBk4ifiRFX6MA/t80nYJEzBBrOmL5N+a19JF1is+YorB9JFgX
   KXnacndOOK5jtHGBmH4TAzRWddfogxjpIOG4I7zM/w9Yn9/3fHhq3hUA0
   tzBOAVs7wu+OWcMHzBym+Ag3dNrZv4tInXLCZffv5nC6rmru2ujNZjrZW
   6T11BZWb2wKGXrM825yv5mViYpgvIzRByj2y4+lqR5RnFe0z9XZS9Txza
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="300511220"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="300511220"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 22:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="653243710"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="653243710"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Dec 2022 22:50:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A0D46F8; Wed, 28 Dec 2022 08:50:51 +0200 (EET)
Date:   Wed, 28 Dec 2022 08:50:51 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 01/17] pinctrl: intel: Introduce INTEL_COMMUNITY_*()
 to unify community macros
Message-ID: <Y6vnSzbaFVswk/iV@black.fi.intel.com>
References: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
 <Y6B2FyOvOK2rR9H9@black.fi.intel.com>
 <Y6tFMB5S23PgmxQd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6tFMB5S23PgmxQd@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 09:19:12PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 19, 2022 at 04:32:55PM +0200, Mika Westerberg wrote:
> > On Mon, Dec 19, 2022 at 02:26:27PM +0200, Andy Shevchenko wrote:
> > > Now it becomes visible that we can deduplicate SoC specific
> > > *_COMMUNITY() macros across the Intel pin control drivers.
> > > For that, introduce a common INTEL_COMMUNITY_GPPS() and
> > > INTEL_COMMUNITY_SIZE() macros in the pinctrl-intel.h.
> > 
> > You should really start learning how to use --cover-letter option with
> > git format-patch because for anything more than one patch pretty much
> > requires such. Here I would really like to see how much lines this
> > series ends up removing :)
> > 
> > The series looks good to me, though.
> 
> The series has been pushed to my review and testing branch, thanks!
> 
> P.S. I dared to convert the above into your Acked-by tag. Tell me if it must
> not be the case.

That's fine, forgot to add it myself :)
