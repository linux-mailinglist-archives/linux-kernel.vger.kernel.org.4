Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009B76A911C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCCGhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCCGhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:37:05 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A639155049;
        Thu,  2 Mar 2023 22:37:01 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 130so890689pgg.3;
        Thu, 02 Mar 2023 22:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677825421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwKQWiJXolgzL1MeiJl+AGrVhqp1zaGutWHj6thTrA0=;
        b=B198lDGitf009QIb9uXueNODLc03HLIak8EtHmF9jj3Np5WRntWEA8PuLhQZOK/zGP
         NZ+vn+0aZwvmCGiVcShKPvP8ch6lvHIqTaj6YVlqVyNXnOaWDHo+851LJaZie9TOokdl
         Cvnp9VNwYYhUUChaZ5h8QCVuaUq2brD7JPDUzcKGoyUjA9pIob8oYQTGiVoslmjuYSdt
         24qkAEuzM+8WYuiUnMGstAT1eV2X+CUVgLXG4qhM7qcfGFNobUJ8kCHu9nmMsIQK4J/q
         Ivs2Ec6nJjjRGNJLC6ZvfvgYtzFY/haUdzrIz/oSfNdmUMMrnR8b2TChDTcasy/Z6UYI
         itig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677825421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwKQWiJXolgzL1MeiJl+AGrVhqp1zaGutWHj6thTrA0=;
        b=X0EcJchBuGL6TkUauAtkOF9N3CccwZLH7YIIChYj6C/KsvxcqILGE3m/Po8VT7rqt4
         nfYs6SLeu2laECZE7PV/I5fTR+BB5woshKeeppXpPNU+BYx51v6vEZrhdL2vjuN1e8Yn
         c1qYdICvFYE3XRIrJcJyv/F2VzEcqT7GZo1qdLcJlJwOFHuGnP5jZssXnJRDt297H/WM
         ZCulzRALRauiqmadUTVFpMnj97b2vcfB8iZrd4aEwwhSDs/AnLTnM8lbGpJ5tvqbrSli
         56v7o6qOQn7S0h9cSONgKMlvpONjp3zydd0slgBpe4hEP6X3XyYGmZUgaQqrYPLf+AjR
         EqMQ==
X-Gm-Message-State: AO0yUKUgzEk1qGT46dT761jPv+OUG8tQ+l80XqWhC1pfOBMtcCXMCrmC
        CQVvFWt6GKrrpcOxqzv16b5Sr5hay2BMWw==
X-Google-Smtp-Source: AK7set/mi2fukCSpA4ET7YXAhcZoWqchQvjCCfDcfym+FcBe1AfZMJ3f5FJytQnHgfVRYLiITx70Eg==
X-Received: by 2002:a62:1c91:0:b0:5e6:14a9:b0c8 with SMTP id c139-20020a621c91000000b005e614a9b0c8mr1000851pfc.32.1677825421100;
        Thu, 02 Mar 2023 22:37:01 -0800 (PST)
Received: from davidwang.dhcpserver.bu9bmc.local (1-34-79-176.hinet-ip.hinet.net. [1.34.79.176])
        by smtp.gmail.com with ESMTPSA id l30-20020a635b5e000000b004ff6b744248sm736348pgm.48.2023.03.02.22.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 22:37:00 -0800 (PST)
From:   David Wang <tomato1220@gmail.com>
X-Google-Original-From: David Wang <davidwang@quantatw.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        fran.hsu@quantatw.com, David Wang <davidwang@quantatw.com>
Subject: [PATCH 5/7] ARM: dts: nuvoton: gsj: Correct gpio-pins
Date:   Fri,  3 Mar 2023 14:34:33 +0800
Message-Id: <20230303063435.803097-5-davidwang@quantatw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303063435.803097-1-davidwang@quantatw.com>
References: <20230303063435.803097-1-davidwang@quantatw.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct gpio-pins accoring to the nuvoton pinctrl driver.

Signed-off-by: David Wang <davidwang@quantatw.com>
---
 arch/arm/boot/dts/nuvoton-npcm730-gsj-gpio.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gsj-gpio.dtsi b/arch/arm/boot/dts/nuvoton-npcm730-gsj-gpio.dtsi
index 53cfd15fa03f..527755dfd4e1 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-gsj-gpio.dtsi
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gsj-gpio.dtsi
@@ -99,12 +99,12 @@ gpio19pp_pins: gpio19pp-pins {
 			drive-push-pull;
 		};
 		gpio24pp_pins: gpio24pp-pins {
-			pins = "GPIO24/IOXHDO";
+			pins = "GPIO24/HGPIO4/IOXHDO";
 			bias-disable;
 			drive-push-pull;
 		};
 		gpio25pp_pins: gpio25pp-pins {
-			pins = "GPIO25/IOXHDI";
+			pins = "GPIO25/HGPIO5/IOXHDI";
 			bias-disable;
 			drive-push-pull;
 		};
@@ -114,12 +114,12 @@ gpio37od_pins: gpio37od-pins {
 			drive-open-drain;
 		};
 		gpio59pp_pins: gpio59pp-pins {
-			pins = "GPIO59/SMB3DSDA";
+			pins = "GPIO59/HGPIO6/SMB3DSDA";
 			bias-disable;
 			drive-push-pull;
 		};
 		gpio60_pins: gpio60-pins {
-			pins = "GPIO60/SMB3DSCL";
+			pins = "GPIO60/HGPIO7/SMB3DSCL";
 			bias-disable;
 			input-enable;
 		};
-- 
2.25.1

