Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E886023C9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiJRFbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJRFbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:31:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539C697EF9;
        Mon, 17 Oct 2022 22:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEBE9B81CD8;
        Tue, 18 Oct 2022 05:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D9CC433D6;
        Tue, 18 Oct 2022 05:31:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZhjdXf/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666071066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IfT8FCupjHgZShjL2XGDOSYwTJpe93DPuuQkU3piicg=;
        b=ZhjdXf/BO0yg8xyeMOcbErVr8U5H9y5p392jqGgNvaDo+uqbkzrANQdCWQWNB9+eGzkLcm
        Mm4wu0FXwGgPwmHIGjPf/0N5QCC3V/55TiulLd3yYNDODqZjq1P2VI/vd1mFlK/h2uf1k3
        AoRm6OzhTdhOLnE3GexEGZu5cPaTTz0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b57869f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 18 Oct 2022 05:31:05 +0000 (UTC)
Date:   Mon, 17 Oct 2022 23:31:03 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        sneves@dei.uc.pt
Subject: Re: [PATCH] random: use rejection sampling for uniform bounded
 random integers
Message-ID: <Y046F2pGjC0apna0@zx2c4.com>
References: <20221017023752.3907-1-Jason@zx2c4.com>
 <Y02ehdiCtHyLErB8@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y02ehdiCtHyLErB8@sol.localdomain>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:27:17AM -0700, Eric Biggers wrote:
> On Sun, Oct 16, 2022 at 08:37:53PM -0600, Jason A. Donenfeld wrote:
> > In order to be efficient, we implement a kernel-specific variant of
> > Daniel Lemire's algorithm from "Fast Random Integer Generation in an
> > Interval", linked below. The kernel's variant takes advantage of
> > constant folding to avoid divisions entirely in the vast majority of
> > cases, works on both 32-bit and 64-bit architectures, and requests a
> > minimal amount of bytes from the RNG.
> > 
> > Link: https://arxiv.org/pdf/1805.10941.pdf
> 
> Thanks for doing this!  Your code looks correct, but it was hard for me to
> understand until I read the paper that is linked to.  Could you include a brief
> comment in the code that explains the algorithm?  Also, though the code looks
> correct, I assume that you've also explicitly tested that each of the four code
> paths produce uniform random numbers as intended?

Yes, I've tested those, and they work. (Threw a lot of cores and ram at
it.)

I could include a comment, sure. What do you have in mind? A
line-by-line thing, or just a short blurb at the top of the function?

Jason
