Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DAA6AB1B3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 19:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCESRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 13:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCESRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 13:17:48 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76338113C0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 10:17:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so29827685eda.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 10:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678040264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0UA/7lZ63JFeoLOmQNO6i8Dnq6C2Xq3iYWWB1kja+U=;
        b=HZnF5dA8oOl+6Jlnkwgm3b1GR0uPuOeNeWpITcsq/Y922X60lZICne2mJfDliiEyZQ
         2z8fXZ7/KrhDTby4Oexr6bKDrXR7L3PfZFuUG6MOZQjuNiPggxitWxU7FySg3p0xbZZo
         B/VX77vk0etI7dKqL93YlzMMyYsfVn8I6ROh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678040264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0UA/7lZ63JFeoLOmQNO6i8Dnq6C2Xq3iYWWB1kja+U=;
        b=QoaGKMPmW11mqI1a0L8NwbnVc3wit7X+/Au5UjuBV3M+q0hda1O/z/+gExaC/ZnT8R
         BR+ZzcYlWm7CYpM3P5CPk74MYe4LpBqi10OCn/t+Ae8K3KjktTtM5KBtUBuARWRkmda+
         kvcCIv8YOl3dwpihsf9PX9RUYEP9S5np+Em1eG1508gqFFQ+wyWOK9u2sQLFofkd24Mv
         8aUNo86Kb5VHvTPLAyDH47EgG0S+5dlDz4SycRoXLJHoDBszv3uGwA3ZU/fpXXUlapxE
         XCqULi0dTupGQkPq/m3sg5Fe2+OYCJstOLHlzDhG827sqxLspN+Pl6OnzODoVow1ObCw
         8gQg==
X-Gm-Message-State: AO0yUKWOcHyS4TBVmRlx33a2s0LZ6tYeZtaEp+JmLyPjYXIIDFs/iQXX
        eA57jx2w6MvBKu+auu3N3J57XgQK8RKnm5RZ7i8K3A==
X-Google-Smtp-Source: AK7set/y2tDQ4Ko01G6hTlDG2OGaieq8efoXX1dW4Ihcc/YWvz7AJIBAFM2G7GkP8oAvtXto4e4bfQ==
X-Received: by 2002:a17:907:72c7:b0:889:d156:616d with SMTP id du7-20020a17090772c700b00889d156616dmr10576767ejc.27.1678040264182;
        Sun, 05 Mar 2023 10:17:44 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id r15-20020a50c00f000000b004bbc90e1fa3sm3966390edb.93.2023.03.05.10.17.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 10:17:43 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id cw28so29874568edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 10:17:43 -0800 (PST)
X-Received: by 2002:a17:906:4997:b0:877:7480:c75d with SMTP id
 p23-20020a170906499700b008777480c75dmr3913520eju.0.1678040262904; Sun, 05 Mar
 2023 10:17:42 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop> <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
 <ZAOvUuxJP7tAKc1e@yury-laptop> <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
 <CAHk-=whEwe1H1_YXki1aYwGnVwazY+z0=6deU-Zd855ogvLgww@mail.gmail.com>
 <CAHk-=wiHp3AkvFThpnGSA7k=KpPbXd0vurga+-8FqUNRbML_fA@mail.gmail.com> <CA+icZUUH-J3eh=PSEcaHRDtcKB9svA2Qct6RiOq_MFP_+KeBLQ@mail.gmail.com>
In-Reply-To: <CA+icZUUH-J3eh=PSEcaHRDtcKB9svA2Qct6RiOq_MFP_+KeBLQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Mar 2023 10:17:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgzNnvVwjoW0Ojn1V_BcEoYX=wydcMs-FTNV+7kJmfq=A@mail.gmail.com>
Message-ID: <CAHk-=wgzNnvVwjoW0Ojn1V_BcEoYX=wydcMs-FTNV+7kJmfq=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     sedat.dilek@gmail.com
Cc:     Yury Norov <yury.norov@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
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

On Sun, Mar 5, 2023 at 1:26=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com> =
wrote:
>
> can you share your "normal config", please?

Well, I just have CONFIG_NR_CPUS set to 64.

That happens to be the number of actual cores (well, threads) I have
on my desktop, but it's what I use for my laptop too (that has 8
cores).

Basically, I consider CONFIG_NR_CPUS=3D64 is likely the "sweet spot" for
code generation and still covering 99+% of all machines out there.

Now, MAXSMP is great for (a) coverage testing and for (b) being able
to handle pretty much *anything* out there, but it really was
originally meant for the SGI kind of hardware: not exactly
off-the-shelf.

So I use MAXSMP for compile testing (by virtue of "allmodconfig"), and
it's great for that. But unless you have more than several hundred
cpus in your machine, you should never use it.

There are a few main issues with MAXSMP:

 - the simple ("common") embedded cpu masks end up being big (ie any
data structure that has a "cpumask_t" in it will be huge, just because
the static size of 'struct cpumask' is 8192 bits, ie 1kB)

 - the fancy case of using a "cpumask_var_t" will use a pointer and a
dynamic allocation (which is then sized to be appropriate to the
*actual* number of CPU's, so that you don't have to allocate 8192 bits
for everything).

 - the code generation ends up inevitably being about variable-sized
loops, because nobody wants to traverse those kinds of data structures

In contrast, if you use CONFIG_NR_CPUS=3D64, both the embeddeed and
"fancy" version will be just a single 64-bit word. No extra pointer
overhead, no indirection through said pointers, and no need for loops
(ok, there will still be loops for walking the bits in the word, but a
lot of them will actually be about using instructions like "bsf" etc).

So you end up with better code, smaller data structures, and less
pointer chasing.

So those two situations are generally the two "sane" configurations: a
good reasonable NR_CPUS that works for just about everybody, and then
another extreme config for the 1% (or - more likely - 0.01%)

Now, it's not like 64 is somehow magical. Picking something like
NR_CPUS of 192 is perfectly fine too - it will use three words for the
bitmap, it will still avoid the pointer indirection, it will have a
few small fixed-size loops. It's certainly not *wrong*. It will cover
bigger HEDT machines, but I feel like the HEDT people probably are
special enough that they could probably just use the MAXSMP case, or -
if they care - just build their own kernels.

So you *can* certainly pick other values. We used to have special UP
vs SMP kernel builds, and that clearly no longer makes sense. Nobody
cares about UP on x86-64.

But I do feel like MAXSMP is simply not a great config for 99.9% of
all people, and if you are willing to have two configs, then that "64
or MAXSMP" seems to be the sane split.

And with that split, there will be *very* few people who actually use MAXSM=
P.

               Linus
