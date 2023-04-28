Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C786F212D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjD1X3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjD1X3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:29:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B72149DE;
        Fri, 28 Apr 2023 16:29:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7F4263B2D;
        Fri, 28 Apr 2023 23:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBD2C433D2;
        Fri, 28 Apr 2023 23:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682724580;
        bh=BGQ8Q4ym3HRMM5Rede+IH1xVvnCtGfFDwMijdn+iWo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gpt8b2X47azSnfwR1JZ1mHJCGtYj5qao1hftGODMB5Os1HSSCvBhXZVDB9dA2W18U
         Zugyol3rB0LSqOXHOt4qwS+kgB0Kh8l8sRossfj1xPHaiW6zr7oA2bcSkEtlR2VkWf
         9k8eSV7JIutWbH9gkRmWoDqrTv+qFJBhAN6l3QPBcbTdMeaHLcEFZmz0oRblD7mdaZ
         zbEqHy4VGc+cBib2I4beGsTTdkqD1/c8zjDzjde0AoQ0JlQUUvpKSMlduXdvDfW1vo
         1X/NTHUJpwZiGsSdWKyvaEE3oIsHrfYPF2Y/ejarjrbtck3cyxThtr+du2IJqTiYiD
         SqD0zuTbSQQQg==
Date:   Fri, 28 Apr 2023 16:29:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dongsoo Lee <letrhee@nsr.re.kr>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <abc@test.nsr.re.kr>,
        Dongsoo Lee <letrhee@gmail.com>
Subject: Re: [PATCH 1/3] crypto: LEA block cipher implementation
Message-ID: <20230428232938.GB3150@sol.localdomain>
References: <20230428110058.1516119-1-letrhee@nsr.re.kr>
 <20230428110058.1516119-2-letrhee@nsr.re.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428110058.1516119-2-letrhee@nsr.re.kr>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongsoo,

On Fri, Apr 28, 2023 at 08:00:56PM +0900, Dongsoo Lee wrote:
> The LEA is a Korean national standard block cipher, described in
> "KS X 3246" and is also included in the international standard, "ISO/IEC
> 29192-2:2019 standard (Information security - Lightweight cryptography
> - Part 2: Block ciphers)".
> 
> The LEA algorithm is a symmetric key cipher that processes data blocks
> of 128-bits and has three different key lengths, each with a different
> number of rounds:
> 
> - LEA-128: 128-bit key, 24 rounds,
> - LEA-192: 192-bit key, 28 rounds, and
> - LEA-256: 256-bit key, 32 rounds.
> 
> The round function of LEA consists of 32-bit ARX(modular Addition,
> bitwise Rotation, and bitwise XOR) operations.
> 
> The implementation same as submitted generic C implementation is
> distributed through the Korea Internet & Security Agency (KISA).
> 
> - https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
> - https://seed.kisa.or.kr/kisa/Board/20/detailView.do
> 
> Signed-off-by: Dongsoo Lee <letrhee@nsr.re.kr>
> ---
>  crypto/Kconfig       |  12 +
>  crypto/Makefile      |   1 +
>  crypto/lea_generic.c | 915 +++++++++++++++++++++++++++++++++++++++++++
>  include/crypto/lea.h |  39 ++
>  4 files changed, 967 insertions(+)
>  create mode 100644 crypto/lea_generic.c
>  create mode 100644 include/crypto/lea.h

This implementation is very ugly.  There's no need to unroll all the rounds in
the source code as you're doing.  It also makes it very difficult to check the
implementation against the original paper.

I happened to write an LEA implementation several years ago, and IMO it's much
cleaner than this one.  It's less than half the lines of code, despite having a
lot more comments.  I also implemented (and documented) some optimizations, some
of which were recommended in the original LEA paper, IIRC.  Maybe you'd like to
take a look at my implementation for some ideas, or even just use it outright?
You can get it from here:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?h=old/wip-lea&id=1d1cbba14380f8a1abc76baf939b9e51de047fb6

- Eric
