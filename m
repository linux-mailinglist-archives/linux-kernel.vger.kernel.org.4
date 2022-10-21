Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EF6607080
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJUGwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJUGw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:52:27 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE21CC3D8;
        Thu, 20 Oct 2022 23:52:26 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id l28so1114290qtv.4;
        Thu, 20 Oct 2022 23:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I59wsqYY5XzomQ555m16KBZpVHjF9zyFBjrO5xQI/Vo=;
        b=KssL1OH1AqDNqPwEntxsB3JYxC/8tfAJF6a0RqyotBp4M7hoPliNpTbR4xaWCeTU8S
         jYZhy6FlmsdnI+g9n/DRg1EKvZ27k7IcQQJ0ibOhNLevKtXWKBK/VA1SGR47khaRgIMw
         j9iR6MowaaGnWWeaPdAN4z1xGpLkIiK2tyYuNqj6dHbmc4iDbvzItJzHyhFpElA/P+Cd
         mdpO2IASsOCTMT3VjjJc2t3Q0IRv3NRT/zCh/v+cD+g/5nwVNXVz7VDp+0Il4r7f+xds
         oMraIhpXWPEhArkibmBMU5WFksuC9V/tV73uqKnbXPZ3cE3vtVQJc0s7WXY0JdC3kGa3
         EP/A==
X-Gm-Message-State: ACrzQf2J5HeERsuW3zVmDoX2ln/S82qnO7ylpcts3nLivnXX+EC8eY6S
        wS5YsQQCYAEfsG+0HRbA7RzbKH3Bujb6kA==
X-Google-Smtp-Source: AMsMyM5Lyb893NWOKTf2SOP1NMEVmji62KWV3elYvNwdu6dKlrPX9MqGQGbKEz6xQSmsz4cl1RyCfA==
X-Received: by 2002:ac8:5c11:0:b0:39c:fd77:336d with SMTP id i17-20020ac85c11000000b0039cfd77336dmr10700134qti.479.1666335145309;
        Thu, 20 Oct 2022 23:52:25 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id m21-20020ac866d5000000b0039cbd3e4ed1sm7526887qtp.6.2022.10.20.23.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 23:52:25 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y72so2235402yby.13;
        Thu, 20 Oct 2022 23:52:25 -0700 (PDT)
X-Received: by 2002:a25:cd01:0:b0:6c2:6f0d:f4ce with SMTP id
 d1-20020a25cd01000000b006c26f0df4cemr14410142ybf.365.1666335144961; Thu, 20
 Oct 2022 23:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221014151302.27641-1-afd@ti.com> <CAL_Jsq+O0_i3k_3S=W6C-n+ZE7GRKKhOQ7HR54QutmMJq54a_Q@mail.gmail.com>
In-Reply-To: <CAL_Jsq+O0_i3k_3S=W6C-n+ZE7GRKKhOQ7HR54QutmMJq54a_Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Oct 2022 08:52:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV2euzPQL35AqBsyeQTkMbkeFz4rk48wtyX7Hd6Lz5d-g@mail.gmail.com>
Message-ID: <CAMuHMdV2euzPQL35AqBsyeQTkMbkeFz4rk48wtyX7Hd6Lz5d-g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Allow DTB overlays to built from .dtso named
 source files
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andrew Davis <afd@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Oct 21, 2022 at 12:47 AM Rob Herring <robh+dt@kernel.org> wrote:
> On Fri, Oct 14, 2022 at 10:13 AM Andrew Davis <afd@ti.com> wrote:
> > Currently DTB Overlays (.dtbo) are build from source files with the same
> > extension (.dts) as the base DTs (.dtb). This may become confusing and
> > even lead to wrong results. For example, a composite DTB (created from a
> > base DTB and a set of overlays) might have the same name as one of the
> > overlays that create it.
> >
> > Different files should be generated from differently named sources.
> >  .dtb  <-> .dts
> >  .dtbo <-> .dtso
> >
> > We do not remove the ability to compile DTBO files from .dts files here,
> > only add a new rule allowing the .dtso file name. The current .dts named
> > overlays can be renamed with time. After all have been renamed we can
> > remove the other rule.
>
> There was a patch from Geert converting everything. I'd rather not
> support both ways.

Actually that was a patch from Frank?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
