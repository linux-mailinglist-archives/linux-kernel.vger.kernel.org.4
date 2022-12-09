Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF9648868
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLISZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLISZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:25:28 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBA4379E9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:25:27 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id x28so4193745qtv.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p2tFGeL4IKHMOLG8K5mBjsPyTa/gwxZuO/Te7d5SkhM=;
        b=R1vwKVYxDcZhuATY+em4HS+UfJ6NrYR93eYQSQkP/OWCN4igMlPzqxVqlrHNSJdMuk
         /E0ywCJEKO+mIaZDAXA6HXw/X1TV964NRZrcyezSbFFg4WgU4w2lnAS1BSNf5QmFx0kz
         1WkDjTNi3H5RBcykqyMCXLYk65nnMVhnooMyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2tFGeL4IKHMOLG8K5mBjsPyTa/gwxZuO/Te7d5SkhM=;
        b=Sdk7gTZu0YV8xXaPq2++LcJ8OkNOVqPmvXBV3I4cRCM/7Lns+RFoMc0UptPMUCKGf4
         Ksg+xE6WAdIgfw8z5ks1PdT8xCa2X52hz8IZKaIaa/KRGiKLTEPYmRzDcx70kHmvj9L+
         hwcxmxMPLHYO1jsnmShnRU10aUshv7P4AmduYRBpVlhHuBKMMmJVF+4w42A/e7RIDzWY
         RJrkWJi35YodAHPg1uE4piF5rkih+PGkqr674tZMIcToMTE1vqvKHtmjh9Jezl6OIvZd
         GpRQvfa9a0v11dZBzxG8y+FVVdQ/ht8yh3IJZ6AN0Kvh78bnNGGjTXeS7gSPho1Pzn0c
         4BFw==
X-Gm-Message-State: ANoB5pnVyp8/HlVo1guKStB+P/mvxTJfIxLO0oZ0qNkS/RXruSXL3Zif
        ubx9+g//fp/kUweuyKvwo4r3+H5oa+ez8pgJ
X-Google-Smtp-Source: AA0mqf65GqGX0e59qksmzXzBwYcs3sLKQc7tW0et2bRGF9f94vQmh+80Mbx5nBWiuNwReXw0KpUGrA==
X-Received: by 2002:a05:622a:2514:b0:39c:da20:f7d2 with SMTP id cm20-20020a05622a251400b0039cda20f7d2mr9395889qtb.47.1670610326650;
        Fri, 09 Dec 2022 10:25:26 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id bl14-20020a05620a1a8e00b006faa2c0100bsm341445qkb.110.2022.12.09.10.25.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 10:25:25 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id s14so3579537qvo.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:25:25 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr69642655qvp.129.1670610325096; Fri, 09
 Dec 2022 10:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20221208205639.1799257-1-kuba@kernel.org> <20221208210009.1799399-1-kuba@kernel.org>
In-Reply-To: <20221208210009.1799399-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Dec 2022 10:25:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wji_NB6hO+35Ruty3DjQkZ+0MkAG9RZpfXNTiWv4NZH3w@mail.gmail.com>
Message-ID: <CAHk-=wji_NB6hO+35Ruty3DjQkZ+0MkAG9RZpfXNTiWv4NZH3w@mail.gmail.com>
Subject: Re: [PULL] Networking for v6.1 final / v6.1-rc9 (with the diff stat :S)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
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

On Thu, Dec 8, 2022 at 1:00 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> There is an outstanding regression in BPF / Peter's static calls stuff,

Looks like it's not related to the static calls. Jiri says that
reverting that static call change makes no difference, and currently
suspects a RCU race instead:

  https://lore.kernel.org/bpf/Y5M9P95l85oMHki9@krava/T/#t

Hmm?

                  Linus
