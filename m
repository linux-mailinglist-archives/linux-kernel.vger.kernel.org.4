Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7745EC7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiI0PaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiI0P3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:29:53 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56D1057F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:29:51 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id i17so3249622qkk.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Wv/hl+O47KbBKhsHuHGT+af8ji5KfNfvypidSDA5LSc=;
        b=DsyBR68Wu/S0VVba+qv6CVMCZqho0zQmVavZf/at76t36etIAfhSqDIcdEfmG4tFRQ
         W0Bxq6SLFRwquDDPh5X9w4qqDqrYEOHY5md2HDrYc0oBxt0nStO8aSQAkkPHpS2temCA
         4uBYwwmoODXKir/dBRM2cfW6ESDSxFFKikdDBxsPeNCJhrb7B/6RYGEgS50mZ2r/FqvU
         5XGxS6dZl5iUFeW+mJ259IMDkmoB2oQUXhz7ifAhi0EmKbWYK5+w3ZbgqasWM9L8cBqu
         qMAjIcDmgxbRzellNS25YCDeYPGkFVm4E/1nv2VPNT9t//85sLt0eojr4gUgXv7vyG+h
         op6A==
X-Gm-Message-State: ACrzQf0ld8GIKmPL8kcZukOP1kc7dFcyN1CSJBFp8s8ZIB4Am9Pthl/l
        KzJo7ywjW7fGNbE9dnwh83KwZMMHuP1obg==
X-Google-Smtp-Source: AMsMyM4y1IHeh00+UbSj4RLyVNLF140fegQMHFam8eOFWbMeFQC3noTyG1J41Vk8XAgqA/BvUzXkXw==
X-Received: by 2002:a05:620a:254f:b0:6cf:9b54:11dd with SMTP id s15-20020a05620a254f00b006cf9b5411ddmr7608729qko.55.1664292590715;
        Tue, 27 Sep 2022 08:29:50 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id z80-20020a376553000000b006b953a7929csm1159329qkb.73.2022.09.27.08.29.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:29:50 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 4so4502708ybe.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:29:50 -0700 (PDT)
X-Received: by 2002:a25:3851:0:b0:6ad:9cba:9708 with SMTP id
 f78-20020a253851000000b006ad9cba9708mr26843654yba.36.1664292589905; Tue, 27
 Sep 2022 08:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <b0981cb5a97452af73b9dd0dd0eb03c5002f7af4.1664285626.git.geert+renesas@glider.be>
 <fe2b1f48-e18a-b1d9-0c62-ddddf9e6515f@arm.com> <CAMuHMdVFAwqVtrRFf-_jSODWeJuGAzbpoyk65HDOqj9h6AUt2A@mail.gmail.com>
 <9db42ab0-da49-95fd-3fea-eb505af0867e@arm.com>
In-Reply-To: <9db42ab0-da49-95fd-3fea-eb505af0867e@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Sep 2022 17:29:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1KQ5TTftYuTT4_b6mmCT5Y+_jpSKau46-g8siDKWjGQ@mail.gmail.com>
Message-ID: <CAMuHMdW1KQ5TTftYuTT4_b6mmCT5Y+_jpSKau46-g8siDKWjGQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable: Make IOMMU_IO_PGTABLE_DART invisible
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
        Hector Martin <marcan@marcan.st>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, Sep 27, 2022 at 5:09 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2022-09-27 15:48, Geert Uytterhoeven wrote:
> > On Tue, Sep 27, 2022 at 4:15 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >> On 2022-09-27 14:36, Geert Uytterhoeven wrote:
> >>> There is no point in asking the user about both "Apple DART Formats" and
> >>> "Apple DART IOMMU Support", as the former is useless without the latter,
> >>> and the latter auto-selects the former.
> >>>
> >>> Fixes: 745ef1092bcfcf3b ("iommu/io-pgtable: Move Apple DART support to its own file")
> >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>> ---
> >>> Should IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S be made
> >>> invisible, too?
> >>> Are there users that do not select them?
> >>
> >> The aim was for formats to be independently selectable for COMPILE_TEST
> >> coverage. The Arm formats are manually selectable for the sake of their
> >> runtime self-tests, which are self-contained, but since DART format
> >> doesn't do anything by itself I'd agree there's no need to prompt when
> >> !COMPILE_TEST here.
> >
> > IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S are
> > selected by other symbols that can be enabled when compile-testing, so
> > the tests can still be enabled in those cases, too
>
> Sure, but when you want to compile-test a thing, what would you rather
> do: enable the thing, or go hunting to find some other thing that
> happens to select the thing you actually want, then potentially have to
> figure out *that* thing's dependencies, and so on?

Agreed.

> Coverage isn't solely about whether it's technically possible to ever
> reach somewhere at all, it's just as much about how easily and/or often
> you can get there in practice. I don't see who benefits from making
> COMPILE_TEST harder to use :/

So perhaps the visibility of IOMMU_IO_PGTABLE_LPAE and
IOMMU_IO_PGTABLE_ARMV7S should depend on COMPILE_TEST?
Normal users would still get it through select when needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
