Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221237373A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjFTSTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFTST3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:19:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA351A8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687285168; x=1718821168;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fxp7O1IFxzgSra3+U3m4CdtMmU0xIakqiwOKj7ZMuzc=;
  b=OKRX26P2xfDuDXHuogAZlOLCQshO1ptM5SxETE2boW46K7DgWFrCdkcU
   foQhNqw8ImGIez0fQI6CY88jv1D8rYrZBqb+1qCZ9+5UIYh2XsNlII5yp
   rEjCSC6h+PmgMC0U5qAOabhM0SvO2JlJzoZLjw1bLw9zQzh76UzggDPJa
   duYeranOu1vfID7rz1ie1f4XU34qDvuRroq/2yr89hXuqhtqNWIkhE18Y
   1ekqmBbQtsM4b3+Tc7sCWgsC948JdOMLaA85SGg67CH1De8XNMYR6ON+y
   /9YyyQeGl+BCl9nyYntDsb7iF4rxj7gCAWeFwKrLnFUwpm+4QwzjA0dBF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="363368698"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="363368698"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 11:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838309700"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="838309700"
Received: from dshvarts-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.204])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 11:19:23 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        intel-xe@lists.freedesktop.org
Subject: Re: [Intel-xe] [PATCH 2/3] linux/bits.h: Add fixed-width GENMASK
 and BIT macros
In-Reply-To: <ZJHkthMktY83pwvy@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
 <ZF4fi5B7PPlgZBOI@smile.fi.intel.com> <87pm75kd0h.fsf@intel.com>
 <ZF4j0NPoBGMBT8CO@smile.fi.intel.com> <87mt29kc34.fsf@intel.com>
 <ZIs0CC2J7nu0LHEK@smile.fi.intel.com> <875y7igph5.fsf@intel.com>
 <ZJG91zMQW3Rnvdbe@smile.fi.intel.com>
 <amgwl5mthhqgvgkqnor6tjfcr3x3pgwvpqin5efwwjfpdhvvpa@vhzhiq5mzsdg>
 <ZJHkthMktY83pwvy@smile.fi.intel.com>
Date:   Tue, 20 Jun 2023 21:19:20 +0300
Message-ID: <87ttv2f13r.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> So, what does prevent you from using GENMASK_ULL()?
>
> Another point, you may teach GENMASK() to issue a warning if hi and/or lo
> bigger than BITS_PER_LONG.

What good does that do if you want the warning for a fixed size
different from unsigned long or long long? Worse, sizeof(long) depends
on arch, while the GENMASK you want depends on the use case.

> I still don't see the usefulness of that churn.

This thread is turning into a prime example of why drivers and
subsystems reinvent their own wheels instead of trying to get generally
useful stuff merged in kernel headers. :p


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
