Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA49F7006DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbjELLcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbjELLci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:32:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746FBD05E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683891157; x=1715427157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PlHNHEaJon/oJdxYet2+Rcf4b0HwSMJh2UW6z3HY6GY=;
  b=ed7MGzofmHZ0b34bZmOLJTIx4VmJDkHGm6omnzltlyp1LZLf35r2ov5s
   gIsUOTRltYEk37qX/c6SR+RvS+tX0tgU9BmlmtXJ0qUtGvZcf1O3BkV27
   veYqDU+Dl0CqkheSZf//Jzd0545c0qKuDjRTgLZGefjTCCx9lUInKuBAi
   xAhpXOKTTgQnKoRL8xBitkttVwrFF41Uokrahioclo3rMjTV7erjp9mRt
   +xpSMEyYdrYoDSCqeHY8krMxCQsFeCS72fl6THBQxhBMCoQPBV8S5sq44
   zyPsBwAgR0lKTW/G9EebYfCXd002WIEdIt4Sw7wInA7QK55urishStp0Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="350792976"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="350792976"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 04:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="703156706"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="703156706"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2023 04:32:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pxR0i-0004cE-1c;
        Fri, 12 May 2023 14:32:32 +0300
Date:   Fri, 12 May 2023 14:32:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/3] linux/bits.h: Add fixed-width GENMASK and BIT macros
Message-ID: <ZF4j0NPoBGMBT8CO@smile.fi.intel.com>
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
 <ZF4fi5B7PPlgZBOI@smile.fi.intel.com>
 <87pm75kd0h.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm75kd0h.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 02:25:18PM +0300, Jani Nikula wrote:
> On Fri, 12 May 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, May 08, 2023 at 10:14:02PM -0700, Lucas De Marchi wrote:
> >> Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
> >> masks for fixed-width types and also the corresponding BIT_U32(),
> >> BIT_U16() and BIT_U8().
> >
> > Why?
> 
> The main reason is that GENMASK() and BIT() size varies for 32/64 bit
> builds.

When needed GENMASK_ULL() can be used (with respective castings perhaps)
and BIT_ULL(), no?

-- 
With Best Regards,
Andy Shevchenko


