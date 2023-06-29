Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17374314C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF2XxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjF2XxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:53:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759F410D8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:53:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f957a45b10so1962795e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688082781; x=1690674781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xL8mcULkodeO8henHTncigIW09N/RJHH4EXE2kEHVXY=;
        b=VR7LyvIg5ycsu40d1YeMolF985bGkOswvgg1Yh/UpplYzehKbR8yAIf/ez+Bie7h+K
         nVJVg3XruBP8xJYogkxZI25e0fRCoiM3dUzXChlHtumE6EcB0Fbxtx2ANqh9if/EqRm7
         PrJL6uJ7aPvQY+z8R4oockkOuvIqmmdCpNhO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688082781; x=1690674781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xL8mcULkodeO8henHTncigIW09N/RJHH4EXE2kEHVXY=;
        b=kU+G486LEXXNC/idkOSywuAwMdlmRfDthIwU833Tt6X+wdywHZaEfbtGGpFzRKm0Y2
         4q8ctxXeCq+MHwgKVBBwfS50HiQtBUhiDrsR1/RPPkr+rq1YHvvKg1lKWdr30cmtVi7w
         reR1D0hg4mP4wEmuTraIFPX81I+o5YKq5Y382GGLT5zy3uKGcUcadskTIOHK4X1xRGRl
         xDgfpfldo1ciFTyIgooDvhnZZrLwZ/G0JwaU1fMwHRIF3zAELZHJsqb805Wu7qC3plBT
         +uIAWRdi0hyIdDXa/c7y2Z8dWQrsdQVn+hXoLyuDHRse3K0R284pAxEVxa+KrOBDjqOY
         EIAA==
X-Gm-Message-State: ABy/qLacUGiPg9zXuDcCiUq7PxtoPvmTBomiqyGfJZ1DiQL4clIMJ+O/
        GrjYwtObUZ4ljaDOrY9QAQFoNKuQg5JOx1p3Lc3K+lPW
X-Google-Smtp-Source: APBJJlG58/pa9FeYCE0QdSvdirBWtxAy3BV75gzFp3gecAFStM7IzobSF39Ogxt5VIu9ojBAggML4Q==
X-Received: by 2002:a05:6512:281e:b0:4fb:78a0:dd32 with SMTP id cf30-20020a056512281e00b004fb78a0dd32mr1000770lfb.60.1688082781372;
        Thu, 29 Jun 2023 16:53:01 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id j18-20020ac24552000000b004f858249931sm2315964lfm.93.2023.06.29.16.53.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 16:53:00 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f957a45b10so1962769e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:53:00 -0700 (PDT)
X-Received: by 2002:ac2:58f6:0:b0:4f9:5711:2eb6 with SMTP id
 v22-20020ac258f6000000b004f957112eb6mr792637lfo.28.1688082780196; Thu, 29 Jun
 2023 16:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-pokal-puzzeln-5199c679b051@brauner>
In-Reply-To: <20230628-pokal-puzzeln-5199c679b051@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 16:52:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBXJOzkez2Rd=cQ5ckttJq6OdYtArFmCtVQHyeuQBGrw@mail.gmail.com>
Message-ID: <CAHk-=wiBXJOzkez2Rd=cQ5ckttJq6OdYtArFmCtVQHyeuQBGrw@mail.gmail.com>
Subject: Re: [GIT PULL] pid: use flex array
To:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 03:37, Christian Brauner <brauner@kernel.org> wrote:
>
> This contains Kees' work to make struct upid in struct pid a proper
> flexible array and thus gets rid of a bunch of syzbot UBSAN warnings.

Hmm. Of this, about half were replacing "array + index" with "&array[index]".

Honestly, it makes no difference, but the reverse is also true: the
"array + index" is *very* traditional, and if people have problems
with that simple syntax I really don't know what to say. It's kind of
core C. It's *literally* how arrays work, and what the '[]' operator
means.

And of the remaining half, half again is using a truly disgusting

    struct_size((struct pid *)0, numbers, X)

thing. That is *GARBAGE*. It's garbage for too many reasons for me to
actually pull this sh*t, but let me just name them:

 - 0 isn't a pointer. Stop doing that.

 - dammit, we have 'struct_size_t' that does the above disgusting cast
without getting that simple thing wrong.

In other words, this pull request contained half pointless and
unrelated churn, and 25% actual garbage.

In other words, I'm not pulling this to just get the remaining 25%.

              Linus
