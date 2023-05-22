Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F35D70B9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjEVKJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjEVKJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:09:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECB9BA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:09:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9203:ad00:c068:e703:1301:7049])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96EB36605706;
        Mon, 22 May 2023 11:09:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684750177;
        bh=6rimz3xbCtOIAsgtzqTRf5vqJmiKmuivxmZtfJtFqCI=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=BSK1xoZm/IlfL0P2CI3I3YbJsUU8lZSAIrGKGgUQiJ7odBhMH22zguUC+xNsHcdVO
         2LCJXoaTEATkpK/ZlNsSisuMThoQdIRp75V85qbkBbXcH5EpULVkY0z6L5vfP4q3rZ
         LOGRmm+cAQUZFNyeaFkKHi1ANHYn7dF7tscSTYc1hMFgYCwUadXkmfkbrsKMkQdDhU
         MQrjFsEKl60dR9U0IGPkc4HCUtRhMtSwp4rs7R676LQc7nY2ZahVmAdNmfR/xBuuW8
         rIowwyVVqaBa4c/ha/RZaffma63e7jl6O1PTm0uj4o3Yp7Z6Mx4iXmOWrwqyZAsUIS
         RLihHMT+ezdOg==
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
        denys.f@collabora.com, kernelci@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with compiler-specific macros
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com> <20220919170828.3718437-1-ndesaulniers@google.com> <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com> <CAKwvOdmSrAxx-YY1Na3BSdYuxXCPKK+F0K5V6i+adTn_bVJEsw@mail.gmail.com> <89961dfc-d40f-78e4-5d34-b86b7d152182@collabora.com> <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com> <17c91d37-7d9c-0df4-2438-2b30ca0b5777@collabora.com> <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com> <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com> <CAKwvOdkFxu9hYSL_RCXadpR0dQd1+dZmAUVXdfFiLUfxg4D_Xw@mail.gmail.com> <878rdlk9bi.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me> <CAKwvOd=8LVU+iANkFx18Wm1jg7gYiAXovAmo9t5ZZaVdMULn-Q@mail.gmail.com> <875y8ok9b5.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me> <CAKwvOdmJJibt6sHSp91v2s7BxUWBC6xG7F7+3C6gUxNMzZ2xRA@mail.gmail.com>
In-reply-to: <CAKwvOdmJJibt6sHSp91v2s7BxUWBC6xG7F7+3C6gUxNMzZ2xRA@mail.gmail.com>
Date:   Mon, 22 May 2023 12:09:34 +0200
Message-ID: <87353ok78h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On vie, may 19 2023 at 08:57:24, Nick Desaulniers <ndesaulniers@google.com> wrote:
> It could be; if the link order was changed, it's possible that this
> target may be hitting something along the lines of:
> https://isocpp.org/wiki/faq/ctors#static-init-order i.e. the "static
> initialization order fiasco"
>
> I'm struggling to think of how this appears in C codebases, but I
> swear years ago I had a discussion with GKH (maybe?) about this. I
> think I was playing with converting Kbuild to use Ninja rather than
> Make; the resulting kernel image wouldn't boot because I had modified
> the order the object files were linked in.  If you were to randomly
> shuffle the object files in the kernel, I recall some hazard that may
> prevent boot.

I thought that was specifically a C++ problem? But then again, the
kernel docs explicitly say that the ordering of obj-y goals in kbuild is
significant in some instances [1]:

    --- 3.2 Built-in object goals - obj-y

    [...]

    Link order is significant, because certain functions (module_init()
    / __initcall) will be called during boot in the order they
    appear. So keep in mind that changing the link order may e.g. change
    the order in which your SCSI controllers are detected, and thus your
    disks are renumbered.

We'll dig deeper into this. Thanks for your insight.

Cheers,
Ricardo

[1]: https://www.kernel.org/doc/Documentation/kbuild/makefiles.txt
