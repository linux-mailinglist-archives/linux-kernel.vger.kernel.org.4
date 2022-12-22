Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D774A65408F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiLVMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiLVL7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:59:51 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307CA286C2;
        Thu, 22 Dec 2022 03:52:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz12so4307121ejc.9;
        Thu, 22 Dec 2022 03:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TufOMWDEgv+LdQVF9KDrnCcYkAYV1qSL3kWuyPvOfwA=;
        b=inQmetdI5RRs36eir0mFdFWZ18MrFXh78ZYY6/l70HHY/dZKkEA0oU1esZNBUfrWvT
         XjQjK270kGKoSxURgH4GLqBFHbVdpg2GEKryI1ow6BRVpGmmiimPNPX2iwgDhudaulo7
         3I2llcftHQOdIS+ajTrp/qSSmX1pIbOkpAeDwovR+Qri+Bmv3sM/6o1N63LAT2CmdaIa
         HC9QZN3mPXOLvEXC17kBbod8fyt0KcJ4TzfZp0+HxoRRSOltH6AZ0mf4USGuCELzDsUA
         kaCrZY2oZlB83r6kJwURh88ng06s4eNDyEXjl82bHRXsEBzj5HnSJj3vvn23f5IPSETc
         I+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TufOMWDEgv+LdQVF9KDrnCcYkAYV1qSL3kWuyPvOfwA=;
        b=O2qS0UgbObHzNM/9NTdmVVjvLsi5V6Lgrti+rSM3f1JbYkaIUezym7RTI5vdMmicCy
         yrZIWEPTc+4J2P/rmJX9v0ZmeUpcu6OZyXd+K5kGCFkiZTVVOPcCkgYbzoC4eQV/06/i
         ha91kVrZemQdJg14e6vRfX6hOg9cy/SnDQabW8dd2T6ROQGVJyKOG94esHOu8AqqnFYh
         PNNG6lcCKhMpCDc5irRD4Qh9ePmtycSBEovfi2rA2UhPInn0xavG+WLwDSHEU9XZVtWF
         C99zQyEM/owRVAyT0KJPKEjpbj075dDL3dOFfs7eo/5Tl2TiPX60pQijiQVKkBzkCsJa
         cauA==
X-Gm-Message-State: AFqh2koeoNIN/ZFclNmiTm23ej00/Pww26/IH7vrayobtQDiuensNSFa
        ORkb2hXbEOayjDOWb7OUI2D0QKH2eH5uzKBhVDsYvMn7fPQ=
X-Google-Smtp-Source: AMrXdXtIq+L4D2O0znucrvf9ePrNFLOUUwv84W+UTAgoCjf3g0+lLHvAmHLTlgbHT4+x4hu1mB54+dPk0rJgmTxPBkM=
X-Received: by 2002:a17:906:b01:b0:7c1:808e:765b with SMTP id
 u1-20020a1709060b0100b007c1808e765bmr340816ejg.196.1671709965796; Thu, 22 Dec
 2022 03:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <86mt7haw0h.wl-maz@kernel.org>
In-Reply-To: <86mt7haw0h.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 22 Dec 2022 11:52:19 +0000
Message-ID: <CA+V-a8vb-PfzMWX=ndF8nsyYVbkfYBkAQZ-UoS9zpQPndL871Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] irqchip: irq-renesas-rzg2l: Skip mapping NMI
 interrupt as part of hierarchy domain
To:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Geert,

On Wed, Dec 21, 2022 at 10:31 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 21 Dec 2022 00:02:36 +0000,
> Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > NMI interrupt is not an external interrupt as compared to the IRQ0-7 and
> > TINT0-31, this means we need to install the irq handler for NMI in the
> > IRQC driver and not include it as part of IRQ domain.
> >
> > This patch skips mapping NMI interrupt as part of the IRQ domain
> > hierarchy.
>
> Does it mean nobody can connect anything to it? Where is the handler
> you're mentioning for this NMI?
>
I got this clarified internally the NMI interrupt is an external
interrupt just like the other IRQ0-7/TINT interrupts. I'll drop this
patch in the next version.

Cheers,
Prabhakar
