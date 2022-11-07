Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5461FC33
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiKGRzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiKGRyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:54:12 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D09625C5A;
        Mon,  7 Nov 2022 09:53:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w14so17380009wru.8;
        Mon, 07 Nov 2022 09:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewkdkX3Q84Mhn4kLhU3/9cKwQhB4ZBILHwBNdxQhLqM=;
        b=T6qdWNc1QAmND0ahZNUdtHC/Pjualisr7bdQyT7ltEGvxxuN4wgxOorvCmKar+iMwo
         5Ov0WxSrzXpDzDH86yf72hFk4vHl468PCD5hupLjcpN+nlD55A4w+1QyuCwJDtI1O5tg
         KNCP3k0NWvC3XKZWSYnmbkjuHAM3WDmoWWZSk9Q8KQssyy3n1jZnYLwngCkYOF+7HlTN
         sl0oXcKsoZyuhXEg/rwe/DZsK6TENoNvIOsuQtCnZ+XlkXjYZFMM6LpRT72xX6L0Bg6v
         sQwQskXiGXJzD/k7V/dskTVRhOxmivT9db85KqBrIYLk9Tq+/Lt+qRPgrx42hc7CHKjN
         C/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewkdkX3Q84Mhn4kLhU3/9cKwQhB4ZBILHwBNdxQhLqM=;
        b=2nrhqMqOrOiLUb2SWqnI2XLmImbRADNktvC2V1wbWWT2kwIXKgUTPskncXUP6YA74Y
         QOC10EwiTFq7X6p82IaVDiNRZSOXJbSQ3SipZzrj6DxUO4mPH/V5/qbbcqWKV/rGqN/q
         VFmwNp6s9zid/Bvt3MD0Dx/B/nJqKBoORgniFZw2ZE6MlTwL8bzJaKuDACO2lOvYdcDh
         CGS9XCgkXsjG7hC5MqZ6sGVoU+vkROVh7K2q+BPS4ulKWAdp1diVJY7qoeENnjxLV9pi
         9pQA5hpeSDSnNhT++xnN6p3Pi4C1ePp3Pghv6WOobNlZXRXEsA3y36zHx+hhcF738QlZ
         kGxw==
X-Gm-Message-State: ACrzQf2e/YObNNFz3UJaAMDG42wYdwA3wUbo/XK4LywbGeoyP3zuNezE
        znRN0PvU4sSjEjctpOH0twSMk4E8LMKakQ==
X-Google-Smtp-Source: AMsMyM5Dj/b4bM++yul5GsWhItJ90z9PxDTvAmcwwXIxUkMakGuvaT+dcz8zPr+dF+WTLgKuPuBSBQ==
X-Received: by 2002:adf:ed4a:0:b0:236:aef1:9c75 with SMTP id u10-20020adfed4a000000b00236aef19c75mr32254562wro.258.1667843596487;
        Mon, 07 Nov 2022 09:53:16 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c45:7ed3:c12e:e25b])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4a44000000b002365254ea42sm8072454wrs.1.2022.11.07.09.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:53:15 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 0/5] Add IRQC support to RZ/G2UL SoC
Date:   Mon,  7 Nov 2022 17:53:00 +0000
Message-Id: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
* Includes a fix for pinctrl driver when using GPIO pins as interrupts
* Adds PHY interrupt support for ETH{0/1}

Reason for sending it as RFC, as I am introducing new compatible string for
RZ/G2UL SoC as there are some differences when compared to RZ/Five:
- G2UL IRQCHIP (hierarchical IRQ domain) -> GIC where as on RZ/Five we have
  PLIC (chained interrupt domain) -> RISCV INTC
- On the RZ/Five we have additional registers for IRQC block
- On the RZ/Five we have BUS_ERR_INT which needs to be handled by IRQC

Cheers,
Prabhakar

Lad Prabhakar (5):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
    RZ/G2UL SoC
  pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
  arm64: dts: renesas: r9a07g043[u]: Add IRQC node
  arm64: dts: renesas: r9a07g043[u]: Update pinctrl node to handle GPIO
    interrupts
  arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for
    ETH{0/1}

 .../renesas,rzg2l-irqc.yaml                   |  1 +
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 10 ++++
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   | 54 +++++++++++++++++++
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    | 11 +++-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 17 +++---
 5 files changed, 84 insertions(+), 9 deletions(-)

-- 
2.25.1

