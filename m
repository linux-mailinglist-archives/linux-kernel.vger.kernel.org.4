Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8B72A198
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjFIRqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFIRqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:46:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA9A30ED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:46:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so3587634a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686332809; x=1688924809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EUzoE9dGxd3VuJpDmZxdF1iqIPMZ5+unNKrN952gKg=;
        b=ZYjiZE3ayaC1WB8OviVOE8JdtqeNA+J3sPq7Oslckul1Yh23a9M/WDXY5yrttzSvl5
         i1nUlmdRN2dyPed9s8TSXiEWg17hNqeW4yZVmx+Fnp8mJSm7lW4O8w5nwPeDQ6BYPf2c
         GWbcoKdopajkDtvvu7owtDP5ho1CASfxytoQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332809; x=1688924809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EUzoE9dGxd3VuJpDmZxdF1iqIPMZ5+unNKrN952gKg=;
        b=Vzp4hbsG3xNMCiEodNGdbexM3y+zTAEM7I5ecQQLMKv+Otjh575/JtarcbLuFGWqoY
         zCYUyjST7+kSWjW0c3MxQzYwfqsZy84yR9Sckbs3CbrQwanMDj/CIl76p+cEo2CAyPHF
         1t6y0nvoL90EmX84nYKxJtTj/QY2//CfbIhekFBstyNmqDyL+WbbZVgoNq+LfeJxcq80
         Tt9Qn2FucvQTgObNH7dJwNV7+Zg0N97y5WiEUTGs0gog6SKKuvTQiyEE46hnrvsUbL0N
         cODpYo2lSfAECJSuZZS/gGYlgN55eRj9/KgoDrui7IRyYOxhWr9rtAydRvMj7IHIiPDL
         6ZLA==
X-Gm-Message-State: AC+VfDxheq8+QISWapPEd/t2p4eEHC+ONyAiYAaaooA8KiwX5AmA6ZU8
        w8RpOWpO4ZxEnjlFkieNwHVSaMR0BSjgsBbNpByZJfo0
X-Google-Smtp-Source: ACHHUZ4exHSl04SGLoZ0KiN55c7bhjWhbRGuhg2vkVSBsMgY8kQkWHHlGddR5kkUAmf7MF8NT4v0gQ==
X-Received: by 2002:a17:906:7303:b0:974:61dc:107c with SMTP id di3-20020a170906730300b0097461dc107cmr2611184ejc.44.1686332809338;
        Fri, 09 Jun 2023 10:46:49 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id u22-20020a170906069600b0097461a7ebdcsm1552986ejb.82.2023.06.09.10.46.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 10:46:49 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so3587603a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:46:48 -0700 (PDT)
X-Received: by 2002:a17:907:7d88:b0:977:d53e:4055 with SMTP id
 oz8-20020a1709077d8800b00977d53e4055mr2799662ejc.58.1686332808499; Fri, 09
 Jun 2023 10:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230607223755.1610-1-richard@nod.at> <202306071634.51BBAFD14@keescook>
 <ZIHzbBXlxEz6As9N@alley> <9cd596d9-0ecb-29fc-fe18-f19b86a5ba44@rasmusvillemoes.dk>
 <ZINbQ3eyMB2OGfiN@alley>
In-Reply-To: <ZINbQ3eyMB2OGfiN@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Jun 2023 10:46:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whW0W3YY4dHGbQoSagMnWEQbQ=Kgv48LJYN1OwVFz8qTQ@mail.gmail.com>
Message-ID: <CAHk-=whW0W3YY4dHGbQoSagMnWEQbQ=Kgv48LJYN1OwVFz8qTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Integer overflows while scanning for integers
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 10:03=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> Added Linus into CC. Quick summary for him:
>
> 1. The original problem is best described in the cover letter, see
>    https://lore.kernel.org/r/20230607223755.1610-1-richard@nod.at

Well, honestly, I'm not convinced this is a huge problem, but:

> > I can't figure out what POSIX actually says should or could happen with
> > sscanf("99999999999999", "%i", &x);
>
> It looks to me that it does not say anything about it. Even the latest
> IEEE Std 1003.1-2017 says just this:

We really don't need to language-lawyer POSIX. It's one of those
"let's follow it to minimize confusion" things, but no need to think
our internal library decisions need to actually care deeply.

For example, we did all the '%pXYZ" extensions on the printf() side,
which are very much *not* POSIX. They have been a huge success.

And even when it comes to the user space ABI, we've always prioritized
backwards compatibility over POSIX.

In some cases have actively disagreed with POSIX for being actively
wrong. For example, POSIX at one point thought that 'accept()',
'bind()' and friends should take a 'size_t' for the address length,
which was complete garbage.

It's "int", and I absolutely refused to follow broken specs. They
ended up fixing their completely broken spec to use 'socklen_t'
instead, which is still completely wrong (it's "int", and anything
else is wrong), but at least you can now be POSIX-compatible without
being broken.

In this case, I would suggest:

 - absolutely do *NOT* add a WARNING() for this, because that just
allows user space to arbitrarily cause kernel warnings. Not ok.

 - fail overflows by default

 - to be able to deal with any compatibility issues, add a way to say
"don't fail overflows" in the format specs, maybe using '!'.

IOW, make

     sscanf("999999999999", "%d", &i);

return 0 (because it couldn't parse a single field - go ahead and set
errno to ERANGE too if you care), but allow people to do

     sscanf("999999999999", "%!d", &i);

which would return 1 and set 'i' to -727379969.

That makes us error out on overflow by default, but gives us an easy
way to say "in this case, I'll take the overflow value" if it turns
out that we have some situation where people gave bad input and it
"just worked".

There's a special case of "overflow" that we may need to deal with:
passing in "-1" as a way to set all bits to one in an unsigned value
is not necessarily uncommon.

So I suspect that even if the conversion is something like "%lu" (or
"%x"), which is technically meant for unsigned values, we need to
still allow negative values, and just say "it's not overflow, it's 2's
complement".

                 Linus
