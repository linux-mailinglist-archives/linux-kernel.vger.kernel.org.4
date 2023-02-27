Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC66A4D05
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjB0VSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjB0VSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:18:37 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5491FC167
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:18:03 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5384ff97993so214533527b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=861ENRhd8EcHSgkNed94lLcOy+3hO+Ai15ZLxiI8kpM=;
        b=kloYiVK17/dt2g3sp7Dfx3rk4LMRwTyDQgC5p0DMXht369w9cWMi9xv7oVE/2p3m9q
         APhG6yjBMR1RV1BkutloNYHI/oKXML0JscnUGWpgoPTr5hGSK0RWsyasxlZsVIFSkbdt
         dgUIrX23diNJXG+RUt9nJMrga98jtbyGd0PpIzC8UGEi4uaKfVOOlSnkr2BVp636gGPU
         oCwBueM+qUp0hrN52MRgMAxZmDDufSyBMPqz7wni4mu0VjOUOBF9KAmDfsUv1rxN3BPA
         kQcR9YDXDLcH8SC/JjCS8CZNtglOl6t+57ywwIDCk/zhZMj0yljfLe6CE0/zDKwsrLxc
         gDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=861ENRhd8EcHSgkNed94lLcOy+3hO+Ai15ZLxiI8kpM=;
        b=ilfOldbicCfM9Ao1Vas1OqOZGrWzepZACiAzmFZg1sH/9ft6kUGyoIRD75FQk/r7Ub
         sdhonGvLS6YujkwHM1uf+hSMA9TP1rzhJfluxvG3Rwu3TQsELLn7kfkBl4f/3qedDytu
         au17rXSS4g5YYejevtLIuugX6NTSzyIY7W5pG/hhU4mKr2rO6Xupn66aTyYnmS1LVsUV
         753211qSeP+MZOowMM6xcksDVt7TYU4V21bPF1fLZyaD5r6it+H86pDuYuPJ/zK52NTg
         Oh8EaoFd7qQTIXn3UVSz4Ovpd9L0VDztk9acfPpPzLyJBqHkt0OgWkJr0SRrx/O0mocf
         K8jg==
X-Gm-Message-State: AO0yUKUuiTOVrwx5Y07j2xNN+5wqvu5XOu2tib/nPW3TTW6EBsh4/44h
        a570wc5YAiQyd3pV0/gtdbw/lgTMfam7RsX1ySc4wg==
X-Google-Smtp-Source: AK7set//HnE1NkogtMQUUnKRN9ZnMZvonCvFO7FMIxs+p8rQ32omlyXDjNQIPGNptsPySH4EGsfKDlYCxpjMnXONZwM=
X-Received: by 2002:a5b:685:0:b0:9f1:6c48:f95f with SMTP id
 j5-20020a5b0685000000b009f16c48f95fmr75674ybq.5.1677532681340; Mon, 27 Feb
 2023 13:18:01 -0800 (PST)
MIME-Version: 1.0
References: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au> <20230224231430.2948-1-kunyu@nfschina.com>
 <Y/cy5wUtk10OahpO@gondor.apana.org.au> <CACRpkdYyB=-UnE1bmdVszSSB5ReECZ0fUoWJX6XtYbKHEe52tA@mail.gmail.com>
 <Y/c7iVW67Xhhdu8e@gondor.apana.org.au> <Y/hQdzsKMYgkIfMY@gondor.apana.org.au> <Y/yIbPBVCPx9K/0s@gondor.apana.org.au>
In-Reply-To: <Y/yIbPBVCPx9K/0s@gondor.apana.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Feb 2023 22:17:49 +0100
Message-ID: <CACRpkdZC4z2Xng4=k94rmM=AFzNzTdXkvtkArMnK7afouz=7VA@mail.gmail.com>
Subject: Re: [v3 PATCH] crypto: stm32 - Save and restore between each request
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:39 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:

> v3 moves the exported state into its own structure so that it
> doesn't contain unnecessary data.  It also subsumes the "empty
> message" patch, as only the stm32_hash_copy_hash hunk was really
> needed and it's easiest if we put that here.

Thanks Herbert, now the driver probes fine, but unfortunately the tests
fail:

[    2.963725] alg: extra crypto tests enabled.  This is intended for
developer use only.
[   17.106532] Key type encrypted registered
[   23.804729] stm32-hash a03c2000.hash: allocated hmac(sha256) fallback
[   23.812529] alg: ahash: stm32-hmac-sha256 test failed (wrong
result) on test vector 0, cfg="init+update+final aligned buffer"
[   23.823902] alg: self-tests for hmac(sha256) using
stm32-hmac-sha256 failed (rc=-22)
[   23.823924] ------------[ cut here ]------------
[   23.836312] WARNING: CPU: 0 PID: 72 at crypto/testmgr.c:5858
alg_test.part.0+0x4d0/0x4dc
[   23.844449] alg: self-tests for hmac(sha256) using
stm32-hmac-sha256 failed (rc=-22)
[   23.844460] Modules linked in:
[   23.855261] CPU: 0 PID: 72 Comm: cryptomgr_test Not tainted
6.2.0-12019-g4bc85a2f8f63 #65
[   23.863440] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
[   23.870408]  unwind_backtrace from show_stack+0x10/0x14
[   23.875653]  show_stack from dump_stack_lvl+0x40/0x4c
[   23.880727]  dump_stack_lvl from __warn+0x94/0xc0
[   23.885450]  __warn from warn_slowpath_fmt+0x118/0x164
[   23.890603]  warn_slowpath_fmt from alg_test.part.0+0x4d0/0x4dc
[   23.896540]  alg_test.part.0 from cryptomgr_test+0x18/0x38
[   23.902042]  cryptomgr_test from kthread+0xc0/0xc4
[   23.906847]  kthread from ret_from_fork+0x14/0x2c
[   23.911557] Exception stack(0xf0f39fb0 to 0xf0f39ff8)
[   23.916609] 9fa0:                                     00000000
00000000 00000000 00000000
[   23.924783] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   23.932956] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   23.939604] ---[ end trace 0000000000000000 ]---


All tests fail on vector 0 or 1.

I am trying to debug!

Yours,
Linus Walleij
