Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD98E5F52F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJEKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJEKz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:55:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C614A66A51
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:55:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u10so25258858wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Hx3lo8iVf7+CPJL6lCE6hKeJnw4lGzp6yArcYS4WFY0=;
        b=CAI2yMPZ0AfpixNqwNV8uaM/lVcWdjhCRGO9KsXgIce3L11kurZia/mIYNw1k0O52Z
         7bhRs46EPQBa3oST9u/qbugdq7llfpVJOT09Nh2qwQiYFIm7L6GAk2F5X89w1onZ3SSG
         TfffOft5OxE0WX35YAKaKukWlHe++Fx+DDKyUAqtW0cNmRLklLhpa2UvT4sd4UXRsbxc
         hP2kFdr70J0BvjOZAofBmef+j7ZFtTgLJwmXRYGivnbRzj17BVHu+3fyZ/gWZeJq7qti
         H8aBcAGQ5luLQjMEk/HFdP3pIW4NAH/IbrQPimJY+4GUXMsyxEvuFM/cT0Xou4qxMMsX
         Q2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Hx3lo8iVf7+CPJL6lCE6hKeJnw4lGzp6yArcYS4WFY0=;
        b=rA8LcYEjn9gadAr/iX6+p3jRG6qVm8/HCsjxWLxMqJgYqx86ZUoB0gtMQuBPV7E1Hv
         KOKUkLrfvx7gxwlH4B+HBr4/plYpbFackjHQvjmRjrlkhUqUNE2scC9llcxCeA/5k4mH
         L1Cw2b31aE+Qafv5W1M9tUTec1WaUM5P7gBMk6wTtIQOlrE9pAfy+sDnxzBwONI1+hsj
         zSpIM7A2XiQtf59rOqvTCF+sMn3/SlKATI7TVtdQSx1D5S6bdP6Ih43YNOrWJX8oc2va
         E6duPp44svZZrS4H+/Xz6BmXQ8r0CPN5Cmgym06sdmCRX0TG/SHv5T/Hxf2qdW9RnJhD
         bHEg==
X-Gm-Message-State: ACrzQf34YKsBrc98XZvOk+LPnjHTtu8eFkgtNayYjx0YwcRBxWpzC+uJ
        CBxZnx84CWKECeI5W/zXDUUTBQ==
X-Google-Smtp-Source: AMsMyM7xVM01Ds+CYcPqh+zpNO5vwN33VsP1sxzIfyPWRVel8KOKAuV5qGXFb5XzF2ljAqzuV4oJ9A==
X-Received: by 2002:a5d:4bcd:0:b0:22c:dfba:6b61 with SMTP id l13-20020a5d4bcd000000b0022cdfba6b61mr15668457wrt.424.1664967324393;
        Wed, 05 Oct 2022 03:55:24 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i30-20020a1c541e000000b003b486027c8asm1604133wmb.20.2022.10.05.03.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 03:55:24 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     kaloz@openwrt.org, khalasa@piap.pl,
        krzysztof.kozlowski+dt@linaro.org, linusw@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: dts: intel-ixp42x-welltech-epbx100: add ethernet node
Date:   Wed,  5 Oct 2022 10:55:10 +0000
Message-Id: <20221005105510.3512132-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ethernet node for the first port of intel-ixp42x-welltech-epbx100.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../boot/dts/intel-ixp42x-welltech-epbx100.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts b/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts
index f5846a50e4d4..b444003c10e1 100644
--- a/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts
@@ -76,5 +76,23 @@ partition@fff000 {
 				};
 			};
 		};
+
+		/* LAN port */
+		ethernet@c8009000 {
+			status = "ok";
+			queue-rx = <&qmgr 3>;
+			queue-txready = <&qmgr 20>;
+			phy-mode = "rgmii";
+			phy-handle = <&phy5>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				phy5: ethernet-phy@5 {
+					reg = <5>;
+				};
+			};
+		};
 	};
 };
-- 
2.35.1

