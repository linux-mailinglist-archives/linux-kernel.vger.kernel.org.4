Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3016AAC05
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCDTC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDTC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:02:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0CC35B8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 11:02:56 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o12so22967650edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 11:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677956575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nulv/YbaIdsPYIu/TyuXgIK5szxQR3P85oOKBpQEjds=;
        b=Y4jFqiPVN6ZvXlcEWlXhhwV3rOFOosDPDSXZxtf5GfztoSu+Zs4s2m5U0vX4mEXNn0
         GO1jy7LINSCiXz4k304O34u8j6ENpioXQbi9SuFJMaqjcSnJJXl1Q1afefooOlth2Dn1
         ENiInfIbHdNoyUEhYiS3kJGcKAdR7ZjLTksRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677956575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nulv/YbaIdsPYIu/TyuXgIK5szxQR3P85oOKBpQEjds=;
        b=3lKsS65QYaAS1ms1hIrF43dpNafbNwes/VeCW4PXqFbKQ6HhhTOPT7ggyKK+vFG03B
         5QspyUme5ZPTHbSwIlB6AssqT4Ygve9PjwSbYoo4Jtw/GR/M9HhlpXaqihwXvqK7Gba6
         uqKYm5IJ8N5r8TtI4rq6ZLOXrVt2+iCzYJUawYPHvr9FnRoLZY+CrM1uxwrndhcsJFHa
         BpBmmT8iBILwPw/puXD/UaZN7pMpZK9tU9yTyoUwMcsJ7lSZcMS//wOxrWQeU7A3asbt
         Gdm4kCDy1k5iS2WGuiyIWo1YdHOpEAVIEBH2LIfthS7ES5qsYd5sg3cGqRT1097RTvKv
         fKgQ==
X-Gm-Message-State: AO0yUKUrXFugR/n/zTJqXCw1xXzw8JfKFrS0kmVkNekrAXqdOYp6HDhE
        pTbwmAqYZfFebxoFRA4cvKdUqX8OYBgXMd0KzU5psg==
X-Google-Smtp-Source: AK7set89D0qSkoM2KWvvW2mfnrmnm9nCBDix03xWQQuxNY+UNYFgVEo6gox8DlFLhDihQsZcu06R8w==
X-Received: by 2002:aa7:c245:0:b0:4ac:c44e:a493 with SMTP id y5-20020aa7c245000000b004acc44ea493mr5312186edo.2.1677956574891;
        Sat, 04 Mar 2023 11:02:54 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906a00e00b008b1b644c9fbsm2325714ejy.103.2023.03.04.11.02.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 11:02:54 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id j11so3514731edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 11:02:53 -0800 (PST)
X-Received: by 2002:a17:906:d041:b0:877:747d:4a82 with SMTP id
 bo1-20020a170906d04100b00877747d4a82mr2787706ejb.0.1677956573508; Sat, 04 Mar
 2023 11:02:53 -0800 (PST)
MIME-Version: 1.0
References: <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop>
In-Reply-To: <ZALcbQoKA7K8k2gJ@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 11:02:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJSXQfPGjpj8SAgEn5bOHOGvHPvFQM6GutcUU7kS8qXw@mail.gmail.com>
Message-ID: <CAHk-=whJSXQfPGjpj8SAgEn5bOHOGvHPvFQM6GutcUU7kS8qXw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
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

On Fri, Mar 3, 2023 at 9:51=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> At that time you was OK with CONFIG_FORCE_NR_CPUS, only suggested to
> hide it behind CONFIG_EXPERT:

I think there was a mis-communication.

I as violently *not* ok with that question at all. I think our Kconfig
phase is really annoying and nasty, and we should not ask people
questions that they don't know what they mean.

So putting it behind EXPERT was a "at that point, the question is
gone", and I'm ok with the config variable existing.

But..

I am *not* ok with you then thinking that "oh, the config variable
exists, so our default code generation can be complete crap".

The kernel should do well by default. No amount of "but you could go
into magic config variables and then force options that might be ok
for embedded systems to make it generate ok code".

I think it's completely crazy that the distros enable MAXSMP. But
that's their choice. A *sane* distro should not do that, and then we
limit the normal kernel to something sane like a couple of hundreds of
CPUs rather than thousands of them (and the associated huge overhead).

At that point, things like cpumap_clear() should be a couple of stores
- not a call-out to a variable-sized memset().

Notice? Simple and understandable Kconfig questions like "do you
*really* need to support thousands of CPU's"

Not that FORCE_NR_CPUS that is _completely_ useless to any
distribution and thus completely unacceptable as a regular question.

See the difference?

          Linus
