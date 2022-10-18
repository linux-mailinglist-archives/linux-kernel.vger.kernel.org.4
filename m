Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540C26024EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJRHEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiJRHE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DFC13DDA;
        Tue, 18 Oct 2022 00:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6CC061487;
        Tue, 18 Oct 2022 07:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AB3C433C1;
        Tue, 18 Oct 2022 07:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666076666;
        bh=nzOkWr31YDiUOeIbP4635LhimacOpccRoPiypQjEzA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOnM0MeBov5bhe9aPWFjq9/qju0h1sLn4ikh0b+N16j6eKKRq4sl4qL7enrW/bMUx
         c1HQguA+ds7DQo0tJNARGtxUOy6mgr/9OPQIMdb7LexoALaeMpktI5JhU/MLrlrgAV
         MUZrj6pfr7H0X/yphD3LL9OnX/5k7EAc8rErw35LdKuq5ADTam26azDrVEKgh0zjSX
         dN1B6Zfp8Dtv7j0jeSYYZ/rsLASxZDSucOypJw4J/BK+qFAJQoRJnSkS/qDARbdpHa
         lpupiXAbvjtoYbFbYnjMoAtdmmC26A9p+RIFTaKAho2Zni595cROGiZ9IoP+MPZaBk
         NfImpGadDPPxg==
Date:   Tue, 18 Oct 2022 00:04:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        sneves@dei.uc.pt
Subject: Re: [PATCH] random: use rejection sampling for uniform bounded
 random integers
Message-ID: <Y05P+KTzFHGaK4C3@sol.localdomain>
References: <20221017023752.3907-1-Jason@zx2c4.com>
 <Y02ehdiCtHyLErB8@sol.localdomain>
 <Y046F2pGjC0apna0@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y046F2pGjC0apna0@zx2c4.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:31:03PM -0600, Jason A. Donenfeld wrote:
> On Mon, Oct 17, 2022 at 11:27:17AM -0700, Eric Biggers wrote:
> > On Sun, Oct 16, 2022 at 08:37:53PM -0600, Jason A. Donenfeld wrote:
> > > In order to be efficient, we implement a kernel-specific variant of
> > > Daniel Lemire's algorithm from "Fast Random Integer Generation in an
> > > Interval", linked below. The kernel's variant takes advantage of
> > > constant folding to avoid divisions entirely in the vast majority of
> > > cases, works on both 32-bit and 64-bit architectures, and requests a
> > > minimal amount of bytes from the RNG.
> > > 
> > > Link: https://arxiv.org/pdf/1805.10941.pdf
> > 
> > Thanks for doing this!  Your code looks correct, but it was hard for me to
> > understand until I read the paper that is linked to.  Could you include a brief
> > comment in the code that explains the algorithm?  Also, though the code looks
> > correct, I assume that you've also explicitly tested that each of the four code
> > paths produce uniform random numbers as intended?
> 
> Yes, I've tested those, and they work. (Threw a lot of cores and ram at
> it.)
> 
> I could include a comment, sure. What do you have in mind? A
> line-by-line thing, or just a short blurb at the top of the function?
> 
> Jason

A comment at the top of the function would be good.

- Eric
