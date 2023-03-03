Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F176AA077
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjCCUI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCCUIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:08:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE913DC1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:08:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id da10so14950194edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677874101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icUeuEqvqPbQnLnoTJFmZqOp/anQ4LMobszRgORXgsw=;
        b=TDRqKYNlaFjGJRfXNmOIUGOwy4UL8l4YqkENlHDD/aan5Eez3v8eXzQg0eyHmIRWSf
         EkSZ7ejXEvxO4jJ0JU6tB+uMDU3kfuY31pQsV9fXDf9EblIb2A0sIiziH1KoBwYbkuUy
         yQFjcNskaa4E4PcnBPbP6vV/amExzZMAZ7kB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677874101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icUeuEqvqPbQnLnoTJFmZqOp/anQ4LMobszRgORXgsw=;
        b=LhGvZEdNp9RwRS4TmaCw6o5rRzB84H6YZz2/0kl9eLb9OnAWpcTl8I3+MKIGRqOuhY
         Ysj7UM86yT2dqGxmoiFd8Prw+Xc1672haF8muvHZgn0Yz7fNO7p3wxx2hbx48I7JIsXs
         PLa639+m9x7FI6Y+DQO7Jsnsit3ODMxc81ZRCefDVuVOUzudS6wezI9aNWF0GBEs/o60
         wqnWylgHpmp3mjeJeNv2FIfbN30wpL08E+GUjg+bvNgWxbb3DodgYXEgf3MJ1K6pgyFu
         atKPW0d7YFWh+8zEQ7pgBzhGsbWJe8dX3THUfWQTzHXI7Zx/9i1pSyIsasiv68FS7ICQ
         NwSQ==
X-Gm-Message-State: AO0yUKVC3gQvVSwZSnjBX11XRxQ9JUIKIkmGsqEWtbsY6Rwle/fzVuEa
        H4ku12pHJPlNeqXl0XWfuIgWfkgcvbDAGngs99c=
X-Google-Smtp-Source: AK7set9YtW4fOhDAd/zF/dFByg1rn99SP5be45giAin1sl4Y2TaVVR7BvAhcjTcCoUPCI8DT5LqO0w==
X-Received: by 2002:a17:906:dac9:b0:8d9:8f8f:d542 with SMTP id xi9-20020a170906dac900b008d98f8fd542mr3165366ejb.32.1677874100743;
        Fri, 03 Mar 2023 12:08:20 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906040800b008bda61ff999sm1290136eja.130.2023.03.03.12.08.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:08:19 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id d30so14933262eda.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:08:19 -0800 (PST)
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr1471718eju.0.1677874098906; Fri, 03 Mar
 2023 12:08:18 -0800 (PST)
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
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com> <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
In-Reply-To: <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 12:08:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
Message-ID: <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
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

On Fri, Mar 3, 2023 at 11:37=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> I mentioned in the previous e-mail that memset is used a lot even
> without the problematic opt and even have shown size distribution of
> what's getting passed there.

Well, I *have* been pushing Intel to try to fix memcpy and memset for
over two decades by now, but with FSRM I haven't actually seen the
huge problems any more.

It may just be that the loads I look at don't have issues (or the
machines I've done profiles on don't tend to show them as much).

Hmm. Just re-did my usual kernel profile. It may also be that
something has changed. I do see "clear_page" at the top, but yes,
memset is higher up than I remembered.

I actually used to have the reverse of your hack for this - I've had
various hacks over the year that made memcpy and memset be inlined
"rep movs/stos", which (along with inlined spinlocks) is a great way
to see the _culprit_ (without having to deal with the call chains -
which always get done the wrong way around imnsho).

            Linus
