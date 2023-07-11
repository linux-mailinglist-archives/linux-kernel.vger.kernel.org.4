Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E1074F898
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjGKUAw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjGKUAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:00:51 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D7C10E7;
        Tue, 11 Jul 2023 13:00:49 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-577ddda6ab1so40147b3.0;
        Tue, 11 Jul 2023 13:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689105649; x=1691697649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74whqM41d7CpA+NyRK8UvTd9meXyXG7n/W6IYNx1Ri0=;
        b=lKY6A+eG3UpHH7hNSNu+SUVlQe6tK40fyRNn34mcY4GzujXib2FkqgDFeYd8RJrNzO
         SnAg9JnoKd4tLniXtualg7fn7rS95iM/4Rv3DtJEP5BsKVgTItDrpQ/aUv2K2NskgvQX
         +Wpq3N5sFdPKl6zO/HLH8Swd1DttN90oi3dZyw5Uml3m6a/ZIa8MNvgbS5lF9I/0pa3g
         U0LXMeG5NH7S9jB9IREJ0tIBpu6TUgs4APnNjvBrHX+i+7UHbY40bODeouHNmT/kpl5L
         So5XkQRzHYVzKY7SUbWJEGuut1596UkvGGq1HQpfkThrzVo1GzvXBanDQCyjekXYZ3N0
         0Jvg==
X-Gm-Message-State: ABy/qLZWbYM9tI+WW3jLb2yaJXsd283v5XFrHu6bnGQTIBafQ6JgEwWy
        73vtVCFKoZCY1NZYdHPecpRB7tBzW04h9A==
X-Google-Smtp-Source: APBJJlGDY/dxrz/+tXARzxI38TCEPu6oWr15qCzLg+YBdSr4vV4RcCtrNuvXxR5kQIcfflFhS8KJvg==
X-Received: by 2002:a81:a114:0:b0:56d:2e66:bd55 with SMTP id y20-20020a81a114000000b0056d2e66bd55mr14633320ywg.3.1689105648809;
        Tue, 11 Jul 2023 13:00:48 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i184-20020a0dc6c1000000b005771872a8dbsm753755ywd.132.2023.07.11.13.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 13:00:48 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c1aad78d5b2so4724276.0;
        Tue, 11 Jul 2023 13:00:48 -0700 (PDT)
X-Received: by 2002:a25:db51:0:b0:c5c:76c7:aa44 with SMTP id
 g78-20020a25db51000000b00c5c76c7aa44mr17033206ybf.12.1689105648378; Tue, 11
 Jul 2023 13:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140825.47793-1-wsa+renesas@sang-engineering.com> <CAMuHMdXr4CmupM9vadidHdyv0ShOhR2yYCCxeDt70d1rPUXBdg@mail.gmail.com>
In-Reply-To: <CAMuHMdXr4CmupM9vadidHdyv0ShOhR2yYCCxeDt70d1rPUXBdg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jul 2023 22:00:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwN9Z2Bui6PR6QxBoLJnvs--BXXep10NR7wRd1cfqKKA@mail.gmail.com>
Message-ID: <CAMuHMdWwN9Z2Bui6PR6QxBoLJnvs--BXXep10NR7wRd1cfqKKA@mail.gmail.com>
Subject: Re: [PATCH RFT] mmc: renesas_sdhi: register irqs before registering controller
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Mon, Jul 10, 2023 at 4:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Jul 10, 2023 at 4:10 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > IRQs should be ready to serve when we call mmc_add_host() via
> > tmio_mmc_host_probe(). To achieve that, ensure that all irqs are masked
> > before registering the handlers.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Thanks for your patch!
>
> > Based on 6.5-rc1 with bf54dec9e953 ("Revert "mmc: Revert "mmc: core:
> > Allow mmc_start_host() synchronously detect a card") reverted. That base
> > alone shows the regression. This patch works fine on a Salvator-X with a
> > M3-W. I'll test more boards. Yet, I send it out so people can tests with
> > boards I don't have.
>
> I guess bf54dec9e953 is your local commit that reverts commit
> fa700d73494abbd3 ("mmc: Revert "mmc: core: Allow mmc_start_host()
> synchronously detect a card"") in v6.5-rc1?
>
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -1004,10 +1004,11 @@ int renesas_sdhi_probe(struct platform_device *pdev,
> >                 host->ops.start_signal_voltage_switch =
> >                         renesas_sdhi_start_signal_voltage_switch;
> >                 host->sdcard_irq_setbit_mask = TMIO_STAT_ALWAYS_SET_27;
> > -               host->sdcard_irq_mask_all = TMIO_MASK_ALL_RCAR2;
> >                 host->reset = renesas_sdhi_reset;
> >         }
> >
> > +       host->sdcard_irq_mask_all = TMIO_MMC_MIN_RCAR2 ? TMIO_MASK_ALL_RCAR2 : TMIO_MASK_ALL;
>
> The condition above is always true. I assume you wanted to test
> "mmc_data->flags & TMIO_MMC_MIN_RCAR2" instead?

No issues seen after reverting fa700d73494abbd3 and applying your patch
(plus the fix below) on top of today's renesas-drivers release.

--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1004,11 +1004,12 @@ int renesas_sdhi_probe(struct platform_device *pdev,
                host->ops.start_signal_voltage_switch =
                        renesas_sdhi_start_signal_voltage_switch;
                host->sdcard_irq_setbit_mask = TMIO_STAT_ALWAYS_SET_27;
+               host->sdcard_irq_mask_all = TMIO_MASK_ALL_RCAR2;
                host->reset = renesas_sdhi_reset;
+       } else {
+               host->sdcard_irq_mask_all = TMIO_MASK_ALL;
        }

-       host->sdcard_irq_mask_all = TMIO_MMC_MIN_RCAR2 ?
TMIO_MASK_ALL_RCAR2 : TMIO_MASK_ALL;
-
        /* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
        if (!host->bus_shift && resource_size(res) > 0x100) /* old way
to determine the shift */
                host->bus_shift = 1;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
