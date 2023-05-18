Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846EC7083DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjEROXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjEROXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:23:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D1E10D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:23:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9203:ad00:b00e:5f04:110d:a967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A01046605941;
        Thu, 18 May 2023 15:23:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684419796;
        bh=xPO1unEEJVJK0T2OHZBtJMRAKEmESNmxmqAwbWmk0IM=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=UZS18BmKRQMiohEWgPcA4RWHECb14V6w64eSrDuN9tKWNbUk22TMBHDX+9QVK/Q7Q
         SYCxCuNWHV7LuLpZ+Ev3T0RajaYu8YseXPs+rpaB/ToBUGrPW9DPxu7Kjp6xC0N1FP
         g4JOBtd+jww/UWoYRkR2rKGUA3ceSLy6USSLE/MdWs9UYGVYybN777OI2zQjFgz/qv
         doxGD+iRX8PUE8nITSPtE61/xoFPlae/utTC/gBSnxPfyPzXDTwx8C5J120RGlD3zQ
         lFfzjRS7mrGNv75xzoOJP91upfb+yp7n+ZNVKPFU0S37ATMUKWf5GEJ1Fsj6i1+PAs
         bUKiJNgBPTnyw==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev,
        "gustavo.padovan\@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, kernelci@lists.linux.dev
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with compiler-specific macros
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com> <20220919170828.3718437-1-ndesaulniers@google.com> <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com> <CAKwvOdmSrAxx-YY1Na3BSdYuxXCPKK+F0K5V6i+adTn_bVJEsw@mail.gmail.com> <89961dfc-d40f-78e4-5d34-b86b7d152182@collabora.com> <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com> <17c91d37-7d9c-0df4-2438-2b30ca0b5777@collabora.com> <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com> <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com> <CAKwvOdkFxu9hYSL_RCXadpR0dQd1+dZmAUVXdfFiLUfxg4D_Xw@mail.gmail.com>
In-reply-to: <CAKwvOdkFxu9hYSL_RCXadpR0dQd1+dZmAUVXdfFiLUfxg4D_Xw@mail.gmail.com>
Date:   Thu, 18 May 2023 16:23:13 +0200
Message-ID: <878rdlk9bi.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nick,

On mi=C3=A9, may 17 2023 at 09:27:41, Nick Desaulniers <ndesaulniers@google=
.com> wrote:
> Shreeya mentioned upthread that `qemu_arm-virt-gicv3-uefi` was
> failing, so I assume others should be able to repro in qemu. I'd guess
> that LAVA lets you have VMs adjacent to physical hardware.  Having the
> qemu command line, kernel config, and perhaps the initramfs are going
> to be the three most useful things for any similar bug report.

Sure, I'm using LAVA because that's the safest way to match exactly the
same setup from the original test, but anyone can try to reproduce it on
their own. You can get the job info and setup from any of the related
LAVA jobs. This one for example:
https://lava.collabora.dev/scheduler/job/10373216

Trying to reproduce this type of setups is not as straightforward as
we'd like, specially for people not familiar with KernelCI, but we're
putting in some effort to improve that so that anyone can pick up a
regression report and work on it right away.

By the way, I found a breaking point in the commit right after the one
that the bisector reported:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D5750121ae7382ebac8d47ce6d68012d6cd1d7926
but I can't find anything there either that makes the boot hang,
specifically for configs including kernel/configs/debug.config. I
wouldn't rule out a problem with the qemu configuration.

Anyway, this is not a critical problem in any way, although it'd be
interesting to find the cause in case we can use the findings to improve
the test setups.

Cheers,
Ricardo
