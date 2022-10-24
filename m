Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1160BD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiJXWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJXWUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:20:30 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F0F311847
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:37:39 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cr19so6389007qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nUgSwI+I3I6ArrFTquHdy3o7OpO0gtexbNIMHahi/Oo=;
        b=EyRs4jkVenQIvpIYDwwLo47kLr08xw8PDrq5+q8jiegP9yQLqJoi9Ln2BcHSwyvUoP
         1oq/ujU391/cpQKLPuwqVJc9PSl3TxpmBd2JBhSdAz1891+sPdmTs06Gq1I6b7YPP9OS
         Rff14GyUNde4IZH7Ol7GRcWSdqXrCimtwiJZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUgSwI+I3I6ArrFTquHdy3o7OpO0gtexbNIMHahi/Oo=;
        b=2wF3KtGpomgZEWTX+aDB5m9R7u3909wWlnWwfHsRnHzxgZA++xHE94TtFUhUQFr53E
         BuahQstUD7y9jA6n4BbK7Xf2KU6AFqm7QzdqN8v17tk5w/MeGr1Pa2ms2jjpcRXJOLS4
         fzznHDQ84Wvo0wZFaSfXyGjPfkruV4N3tAHM284J2lfonbuS2xT9Lag+ty9JlsNl2t/8
         ZQADWrj660R1HdsuQF/GZe3aUeBr/BofVUTRnFsIN/NZ49SoUQpemp/uMaf1oiWzRvpt
         w1CxJJc1ANeoRbLBMveQC8DRmUJZXR/XS6YTWGOmiqRk5PcTnRnxi51VUyw4kpEUA2Jn
         5b8g==
X-Gm-Message-State: ACrzQf0vcIsdCSTyDnjS9VHiFSoiCFLwObOu6cM0ZeAKYNbb9a8qtIse
        J3gjN96tUsI3PKZE8BiULAAig+AiSB+Y5Q==
X-Google-Smtp-Source: AMsMyM4EHagWQFiLOqbWcjisFxSOIHG7q1PnESXKz4E9gPOptKThKTw1uu9mHuqoL7vpabjrVWB/5Q==
X-Received: by 2002:ac8:5f52:0:b0:39c:cb1c:9310 with SMTP id y18-20020ac85f52000000b0039ccb1c9310mr29144571qta.177.1666643802561;
        Mon, 24 Oct 2022 13:36:42 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id dt47-20020a05620a47af00b006ee96d82188sm672326qkb.1.2022.10.24.13.36.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:36:40 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 185so1787008ybc.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:36:40 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr29619641ybk.501.1666643799980; Mon, 24
 Oct 2022 13:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <CAHk-=wjoGnHVVp5pcb69C6HtnJ_avqQo_b5NK-X9bgoDDw_XbA@mail.gmail.com> <CAG48ez3KMuM2aLpc8SvGiqZvv1KFc7E2DBZ4CLzxQeFhrMN_-w@mail.gmail.com>
In-Reply-To: <CAG48ez3KMuM2aLpc8SvGiqZvv1KFc7E2DBZ4CLzxQeFhrMN_-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 13:36:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE3+pLUQrzK=f0_GKdYZrv=72ox2nQrPhc+jZCMLqVSw@mail.gmail.com>
Message-ID: <CAHk-=whE3+pLUQrzK=f0_GKdYZrv=72ox2nQrPhc+jZCMLqVSw@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Jann Horn <jannh@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
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

On Mon, Oct 24, 2022 at 1:24 PM Jann Horn <jannh@google.com> wrote:
>
> That's why GUP-fast re-checks the PTE after it has grabbed a reference
> to the page.

Bah. I should have known that. We got that through the PPC version
that never had the whole IPI serialization thing (just the RCU
freeing).

I haven't looked at that code in much too long.

Actually, by "much too long" I really mean "thankfully I haven't needed to" ;)

                 Linus
