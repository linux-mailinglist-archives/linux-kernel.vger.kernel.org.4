Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591785E8B85
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiIXKhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIXKhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0825124178;
        Sat, 24 Sep 2022 03:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E27660B7C;
        Sat, 24 Sep 2022 10:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10835C433C1;
        Sat, 24 Sep 2022 10:37:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L2lBxUZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664015849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h5kgHEcknryBBnHkgrOeyL+fyobuwOkSKDE5eb5/nFg=;
        b=L2lBxUZoujkPUqMlD9NDKETXb6Wv7ghGF+W5D+ItQB/gHYOS7FXwkFDLoTZf7pFj4vVDrk
        C3U2iBCyl4NBKT5oehRixdoWkABuvsQWCIZZiWSGHMXObjrZRA2ObS9LoUbAnucD/F1m1+
        byWqWAohYQgpPt/NAOovvqPmvTJbrOg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e831e8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 24 Sep 2022 10:37:28 +0000 (UTC)
Date:   Sat, 24 Sep 2022 12:37:26 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra
 comparison
Message-ID: <Yy7d5qWpT5Xj2WvN@zx2c4.com>
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
 <20220923154001.4074849-1-Jason@zx2c4.com>
 <20220923155412.b0132fc62eca18817a023cd2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220923155412.b0132fc62eca18817a023cd2@linux-foundation.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Sep 23, 2022 at 03:54:12PM -0700, Andrew Morton wrote:
> On Fri, 23 Sep 2022 17:40:01 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> 
> > Currently the clamp algorithm does:
> > 
> > 	if (val > hi)
> > 		val = hi;
> > 	if (val < lo)
> > 		val = lo;
> > 
> > But since hi > lo by definition, this can be made more efficient with:
> > 
> > 	if (val > hi)
> > 		val = hi;
> > 	else if (val < lo)
> > 		val = lo;
> > 
> > So fix up the clamp and clamp_t functions to do this, adding the same
> > argument checking as for min and min_t.
> > 
> 
> The patch adds 140 bytes of text to mm/memblock.o, for example. 
> Presumably from the additional branch.  Larger text means larger cache
> footprint means slower.
> 
> So where's the proof that this change gives us a more efficient kernel?

For x86, code generation ought to be the same, because the compiler can
still generate cmovs for all:

unsigned int clamp1(unsigned int val, unsigned int lo, unsigned int hi)
{
    if (val >= hi)
        val = hi;
    if (val <= lo)
        val = lo;
    return val;
}

unsigned int clamp2(unsigned int val, unsigned int lo, unsigned int hi)
{
    if (val >= hi)
        val = hi;
    else if (val <= lo)
        val = lo;
    return val;
}

On x86_64 this is:

clamp1:
        cmp     edi, edx
        mov     eax, esi
        cmova   edi, edx
        cmp     edi, esi
        cmovnb  eax, edi
        ret
clamp2:
        cmp     edi, esi
        mov     eax, edx
        cmovnb  esi, edi
        cmp     edi, edx
        cmovb   eax, esi
        ret

The latter one clever compares hi and lo first. I observe the same when
hi and lo are constants instead. So no change.

On ARM64 the same thing happens:

clamp1:
        cmp     w0, w2
        csel    w8, w0, w2, lo
        cmp     w8, w1
        csel    w0, w8, w1, hi
        ret
clamp2:
        cmp     w0, w1
        csel    w8, w0, w1, hi
        cmp     w0, w2
        csel    w0, w8, w2, lo
        ret

On MIPS64, on the other hand, we save some arithmetic and the number of
branches remains the same:

clamp1:
        sltu    $3,$6,$4
        bne     $3,$0,.L2
        move    $2,$6

        move    $2,$4
.L2:
        sltu    $3,$2,$5
        bnel    $3,$0,.L7
        move    $2,$5

.L7:
        jr      $31
        nop

clamp2:
        sltu    $3,$4,$6
        beq     $3,$0,.L13
        move    $2,$6

        sltu    $3,$4,$5
        bne     $3,$0,.L12
        move    $2,$4

.L13:
        jr      $31
        nop

.L12:
        jr      $31
        move    $2,$5

So it seems like, at least in isolation, this is only a win?

It's possible that when inlined into a more complex function that the
various cases are optimized together and a branch is introduced if the
compiler thinks its better; but alone I'm not seeing that happen.

Or maybe older compilers do something worse? On x86_64, clang doesn't do
the smart thing until clang 13 and gcc not until gcc 11. So maybe your
text size blew up because your compiler is old?

Either way, I agree that text size increase is not a good idea, and we
should avoid that if we can.

Worth noting, by the way, is that the input validation check already
caught a bug when 0day test bot choked:

https://lore.kernel.org/linux-hwmon/20220924101151.4168414-1-Jason@zx2c4.com/

So, options:
1) Keep this patch as-is, because it is useful on modern compilers.
2) Add an ifdef on compiler version, so we generate the best code in
   each case.
2) Go back to testing twice, but keep the checker macro because it's
   apparently useful.
4) Do nothing and discard this series.

Any of those are okay with me. Opinions?

Jason
