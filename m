Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9314461FC26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiKGRzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiKGRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:54:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D78A2496D;
        Mon,  7 Nov 2022 09:53:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a14so17403962wru.5;
        Mon, 07 Nov 2022 09:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ1erY58kBlhlkmhk9QjyKuuzmHiyGJEgyZd797XqYk=;
        b=eyrR2GZIXjzm6iz1blmbSY//jE433W7wwwq2lG3UhlpeoKyc4FvX4tFcR1kQbKyZcA
         u+Ihdrjp6a2igl3uDxUCDm9QDuGFYXrlf47mAJf2xNSdHQbV3pXOUQKALB0kJEUCSpPz
         RoHjJR98iRDJE5RDMJCr4zeXP6pQ/EHDhlG7DXz6NS8RRIx9kHz6lVDSEUVWI5qidF9V
         D2JJaazfYsnjnig902R8l6htT3UgRON2KyxicuqtcN/aK9i3Ri5qfMFgSHARLCl8AfT2
         KD45M1FgwaMqfgmfm7wHBhI8EQdxkxiT+jS5zxa5bMO3GcRJoBXdjTYBQtoeed3IXsXb
         zToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ1erY58kBlhlkmhk9QjyKuuzmHiyGJEgyZd797XqYk=;
        b=2fh9QUtC40hUETPDLpz9e9G+aStpzTwyOq9JoBvBs5Jzx9a+IWSmUuX71qFicccZTF
         GpAFk0h/MzM8Qtg11Or0QJXrTCTXhgYQvo+4Lq5KwN6iWM9VO94/0p6I4eGGc1tYvNgK
         RIDTPW86oFV4BHr3DXzaITxSUO/4El+An5mvuASqE+tHHxu8UmLrmabuHyquWrwCRotF
         x97IECGfPtmoZ8i9VPsr15m88oKOj8cAaPw6kedaDqBqzsTP42m9tAIU8c0LBCZzOqNN
         pLDbqrTdDI84ZEEmy6BoZvs7vHt+OgeQi63yg8A4ujmD2CCvGhP1ldyGDZYCq56LvOdF
         KCHA==
X-Gm-Message-State: ACrzQf0acmkjXoIg2rexpyENOOb3d1PyHESeyi/jmgI+NFxvwnNcSOYI
        PLed348cs2mNTWaIShN15b0=
X-Google-Smtp-Source: AMsMyM5XNrG/+i6JNNIrr+JBnFnqI3iNiQ8pnIbp/mspxwOO/BeOD8TV8BCAmJo/Zki07Rp7tK2OlQ==
X-Received: by 2002:a05:6000:10c6:b0:236:6613:a7bd with SMTP id b6-20020a05600010c600b002366613a7bdmr33617622wrx.570.1667843597649;
        Mon, 07 Nov 2022 09:53:17 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c45:7ed3:c12e:e25b])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4a44000000b002365254ea42sm8072454wrs.1.2022.11.07.09.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:53:17 -0800 (PST)
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
Subject: [PATCH RFC 1/5] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G2UL SoC
Date:   Mon,  7 Nov 2022 17:53:01 +0000
Message-Id: <20221107175305.63975-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Document RZ/G2UL (R9A07G043) IRQC bindings. The RZ/G2UL IRQC block is
identical to one found on the RZ/G2L SoC. No driver changes are
required as generic compatible string "renesas,rzg2l-irqc" will be
used as a fallback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, renesas,r9a07g043u-irqc is added we have slight difference's compared to RZ/Five
- G2UL IRQCHIP (hierarchical IRQ domain) -> GIC where as on RZ/Five we have PLIC (chained interrupt
domain) -> RISCV INTC
- On the RZ/Five we have additional registers for IRQC block
- On the RZ/Five we have BUS_ERR_INT which needs to be handled by IRQC
---
 .../bindings/interrupt-controller/renesas,rzg2l-irqc.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index 33b90e975e33..8f3678a82ba4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043u-irqc   # RZ/G2UL
           - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
           - renesas,r9a07g054-irqc    # RZ/V2L
       - const: renesas,rzg2l-irqc
-- 
2.25.1

