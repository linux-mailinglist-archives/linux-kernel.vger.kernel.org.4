Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C517502B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGLJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGLJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:17:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AF7FB;
        Wed, 12 Jul 2023 02:17:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso68656025e9.3;
        Wed, 12 Jul 2023 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689153469; x=1691745469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6FPPQORg8BA8HmUzK+CsSAH2CNPePIaX8RbDd2wjhw=;
        b=CNn/x19mtxoqsmq4vc3WT3RNTrksvWMrfhJP/LHgEKIs9QJYpM/la9d8iYzmoOschq
         k4UF8syzFoiaxdSA5N3Gj4PaIvB19d9OxYkKDmQ5WOunXNwdCONw136XUTl2zg0gbo4K
         u22X10rENvm0zBDnpfYpWJn8ii1zKmAx7OGhiMyCTyPL18YHA0f3M2Q7AuX13mpqEe4p
         /9K8RHXGP6kkAcbny6QVf8I4/8U80SWafScEOMclTEKWmRxhaXfVRAvpFMVHME4FKmqV
         Ef2OfwTgbPPZ10y9K0oJZT86bCEso2seWtjm/VmAhA+tOh8tJ2eE9ctfMQ1q/JAIFuF+
         0Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689153469; x=1691745469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6FPPQORg8BA8HmUzK+CsSAH2CNPePIaX8RbDd2wjhw=;
        b=LB36IiVn0jHvA6UDx31Nu3VmOPrM12SmPbGfgvmI32DCU2aHoVlNKd0Vtuo8dFpqOW
         6eAsTe0vvOEgHR1NcIm9zgiIRG9iZtpxocqVI4FJ2hJWb9EINpyCxmq8Sb2jQxhfVnBI
         jlT1PXMthdy4L3xy/DwfJpoboMTiKL47rETFYZv13SU2U3Wc974uWLTPdDI77gL2ZV+1
         1UGERxxuphwWVhw4b++cJ7HbOzbOynicyMb5Z8x5IMIBe14dQXWZFa6BuEL5VRQ8Sx0r
         WrZP+oaokCQzZbq9gVnK/mXpoFsJSW1CgiWtVC+crJQpCHAWS8HxFtAaO0X7KN3ovSMr
         Gplg==
X-Gm-Message-State: ABy/qLZTieBt83j6cn5rfrfgYZPG8DbIXgzIS0GShmKiz2leVuvzcDs2
        A26QBstTfNWmfgNPA3jCHlA=
X-Google-Smtp-Source: APBJJlHZ1eN2ZaZnb+H58NL4fR23HmWYBW/tI+5EtbLZEgpGw6wydopI9h5/MfvsxwURhee45OjjOw==
X-Received: by 2002:a05:600c:2153:b0:3fb:dbd0:a7ea with SMTP id v19-20020a05600c215300b003fbdbd0a7eamr16822816wml.37.1689153468295;
        Wed, 12 Jul 2023 02:17:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id s6-20020a05600c044600b003fbdf8292a7sm4467099wmb.46.2023.07.12.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:17:47 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ren=C3=A9=20Kjellerup?= <rk.katana.steel@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Aleksey Nasibulin <alealexpro100@ya.ru>,
        Christian Marangi <ansuelsmth@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2
Date:   Wed, 12 Jul 2023 03:40:17 +0200
Message-Id: <20230712014017.28123-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksey Nasibulin <alealexpro100@ya.ru>

Linksys ea6500-v2 have 256MB of ram. Currently we only use 128MB.
Expand the definition to use all the available RAM.

Fixes: 03e96644d7a8 ("ARM: dts: BCM5301X: Add basic DT for Linksys EA6500 V2")
Signed-off-by: Aleksey Nasibulin <alealexpro100@ya.ru>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts b/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
index f1412ba83def..0454423fe166 100644
--- a/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
@@ -19,7 +19,8 @@ chosen {
 
 	memory@0 {
 		device_type = "memory";
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000>,
+		      <0x88000000 0x08000000>;
 	};
 
 	gpio-keys {
-- 
2.40.1

