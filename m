Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C837E6AB1C2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 19:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCESnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 13:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCESnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 13:43:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702ABCDEB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 10:43:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s11so29974014edy.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 10:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678041818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK/rrMwqyPmyu+qAqo29lnLv2pRkbjMCkopb9tAe0Bw=;
        b=L/L1p+p287ayjfrr2WV0hGq9D51L0hN9W/l+u4K/eva2mK1HoPszjfDUJBEJP0XeBk
         iAitbcUlClR3pt7TlxH0Pm8wGoAQLXaHqojHPz1mK0RItMQXm3j+piZaFcfSHApa+FCP
         A6qfQmeB9CT+1UFij6KBtgFeAyi3IDWWvkQjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678041818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zK/rrMwqyPmyu+qAqo29lnLv2pRkbjMCkopb9tAe0Bw=;
        b=jSTBEAMJBjdDakZZxbiTaVpO+dSb98/VgepndserEobC7m/l0Kc9F2OF7gSjGA8U9d
         +pUsX/sVVhe25hnhRF0ogpYNOhd7KzKXCnCMFHrnHfC3UN3HxedDu3BAFEALpdXjh3sp
         DP8ZwL+tw88HqSWT16XrX8f6npJXzDbY+Kz7U9aC5YAcIv85UncTXFgAaxdx8waM/UY5
         TMTq8+KNqtASgCZdpJOGnD91OfOTe/4AAm9uWGaMXwJHUHAMJ9CVfnIgZhiKaNnoJRNy
         X5ZxzPG35gtiGvfpKmlwh7TFo8pNEBsBKJ+uSyoM26QCJvrFy8ggpOAbmbt9NQdLEniq
         zBwQ==
X-Gm-Message-State: AO0yUKUByj5IhoptzUqpaEklOI7L1PKmmczEkRokyJ0yvS3HxaKArwE3
        IvCiiQuqNw1oUXzs7uO1FdNcjXnKD34ZoKuNss20Hg==
X-Google-Smtp-Source: AK7set+nhLolK8YPerzI2bj4XqhDh/uNWqCJUWjzhWNq3vr+5ZTdAgywgHXSKTSbix8InlAsyLgcMw==
X-Received: by 2002:aa7:cf04:0:b0:4ac:bb85:c895 with SMTP id a4-20020aa7cf04000000b004acbb85c895mr7889475edy.1.1678041818545;
        Sun, 05 Mar 2023 10:43:38 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id m30-20020a50d7de000000b004c13fe8fabfsm4004722edj.84.2023.03.05.10.43.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 10:43:37 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id f13so29987779edz.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 10:43:37 -0800 (PST)
X-Received: by 2002:a50:9f47:0:b0:4bc:13f5:68a5 with SMTP id
 b65-20020a509f47000000b004bc13f568a5mr4529109edf.5.1678041816888; Sun, 05 Mar
 2023 10:43:36 -0800 (PST)
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
 <CAHk-=wiHp3AkvFThpnGSA7k=KpPbXd0vurga+-8FqUNRbML_fA@mail.gmail.com>
 <CA+icZUUH-J3eh=PSEcaHRDtcKB9svA2Qct6RiOq_MFP_+KeBLQ@mail.gmail.com> <CAHk-=wgzNnvVwjoW0Ojn1V_BcEoYX=wydcMs-FTNV+7kJmfq=A@mail.gmail.com>
In-Reply-To: <CAHk-=wgzNnvVwjoW0Ojn1V_BcEoYX=wydcMs-FTNV+7kJmfq=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Mar 2023 10:43:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1evFSMjkpNgL-6p2Qx44nR9r0GK+1mPodous89czBfQ@mail.gmail.com>
Message-ID: <CAHk-=wg1evFSMjkpNgL-6p2Qx44nR9r0GK+1mPodous89czBfQ@mail.gmail.com>
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

On Sun, Mar 5, 2023 at 10:17=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> There are a few main issues with MAXSMP:

It's probably worth noting that most architectures don't even support
MAXSMP at all.

Only x86-64 does.

For example, ia64 and sparc64, which both did techncially support a
lot of cores, just made "cpumask_t" huge, and had no support for the
whole "use a pointer to an indirect allocation".

That ends up meaning that you allocate those huge structures on the
stack or just make other structures enormous when they contain a CPU
mask, but it mostly works. It's a horrid, horrid model, though. But at
least ia64 had 64kB stacks anyway, and in the book of "bad engineering
decisions of Itanium", this is all just a footnote.

arm64 also has that "range 2 4096" for number of CPUs but defaults to
a much saner 256 cpus.

I suspect (and sincerely hope) that nobody actually tries to use an
arm64 build with that 4k cpu build. If/when arm64 actually does get up
to that 'thousands of cores" situation, they'll hopefully enable the
MAXSMP kind of indirection and off-stack cpu mask arrays.

So MAXSMP and the whole CPUMASK_OFFSTACK option is an architecture
choice, and you don't have to do it the way x86-64 does it. But the
x86 choice is likely the best tested and thought out by far.

For example, POWERPC technically supports CPUMASK_OFFSTACK too, but
really only in theory. On powerpc, you have

    config NR_CPUS
          range 2 8192 if SMP
          default "32" if PPC64

so while configuration the range is technically up to 8k CPUs, I doubt
people use that value very much. And we have

        select CPUMASK_OFFSTACK if NR_CPUS >=3D 8192

so it only uses that OFFSTACK one if you pick exactly 8192 CPUs (which
presumably nobody does in real life outside of build testing - it's
not the default, and I think most of the POWER range tops up in the
192 core range, eg E980 with 16 sockets of 12 cores each).

So I suspect that x86-64 is the *only* one to actually use this
widely, and I think distros have been *much* too eager to do so.

The fact that most distros default to

    CONFIG_MAXSMP=3Dy
    CONFIG_NR_CPUS=3D8192

seems pretty crazy, when I have a hard time finding anything with more
than 192 cores.  I'm sure they exist. But do they _really_ run
unmodified vendor kernels?

               Linus
