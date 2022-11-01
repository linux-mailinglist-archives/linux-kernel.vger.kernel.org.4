Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BFA614B4F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKANDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiKANDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:03:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3D1B798
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 128F4B81BD2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 13:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB39C433D6;
        Tue,  1 Nov 2022 13:03:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="myvlQccd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667307780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aGf3HRCgre3btUoaDn4OQ44V8myJz/3Xau3fRCIpvUk=;
        b=myvlQccdLLbbOrtow+kUbH/oXOYEc8Oy9LENIq4/ncat6FPoYRAVx9139m1B9/8SVuOXJ1
        CIkMB7K2W8O7BGFtcBthO1d7Z+zw2tKWQkTc2ucHEyTq76TFDkgcaYSwkHDXHW/NN0rtmP
        RBf5hazhmW6EgCY1N4D/nZJ8eKI2Jr0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 52812150 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Nov 2022 13:03:00 +0000 (UTC)
Date:   Tue, 1 Nov 2022 14:02:58 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v5] random: remove early archrandom abstraction
Message-ID: <Y2EZAsRA8uS+ppnn@zx2c4.com>
References: <20221101115616.232884-1-Jason@zx2c4.com>
 <20221101122527.323843-1-Jason@zx2c4.com>
 <Y2ESilMCF9eeffW6@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2ESilMCF9eeffW6@FVFF77S0Q05N>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Nov 01, 2022 at 12:36:07PM +0000, Mark Rutland wrote:
> Hi Jason,
> 
> Sorry for joining this late...
> 
> On Tue, Nov 01, 2022 at 01:25:28PM +0100, Jason A. Donenfeld wrote:
> > The arch_get_random*_early() abstraction is not completely useful and
> > adds complexity, because it's not a given that there will be no calls to
> > arch_get_random*() between random_init_early(), which uses
> > arch_get_random*_early(), and init_cpu_features(). During that gap,
> > crng_reseed() might be called, which uses arch_get_random*(), since it's
> > mostly not init code.
> 
> The original rationale for arch_get_random*_early() was just to seed the RNG
> more robustly rather than to feed every possible arch_get_random() call made
> early in the boot flow, and the rationale for having a separate functions was
> that it was trivial to see by inspection that it was (only) called in the
> expected places.
> 
> I'm not wedded to arch_get_random*_early() specifically, but I do think that
> having arch_get_random() behave differently depending on which phase of boot
> we're in has more scope for error than having a separate call of some sort.
> 
> Other than removing the lines below, what chages is this going to permit?

Firstly, the issue with the API is having to remember to use it! There's
already been a bug from forgetting to use the _early() call during some
refactoring, and I doubt it'll be the last.

But also, functions such as crng_reseed()->extract_entropy() wind up
being called in both early contexts and normal contexts. It's not
feasible to have different paths there, so by having two functions,
we miss out on having access during early boot.

So I don't want a separate call, both for the API complexity reasons,
and because it doesn't really work as intended in the end.

Jason
