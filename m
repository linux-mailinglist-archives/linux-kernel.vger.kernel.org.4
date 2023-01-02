Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AAC65B782
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjABWSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjABWSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:18:30 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3139592;
        Mon,  2 Jan 2023 14:18:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z10so27544978wrh.10;
        Mon, 02 Jan 2023 14:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wZIWvfT1uJMqx6ukLQ7vb16vHBpK1b+BBT/t6DKt+tM=;
        b=S+EuOgqAiV0aPUV6cZovT5jdd6yrX8O7+/W4cOQ7WaXN1VCwQU2r0rZUCM6cUJ6axn
         NAGFmjW9sVbLpemWKmY8JeuRckLpSPf3ULLf+TknWzFBf1GW2YSl//vpnuIR3aBxMZwY
         Blc4w3WlWhbD1OeD2C3opwt9LHvMatcWzUYkyCtuftfX7a7vdFo7SQ5iOBmamZgWUP5u
         5U9TaJ6oBOBCEBhEOqeT2UN19c3l1VLdiTp0PvAwS0Qm/q7XgkITv36M614vF60zJpLn
         5xPcxFSzPvWM6/3Dp39vaajhf9Fx+Lzv6Zjr9MPmizFDHixfOV26smBnRy864+Q00B2R
         eTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZIWvfT1uJMqx6ukLQ7vb16vHBpK1b+BBT/t6DKt+tM=;
        b=0T0bA3Epn05a83llSiR7zcFVraaedzUE2Se4uRui6MQxjzscOGhb/cpMNJ9mRirLW1
         Xhm8JbqJMr9rkHyYWShFQQV80Lcn2YR0YAlvEm/7+8NueysOlMCyAV0fI7LYs2ekJ5Lc
         bcjacdK6C8CJ56RYZdcPdVdIq7TpHwjfkQ4qCrYVKoIJUJeG/dyqb1+ZYfs7B+d6TM7l
         QjRhLUSKmJAFcR1Z5Hu7H4nhSNkFxFo7NcROjCQiTZsG/J73wCRdcflAJpDocff/h4Wg
         4yS30cI4ht5PO+Ppmq1/70/yd6fznQfWTcmlbvahvjlAvEkaDs2eM8NXxKK85gxJ+RDs
         OM7Q==
X-Gm-Message-State: AFqh2kpXtYECuH6CIZX2g+X9Pj2nUJxj6QiQrhk757v0Vs2EWKKb82Zu
        3Mm2zXvBViz5zeYVqNJ8yXA=
X-Google-Smtp-Source: AMrXdXuu3AuRqbI27zvZiO3TfgE0OkoOmHsdQdNCMrvelUlojg5xWWoYaut9gvDgcWdwPiOtcx5jpA==
X-Received: by 2002:adf:f285:0:b0:270:57d:d1c9 with SMTP id k5-20020adff285000000b00270057dd1c9mr24749786wro.39.1672697905676;
        Mon, 02 Jan 2023 14:18:25 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:8a7:e535:b020:566a])
        by smtp.gmail.com with ESMTPSA id n14-20020adfe34e000000b002366dd0e030sm29872463wrj.68.2023.01.02.14.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 14:18:24 -0800 (PST)
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
Subject: [PATCH v3 0/6] Add IRQC support to RZ/G2UL SoC
Date:   Mon,  2 Jan 2023 22:18:09 +0000
Message-Id: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

v2->v3
* Dropped skipping of NMI interrupt, as it can be used as an external
  interrupt.
* Dropped parsing interrupts based on names
* Dropped "renesas,rzg2ul-irqc" compatible string

v1->v2
* Updated binding doc
* Dropped mapping NMI interrupt as part of IRQ domain
* Fixed review comments pointed by Geert
* Added support to parse interrupts by name
* Added compile time checks for gpio config arrays

RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (6):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
    RZ/G2UL SoC
  pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
  pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
  arm64: dts: renesas: r9a07g043u: Add IRQC node
  arm64: dts: renesas: r9a07g043[u]: Update pinctrl node to handle GPIO
    interrupts
  arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for
    ETH{0/1}

 .../renesas,rzg2l-irqc.yaml                   | 225 +++++++++++++-----
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   2 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  72 ++++++
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    |  11 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  25 +-
 5 files changed, 270 insertions(+), 65 deletions(-)

-- 
2.25.1

