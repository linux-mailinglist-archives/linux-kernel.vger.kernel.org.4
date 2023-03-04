Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01586AAC1A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCDTUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCDTUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:20:16 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1251A1A4A2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 11:20:15 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id da10so23213281edb.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677957613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3SyI5wgA+xTVIyMgqXNDzGyf+k3DO/lHNaL5moHRgg=;
        b=gIZNwHIq7of5vBXFWYayy/5Jn4WG7jeGgLHTbK2wcsymhq/38Aessnoje0kTTXsKfG
         9lcp/uJxGqqsHwBl6IlSqQEeQQHaNsyKIMpryyA5ArC48Q79bgWbpXqj13jELuhhOHN/
         2rVcsvLwZ+IvMfoAMx/76Zj8wwAdwKJXLMs0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677957613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3SyI5wgA+xTVIyMgqXNDzGyf+k3DO/lHNaL5moHRgg=;
        b=Jyhjq4Mgiuo2C82bp8DFXZh/KL8MMI7GZlUoYo9hFV4GSl0cWW9k7/j5K+9XO0+y4A
         tmX7IXozS0r4ZSuOKL4J5M8qVlT7jCaOEywr4uUHa7g2UVgGK8fNPlS6Vf0PGwbd/RSo
         +G+/ubAe6kLeDvZBo4XLj8HOkjoFJSC/negxQdWF9rDfZ83pRwR+0HzfGPL6Omx8Js6L
         s3A5LEYlP6s1Q4cEmOak+ATi61PPQYsQyPp+5y4JI32E7kMwqIHJRsXTZxTfBjbduc2i
         lAtRJHW4ClTvPHjjrnrk0OifePFPeq1+DxeogXPYwqNh6rc+VxoxZ3ngZyUs50MYeQ+q
         7Z0w==
X-Gm-Message-State: AO0yUKXX25K8/DaRH3hf98TMvCHOuACzznatw/1P8QRkj1Iyjnabmo8g
        WElmz5HmE1TnGauZlpmOEI3JQOCypLwNeITcMzGQfg==
X-Google-Smtp-Source: AK7set+dSJ8opDNywbbFnXP8iIGw8P5/RH/GF0FY5yrDc1I98gsh+odswnZd5AJMMVTG7Ge8lyf5zg==
X-Received: by 2002:aa7:d915:0:b0:4ad:7224:ce9d with SMTP id a21-20020aa7d915000000b004ad7224ce9dmr5776899edr.17.1677957613331;
        Sat, 04 Mar 2023 11:20:13 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id s26-20020a50ab1a000000b004bf999f8e57sm2726119edc.19.2023.03.04.11.20.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 11:20:11 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id f13so23123833edz.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 11:20:11 -0800 (PST)
X-Received: by 2002:a17:906:3d51:b0:8f1:4c6a:e72 with SMTP id
 q17-20020a1709063d5100b008f14c6a0e72mr2610583ejf.0.1677957611299; Sat, 04 Mar
 2023 11:20:11 -0800 (PST)
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
Date:   Sat, 4 Mar 2023 11:19:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
Message-ID: <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
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
> And the following code will be broken:
>
> cpumask_t m1, m2;
>
> cpumask_setall(m1); // m1 is ffff ffff ffff ffff because it uses
>                     // compile-time optimized nr_cpumask_bits
>
> for_each_cpu(cpu, m1) // 32 iterations because it relied on nr_cpu_ids
>         cpumask_set_cpu(cpu, m2); // m2 is ffff ffff XXXX XXXX

So  honestly, it looks like you picked an example of something very
unusual to then make everything else slower.

Rather than commit aa47a7c215e7, we should just have fixed 'setall()'
and 'for_each_cpu()' to use nr_cpu_ids, and then the rest would
continue to use nr_cpumask_bits.

That particular code sequence is arguably broken to begin with.
setall() should really only be used as a mask, most definitely not as
some kind of "all possible cpus".

The latter is "cpu_possible_mask", which is very different indeed (and
often what you want is "cpu_online_mask")

But I'd certainly be ok with using nr_cpu_ids for setall, partly
exactly because it's so rare. It would probably be better to remove it
entirely, but whatever.

              Linus
