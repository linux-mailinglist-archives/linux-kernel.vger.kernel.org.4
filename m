Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4D26AA0C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjCCU6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjCCU6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:58:42 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEFA17145
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:58:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g3so15435465eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677877111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o4OY5lQPKh+GkI89Rz6TXZXk/LYf31mRBJK3Sl9ezg=;
        b=he65XQOu+UTB4in3Szyiw11xAa8mqRP2ytbOj4xIHb6LvrWUZKUzdsqGCCEJ1W4C3X
         TuMyEiexc/qgDlzevsKPjI04q8h/4QsxnWeO2rFK26G98RH928vITMEmJoE2GmYgnrT9
         +mC3ntKhkSOfnIoYv0aY8TgoZDk1kMSa2WELY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677877111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o4OY5lQPKh+GkI89Rz6TXZXk/LYf31mRBJK3Sl9ezg=;
        b=iLmsKqDK/yxWZQDn8A8yZ7bfyUJPAtE1qZ8LTn2edxSmy73jaiUwj5CqefHVP5yDDi
         Y/3mASsBJQaxrVdd4MvpGlCGaqQv1IHO4Fz4O/NlxmDdEnOnZfLo0wObxNL6seKX5KmA
         MSdtzjPwGMLyRCzlmIz/gEqI7ypkXYlgEGFm2i1sfOEApJwfYunyvsDgKneBCl4oSykf
         v5UR3mbOwgsDXQeCeph6Vfbpr5Q/LYW4s2fwWUXN/BtfaR0E1OR77rj1aoZR9kQOPY/G
         XQIJLA24S/R8quxhpK4yGrkxFN0+mTrL2dx61QISciEsU86QqKPBSdQFsup9LW6Vqnp8
         FCCQ==
X-Gm-Message-State: AO0yUKWwZzG/slkmsniLeN2edVX/4gyY6pq3Zxh9q5dmxbjixVXrBP4e
        gXmHXL2p6wHZdnMXJJRmn34Rg65ugcfjumHLApu2mg==
X-Google-Smtp-Source: AK7set+heXTvPJi8Jqm4Nl/lLabmZbxQHkGm4oXsMsfCuZY1OKEE0jTNZgNOyrPEFQEBN/Hj3av9iw==
X-Received: by 2002:a17:906:a00a:b0:87b:d3f3:dcf3 with SMTP id p10-20020a170906a00a00b0087bd3f3dcf3mr2540396ejy.35.1677877111531;
        Fri, 03 Mar 2023 12:58:31 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906164d00b008deba75e89csm1342236ejd.66.2023.03.03.12.58.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:58:30 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id f13so15327817edz.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:58:30 -0800 (PST)
X-Received: by 2002:a17:906:3d51:b0:8f1:4c6a:e72 with SMTP id
 q17-20020a1709063d5100b008f14c6a0e72mr1497478ejf.0.1677877109830; Fri, 03 Mar
 2023 12:58:29 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com> <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
In-Reply-To: <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 12:58:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com>
Message-ID: <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
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

On Fri, Mar 3, 2023 at 12:39=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> I think there is a systemic problem which comes with the kzalloc API

Well, it's not necessarily the API that is bad, but the implementation.

We could easily make kzalloc() with a constant size just expand to
kmalloc+memset, and get the behavior you want.

We already do magical things for "find the right slab bucket" part of
kmalloc too for constant sizes. It's changed over the years, but that
policy goes back a long long time. See

   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/=
?id=3D95203fe78007f9ab3aebb96606473ae18c00a5a8

from the BK history tree.

Exactly because some things are worth optimizing for when the size is
known at compile time.

Maybe just extending kzalloc() similarly? Trivial and entirely untested pat=
ch:

   --- a/include/linux/slab.h
   +++ b/include/linux/slab.h
   @@ -717,6 +717,12 @@ static inline void *kmem_cache_zalloc(struct
kmem_cache *k, gfp_t flags)
     */
    static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
    {
   +    if (__builtin_constant_p(size)) {
   +            void *ret =3D kmalloc(size, flags);
   +            if (ret)
   +                    memset(ret, 0, size);
   +            return ret;
   +    }
        return kmalloc(size, flags | __GFP_ZERO);
    }

This may well be part of what has changed over the years. People have
done a *lot* of pseudo-automated "kmalloc+memset -> kzalloc" code
simplification. And in the process we've lost a lot of good
optimizations.

I used to do profiling religiously, but these days I only do it for
particular areas (usually just the walking part of pathname lookup)

             Linus
