Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CAB5E9E81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiIZKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiIZKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:00:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ABF17E2C;
        Mon, 26 Sep 2022 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664186425; x=1695722425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RVGhqtsE7PdAaicNO71PoIIBxIolZaTTzaRRLrULv4s=;
  b=h/yq0q+nhJalclUupsSx/87PrhF5KvbogRh7h/YAhuugFfNGGzuwsC4e
   doZym76NjFsrxJBCQciPtQ1lCcmiRzyF3nKc5WX+ez8atOOeBX/P0eP/s
   VbYbEu/XcoYP0ruoEabyj5T23MwtVJIO/+Fccbya4iu5vOOIjKeaEEP+Z
   Kj9k2u1nmiBOZpb/T1Rsfp2iSXw6BcJUa8xH2SKDfxSWTOmO69VWwRslq
   NEHXA0Uj6ThT6M84e3f6VCBsFBuJqBJx6aU8yzp/FLviZIW3NvDGAN6Sc
   2PlSAmD2p+pwS1x4/RyguENYzIA9mL7KuUCibc0IcK/PtvLh0o7enJxwQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="298588459"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="298588459"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 03:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="724986257"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="724986257"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2022 03:00:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ockuU-007jr2-0p;
        Mon, 26 Sep 2022 13:00:22 +0300
Date:   Mon, 26 Sep 2022 13:00:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra
 comparison
Message-ID: <YzF4NrcBkR/p0cD3@smile.fi.intel.com>
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
 <20220923154001.4074849-1-Jason@zx2c4.com>
 <20220923155412.b0132fc62eca18817a023cd2@linux-foundation.org>
 <Yy7d5qWpT5Xj2WvN@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy7d5qWpT5Xj2WvN@zx2c4.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 12:37:26PM +0200, Jason A. Donenfeld wrote:
> On Fri, Sep 23, 2022 at 03:54:12PM -0700, Andrew Morton wrote:
> > On Fri, 23 Sep 2022 17:40:01 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

...

> Worth noting, by the way, is that the input validation check already
> caught a bug when 0day test bot choked:
> 
> https://lore.kernel.org/linux-hwmon/20220924101151.4168414-1-Jason@zx2c4.com/

Hooray, it was a good idea! :-)

> So, options:
> 1) Keep this patch as-is, because it is useful on modern compilers.
> 2) Add an ifdef on compiler version, so we generate the best code in
>    each case.
> 3) Go back to testing twice, but keep the checker macro because it's
>    apparently useful.
> 4) Do nothing and discard this series.
> 
> Any of those are okay with me. Opinions?

I tend to case 3) (I believe you typo'ed double 2) cases) and apply the rest
as a separate change with all downsides explained (kinda 1) approach).

-- 
With Best Regards,
Andy Shevchenko


