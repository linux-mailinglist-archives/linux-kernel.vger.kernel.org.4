Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D705652A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiLUADF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiLUADB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:03:01 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439A31C900;
        Tue, 20 Dec 2022 16:03:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y16so13456597wrm.2;
        Tue, 20 Dec 2022 16:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1g/qK+wITcmMNBzaKxGBCpgwiK6fj9WTq342zlrl9U=;
        b=Ua0sxbOPrzWv+NNn2uxUgOEQEzqxLhlVwhO637MFvOZWWBlgRQH/rREgDkhXAl9y9b
         mIcOn1TuRwM4UwuxFF6hyc2pBvlrEsdsTSeEz7WFUgWRBaDZRP7f9NBE0UBXe7u/xpOg
         3yiL3Cixg8QeJJgPEEMoaB0waB8s2MkBHW/aXXQH74ETLk31uLHJdskA91I3MnD7gZxQ
         zQqK5n7r+OYz06PbohEtHTNIIrzEjLXiwclY6QMGB1yut1YxmI8YNwh2L/SRWc37dMIN
         IAoOYRG71JYE/FuPib/NijuoDl1M6s0oxEVq8exQBmXAyQZJrmkvvJ4LvUj1KkllsT21
         1+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1g/qK+wITcmMNBzaKxGBCpgwiK6fj9WTq342zlrl9U=;
        b=KH2jO9IGmflZOWMn7UXigkX73vkTVRP2QJqzx1y4wSWBrm/B7NXRkldmYRG9yin9v3
         FuxJxgdAS80ym3AtsagFz97hQFw6oapINr4MIcoixDPM42Plk4JunvQsgsTp1ri0woYL
         EuPTYkS8Ru0WXyauurjddQS8D7663wpXm4g8PqtxHcpc/o0/rctXt0URP+UacjHWvCYN
         nieiTFbxMphwVAbSdcso/i5/eS4vagVpx0qii0g44cOgf8fEldqkMU2Oh+XqVs/qFSW1
         RftlgQ0hXfnEbtw4nHrqjOJUh1yPYBmmuSWei9/uZFDFjbPZhO2qe7bh8LtzUp8XGGts
         T/tA==
X-Gm-Message-State: ANoB5pmBfDsSJEnjnC/F9c1y1CsZAzOgtA1IDoImR7pws+GC5WteTYr7
        CCufYbVpkZwfFfA5X5VvZKc=
X-Google-Smtp-Source: AA0mqf49swmiA1NfsE48IIYpD/gm+EK08KkuDqNydVay+PXkoEPAOluFubQk/lNISxWQzkd4bPiYsw==
X-Received: by 2002:adf:f3cd:0:b0:241:f95f:eef8 with SMTP id g13-20020adff3cd000000b00241f95feef8mr27395099wrp.11.1671580978710;
        Tue, 20 Dec 2022 16:02:58 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1595:a48c:95a8:15e0])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002362f6fcaf5sm13740150wrt.48.2022.12.20.16.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 16:02:58 -0800 (PST)
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
Subject: [PATCH v2 2/9] dt-bindings: interrupt-controller: irqc-rzg2l: Drop RZG2L_NMI macro
Date:   Wed, 21 Dec 2022 00:02:35 +0000
Message-Id: <20221221000242.340202-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

NMI interrupt is not an external interrupt as compared to IRQ0-7 and
TINT0-31 on RZ/G2L SoC, so there is no need for RZG2L_NMI macro.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1 -> v2
* New patch
---
 include/dt-bindings/interrupt-controller/irqc-rzg2l.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/dt-bindings/interrupt-controller/irqc-rzg2l.h b/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
index 34ce778885a1..dd2da795208d 100644
--- a/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
+++ b/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
@@ -9,9 +9,6 @@
 #ifndef __DT_BINDINGS_IRQC_RZG2L_H
 #define __DT_BINDINGS_IRQC_RZG2L_H
 
-/* NMI maps to SPI0 */
-#define RZG2L_NMI	0
-
 /* IRQ0-7 map to SPI1-8 */
 #define RZG2L_IRQ0	1
 #define RZG2L_IRQ1	2
-- 
2.25.1

