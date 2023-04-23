Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B3C6EBDA8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 09:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDWHal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 03:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWHaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 03:30:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4251BEB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 00:30:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f18335a870so20402685e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 00:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1682235036; x=1684827036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMQtQc8JBwrkwHWNnKD4f7Fese2aLtEj8rsPPS7jZeY=;
        b=d5k8sprxqaekFneXVau7DimNbLbbBMWS/YrGYklGnahwF4u09MJSTpu5vbcKh9QK1p
         vsmMJPOpMPtKC91glbIIpAzgdbXZ323upbWys1ZZ7JPkJrUqH61F2O6kN0nl3uLHLy9o
         OBKT57XQYplpxLguxkhPmHHnLiFzHh42PbsMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682235036; x=1684827036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMQtQc8JBwrkwHWNnKD4f7Fese2aLtEj8rsPPS7jZeY=;
        b=QgkkUkoGM4lWKoiTLl56TZinaJzkjg52Mxew7pQzeZFey4Bw1TGJW5Y7NEXadfSB9C
         FcFWv2Y/vIjmfQOFyKxjvjVgZSOhvSEdohHwMM0Qw9bXyPTLTAXnr+NV4pJBliPVS0qc
         +Lw7xeE0+LcMomDosjN5enpMkHTX4fzcoEzT/Qi79OmqdNbhQCr51FaK+lJpWFynN7/h
         c0LMAS+kJzMicwFsG37BY8bPdwlTM2Oaolss6bFvWmoWysAzpQH+J9daepMSUUZr3/AW
         Xr/4ZsDxM8jtuj3pLyQ4MIu96BSPVxdgKFqNf3xgjmJEkEN4RrfuYJ6P78fzWWyVgF4p
         7pbw==
X-Gm-Message-State: AAQBX9d00vkK3yQu6VcvGHwycESsYXjaf4B/eLB4wthzj0WJ8ajPZUQS
        e9FmhayMnJciHdAovOU8Nnmb5MVprkrm1Tqd9N7suw==
X-Google-Smtp-Source: AKy350auzcKF/ylwee37jevhbBIw4KODF2cfu/Jc6CUqcI+mn2H9D4eZ/UFx61lUNWeOf1aDCREEbsSRbOuyeFcpA7M=
X-Received: by 2002:a05:6000:1b0f:b0:2fa:2e64:7d10 with SMTP id
 f15-20020a0560001b0f00b002fa2e647d10mr7312858wrz.28.1682235036158; Sun, 23
 Apr 2023 00:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230416172323.13278-1-david.keisarschm@mail.huji.ac.il> <CAHmME9qP2jwSk7o6EYGK_=vRntfLq6O1BcnH46ibt=Ypv3v-vw@mail.gmail.com>
In-Reply-To: <CAHmME9qP2jwSk7o6EYGK_=vRntfLq6O1BcnH46ibt=Ypv3v-vw@mail.gmail.com>
From:   David Keisar Schm <david.keisarschm@mail.huji.ac.il>
Date:   Sun, 23 Apr 2023 10:30:24 +0300
Message-ID: <CAD0z2U0GkJt8Xt1xDPfhBRJ3JbugUSggFj2-Q+F9MKhQr+0L6A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arch/x86/mm/kaslr: use siphash instead of prandom_bytes_state
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        keescook@chromium.org, ilay.bahat1@gmail.com, aksecurity@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 8:26=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> On 4/16/23, david.keisarschm@mail.huji.ac.il
> <david.keisarschm@mail.huji.ac.il> wrote:
> > From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
> >
> > However, the seeding here is done by calling prandom_seed_state,
> > which effectively uses only 32bits of the seed, which means that observ=
ing
> > ONE
> > region's offset (say 30 bits) can provide the attacker with 2 possible
> > seeds
> > (from which the attacker can calculate the remaining two regions)
> >
> > In order to fix it,  we have replaced the two invocations of
> > prandom_bytes_state and prandom_seed_state
> > with siphash, which is considered more secure.
> > Besides, the original code used the same pseudo-random number in every
> > iteration,
> > so to add some additional randomization
> > we call siphash every iteration, hashing the iteration index with the
> > described key.
> >
> >
>
> Nack. Please don't add bespoke new RNG constructions willy nilly. I
> just spent a while cleaning this kind of thing up.

Hi Jason,

Thank you for reviewing our revised patch. We appreciate your concern
regarding the use of custom RNG constructions, and we understand the
potential issues that could arise from doing so.

However, we wanted to clarify that our intention was to use a
deterministic PRNG that meets Kees Cook's requirements for debugging
and performance analysis purposes.

We also acknowledge that using a custom RNG could introduce additional
risks, and we're open to exploring alternative solutions that meet our
requirements.

If you have any suggestions for a more secure and deterministic RNG,
we'd be happy to hear them and implement them.
