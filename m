Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBBC6AAC7F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 21:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCDUsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 15:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCDUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:48:28 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6306AD326
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 12:48:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o15so23430025edr.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677962905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn2gZXKlQFGR+IhNp/0q9B10wC8MYWo3Xkj5MLWqjns=;
        b=dJtwGIMLUvRVLfyftU83pXDQ7ZHeelQh9GKUmyXSKtJeY3w4b312g5jt3ZndGIk/1O
         o7cFw1LXjGZtGD940+EOSfSvH8B4OsfTM9OHbsFssJ2p0NL2mORe0tL+ByQcH0geWJwy
         EM3CjLMmA/BxyrLWut5Hg5wT7BCb4ocNQoaAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677962905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn2gZXKlQFGR+IhNp/0q9B10wC8MYWo3Xkj5MLWqjns=;
        b=z9GLUPL8tj59vewniBBxypxDM6QrHurXJxsvY6vI47fu2r0uGf3McQzgCAUA9KYn4X
         hH0hT9x0Ps3NjtSY2/iIXDESvB9RH52hG05F67UL7Hd1VnLlSRnbpdj1z9xe1ya1NQIs
         0WPTDf6VCQ0Y4TyAdotpQX/ijTped9cg02lwk0Zuz50XkWcheFFPlj1NCs1qYTuCUwZb
         jCJ/uWAhSYzUE+iszFMuG7wFTJndz7A4/kkQD9UIY9AoxyFAAe0+Q0CxYK3vE5mBuipP
         9emBoAxEcmHytGT63WraUj51SRT9LbcftVpv2W51NYGmgsK3BruHKM6oBXx+PG14nWpx
         Y4YQ==
X-Gm-Message-State: AO0yUKUPGa5vDe1EcLF8ThloCLMqmHbsBOriI9c1AU4Ba4a7sLTeucBg
        I9IaAiT1U2xxzYsnuZQ05NL67IPrxBbU9quu7EG04w==
X-Google-Smtp-Source: AK7set+YkCctCSzqOGCp6OtNqMbc2t4jnXZbnLFMxEHeNIzgyo8Z8gViDXzMIMNaWSZ65QhJ4nzhRw==
X-Received: by 2002:a17:906:70c5:b0:882:ed4a:f23 with SMTP id g5-20020a17090670c500b00882ed4a0f23mr5219489ejk.49.1677962905449;
        Sat, 04 Mar 2023 12:48:25 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id jz2-20020a17090775e200b00909f7f28ed7sm2443566ejc.16.2023.03.04.12.48.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 12:48:24 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id u9so23684506edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 12:48:23 -0800 (PST)
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr2818736eju.0.1677962903549; Sat, 04 Mar
 2023 12:48:23 -0800 (PST)
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
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com>
 <CAGudoHH8t9_5iLd8FsTW4PBZ+_vGad3YAd8K=n=SrRtnWHm49Q@mail.gmail.com> <CAGudoHFPr4+vfqufWiscRXqSRAuZM=S8H7QsZbiLrG+s1OWm1w@mail.gmail.com>
In-Reply-To: <CAGudoHFPr4+vfqufWiscRXqSRAuZM=S8H7QsZbiLrG+s1OWm1w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 12:48:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh17G6zo6Rfut++SHzDgXdvtrupfSX+bNL08v=LpHU0Lg@mail.gmail.com>
Message-ID: <CAHk-=wh17G6zo6Rfut++SHzDgXdvtrupfSX+bNL08v=LpHU0Lg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>, Borislav Petkov <bp@suse.de>
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

On Sat, Mar 4, 2023 at 12:31=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> Good news: gcc provides a lot of control as to how it inlines string
> ops, most notably:
>        -mstringop-strategy=3Dalg

Note that any static decision is always going to be crap somewhere.
You can make it do the "optimal" thing for any particular machine, but
I consider that to be just garbage.

What I would actually like to see is the compiler always generate an
out-of-line call for the "big enough to not just do inline trivially"
case, but do so with the "rep stosb/movsb" calling convention.

Then we'd just mark those with objdump, and patch it up dynamically to
either use the right out-of-line memset/memcpy function, *or* just
replace it entirely with 'rep stosb' inline.

Because the cores that do this right *do* exist, despite your hatred
of the rep string instructions. At least Borislav claims that the
modern AMD cores do better with 'rep stosb'.

In particular, see what we do for 'clear_user()', where we effectively
can do the above (because unlike memset, we control it entirely). See
commit 0db7058e8e23 ("x86/clear_user: Make it faster").

Once we'd have that kind of infrastructure, we could then control
exactly what 'memset()' does.

And I note that we should probably have added Borislav to the cc when
memset came up, exactly because he's been looking at it anyway. Even
if AMD seems to have slightly different optimization rules than Intel
cores probably do. But again, that only emphasizes the whole "we
should not have a static choice here".

                 Linus
