Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66DE6A497B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjB0SUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjB0ST7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:19:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20CE078;
        Mon, 27 Feb 2023 10:19:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4603B60DEA;
        Mon, 27 Feb 2023 18:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE64C4339C;
        Mon, 27 Feb 2023 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677521997;
        bh=MdVd1A1n9fbYRjjUTOn4iwg1RDnWWorsLDZ3ptrlFcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6gYBlCJoDJv1TvVWmV2HycVsYhOWTw0PZsHwYSRSW7undoqby12kYYEBsqTgNsLo
         +UeZ6nSdnEXG+yvDYIUqqEebqYqMwYpUdjElHe4f5wEQQiNm8DCj5l2lGUq1gSSMJ3
         m3eGLG3vd0ZzkJElrRuCBt0QaZHp5NQeRNZf8wBNjPVSe71ukT7wg8RLRNVfJJz6bR
         PacbhP2xbQ7V+j0W3sk/m5K92p7JN5Tej53EstVDk7vVIfrrg7RyEmER4z6AFfG2qD
         AV+0CLDOj/wDGSbcxeuMZinVM2qaWX3+2Hcnbn/b5sxcmg3/P0ejnjibISdrna4IhW
         O5z8C4FlMux9A==
Date:   Mon, 27 Feb 2023 10:19:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - fix RNG performance in fuzz tests
Message-ID: <Y/z0S7u01VRM1Z6e@sol.localdomain>
References: <20230227055018.1713117-1-ebiggers@kernel.org>
 <c18250f8126b92478e31817c4162286a31983f51@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c18250f8126b92478e31817c4162286a31983f51@opteya.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 08:13:41AM +0000, Yann Droneaud wrote:
> > +/*
> > + * The fuzz tests use prandom instead of the normal Linux RNG since they don't
> > + * need cryptographically secure random numbers. This greatly improves the
> > + * performance of these tests, especially if they are run before the Linux RNG
> > + * has been initialized or if they are run on a lockdep-enabled kernel.
> > + */
> > +
> > +static inline void init_rnd_state(struct rnd_state *rng)
> > +{
> > + static atomic64_t next_seed;
> > +
> > + prandom_seed_state(rng, atomic64_inc_return(&next_seed));
> 
> Isn't making this deterministic defeating the purpose of fuzzing ?
> 
> Regards.

No, it's still fuzzing.  It just means that you'll no longer get different test
cases each individual time you boot the kernel.  Which seems like mostly a good
thing, since it makes test failures reproducible.

This seemed like the obvious thing to do now that we're not using an API that
doesn't provide this option.  Though now that you draw attention to it, there is
indeed a tradeoff that rare bugs will be harder to find.  I suppose that making
it deterministic ought to be a separate patch so that this one isn't doing two
different things.  I'll make this patch use get_random_u64() here instead.

- Eric
