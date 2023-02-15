Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB676697975
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjBOKBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjBOKBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:01:11 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6624C8E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:01:05 -0800 (PST)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8A9DD3F215
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676455264;
        bh=N6nLfe3Ogw8JebzYy5+qmB5POBTivnyXYU0aBkUXowQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=JIeaudR4mbYN5e4tKLDFictbCRnvVkglBxXXDqci5fp33DonnGKb6QTB0qQFzKfb6
         vez+mG8MVCKwKnL7SLl0usuVkvF/KCuXL+BXiXhiGowKhVLfAuPyCsTj6LiOOyNejs
         u08z4nyfN0sb9slFB9QVMzj+m0AvncBXSgS73wEnXbvQX5f5kKSptcBs/El+rF9M+y
         HYs6coNe4gp2dk+UTvhTXcTbSpamiDJQ4DKX46tvhwI8L71rtZDfd/AOqyEjARLiK+
         yeBWeNr+mC8G4UGiI64o8gusUbDY4+i5u07TYTEh7TdbQHpyfpvJxFzW2fkJ9u66wN
         HUvqrbZbAjBww==
Received: by mail-qk1-f198.google.com with SMTP id a198-20020ae9e8cf000000b007259083a3c8so11126760qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6nLfe3Ogw8JebzYy5+qmB5POBTivnyXYU0aBkUXowQ=;
        b=iGKlLsTp+llHrWC2HPAU0yHP4/gcntpbZ9iPntbhUdfRjDFumfEKcuG+UlQzXnoS83
         ij5QGb6lMyCxmMRzetz5eGNAQ0O6O80a2tLyEziI7ITZWPOqqVzRUru+Wg5674/9lKy+
         bh/JsGQpwc3RHSpPA8MpW+r6udpclyHdzffnRJ38TRzDDYAXMpxEZENci81kjVhPXQq+
         RnHI113ApDPnry95WpG4eYEBKbr0U1UOeREGrH3fV2RpZfpiYiHBZIe6XKBegVywsYPr
         uweO2lYtI7pN5cxzvwpeJRuTiGRJkEKDbpmhUjJNRsuFtj0TfZAPiEDbjm7SoD12fB7R
         o4og==
X-Gm-Message-State: AO0yUKWYCp886zDduuNsXjhObxX8GRxq9ytyB1bTuwavOwzgcVhN0piJ
        cg64bjIWZLUvwt7d9CcrWnEv+PU6nHZvRgGavIYHR9XZao6TAOOrfBU6BmaPy8qTEHB0Zv43zXO
        6nvC400/cEvybN9MSAbSeQ+MeqsG1Qgqdr9F7g4b6oZwYuV38crgU1vEU1w==
X-Received: by 2002:a37:4249:0:b0:73b:3411:48b1 with SMTP id p70-20020a374249000000b0073b341148b1mr77167qka.219.1676455263485;
        Wed, 15 Feb 2023 02:01:03 -0800 (PST)
X-Google-Smtp-Source: AK7set+9H4L1nqdu+2ESDHje9l8E+qLdMohDtVuTVdGzCspjXkgOLnXU/9AA+6LBSrMd5WIhdVG6YbR1SazSJWLVTSk=
X-Received: by 2002:a37:4249:0:b0:73b:3411:48b1 with SMTP id
 p70-20020a374249000000b0073b341148b1mr77162qka.219.1676455263227; Wed, 15 Feb
 2023 02:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20230203081913.81968-1-william.qiu@starfivetech.com> <CAPDyKFqei-GjKpBUQnDZUbYnSyn-JS5f_EnTLOuA1U4PdYTyVA@mail.gmail.com>
In-Reply-To: <CAPDyKFqei-GjKpBUQnDZUbYnSyn-JS5f_EnTLOuA1U4PdYTyVA@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 15 Feb 2023 11:00:46 +0100
Message-ID: <CAJM55Z8gpBDu9818GPLRYJ9DBa+NfXW0uo76_bkwWm6RS1S9wg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] StarFive's SDIO/eMMC driver support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 at 13:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 3 Feb 2023 at 09:19, William Qiu <william.qiu@starfivetech.com> wrote:
> >
> > Hi,
> >
> > This patchset adds initial rudimentary support for the StarFive
> > designware mobile storage host controller driver. And this driver will
> > be used in StarFive's VisionFive 2 board. The main purpose of adding
> > this driver is to accommodate the ultra-high speed mode of eMMC.
> >
> > The last patch should be applied after the patchset [1]:
> > [1] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
> >
> > Changes since v2:
> > - Wraped commit message according to Linux coding style.
> > - Rephrased the description of the patches.
> > - Changed the description of syscon regsiter.
> > - Dropped redundant properties.
> >
> > The patch series is based on v6.1.
> >
> > William Qiu (3):
> >   dt-bindings: mmc: Add StarFive MMC module
> >   mmc: starfive: Add sdio/emmc driver support
> >   riscv: dts: starfive: Add mmc node
> >
> >  .../bindings/mmc/starfive,jh7110-mmc.yaml     |  77 ++++++++
> >  MAINTAINERS                                   |   6 +
> >  .../jh7110-starfive-visionfive-2.dtsi         |  23 +++
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  37 ++++
> >  drivers/mmc/host/Kconfig                      |  10 +
> >  drivers/mmc/host/Makefile                     |   1 +
> >  drivers/mmc/host/dw_mmc-starfive.c            | 185 ++++++++++++++++++
> >  7 files changed, 339 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> >  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
> >
>
> Patch 1 and patch 2 applied for next, thanks!
>
> Note that I fixed some checkpatch errors/warnings. Next time, please
> run ./scripts/checkpatch.pl before you submit your patches.

Hi,

Something here is not right. The bindings document "starfive,sysreg",
but the code is looking for "starfive,syscon".
William, did you test this and run dtbs_check before sending this series?

/Emil

> Kind regards
> Uffe
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
