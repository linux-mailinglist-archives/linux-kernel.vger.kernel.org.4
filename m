Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA253600620
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJQFJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJQFJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:09:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5DC50711
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 22:09:01 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id k3so11991724ybk.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 22:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VEzm5h9OntgxbzEjmOZCMD/M7H/7hxbpoHa7ynBSAfU=;
        b=T8eEgfyL30dpKq9Kc3Rt7tzPpafj0mLDSPpsFk7I8GXnmflBpe6m0fUGkB9cuwzAA8
         za12aTqLOwTFB17LpfdslKU8DysJuS0tqch/AOSknk1nWNWsvH3Q6BLOYOHCSoPXaFPo
         NYu4ylBhu5bIqBlXbBkGIUwZv4p1J5Uz4S6JDK6k8CH9lTUz1Zhx7ithykzLKg0msSIx
         EcX6RH+crezTmpm1P2G0q79lHKslcAO7Wo2fzYyt1RcUQwnJ3MDEPwn6S3vIsp4Ne9BO
         Ke2Bi4aJoA014+e1vbTfy59iYdVWIxQtgt7ChhuQRylhlsFLAvALMlU4be523bmNPgco
         G+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEzm5h9OntgxbzEjmOZCMD/M7H/7hxbpoHa7ynBSAfU=;
        b=dkZJLkMCUBhYSw4wDuiSUoAr7zNS+xA1AQ2xEkCRupIaU+tAwndf+dQRJwNOUDYDjN
         NlLm5lC7v2b7ZmpYvBSEQGuUls8l+TfSL68dMwON8KfFX3nei7mfmSS33OG32BAGeSOk
         JC9Pcj/z22SEPNbP/87//Kz4EyMSIh7AtLq6iun9pTu1OSNM8wpElrILEIZPxWuxTPqw
         ie4ptb+Nz79muMCwMXt+FcaMpGHPYkMs142g+HibIUxj2k8uYyLnwNaGnNsGPt0xWZLi
         NX5vdmmQzKgzmEgrjGu+jVgb5GWqB6/cctk6gUWaYxj2+e/1Owu3t+V54DTGnlhXERLU
         3ipw==
X-Gm-Message-State: ACrzQf0+BkyZuG5UcWS8h8zmGpY0aoXyLsNWCVSlsywos4cbrY75KPRc
        T5nSwXK9kg4DoBHFX7gZsuCZi70hASIL3HZxmiozlw==
X-Google-Smtp-Source: AMsMyM5KgjpHIV/vRrFHa5Ebdyfgzmp24GLiOhEQVJO1emaTAZJLBk5Yl3qEjwR45uX8V1UU45twAt9ggA5YvVk7a4Y=
X-Received: by 2002:a25:c102:0:b0:6c4:c94:2842 with SMTP id
 r2-20020a25c102000000b006c40c942842mr922664ybf.611.1665983340924; Sun, 16 Oct
 2022 22:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221017044345.15496-1-Jason@zx2c4.com> <CANpmjNM7Sca3YJQ7RK14e_pzB5Wq3_-VokLum6MpqKXq7ixzSQ@mail.gmail.com>
In-Reply-To: <CANpmjNM7Sca3YJQ7RK14e_pzB5Wq3_-VokLum6MpqKXq7ixzSQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sun, 16 Oct 2022 22:08:24 -0700
Message-ID: <CANpmjNO0hu7OHmckU7kAVu+C6Jy_M_yMxe41YmcF2oePxh7Rnw@mail.gmail.com>
Subject: Re: [PATCH] kcsan: remove rng selftest
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 at 22:07, Marco Elver <elver@google.com> wrote:
>
> On Sun, 16 Oct 2022 at 21:43, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > The first test of the kcsan selftest appears to test if get_random_u32()
> > returns two zeros in a row, and requires that it doesn't. This seems
> > like a bogus critera. Remove it.
> >
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Acked-by: Marco Elver <elver@google.com>
>
> Looks pretty redundant at this point (I think some early version had
> it because somehow I managed to run the test too early and wanted to
> avoid that accidentally happening again).
>

And kindly queue it in your tree with all the rng related changes. Thanks!

> > ---
> >  kernel/kcsan/selftest.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
> > index 00cdf8fa5693..1740ce389e7f 100644
> > --- a/kernel/kcsan/selftest.c
> > +++ b/kernel/kcsan/selftest.c
> > @@ -22,13 +22,6 @@
> >
> >  #define ITERS_PER_TEST 2000
> >
> > -/* Test requirements. */
> > -static bool __init test_requires(void)
> > -{
> > -       /* random should be initialized for the below tests */
> > -       return get_random_u32() + get_random_u32() != 0;
> > -}
> > -
> >  /*
> >   * Test watchpoint encode and decode: check that encoding some access's info,
> >   * and then subsequent decode preserves the access's info.
> > @@ -259,7 +252,6 @@ static int __init kcsan_selftest(void)
> >                         pr_err("selftest: " #do_test " failed");               \
> >         } while (0)
> >
> > -       RUN_TEST(test_requires);
> >         RUN_TEST(test_encode_decode);
> >         RUN_TEST(test_matching_access);
> >         RUN_TEST(test_barrier);
> > --
> > 2.37.3
> >
