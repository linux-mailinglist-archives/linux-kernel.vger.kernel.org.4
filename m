Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED66118A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiJ1RCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJ1RCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:02:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC70B1EEF0E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:00:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id ay12so3183145qtb.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RYQ/XmUKTLIxg2/bBmBEhVhgLpDBA+IR/MiWfkS8faQ=;
        b=eK2T2BFZsMmVIyYtBs0TxAqvAjJMJJviEskSG1mmTefcz83Qzml2HsKCVNkCupdd2Q
         kMtz6rPibF59y3E35JL6+FcUdlPBl8oOyyT2G043EshulM6VnuWi8moV2m573xCNnV55
         2YzXQCGz/TXOJnFhLZ4U4gZ35iLyjiLt2nuu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYQ/XmUKTLIxg2/bBmBEhVhgLpDBA+IR/MiWfkS8faQ=;
        b=AZb4ufucFZ2UhWvujzJE6r+yfGk2uDuCzwVcOTyS7PNINwmRayoMXB3l9UqrtI3VEQ
         KSaR1uRwUsAK+2PYYkZb2nTm0t+A8EV+LFa/wcEfDI1hXnkHIbl+uNzp8KTfI2fHEykn
         u1nJPmmNePrKJf27nr2I3p3sR53kZ6Jm3Pt1PzgIq/hcJaKvRciveNA8RNof1v1/bhEg
         4Axanof8Ni8073Y+IEJAmZfGGy8vCnjupt+J18j+p7+W9rpLRvME6L0lPt0p074T6L9h
         s0bHx8hq3mXnxtrOxp/o9qNIZzrf335f32GsiNUMzugKIM6TU04yHEKj5+2jxabSsKL0
         lCHA==
X-Gm-Message-State: ACrzQf1aUmOOZIir0Fws91B7k1uaMLw8Mu6Jq2sWGfOmQKeERNCzUMe0
        qYkrx0/K6dk5WhNwRKnX73njz/sEVM4SJA==
X-Google-Smtp-Source: AMsMyM4mlqb3EILiG8BAAKFV0FNCJ4Kyjza3UWyRvAlzfeCXasmaPnvg55A1OwAwqT2wGxolLTLElA==
X-Received: by 2002:a05:622a:58f:b0:39d:10f3:cae4 with SMTP id c15-20020a05622a058f00b0039d10f3cae4mr376375qtb.604.1666976451606;
        Fri, 28 Oct 2022 10:00:51 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a280b00b006eee3a09ff3sm3248993qkp.69.2022.10.28.10.00.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 10:00:50 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id t186so6771994yba.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:00:50 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr148973ybk.501.1666976450437; Fri, 28 Oct
 2022 10:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211029041408.GA3192@gondor.apana.org.au> <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au> <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au> <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au> <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au> <Y0zcWCmNmdXnX8RP@gondor.apana.org.au> <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
In-Reply-To: <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 10:00:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtC_Z5_xU1q3HTvvLKhjeq--EmSEtkJdfzuFtJs8uQfA@mail.gmail.com>
Message-ID: <CAHk-=wjtC_Z5_xU1q3HTvvLKhjeq--EmSEtkJdfzuFtJs8uQfA@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Fixes for 6.1
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 9:58 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> This push fixes an alignment crash in x86/polyval.

I'm surprised that there isn't a cra_ctxalignment field. Instead there
is crypto_tfm_ctx_alignment(), but that is just an odd way to write
CRYPTO_MINALIGN.

            Linus
