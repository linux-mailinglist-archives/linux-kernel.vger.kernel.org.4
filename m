Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009D15EC6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiI0OvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiI0OuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:50:17 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BA3BC3E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:48:41 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id g2so6171444qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sIkic6SUoveiF5m/KjLf8xeEdyIptPVHhr889tOMLnU=;
        b=nYzOcKx3EJuyAfJ9aDUTKc7o3DLunj3aAejfVjB0X73KAdvT3KafO//JxCjPR8ufRT
         MayerniMjK2tqrlBl9VY6HP+t9/hw05OI83yQIpwAr0UIhuWevST1fd0RiHB+ZVWwJ6L
         3PoyAiELEARRMn7w7sXGb5yqQjJJixxrEV5OUj98FnhM80XGIDZuLEZS0sOGxhKatOp1
         i6mIPxLG0Wh7At3ImvI+LdY5s+myK3pGHhLf6jBaWNAkw7fuFz2bcocQcrDeiSlLaiih
         BO85ML5Y9852c49Swi7/N+JaJLrLe8rMMaLv5f2KhfI415rlLWYxFAMTcRL4CoOc8Azy
         kdgA==
X-Gm-Message-State: ACrzQf2KuCc8aZAg4Y4xD5ySpRv926nnBeyel/ctUJZQM969HHgjobUc
        WGT1MFy+nePFDthfKiTgvZKTXq6RQxa1VA==
X-Google-Smtp-Source: AMsMyM4021cvju3rcgJdLmgELtzjPb+e7V7xF+b6WIz3V4OUUwF5uHCbyr4GZL82Ixv1pt5A5s5rEw==
X-Received: by 2002:a37:8a87:0:b0:6cf:3ee4:56e0 with SMTP id m129-20020a378a87000000b006cf3ee456e0mr17640225qkd.200.1664290120685;
        Tue, 27 Sep 2022 07:48:40 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id w23-20020a05620a0e9700b006b60d5a7205sm1105363qkm.51.2022.09.27.07.48.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:48:39 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3457bc84d53so103180717b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:48:39 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr24868987ywc.316.1664290119137; Tue, 27
 Sep 2022 07:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <b0981cb5a97452af73b9dd0dd0eb03c5002f7af4.1664285626.git.geert+renesas@glider.be>
 <fe2b1f48-e18a-b1d9-0c62-ddddf9e6515f@arm.com>
In-Reply-To: <fe2b1f48-e18a-b1d9-0c62-ddddf9e6515f@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Sep 2022 16:48:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVFAwqVtrRFf-_jSODWeJuGAzbpoyk65HDOqj9h6AUt2A@mail.gmail.com>
Message-ID: <CAMuHMdVFAwqVtrRFf-_jSODWeJuGAzbpoyk65HDOqj9h6AUt2A@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable: Make IOMMU_IO_PGTABLE_DART invisible
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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

On Tue, Sep 27, 2022 at 4:15 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2022-09-27 14:36, Geert Uytterhoeven wrote:
> > There is no point in asking the user about both "Apple DART Formats" and
> > "Apple DART IOMMU Support", as the former is useless without the latter,
> > and the latter auto-selects the former.
> >
> > Fixes: 745ef1092bcfcf3b ("iommu/io-pgtable: Move Apple DART support to its own file")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Should IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S be made
> > invisible, too?
> > Are there users that do not select them?
>
> The aim was for formats to be independently selectable for COMPILE_TEST
> coverage. The Arm formats are manually selectable for the sake of their
> runtime self-tests, which are self-contained, but since DART format
> doesn't do anything by itself I'd agree there's no need to prompt when
> !COMPILE_TEST here.

IOMMU_IO_PGTABLE_LPAE and IOMMU_IO_PGTABLE_ARMV7S are
selected by other symbols that can be enabled when compile-testing, so
the tests can still be enabled in those cases, too

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
