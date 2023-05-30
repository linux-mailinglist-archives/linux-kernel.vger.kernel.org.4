Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C75715815
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjE3INk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 04:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjE3INh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:13:37 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E38F;
        Tue, 30 May 2023 01:13:36 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-561c1436c75so60481627b3.1;
        Tue, 30 May 2023 01:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434416; x=1688026416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9Vz4Mcu07ZG1Duh8zc0cEOELXefrTV8SfNph9PmAWs=;
        b=DVO2L8Fk76Fyz100+16gT9UpfRv2UACXJPDiyQQ6FKMxdTyWFDUBpNmMJm/3GnCZg7
         wOFe1zjRyfQcE75ERaipy69tSqQO9GnATQrda//kiEGfspL/9g8y5NfvaL+YohcJr9Qh
         +xJ3YZd0awoBjoFS+yOrrC1tf5Ggn3IjwyhHccsUoPWUGTGSXH3r3gk7c/G6elAvS261
         6ta6PwsNFk4oTnejhDf17WoZ5uoUqzxhQ55eqmtgQ4iXY7AsfGUWQDpeSx/PuXVMmciQ
         T2QR7N4Wq0QI+YrBinTbv5RmfJQRqEJxgvPDDMFtsEGYOtWkmFaerYUvyrTNy5IwWDsM
         6yfg==
X-Gm-Message-State: AC+VfDyeqxUA5ICKfxjS7w2ZfRepVMTlegZRMimfdDe/h1KwbbaNTxbs
        G0TG+Rav+IqqgYJkTmGp2X44EFkoomoHXQ==
X-Google-Smtp-Source: ACHHUZ419HcmoIL7UeM2RnOj8LXoFP36QGm3PvD6UfXwVw2rBna9CX4tQWJ6E/16XSoakbV8zmsh1Q==
X-Received: by 2002:a81:4806:0:b0:561:d1b0:3f7e with SMTP id v6-20020a814806000000b00561d1b03f7emr1411512ywa.44.1685434416036;
        Tue, 30 May 2023 01:13:36 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id g74-20020a0ddd4d000000b00565b26a9c9csm3468008ywe.64.2023.05.30.01.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 01:13:35 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so7723002276.2;
        Tue, 30 May 2023 01:13:35 -0700 (PDT)
X-Received: by 2002:a25:cf96:0:b0:bad:f1f:7d4b with SMTP id
 f144-20020a25cf96000000b00bad0f1f7d4bmr1994288ybg.24.1685434415493; Tue, 30
 May 2023 01:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220307143014.22758-1-lcherian@marvell.com> <164668950224.3277206.2552145973830842260.b4-ty@kernel.org>
In-Reply-To: <164668950224.3277206.2552145973830842260.b4-ty@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 May 2023 10:13:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUmTV3Mmp-6LGiEqNG7DdxsBq-dpoGwTv7MHHMJQrGcLA@mail.gmail.com>
Message-ID: <CAMuHMdUmTV3Mmp-6LGiEqNG7DdxsBq-dpoGwTv7MHHMJQrGcLA@mail.gmail.com>
Subject: Re: [PATCH V3] irqchip/gic-v3: Workaround Marvell erratum 38545 when
 reading IAR
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, Linu Cherian <lcherian@marvell.com>,
        maz@kernel.org, tglx@linutronix.de, kernel-team@android.com,
        linuc.decode@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Mar 7, 2022 at 11:15 PM Will Deacon <will@kernel.org> wrote:
> On Mon, 7 Mar 2022 20:00:14 +0530, Linu Cherian wrote:
> > When a IAR register read races with a GIC interrupt RELEASE event,
> > GIC-CPU interface could wrongly return a valid INTID to the CPU
> > for an interrupt that is already released(non activated) instead of 0x3ff.
> >
> > As a side effect, an interrupt handler could run twice, once with
> > interrupt priority and then with idle priority.
> >
> > [...]
>
> Applied to arm64 (for-next/errata), thanks!
>
> [1/1] irqchip/gic-v3: Workaround Marvell erratum 38545 when reading IAR
>       https://git.kernel.org/arm64/c/24a147bcef8c

This workaround is now enabled on R-Car V4H:

    GIC: enabling workaround for GICv3: Cavium erratum 38539

which is not a Cavium SoC. Is this expected?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
