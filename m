Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF716F3903
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 22:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjEAUIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEAUIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 16:08:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A51FFD
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 13:08:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f173af665fso16761455e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1682971730; x=1685563730;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNEnyZjeMgXIjOySMzC1Nr3EEs2BX/oIpvOTrJwSTWA=;
        b=NU/XgCJwVgtNGw/y4aUZ4yUwZD0YoY7sBruWi76FiK2ktpoUCs5qTXiINRBKOnwSDg
         r2pbXdqhIiE3OrmHSpSiBozKFp4XDo9gtX2VoMa3jYnWeUGRneBn/T6D9H6OMZDa8WXw
         3QDnD9Oc5htL3mM0KhfH0xcQ8RUBq+HtWrIHEt1mMuNzxBELZsWk1L5sWib/6RbPSj2Z
         hG7RJS7ssg3OLRyDnOJNadaSBxBWIASSVW4YVVjH89nyKaINJHcb7MY0c69qrqgvg937
         HT7fnk+nJrcVqqg/HeA702lyOfG8x16JNnh6mRkNIwWgR+K3h90m22tP781w0O80astL
         nGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682971730; x=1685563730;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNEnyZjeMgXIjOySMzC1Nr3EEs2BX/oIpvOTrJwSTWA=;
        b=EpLpvoeB2FtQBIOgrx6ILAmTy0DcpsJF19llqkf0mjzCFy5VvsqSiLJTuTDCtcP2UP
         th5w9C5zUUe83FQ8l41KOSY6Yyaiu0UrgbYMIS1fd8sGJkFj911FgtdWzFEmkkbwbmaQ
         dfG02k/U26QSbFIxO+Zv+BYtcL9d91ZGIMQHXOoM/LDL7+lvettN1Hg3ot+KlhnuDsn1
         9Bdb/jF7Q1WE5YMReaa63lk/1jItgrateZk6RcE/Ba3n1rDYMtaTa1klAAZSf4iE2jB+
         /dYvPrN7h7djs4DfpWn/B7ZnusBEJh9ZBhGIDIo0l5TivgpNLipEGLdgMnAKeYkITIj9
         3oug==
X-Gm-Message-State: AC+VfDyUecD8KDrVqfC+LdKtorsQqujqO3caWjhq4SI/5CzH+ekbG2A2
        DRz4aHrKNNssfdw8PaJq4Vlapg==
X-Google-Smtp-Source: ACHHUZ6Hfmr3l/cAhhs3vBCFmGlsXjd7ooDbYqDSdAUhXWW3tajdyie0cH6nmfHmMO2cWAU7Mtu1bQ==
X-Received: by 2002:a7b:c408:0:b0:3eb:42fc:fb30 with SMTP id k8-20020a7bc408000000b003eb42fcfb30mr10291092wmi.32.1682971730542;
        Mon, 01 May 2023 13:08:50 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c028e00b003f18b942338sm33058328wmk.3.2023.05.01.13.08.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2023 13:08:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux
 vector
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <87ednz7roh.fsf@all.your.base.are.belong.to.us>
Date:   Mon, 1 May 2023 21:08:48 +0100
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kito Cheng <kito.cheng@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Greentime Hu <greentime.hu@sifive.com>, nick.knight@sifive.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu,
        richard.henderson@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DD2C38C-CBB3-41EE-A195-50E4C2451B7E@jrtc27.com>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <87ednz7roh.fsf@all.your.base.are.belong.to.us>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 May 2023, at 20:55, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrote:
>=20
> Heiko Stuebner <heiko@sntech.de> writes:
>=20
>> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>>=20
>> The hwprobing infrastructure was merged recently [0] and contains a
>> mechanism to probe both extensions but also microarchitecural =
features
>> on a per-core level of detail.
>>=20
>> While discussing the solution internally we identified some possible =
issues,
>> tried to understand the underlying issue and come up with a solution =
for it.
>> All these deliberations overlapped with hwprobing being merged, but =
that
>> shouldn't really be an issue, as both have their usability - see =
below.
>> Also please see the "Things to consider" at the bottom!
>>=20
>>=20
>> Possible issues:
>> - very much limited to Linux
>> - schedulers run processes on all cores by default, so will need
>>  the common set of extensions in most cases
>=20
> ...which hwprobe has support for via the CPU mask. no?
>=20
>> - each new extensions requires an uapi change, requiring at least
>>  two pieces of software to be changed
>> - adding another extension requires a review process (only known
>>  extensions can be exposed to user-space)
>> - vendor extensions have special needs and therefore possibly
>>  don=E2=80=99t fit well
>>=20
>>=20
>> Limited to Linux:
>> -----------------
>>=20
>> The syscall and its uapi is Linux-specific and other OSes probably
>> will not defer to our review process and requirements just to get
>> new bits in. Instead most likely they'll build their own systems,
>> leading to fragmentation.
>=20
> There are a number of examples where multiple OSs have followed what
> Linux does, and vice versa. I'd say the opposite -- today system
> builders do not do their own solution, but review what's out there and
> mimics existing ones.

Where they can. But if the interface is =E2=80=9Cmake =
architecture-dependent
syscall X=E2=80=9D that=E2=80=99s not going to fly on other OSes where =
syscalls are not
architecture-dependent. Similarly if it=E2=80=99s =E2=80=9Cgo read =
auxarg Y=E2=80=9D where Y is
architecture-dependent and the OS in question has
architecture-independent auxargs. Or the system doesn=E2=80=99t even =
have
auxargs. Now, at the end of the day, I couldn=E2=80=99t care less what =
Linux
does to communicate the information to userspace, what matters is what
the userspace interface is that random IFUNCs are going to make use of.
Something which seems to be woefully lacking from this discussion. Is
the interface going to just be syscall(2)? Or is there going to be some
higher-level interface that other OSes *do* have a hope of being able
to implement?

> Personally I think this argument is moot, and will not matter much for
> fragmentation.
>=20
>> Feature on all cores:
>> ---------------------
>>=20
>> Arnd previously ([1]) commented in the discussion, that there
>> should not be a need for optimization towards hardware with an
>> asymmetric set of features. We believe so as well, especially
>> when talking about an interface that helps processes to identify
>> the optimized routines they can execute.
>>=20
>> Of course seeing it with this finality might not take into account
>> the somewhat special nature of RISC-V, but nevertheless it describes
>> the common case for programs very well.
>>=20
>> For starters the scheduler in its default behaviour, will try to use =
any
>> available core, so the standard program behaviour will always need =
the
>> intersection of available extensions over all cores.
>>=20
>>=20
>> Limiting program execution to specific cores will likely always be a
>> special use case and already requires Linux-specific syscalls to
>> select the set of cores.
>>=20
>> So while it can come in handy to get per-core information down the =
road
>> via the hwprobing interface, most programs will just want to know if
>> they can use a extension on just any core.
>>=20
>>=20
>> Review process:
>> ---------------
>>=20
>> There are so many (multi-letter-)extensions already with even more in
>> the pipeline. To expose all of them, each will require a review =
process
>> and uapi change that will make defining all of them slow as the
>> kernel needs patching after which userspace needs to sync in the new
>> api header.
>>=20
>>=20
>> Vendor-extensions:
>> ------------------
>>=20
>> Vendor extensions are special in their own right.
>> Userspace probably will want to know about them, but we as the kernel
>> don't want to care about them too much (except as errata), as they're
>> not part of the official RISC-V ISA spec.
>>=20
>> Getting vendor extensions from the dt to userspace via hwprobe would
>> require coordination efforts and as vendors have the tendency to =
invent
>> things during their development process before trying to submit =
changes
>> upstream this likely would result in conflicts with assigned ids down
>> the road. Which in turn then may create compatibility-issues with
>> userspace builds built on top of the mainline kernel or a pre-
>> existing vendor kernel.
>>=20
>> The special case also is that vendor A could in theory implement an
>> extension from vendor B. So this would require to actually assign
>> separate hwprobe keys to vendors (key for xthead extensions, key for
>> xventana extensions, etc). This in turn would require vendors to
>> come to the mainline kernel to get assigned a key (which in reality
>> probably won't happen), which would then make the kernel community
>> sort of an id authority.
>>=20
>>=20
>>=20
>>=20
>> To address these, the attached patch series adds a second interface
>> for the common case and "just" exposes the isa-string via the
>> AT_BASE_PLATFORM aux vector.
>=20
> *A second interface* introduced the second hwprobe landed. Really?
> Start a discussion on how to extend hwprobe instead.

I=E2=80=99ve been trying to push for something other than this for =
months, but
RVI took no interest in dealing with it until it got closer to these
landing, at which point finally some action was taken. But even then,
heels were dragged, and it took hwprobe being landed to force them to
finally publish things. But of course too late, so now the ecosystem is
forever screwed thanks to their inaction.

All I wanted was some simple extension string -> version number function
as a standardised userspace interface... because at the end of the day
people just want to know =E2=80=9Ccan I use extension Y?=E2=80=9D, =
possibly with a
minimum version. But maybe there=E2=80=99s some hope that Linux libcs =
will
translate such queries into poking at this hwprobe thing. Though god
knows what they=E2=80=99re going to do about vendor extensions, =
especially if
those vendor extensions only get supported in vendor forks of the
kernel (who=E2=80=99s allocating their encodings? Xvendorfoo exists to
namespace them and give vendors control...).

Jess

