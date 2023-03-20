Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06A96C1FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCTSfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjCTSek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:34:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19C56E89
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:26:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cy23so50338788edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679336795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIfBJvw4GqAMhW5twcZsJZl6S9pMqZHlkEyev/gaORI=;
        b=VAd9dDtgxN14PqtMJWYqSIEAFzFtFFNLlsJrPb/OCGinTMVnOJidMx0e64v2l0xPkR
         MuZblZBj0ZGFj01L4KSaoHWQWQIycrRIPm5FO7lfaRrKDUr6pRwx6cubkTGNaZgiChYf
         +1i8FPpcIeEpe6DVWw3oQ8CAOQ7OEQOw5ZhKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIfBJvw4GqAMhW5twcZsJZl6S9pMqZHlkEyev/gaORI=;
        b=bxh+zC1rZIjNjQd5VeVr26z3P6L4DBKeE5/XpU83HYemlQLxbCdddWzfiLUncy4PJs
         DLKMQbwI/T9oBCB2SKk6FLIg7ywH2S8xfKpZj/JjCIq611tgyWz1rG8k3croQDLB126h
         qsCkIGfTeXefL3MJ/0dOwzWPDq2+M57TgkIQixglNXALE0K2hfdoUePRA2Ji3dtEzLaN
         puhLgc3h23/+Awg/VpJbo0vezKeo4e5oPFGi0yYNy63Wzqi2lHfXyvwbM0UxN5J2bwgY
         Hk6IE8iOMFypztAVB51KynmWoQt7VO+VPx/Y1ZB1QBNg9vontLsHYOS5AoU0Kr/12OzH
         XcCw==
X-Gm-Message-State: AO0yUKXJtT/HL8Afd3u9MIHaEbQYr3OKgPsClJANdgPIheKYPhDJS44s
        9GCTq8dgMijBrzuwQowYmVBy/HaFq3TxDc+TMRAjHgtp
X-Google-Smtp-Source: AK7set+DPnZYsbXrtFkN8t7yks1nMN3DS+EfOT1311+/0gxkNRZftNnvoszg4bVN9CgvnixTggh9ng==
X-Received: by 2002:a17:906:5a59:b0:879:d438:4d1c with SMTP id my25-20020a1709065a5900b00879d4384d1cmr14171ejc.21.1679336795099;
        Mon, 20 Mar 2023 11:26:35 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709064a8b00b009342fe44911sm1824629eju.123.2023.03.20.11.26.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:26:34 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id b20so17509193edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:26:34 -0700 (PDT)
X-Received: by 2002:a17:907:9b03:b0:932:da0d:9375 with SMTP id
 kn3-20020a1709079b0300b00932da0d9375mr288149ejc.4.1679336794015; Mon, 20 Mar
 2023 11:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320180501.GA598084@dev-arch.thelio-3990X>
In-Reply-To: <20230320180501.GA598084@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 11:26:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
Message-ID: <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
Subject: Re: Linux 6.3-rc3
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:05=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On the clang front, I am still seeing the following warning turned error
> for arm64 allmodconfig at least:
>
>   drivers/gpu/host1x/dev.c:520:6: error: variable 'syncpt_irq' is uniniti=
alized when used here [-Werror,-Wuninitialized]
>           if (syncpt_irq < 0)
>               ^~~~~~~~~~

Hmm. I do my arm64 allmodconfig builds with gcc, and I'm surprised
that gcc doesn't warn about this.

That syncpt_irq thing isn't written to anywhere, so that's pretty egregious=
.

We use -Wno-maybe-uninitialized because gcc gets it so wrong, but
that's different from the "-Wuninitialized" thing (without the
"maybe").

I've seen gcc mess this up when there is one single assignment,
because then the SSA format makes it *so* easy to just use that
assignment out-of-order (or unconditionally), but this case looks
unusually clear-cut.

So the fact that gcc doesn't warn about it is outright odd.

> If that does not come to you through other means before -rc4, could you
> just apply it directly so that I can stop applying it to our CI? :)

Bah. I took it now, there's no excuse for that thing.

Do we have any gcc people around that could explain why gcc failed so
miserably at this trivial case?

                   Linus
