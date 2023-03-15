Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B41B6BB228
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjCOMdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjCOMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:33:23 -0400
X-Greylist: delayed 1351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 05:32:21 PDT
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04A012F3E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:32:21 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197]) by mx-outbound46-204.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 15 Mar 2023 12:32:18 +0000
Received: by mail-pf1-f197.google.com with SMTP id q15-20020a62e10f000000b00622aa7007f0so6149652pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1678883537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gq45/aTsPc3VfJfslzwPgA8R01rxpja2ayPseefo/Ts=;
        b=FHjzsb+vohmjsAnvNy9sLyMJ14xZE3jQXR09X/cT7RZEwWgKCKUmf8jjTWii5uqDkN
         5q9ajkhQ/esZLMRr/YhLQsf3+4JFnrg2PN8eId1sKQkRWKigREQN/cDSrgqpvrj+imru
         y3VVtFbD34j9mzvsehRhEUYJUjVYjOcQOO54s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gq45/aTsPc3VfJfslzwPgA8R01rxpja2ayPseefo/Ts=;
        b=QJGm2CblsYKyFxc9ijV1WY3NMswK3oXH+mVPUFQFlVY/Reqo66JjW7UXDMy5HjbZuO
         51zUEsJ3/ErHzt9KktWs9Le2BGrxMTDHYHIetdttHFdEccPKk7R5VWInMJG8Tn2lHkMQ
         r9fKXr7Y6Vub2s4xdmN+s8S/s1M5SmC4mjaJ1h2XcYyiaybVxalJf0Tcazs1fOLIAVlJ
         kIvX/UlM25TrQ+CZHbBRk3yNMuCX5peTrIWa9YoR1z91FF9NWPfbsGSrAhgLToTypJR0
         D7hf1TEjuiMo2Q/tHypJ82fLvgdXCCtosFDOaUKKlzgiZ9WsSvK2VBb647YMyIcszRvv
         oUFw==
X-Gm-Message-State: AO0yUKX0RKkdQTIjTo7X8xPLVJVgxd0V4zIHN/UDF9QU2Qr3xrHALWfy
        SFzsx30WbjMdKfY9CZWgXQjgtjWf9+/evA+YKeWNezmBG2dtTiYgRlUjfyuNGmYk1IJLY6ic1vR
        jcoa7E+7zPKXkQ6F7Lh1/U58/un+veYAshlutE5eD1ZowiBDdND+KY387eY8J
X-Received: by 2002:a05:6a20:8e0a:b0:c7:6a98:5bd8 with SMTP id y10-20020a056a208e0a00b000c76a985bd8mr27588953pzj.0.1678882184287;
        Wed, 15 Mar 2023 05:09:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set8ErCxPeOlq5ZfGnI2EzU8xgcCdovh/xZZ01dLY1MDuWVd0WzbziSF7awS6m5xwBp8qWj0feA==
X-Received: by 2002:a05:6a20:8e0a:b0:c7:6a98:5bd8 with SMTP id y10-20020a056a208e0a00b000c76a985bd8mr27588926pzj.0.1678882183835;
        Wed, 15 Mar 2023 05:09:43 -0700 (PDT)
Received: from localhost.localdomain ([49.207.203.68])
        by smtp.gmail.com with ESMTPSA id m7-20020a655307000000b004fb8732a2f9sm3251343pgq.88.2023.03.15.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:09:43 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Update IO EXP GPIO lines for Rev E2
Date:   Wed, 15 Mar 2023 17:39:34 +0530
Message-Id: <20230315120934.16954-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1678883537-311980-5508-15758-1
X-BESS-VER: 2019.1_20230310.1716
X-BESS-Apparent-Source-IP: 209.85.210.197
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNDM0BrIygIJpSRbmhkZJZu
        aJBpYGlqnGhikmlilJKQbG5skpKYYWBkq1sQCuCMYbQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.246812 [from 
        cloudscan18-153.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Rev E2 of the AM68 SK baseboard has updated the GPIO IO expander pins
functionality. To match the Rev E2 schematics, update existing IO expander
GPIO line names and the corresponding node which uses the expansion(exp1)
node.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

Schematics Ref: https://www.ti.com/lit/zip/sprr463

 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 2091cd2431fb..27a43a8ecffd 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -60,7 +60,7 @@ vdd_mmc1: regulator-sd {
 		regulator-boot-on;
 		enable-active-high;
 		vin-supply = <&vsys_3v3>;
-		gpio = <&exp1 10 GPIO_ACTIVE_HIGH>;
+		gpio = <&exp1 8 GPIO_ACTIVE_HIGH>;
 	};
 
 	vdd_sd_dv: regulator-tlv71033 {
@@ -264,12 +264,10 @@ exp1: gpio@21 {
 		reg = <0x21>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		gpio-line-names = "CSI_VIO_SEL", "CSI_SEL_FPC_EXPn", "HDMI_PDn",
-					"HDMI_LS_OE", "DP0_3V3 _EN", "BOARDID_EEPROM_WP",
-					"CAN_STB", " ", "GPIO_uSD_PWR_EN", "eDP_ENABLE",
-					"IO_EXP_PCIe1_M.2_RTSz", "IO_EXP_MCU_RGMII_RSTz",
-					"IO_EXP_CSI2_EXP_RSTz", " ", "CSI0_B_GPIO1",
-					"CSI1_B_GPIO1";
+		gpio-line-names = " ", " ", " ", " ", " ",
+				  "BOARDID_EEPROM_WP", "CAN_STB", " ",
+				  "GPIO_uSD_PWR_EN", " ", "IO_EXP_PCIe1_M.2_RTSz",
+				  "IO_EXP_MCU_RGMII_RST#", " ", " ", " ", " ";
 	};
 };
 
-- 
2.36.1

