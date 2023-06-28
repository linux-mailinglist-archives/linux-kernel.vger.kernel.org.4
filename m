Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4BF741934
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjF1UCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjF1UCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:02:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D592718
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:02:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9920b4d8a89so23672066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687982549; x=1690574549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rqjx8BFkvS49FUhfj3VfQwjT1TYgw6RhCYPNR0yTSNc=;
        b=ce7xVd/FNl5ogr8NSqwQai/kzQMgEdA1Y7krACrikRY55ryGQbkKjI7dA+f+HMMnBq
         WK6Qcjk9LMR5NdOnCSlazRvAk97s2AQvPlIpMjvon5W8xaMo8tX4+oEtQn9GXw9b6nqn
         A8/FyPHBfgOs5dAZrHQbTMYP78dnLkzWKBiR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982549; x=1690574549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqjx8BFkvS49FUhfj3VfQwjT1TYgw6RhCYPNR0yTSNc=;
        b=Da0gNFaaa9ITnYfQsXh+GlmpJKkbKNg0cMsV8Vgf8RKRyVnqwzvvjJ+T9GNjKosoWa
         TkMTmXMv7AxOulBFYbSl2pNwTpQr5J2TwDD73+/r/zWeyFZlFm8QTOXTuPzfQHvneK6R
         NZfF8UDuy3R5s5D8rRRH49G3Sq83mTbUz2HiEPWnrHEcp3YGzDVswO9C3Ipw3KWLPCrB
         Dc+C1HWR03dELkvPQrAFjzVEMamhqRQ4+Rqmk5P+h+PHiltQVE7JmhvztL6qtwMP4h8u
         r7R/3d/HUiL9a8sBIxKlGVz09XcljVwaFPRSRwQSXCM86mIQH+KAGblMy9jjzyCP+87Q
         0mfg==
X-Gm-Message-State: AC+VfDyzKsuR3JwMH0A9eShaRwpVeX99zDZUD0Y1lPUgAgQdawKUdC1U
        DVq5XwMyc+nBV5ngUR4o+4ef0U80tJtevzHrr0grPEdw
X-Google-Smtp-Source: ACHHUZ7eG8ggGyN5LQTcjOGkEtZEcNMCBQASUT3fh2ZWJqx+7sw2E0JS1j85nzNVGeTmBlaUpZ2A+Q==
X-Received: by 2002:a17:906:5a59:b0:98d:f11e:4818 with SMTP id my25-20020a1709065a5900b0098df11e4818mr11011202ejc.36.1687982549437;
        Wed, 28 Jun 2023 13:02:29 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id lc26-20020a170906dffa00b00991e6951c1fsm3299043ejc.5.2023.06.28.13.02.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 13:02:28 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51d97ba7c01so4605617a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:02:28 -0700 (PDT)
X-Received: by 2002:a50:fc13:0:b0:51d:df35:3818 with SMTP id
 i19-20020a50fc13000000b0051ddf353818mr57973edr.5.1687982548324; Wed, 28 Jun
 2023 13:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
 <20230628091241.GAZJv5ie0xVGvnMKIM@fat_crate.local> <CAFUsyfKYQk87fxCDj9FpM9xzLwZVRrfUZgyUCF5G+HuC0N2pXg@mail.gmail.com>
 <CAHk-=wj1fe4Pa0zLxUTiMjaxEXW84HBup+Hv=fe-U8PoFzrm5g@mail.gmail.com> <CAFUsyfJ-n53mXd1QZCtFfkCjux6Hy7iAG4-uALX0Uyofg=PTGg@mail.gmail.com>
In-Reply-To: <CAFUsyfJ-n53mXd1QZCtFfkCjux6Hy7iAG4-uALX0Uyofg=PTGg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 13:02:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7g131ZG=-HBc-3gMDS8RX-D97A5d3Nx66m9=ZxdXaOQ@mail.gmail.com>
Message-ID: <CAHk-=wh7g131ZG=-HBc-3gMDS8RX-D97A5d3Nx66m9=ZxdXaOQ@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        edumazet@google.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 11:34, Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> There is a reasonably robust kunit for csum_partial: lib/checksum_kunit.c
> so if you happened to run the kunit testsuite with your patch, it's
> probably correct.

Testing? TESTING?

Why do you think I do open source? I like the programming part. I even
like the debugging part. But testing - that's what users are for. No?

               Linus
