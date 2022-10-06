Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B871A5F631D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiJFIzp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Oct 2022 04:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiJFIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:55:43 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 01:55:39 PDT
Received: from ouvsmtp1.octopuce.fr (ouvsmtp1.octopuce.fr [194.36.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACE795E40;
        Thu,  6 Oct 2022 01:55:39 -0700 (PDT)
Received: from panel.vitry.ouvaton.coop (unknown [194.36.166.20])
        by ouvsmtp1.octopuce.fr (Postfix) with ESMTPS id 7717D173;
        Thu,  6 Oct 2022 10:17:18 +0200 (CEST)
Received: from sm.ouvaton.coop (ouvadm.octopuce.fr [194.36.166.2])
        by panel.vitry.ouvaton.coop (Postfix) with ESMTPSA id 376215E16F9;
        Thu,  6 Oct 2022 10:17:18 +0200 (CEST)
MIME-Version: 1.0
Date:   Thu, 06 Oct 2022 08:17:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
From:   "Yann Droneaud" <ydroneaud@opteya.com>
Message-ID: <125581881ad4aa85b2dadfe0d7338af9901caa03@opteya.com>
Subject: Re: [PATCH v1 0/5] treewide cleanup of random integer usage
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "Julia Lawall" <Julia.Lawall@inria.fr>,
        "Nicolas Palix" <nicolas.palix@imag.fr>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221005214844.2699-1-Jason@zx2c4.com>
References: <20221005214844.2699-1-Jason@zx2c4.com>
X-Originating-IP: 10.0.20.16
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

6 octobre 2022 à 04:51 "Jason A. Donenfeld" a écrit:

> 
> This is a five part treewide cleanup of random integer handling. The
> rules for random integers are:
> 
> - If you want a secure or an insecure random u64, use get_random_u64().
> - If you want a secure or an insecure random u32, use get_random_u32().
>  * The old function prandom_u32() has been deprecated for a while now
>  and is just a wrapper around get_random_u32().
> - If you want a secure or an insecure random u16, use get_random_u16().
> - If you want a secure or an insecure random u8, use get_random_u8().
> - If you want secure or insecure random bytes, use get_random_bytes().
>  * The old function prandom_bytes() has been deprecated for a while now
>  and has long been a wrapper around get_random_bytes().
> - If you want a non-uniform random u32, u16, or u8 bounded by a certain
>  open interval maximum, use prandom_u32_max().
>  * I say "non-uniform", because it doesn't do any rejection sampling or
>  divisions. Hence, it stays within the prandom_* namespace.
> 
> These rules ought to be applied uniformly, so that we can clean up the
> deprecated functions, and earn the benefits of using the modern
> functions. In particular, in addition to the boring substitutions, this
> patchset accomplishes a few nice effects:
> 
> - By using prandom_u32_max() with an upper-bound that the compiler can
>  prove at compile-time is ≤65536 or ≤256, internally get_random_u16()
>  or get_random_u8() is used, which wastes fewer batched random bytes,
>  and hence has higher throughput.
> 
> - By using prandom_u32_max() instead of %, when the upper-bound is not a
>  constant, division is still avoided, because prandom_u32_max() uses
>  a faster multiplication-based trick instead.
> 
> - By using get_random_u16() or get_random_u8() in cases where the return
>  value is intended to indeed be a u16 or a u8, we waste fewer batched
>  random bytes, and hence have higher throughput.
> 
> So, based on those rules and benefits from following them, this patchset
> breaks down into the following five steps:
> 
> 1) Replace `prandom_u32() % max` and variants thereof with
>  prandom_u32_max(max).
> 
> 2) Replace `(type)get_random_u32()` and variants thereof with
>  get_random_u16() or get_random_u8(). I took the pains to actually
>  look and see what every lvalue type was across the entire tree.
> 
> 3) Replace remaining deprecated uses of prandom_u32() with
>  get_random_u32(). 
> 
> 4) Replace remaining deprecated uses of prandom_bytes() with
>  get_random_bytes().
> 
> 5) Remove the deprecated and now-unused prandom_u32() and
>  prandom_bytes() inline wrapper functions.
> 

Did you use some coccinelle patches ? Or other semantic patch tool ?

Maybe we could introduce some coccinelle patch to ensure future get_random_u{16,32,64} usages be checked and patched to use the best fit.

Regards.

-- 
Yann Droneaud
OPTEYA
