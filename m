Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE54743573
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjF3G77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjF3G75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379EB10F8;
        Thu, 29 Jun 2023 23:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCF5C616B7;
        Fri, 30 Jun 2023 06:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DF7C433C0;
        Fri, 30 Jun 2023 06:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688108395;
        bh=OHVwB6AqoCRWSUdVLQgpPTx6eiqexiT0q7Vmk/ufVo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tsn+BTw0Hw74U1V97NJdAkIInwS7ZwrpnA2CLB8z2V0ZU0NZ2C5SVji8USvD/PlFH
         PWnRPaskwErJvX9nGu0pd3P9G1oV2k5RCqRFaQX5jw3C1dxYx8eG0hoDIDpFjS8E3f
         nmTLe7IjAd2fLj2a0rVG7meoPGqqHxyzafwdqQz0He9QZk6U8KVsv+maxhVS+f7yLD
         OylWO48fIDJ4fZJH1dAK2nWVA/llQM19zJ52lhF7Jvnp1wHiAzUwtCaQYQ4xfhazGB
         /ZlONoxZNF5u+Zbrfvu47rL0Kxywt8LPw3wMBCivXfFw1krRCtaD4kMPtJcfV1bt+Z
         DqrNepJz78YJw==
Date:   Thu, 29 Jun 2023 23:59:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dongsoo Lee <letrhee@nsr.re.kr>
Cc:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        'Jens Axboe' <axboe@kernel.dk>,
        "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        'Jaegeuk Kim' <jaegeuk@kernel.org>,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] fscrypt: Add LEA-256-XTS, LEA-256-CTS support
Message-ID: <20230630065953.GA36542@sol.localdomain>
References: <20230626084703.907331-1-letrhee@nsr.re.kr>
 <20230626084703.907331-5-letrhee@nsr.re.kr>
 <20230628063830.GA7920@sol.localdomain>
 <000901d9aa70$a228c420$e67a4c60$@nsr.re.kr>
 <20230630025914.GB1088@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630025914.GB1088@sol.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 07:59:14PM -0700, Eric Biggers wrote:
> On Thu, Jun 29, 2023 at 07:01:11PM +0900, Dongsoo Lee wrote:
> > On Tue, Jun 27, 2023 at 23:38:30 -0700, Eric Biggers wrote:
> > >On Mon, Jun 26, 2023 at 05:47:03PM +0900, Dongsoo Lee wrote:
> > >> when SIMD instructions are available, it performs even faster.
> > >
> > >This will only be true once there is actually an applicable implementation
> > of
> > >LEA-XTS and LEA-CTS using SIMD instructions included in the kernel.
> > >
> > >Perhaps it is your plan to go through and accelerate LEA-XTS and LEA-CTS
> > for the
> > >common CPU architectures.  However, it is not included in this patchset
> > yet, so
> > >it should not be claimed in the documentation yet.
> > >
> > >> Particularly, it outperforms AES when the dedicated crypto
> > >> +instructions for AES are unavailable, regardless of the presence of SIMD
> > >> +instructions. However, it is not recommended to use LEA unless there is
> > >> +a clear reason (such as the absence of dedicated crypto instructions for
> > >> +AES or a mandatory requirement) to do so. Also, to enable LEA support,
> > >> +it needs to be enabled in the kernel crypto API.
> > >
> > >I think I'd prefer that you omit the mention of the "absence of dedicated
> > crypto
> > >instructions" use case for now.  fscrypt already supports another algorithm
> > that
> > >fulfills exactly that use case (Adiantum), and that algorithm already has
> > >optimized implementations for arm32, arm64, and x86_64.  LEA does not have
> > that
> > >yet.  So it does not really bring anything new to the table.  I'm also
> > unsure it
> > >would be appropriate to recommend a "lightweight" cipher at this point...
> > >
> > >That would leave "mandatory requirement" as the rationale, at least for
> > now,
> > >similar to SM4.
> > >
> > >- Eric
> > 
> > As you might expect, we are working on a SIMD implementation of LEA in a
> > general-purpose CPU environment. However, since no such implementation has
> > been submitted yet, we agree that it's right to leave it out for now.
> > 
> > In the next version, we would like to change the description to the
> > following:
> > 
> > LEA is a South Korean 128-bit block cipher (with 128/192/256-bit keys)
> > included in the ISO/IEC 29192-2:2019 standard (Information security -
> > Lightweight cryptography - Part 2: Block ciphers). If dedicated cipher
> > instructions are available, or other options with performance benefits
> > are available, using LEA is likely not a suitable choice. Therefore,
> > it is not recommended to use LEA-256-XTS unless there is a clear reason
> > to do so, such as if there is a mandate. Also, to enable LEA support,
> > it needs to be enabled in the kernel crypto API.
> 
> I don't think that really addresses my comment, due to the second sentence.  I
> understand that you would like to advertise the performance of LEA.  But as I
> mentioned, it's not yet realized in the kernel crypto API, and in the context of
> fscrypt it won't really bring anything new to the table anyway.  For now I think
> LEA is best described as a "national pride cipher" alongside SM4...  Keep in
> mind, it can always be changed later if new use cases come up.
> 
> Could you just omit the documentation update from your patch?  I actually need
> to rework the whole "Encryption modes and usage" section anyway since it's
> growing a bit unwieldy, with 6 different combinations of encryption modes now
> supported.  The information needs to be organized better.  It currently reads
> like a list, and it might be hard for users to understand which setting to use.
> 
> I'll add on a patch that does that and adds the mention of LEA support.
> 
> - Eric

I've sent out
https://lore.kernel.org/linux-fscrypt/20230630064811.22569-1-ebiggers@kernel.org/T/#u.
One of the things it does is add a nice list for the "national pride ciphers".
So we can just add ciphers like SM4 and LEA, and any that people might insist on
adding in the future like Camellia, Kuznyechik, SEED, ARIA, etc., to that list,
and not have to waste time with each one individually...

- Eric
