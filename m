Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E44706E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjEQQ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjEQQ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:27:55 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3937E45
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:27:53 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62384e391e3so4008726d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684340873; x=1686932873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKP3y2yRA1niickBAZNGt652pVuj+gN+BwTUxLrXHNQ=;
        b=x6IZmmBCbPWXYEV1s7cwpW+6JSUPvlKX/pEzz5bkryXn1zZebfylT4DUapS4sia6Bm
         593nM5GeWZJyZU3elQthsjSQjaLVUhiT1xATIBTlx6rJyiWe0BccHZKUZGy7Z49VVOLd
         ULfJnBAe1kcFUWU2OIxI2oQBL0av3WUv1TcT/EojkwXeF6gWCYxGzmC+msS0zdE7h2c6
         fFxl6SEEE9bf4C/2eLRqperK6PFAMdAo5Anph13Y+2ohfRM3KPQVKxLEiepYwlcZclQY
         Kbs6f6WlYEPs0MMgn7IKu31Wd88GMhBytneV3IfZ4EFpknd5ojk0j/bgaMZ1fWbTt4V/
         rOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340873; x=1686932873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKP3y2yRA1niickBAZNGt652pVuj+gN+BwTUxLrXHNQ=;
        b=amWrh+9KBaGF5fxVXhwhKh7tVCSsvSh7CNrDr4qOwl1jhTBC4GnJxmogh7iTtxEocq
         Ht/YzxSZ4s3wkMgcQRAtu628m20tERDucSYVcYmJgLJjQRPTTqCbr4odAymTDy+RPphK
         CT4CLplTwMoHGElQ3I6HHi1RqnzlCmgZCu9j7keGHczWhlooJl5cSDjDRtYM2zGzKl2x
         tYZV7tq65cGe9K5i/yay6jnskspyJEvPNmE/KiRQEhygU7sUjQtHtWQSX4XsE09mOnxc
         yudnh3r3yS8XZVlxAsM1Qc0UJIuBvoR0nKBLdjyDKwOvLEosTzQh5t+hPM/o02hMiHY9
         SYEw==
X-Gm-Message-State: AC+VfDzbdXW9NUG6VHvgl2nTkg3AIE+9q4lSA1zz0bT6WhMwv7txuIg5
        LUs59WQVxQTOCJrXIzLQw91rK6Q5wiC4j3/KgSVfmw==
X-Google-Smtp-Source: ACHHUZ5i7gqrt52vlZ8Nnb/F0kMFD8QMC/x9Q5gQRUQ0nTJlG6e6Y29/q9q1G0M5KBatPnK9A2vJ9E/t/pXyL0yzlQ8=
X-Received: by 2002:ad4:5dc4:0:b0:61a:c2bf:9f0b with SMTP id
 m4-20020ad45dc4000000b0061ac2bf9f0bmr658197qvh.6.1684340872605; Wed, 17 May
 2023 09:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com> <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com>
 <CAKwvOdmSrAxx-YY1Na3BSdYuxXCPKK+F0K5V6i+adTn_bVJEsw@mail.gmail.com>
 <89961dfc-d40f-78e4-5d34-b86b7d152182@collabora.com> <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
 <17c91d37-7d9c-0df4-2438-2b30ca0b5777@collabora.com> <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com>
 <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com>
In-Reply-To: <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 May 2023 09:27:41 -0700
Message-ID: <CAKwvOdkFxu9hYSL_RCXadpR0dQd1+dZmAUVXdfFiLUfxg4D_Xw@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 8:39=E2=80=AFAM Ricardo Ca=C3=B1uelo
<ricardo.canuelo@collabora.com> wrote:
>
> Hi Nick,
>
> On 16/5/23 1:01, Nick Desaulniers wrote:
> > Can you please help verify this failure by hand, and see if applying
> > https://github.com/ClangBuiltLinux/linux/commit/45c4fb6095d872785e07794=
2da896d65d87ab56b.patch
> > helps?  If you can repro; mind sharing your precise steps to reproduce?
>
> I ran a few tests but the commit that introduced your changes
> passes every time. There's a chance that the bisector got misled
> due to the test runs failing for whatever reason unrelated to the
> patch. There's definitely something introducing a bug somewhere,
> as current mainline/master makes this test fail on this target
> when kernel/configs/debug.config is applied, but it must be
> somewhere else. I'll investigate this some more to see what I can
> find.

Thanks for verifying/reporting.


>
> About the steps to reproduce it, we're using the current KernelCI
> tools (kci_build) to generate the kernel. To actually launch the
> tests I'm submitting jobs to Collabora's LAVA lab, which is
> something that isn't available to external users, so it might be
> a bit hard for you to reproduce the exact environment from the
> original test. If you need to test something, I can do it for
> you.

Shreeya mentioned upthread that `qemu_arm-virt-gicv3-uefi` was
failing, so I assume others should be able to repro in qemu. I'd guess
that LAVA lets you have VMs adjacent to physical hardware.  Having the
qemu command line, kernel config, and perhaps the initramfs are going
to be the three most useful things for any similar bug report.
--=20
Thanks,
~Nick Desaulniers
