Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF462F677
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiKRNlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbiKRNlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:41:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2B1C3D;
        Fri, 18 Nov 2022 05:41:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w14so9311359wru.8;
        Fri, 18 Nov 2022 05:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdLS+asfEoSvipkYLNNhcL5qp6R+rlOz+8ktYa9WENs=;
        b=N+pZ+IvkTjyayqCEzGcFSxvi2J3GiWXiEAxO4CgJw5mldoXyA6fyZvQvaKCIiqAAtk
         xYcHNqBuAmywb85rF4Q//hD752UHwXaYm/b8esSIDEWMK6+v6g5eoUmFH79aZ79Loyv+
         hThyVMei5G84VN7Ek8izxHjTclWCMCQpJFRoeh8woM0Dv55lShnyyzjHHRcnoz3f/sai
         dvnpXgdIRPeVZvTWSyj+3uDgHEf+lpGpS/cKul7d6WxAxTIT8YbQTSM0wvd1j8MpjwoE
         SLA6kQnez4WZ5cKsKaiupHvo5qJWrEHFgWdSES1hllm7we3bD0HAot3KF1r+EtlHuYDw
         FmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdLS+asfEoSvipkYLNNhcL5qp6R+rlOz+8ktYa9WENs=;
        b=oeNUSi2cLvGLSUs5NV0FXGQO9dYIh39pWi+noBRCxNiV2T8d4nQgtOpgRAbNNTT1yX
         UzPqWJ3csjOlsmr2RNc4gWjzjbVPxYhOG6c8YPw/MQmsiNjwKhta9CfprHmXlEF+fNX3
         Nm3A6y4u1IfAWaTwpec4eSRYmJ/tuUVl+DSxYVd8MqJ2Fq56bpYw3KuqBAJOPpbT4wmS
         GyuCQ5nXFglDU3Gb0P6j2nFXpaKgewr6c6cnKeylGpJmyF6bqW13wikZaI2wjvkQfrmJ
         ILtjGaczsbX05mDRumBCdg8Z2O0mr8Om2ZiYE0TEQ+EEa9rdpJLVc9HHpCwetqUv3lDT
         BI/A==
X-Gm-Message-State: ANoB5pmbdO1r2Qx5p4u6lsVQ4n1/E/ZH4lNuUm5I9vNtZB8Wk+5IFaEG
        qncXVictXvwwkCyAnFEiBbY=
X-Google-Smtp-Source: AA0mqf4nHDAuiyx+n3E39N7LD5MIjpFi4kW9nKbyHoi5Zgoi7z371ZYJ18sTItNGjWEiIIpvwoJ0gQ==
X-Received: by 2002:a05:6000:12cb:b0:236:62e3:6202 with SMTP id l11-20020a05600012cb00b0023662e36202mr4395284wrx.47.1668778902081;
        Fri, 18 Nov 2022 05:41:42 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:29e1:fee9:75e6:d6ea])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b003b476cabf1csm4531598wml.26.2022.11.18.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 05:41:40 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: watchdog: renesas,wdt: Document RZ/Five SoC
Date:   Fri, 18 Nov 2022 13:38:29 +0000
Message-Id: <20221118133829.12855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The WDT block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,r9a07g043-wdt" compatible string will be used on the
RZ/Five SoC so to make this clear, update the comment to include RZ/Five
SoC.

No driver changes are required as generic compatible string
"renesas,rzg2l-wdt" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 26b1815a6753..e2c9bf1aec38 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -26,7 +26,7 @@ properties:
 
       - items:
           - enum:
-              - renesas,r9a07g043-wdt    # RZ/G2UL
+              - renesas,r9a07g043-wdt    # RZ/G2UL and RZ/Five
               - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
               - renesas,r9a07g054-wdt    # RZ/V2L
           - const: renesas,rzg2l-wdt
-- 
2.25.1

