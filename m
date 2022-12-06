Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF7643F7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiLFJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiLFJLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:11:23 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7031EEF8;
        Tue,  6 Dec 2022 01:11:22 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id m5so5458164qkg.0;
        Tue, 06 Dec 2022 01:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xecAIxqgdkhlDnskCgGkdXEsAstHBuFzAgEKe0CMxQ0=;
        b=KfytAYO9F49g5s9lztaqU/5+UzgojlMqCadE0j1zY2ueTk6LROKwr5e33ADEK4LLk1
         0UJPo6tv4wt996NNvu4vvqbeIIQwOnsaj3WOjxY4bqL82SbHCHI16oGbfCrgTcf8tu4o
         0GoHJucXkWyDrsB7OpRZrf/yK4M080sQSuypDRy8cNkvbYg/bTLYCc5u7Te0ciA+TeV2
         q3872gY3q65/BFJUPqV5/p62sGm9HHFLhr3SfnxMvmRhG2IEFa2ebXaD3jFzZmUUoTz8
         zPdjixlvlJSreK6ZgRLXfWgrXz1KpEMZddeP5OIqZ0u1L79FPPq65qnT5GZldNvYtTow
         BcWA==
X-Gm-Message-State: ANoB5pnZWKs1UoL/d+jHzPrRTQ4AxqblNmU0fX0SKenPNw/Vvqm3lTOO
        RsKAoFp1pawCvpcmwntuC9+VrRtgi3+Osw==
X-Google-Smtp-Source: AA0mqf7F/AAPhAhlvFo0AEEAXp2XGpuf5b+N+NcFZN/nHPHXqTC4IxZHT3gT5UyEcc/XDQAExGWKwg==
X-Received: by 2002:a05:620a:1398:b0:6fa:1d51:74a1 with SMTP id k24-20020a05620a139800b006fa1d5174a1mr59677651qki.688.1670317881311;
        Tue, 06 Dec 2022 01:11:21 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id o13-20020ac85a4d000000b003a68fe872a5sm2305892qta.96.2022.12.06.01.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 01:11:20 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id s11so3280889ybe.2;
        Tue, 06 Dec 2022 01:11:20 -0800 (PST)
X-Received: by 2002:a25:9:0:b0:6f9:29ef:a5ee with SMTP id 9-20020a250009000000b006f929efa5eemr28698201yba.380.1670317880298;
 Tue, 06 Dec 2022 01:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20221205163157.269335-1-nick.alcock@oracle.com> <20221205163157.269335-6-nick.alcock@oracle.com>
In-Reply-To: <20221205163157.269335-6-nick.alcock@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Dec 2022 10:11:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVrP1sLGRS999q=2L-5JhxXwcjBLkQREdcJhDerg70OtA@mail.gmail.com>
Message-ID: <CAMuHMdVrP1sLGRS999q=2L-5JhxXwcjBLkQREdcJhDerg70OtA@mail.gmail.com>
Subject: Re: [PATCH v10 05/13] kbuild: remove MODULE_LICENSE/AUTHOR/DESCRIPTION
 in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Thanks for your patch!

On Mon, Dec 5, 2022 at 5:34 PM Nick Alcock <nick.alcock@oracle.com> wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations in
> non-modules will cause modprobe to misidentify their containing object
> file as a module when it is not, which might cause it to spuriously fail
> when trying to load something that is built in to the kernel.  They
> also cause misconstruction of modules.builtin.objs, leading to incorrect
> output in kallmodsyms (notating things as being in modules when they
> actually cannot be built as a module at all).
>
> Automatically identified with the new tristate checker, and purged with
> sed and a subsequent make allmodconfig to double-check.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>

I can (sort of) agree with the MODULE_LICENSE(), as it duplicates the
SPDX-License-Identifier at the top.
However, you don't explain why it is a good thing to remove the
MODULE_{AUTHOR,DESCRIPTION}, too.  This is useful information, in an
easy-to-parse format.

Moreover, many of the affected drivers might be converted into modules
in the near or far future.

If the presence of these causes issues for the tooling, perhaps the
tooling can be fixed instead?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
