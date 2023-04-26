Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92B56EF7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbjDZPdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbjDZPdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:33:15 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08C530C4;
        Wed, 26 Apr 2023 08:33:13 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54f8af6dfa9so104789657b3.2;
        Wed, 26 Apr 2023 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682523192; x=1685115192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/Qe8qA3fHR0DJ9awFHl+xJWRX9IcqbauBmCzaqaPDM=;
        b=kcQcUnB045g649/sPS4cd4aWR51M8dATi1sfvAaxyg3GBJ9bSAVrRYIiS1zxuuDVC0
         AXzatI1pX9JfgYyrlQJ+9SUhD7G37SZSWZY8t2tlDGTamSukc6f+pDpj3uBzSmrwu8Ck
         bqAORgBKYfvw2xK4KYxuB9pl0YViZLDpmQdqDdtjk7OxTi2U9iqNU9Oj6z6AJmLW+VE6
         lBXiU/mZiCGmDPs5TZnFL3tQbn7f5A6WOOk2Z708q/pRlAyCVCDemC0l0MbEmS0bTCM0
         ECG8MWmb/U5E5fbPIpapo1PUl3FeI4+UDZO+xCOdYUwegWUnMNd9woc8K7j7wAWWAt4L
         PTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682523192; x=1685115192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/Qe8qA3fHR0DJ9awFHl+xJWRX9IcqbauBmCzaqaPDM=;
        b=jD9IOYb2q8xSNuPOo6pEnP2ZoAkPn2UAsxwTxR0RUoMZ3Zv8VXURye1YxQrjKh06pb
         dqOyZ+VDSex9W5J3a3uc2Z0wQNRtjEnONoCpT8NOIddcW9IDNJ7lRMy1MsUHHDqmvaT4
         Lq2Y9zy+iN+r6pFY/tWSmS9qVCEXWQ874fA3R5q3YoBYFtIfK7cKds/FYaifvzovmB8D
         9svWH9Smeq5BjkKsePDqxuDMkKsB962HUjKQetA45IEZZvOc+A0Q0A/iCn0ah3Kt1J5A
         QQayheBIeQanxq96eyR3lDbQ1rADWdLuWcTjk/6bqpesM13qpc7z1zq0uPfTXt67DQJo
         87Lg==
X-Gm-Message-State: AAQBX9duM0Vo6jMbMRxbtxsBeXljNCOuxwuYbrxPETyBHmpSZD0s2xPU
        Bufr0Qw9JyUOWGIa21lt0Ff2pt38CJjEKSrHUYY=
X-Google-Smtp-Source: AKy350aDTjt9oOtlFzvX7M/KIlYoRb+/b86NTLTir4OIIDrglA8XJk/HpgOTl5O1YOreDQfWTg6IckZhPl2wMfNtw1M=
X-Received: by 2002:a81:4911:0:b0:54f:e33f:31bc with SMTP id
 w17-20020a814911000000b0054fe33f31bcmr14102642ywa.2.1682523191828; Wed, 26
 Apr 2023 08:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <ZDSRSWhWsN34MghQ@xps> <CANiq72=n1b=fJ2XZZx_MLKkbKMTmnmTBMgA3GJ_hqyARPtwEiQ@mail.gmail.com>
 <20230412025834.GA301301@mit.edu> <aae753d6-6874-4f91-e7ba-bd6c77f07b62@metux.net>
In-Reply-To: <aae753d6-6874-4f91-e7ba-bd6c77f07b62@metux.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 Apr 2023 17:33:00 +0200
Message-ID: <CANiq72=L+tQOOQ3VQb8tTCwGOO3rKZpJbs5k7KrFwoFb-BdeOQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Deborah Brouwer <deborah.brouwer@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 3:37=E2=80=AFPM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> As already said in my other mail, one major problem IMHO is (recent
> enough) toolchain availability for the major distros and package build
> systems - including the embedded ones (ptxdist, buildroot, bitbake,
> ...).
>
> IMHO, those who want Rust in the kernel, should take care of this first.
> (and no: asking to download some precompiled binary from somewhere is
> not any acceptable solution)

Some distributions already provide up-to-date Rust versions compiled
by themselves. Those should work if we start tracking the latest
version, which is what I discussed above.

You can, of course, do it yourself too and build the compiler
yourself. Other that that, if you are not OK with third-party
binaries, or binaries we could potentially upload to kernel.org, there
is little we can do until the minimum version arrives to your favorite
distribution.

Having said that, we still need to declare a minimum version, and for
that, extra funding or engineer-hours would be helpful. If your
organization/company is up for it, please contact me.

> ACK. Maybe those folks could set up some CIs for at least building and
> deploying the Rust patches on as many distros as possible - hopefully
> before they're sent to lkml.

I am unsure what you are asking for. Testing patches for the Rust
subsystem? We already do that, of course, and some independent CIs and
companies have already started building with Rust some configs (e.g.
KernelCI and 0-Day).

If you are concerned about distributions breaking their toolchains,
well, sure, we could also test their packages. But it would be best
that, instead, distributions looking to support kernel developers set
up a test on their side, since they are the ones deciding what to do
with their toolchain packages.

I talked with a few distributions' maintainers about this lately, and
most of them were very helpful, so they may be interested in
supporting kernel developers using their distribution for development.
Would that help?

Cheers,
Miguel
