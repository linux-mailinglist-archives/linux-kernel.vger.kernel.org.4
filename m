Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668C0614B59
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKANHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKANHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:07:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06CF31A82D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:07:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1828F1FB;
        Tue,  1 Nov 2022 06:07:50 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 847323F703;
        Tue,  1 Nov 2022 06:07:42 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:07:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v5] random: remove early archrandom abstraction
Message-ID: <Y2EaG7Zo2jiyKUWB@FVFF77S0Q05N>
References: <20221101115616.232884-1-Jason@zx2c4.com>
 <20221101122527.323843-1-Jason@zx2c4.com>
 <Y2ESilMCF9eeffW6@FVFF77S0Q05N>
 <Y2EZAsRA8uS+ppnn@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2EZAsRA8uS+ppnn@zx2c4.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 02:02:58PM +0100, Jason A. Donenfeld wrote:
> Hi Mark,
> 
> On Tue, Nov 01, 2022 at 12:36:07PM +0000, Mark Rutland wrote:
> > Hi Jason,
> > 
> > Sorry for joining this late...
> > 
> > On Tue, Nov 01, 2022 at 01:25:28PM +0100, Jason A. Donenfeld wrote:
> > > The arch_get_random*_early() abstraction is not completely useful and
> > > adds complexity, because it's not a given that there will be no calls to
> > > arch_get_random*() between random_init_early(), which uses
> > > arch_get_random*_early(), and init_cpu_features(). During that gap,
> > > crng_reseed() might be called, which uses arch_get_random*(), since it's
> > > mostly not init code.
> > 
> > The original rationale for arch_get_random*_early() was just to seed the RNG
> > more robustly rather than to feed every possible arch_get_random() call made
> > early in the boot flow, and the rationale for having a separate functions was
> > that it was trivial to see by inspection that it was (only) called in the
> > expected places.
> > 
> > I'm not wedded to arch_get_random*_early() specifically, but I do think that
> > having arch_get_random() behave differently depending on which phase of boot
> > we're in has more scope for error than having a separate call of some sort.
> > 
> > Other than removing the lines below, what chages is this going to permit?
> 
> Firstly, the issue with the API is having to remember to use it! There's
> already been a bug from forgetting to use the _early() call during some
> refactoring, and I doubt it'll be the last.
> 
> But also, functions such as crng_reseed()->extract_entropy() wind up
> being called in both early contexts and normal contexts. It's not
> feasible to have different paths there, so by having two functions,
> we miss out on having access during early boot.
> 
> So I don't want a separate call, both for the API complexity reasons,
> and because it doesn't really work as intended in the end.

If it's too painful to use separate paths, then fair enough. Thanks for the
summary!

Mark.
