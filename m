Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4DB652A23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiLUADC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLUAC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:02:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D161C900;
        Tue, 20 Dec 2022 16:02:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h16so13390292wrz.12;
        Tue, 20 Dec 2022 16:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bIxMvbuO9yaK81EcXrGxNHHur90BJYczDKwTQOVxFg=;
        b=HizRdbK6aIQCTix5WLUu1NOK4XGS+3q5id/bxXXqrdlhxgvxEwOFBYgx8TLTnSX3W0
         FWKkXv848Tp8THdEvkYi4xPosOqGoJ/8F/9KAzUGT4EETsZLQ0gV6XVUqEBWIwsX0EXE
         FRi68GLaLqRmEzDfuzdYWmFadXzogZinKEWMVZ8JLZuKyAZnKUCWXmdq7ap+q9dum5e2
         JvTJzIE7yTGdwofw4TpOC6WbpdY//60lnU8VTBU8LyptE52HDd2hiE0Xy9R56SeeEI4G
         GizKAGJth/S9psWUeIi/Kv/A3F8It9UOQBizdSwmjU/kxohTTET+NOJKmf/SCwnURYEy
         mbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bIxMvbuO9yaK81EcXrGxNHHur90BJYczDKwTQOVxFg=;
        b=F6Gt9p6DY77RPonRnbK0eJSWyiMuVxzl+Ia3MoU3GpQkY3VFIhKKnUguaVoZg9NWZC
         j+jOC8DbPGeq66ugcVP1+2lMH8ZhDDJiA9RXFPkKeVTdPY87Oux4qGRdbjhoZfZapoae
         IOgOFUXcWe0TNCzRLl+X6NnHH8Jw8SBBwQOBaXYj3Aa5fMoWVfqea5JH+t0bYcYbs3TM
         qXKeoZAy55EAQnXCtyZUQiYNld9yaVdLv+AZZy4eld0bxBF3E8WkroMvB/gKOdnwoOMF
         Zpn6ymPa5uccWU0s3Y5vtwSWSKxq1YpkhQOPVnwhT8u/wTbmjkcq8c/sa/lcVOpAThVP
         wDgw==
X-Gm-Message-State: AFqh2kqr4/rEODIwSPf8Z7SqYAx6wIowgLSz3QDbsU+C29NNleklxS7D
        b3f1xNnEXDGgbprG06yASZc=
X-Google-Smtp-Source: AMrXdXuEKOv0Mbi3S4xpZ2/K6HynC1Y8FEvzHEf1+33Rx8qtzvrlRjBrYGXikGX+jH3jyM8XiIrwGA==
X-Received: by 2002:a5d:4d8a:0:b0:268:b15a:e7ae with SMTP id b10-20020a5d4d8a000000b00268b15ae7aemr1661740wru.5.1671580976699;
        Tue, 20 Dec 2022 16:02:56 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1595:a48c:95a8:15e0])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002362f6fcaf5sm13740150wrt.48.2022.12.20.16.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 16:02:56 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/9] Add IRQC support to RZ/G2UL SoC
Date:   Wed, 21 Dec 2022 00:02:33 +0000
Message-Id: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series does the following:
* Adds IRQC support to the RZ/G2UL SoC.
* Drops mapping NMI interrupt as part of IRQ domain
* Parses interrupts based in interrupt-names
* Includes a fix for pinctrl driver when using GPIO pins as interrupts
* Adds PHY interrupt support for ETH{0/1}

v1->v2
* Updated binding doc
* Dropped mapping NMI interrupt as part of IRQ domain
* Fixed review comments pointed by Geert
* Added support to parse interrupts by name
* Added compile time checks for gpio config arrays

RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (9):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
    RZ/G2UL SoC
  dt-bindings: interrupt-controller: irqc-rzg2l: Drop RZG2L_NMI macro
  irqchip: irq-renesas-rzg2l: Skip mapping NMI interrupt as part of
    hierarchy domain
  irqchip: irq-renesas-rzg2l: Add support for RZ/G2UL SoC
  pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
  pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
  arm64: dts: renesas: r9a07g043u: Add IRQC node
  arm64: dts: renesas: r9a07g043[u]: Update pinctrl node to handle GPIO
    interrupts
  arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for
    ETH{0/1}

 .../renesas,rzg2l-irqc.yaml                   | 240 +++++++++++++-----
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   2 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  72 ++++++
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    |  11 +-
 drivers/irqchip/irq-renesas-rzg2l.c           | 102 ++++++--
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  25 +-
 .../interrupt-controller/irqc-rzg2l.h         |   3 -
 7 files changed, 366 insertions(+), 89 deletions(-)

-- 
2.25.1

