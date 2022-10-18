Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F03D602EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiJROoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJROod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:44:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0665B2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666104271; x=1697640271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SUwj3kGASYH7/krxPp8za6uw30Nuoq25jipn3cGnyp8=;
  b=KvYIQCIFsttOngHjxU50RnNz9dh0DV6YOJzVdRpBAI+JkczkAsVR7m7Z
   hePKGAJdQNGA7ymVS6+ShgCuM6gRBJR19MScGgAjyQUIwvvT6TEp2MpYY
   xedsqU7VbDU0ZZ7pbq4tsZNO9UlsG79YgZuHLdkSAlQZ5rJHrfZNF9JdC
   h+avM3ypXLM7Hk05Cj5zJQE9CcrEymASSceQ66Gql9JBIDUv83xBfJwOG
   5UB5PhBE/mFMVGVe6yLCLUO+Ygm+YXY9BUpF5ay0Mz8EjcVbVPNcO6mX0
   1PAIjB9Jb31NuTgFLFZLfso8UBM5BtCddzFcmuP/7JZsgo7WITlJFL3vL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332668923"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="332668923"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 07:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="754074895"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="754074895"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 18 Oct 2022 07:44:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oknpB-009QfO-1q;
        Tue, 18 Oct 2022 17:44:09 +0300
Date:   Tue, 18 Oct 2022 17:44:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] lib/cpumask: add FORCE_NR_CPUS config option
Message-ID: <Y067uYGTaA93Hn3z@smile.fi.intel.com>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-6-yury.norov@gmail.com>
 <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
 <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com>
 <mvmlepdb66h.fsf@suse.de>
 <CAMuHMdVeHPR_JH0dJ+WSddjd8_hax70JRzd4pqHLNvgbh+-znw@mail.gmail.com>
 <Y065nbfVQwZhwt51@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y065nbfVQwZhwt51@yury-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 07:35:09AM -0700, Yury Norov wrote:
> On Tue, Oct 18, 2022 at 03:50:31PM +0200, Geert Uytterhoeven wrote:

...

> For those who choose FORCE_NR_CPUS, it's required to set NR_CPUS
> to a value that matches to what's parsed from DT.
> 
> Can you please look at the draft below that disables FORCE_NR_CPUS
> in allmodconfig? If it's OK with you, I'll send a patch. If you think
> that there are architectures where it's not possible to set correct
> NR_CPUS at compile time for some reason, I'll add ARCH_UNFORCE_NR_CPUS
> option.

Instead you may simply add

	depends on CONFIG_$ARCH/$MACHINE=n

and so on to the FORCE_NR_CPUS, no?

-- 
With Best Regards,
Andy Shevchenko


