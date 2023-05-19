Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D483E7091BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjESIfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESIft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:35:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C705102
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:35:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9203:ad00:12f5:ce1d:c8ab:bb96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B4C76605960;
        Fri, 19 May 2023 09:35:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684485345;
        bh=yjBON+zRg7ZjvIUz47H8LbZbKfsz5bLofO+XkmCgFJ4=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=IcoakT/g2c1m4s5VFi+BkmaHbAURqRJja//PpqPmnXeQhBejvqWfOSVV8XpGGdzhM
         Cmzsj032C+qIC/W74j1UQ3UtfaCoLNmCqMeHeWcwogS/5o6MizX+FgVLqmnEXlw7IQ
         UjPXL7k6eZ40unEus5b2+yVrU7cqDkq3IbstrCfb4XFPgx8patMgoJDtebofTCsJ08
         D8wJ9Ek732eFA8aAcVdqkppa/X/oZjhl1sM11DFn40ND+DWAl1BK2Zm2SXwR3I7xEF
         XePn0EICqwI/x32Jsz+8om2MJ9M2E91WX9YPWiskvD4RTx4CeJv1XueK/dxREryOTc
         dZLzNJkefYBbQ==
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
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com> <20220919170828.3718437-1-ndesaulniers@google.com> <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com> <CAKwvOdmSrAxx-YY1Na3BSdYuxXCPKK+F0K5V6i+adTn_bVJEsw@mail.gmail.com> <89961dfc-d40f-78e4-5d34-b86b7d152182@collabora.com> <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com> <17c91d37-7d9c-0df4-2438-2b30ca0b5777@collabora.com> <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com> <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com> <CAKwvOdkFxu9hYSL_RCXadpR0dQd1+dZmAUVXdfFiLUfxg4D_Xw@mail.gmail.com> <878rdlk9bi.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me> <CAKwvOd=8LVU+iANkFx18Wm1jg7gYiAXovAmo9t5ZZaVdMULn-Q@mail.gmail.com>
In-reply-to: <CAKwvOd=8LVU+iANkFx18Wm1jg7gYiAXovAmo9t5ZZaVdMULn-Q@mail.gmail.com>
Date:   Fri, 19 May 2023 10:35:42 +0200
Message-ID: <875y8ok9b5.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On jue, may 18 2023 at 14:12:30, Nick Desaulniers <ndesaulniers@google.com> wrote:
> That's a higher risk change (and has my name on the tested-by tag, yikes).
>
> So is that the culprit of the boot failure you're observing?

Right now it is.

Here's a test run using that commit
(5750121ae7382ebac8d47ce6d68012d6cd1d7926):
https://lava.collabora.dev/scheduler/job/10373216

Here's one with the commit right after that one
(26ef40de5cbb24728a34a319e8d42cdec99f186c):
https://lava.collabora.dev/scheduler/job/10371513

Then one with 26ef40de5cbb24728a34a319e8d42cdec99f186c with a revert
commit for 5750121ae7382ebac8d47ce6d68012d6cd1d7926 on top:
https://lava.collabora.dev/scheduler/job/10371882

But I'm not confident enough to jump ahead and call this a kernel
regression, specially after the bisector confidently said that about
your commit and then it turned out none of us could reproduce it.

There have been some cases where a commit made a test fail (kernel
failing to load, for instance) and the real problem was that the kernel
got bigger than the target was capable of handling. So not a problem
with the commit at all, it was just that the memory mappings needed to
be redefined for that target. What I'm saying is that sometimes a
regression report is really uncovering a problem in the test setup
rather than introducing a bug. Maybe this is one of those cases.

Cheers,
Ricardo
