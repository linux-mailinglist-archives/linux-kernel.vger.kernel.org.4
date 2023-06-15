Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2667E7321F0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjFOVxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjFOVx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:53:27 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5742962;
        Thu, 15 Jun 2023 14:53:26 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-77b6e428f84so856439f.1;
        Thu, 15 Jun 2023 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686866005; x=1689458005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uulmumzfWaS24fz5Ie5uKr4WLizl9rXMt6vNsDfz7EE=;
        b=lYLQZlxD0L4+JpK0z9ab/NrFVC5A8Z8TVfzWOfzd7K2Cx9eJF3BI2UO4Ap2GFaJdtx
         gzEkNtZ/o0CWLS5jdauGbe0BPwE9sH2UNVA/pQDChmfBPkoUe8l3mykW3JOjCbYvkn3w
         29+wY1wB20hLy3gGSoOMOoX1nbh36kAnxg+aJGaXLnP6o76HP0lHzQrBaZBjbbkkAOcL
         scA/NiIY7U0xFcNw5gtN4fKXK8I+JnJxuh+GNzWyPuuRzP45ZWXW3AR90v0yujv/2OC7
         8JjnaWel8vl/x6HatnX6zdMPIPYao5+bk7RKOu30T9uGmMAzLN/SD/F+VHyQDelCSTst
         U1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686866005; x=1689458005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uulmumzfWaS24fz5Ie5uKr4WLizl9rXMt6vNsDfz7EE=;
        b=ADm6maG3nq7PWWJR/s6SXfTBa3bTmUPM3vf18L/7wce/NRFEHBaRsO2aKDcyEIBxtd
         9FmWHoUCk6y4MLx1KTVO+FSDmI1xfsnLuX+/xcoKDkUSvl9t6YynK48jWFZzEofrrs5b
         SFM7DusMuBNYdcuMia4pcV0Kz9Xrl/wJnnX7UIhA50/zXj/KGQiYWuDI8tj2gdvAFuEW
         Rc8EECLn/9lrjqFjuXs7+aV43sieQUmxyXbeM4cKQgyjAv9ykIkXPxCJSIMtRogPKO01
         aAqxtifOJaowWt9Hlr5+r9HSJ+gbFNwYFDzwyzBB37HA/120dGmRltnh1z+8wD5dlL/w
         MnHg==
X-Gm-Message-State: AC+VfDwUFFKrexw3yzQnLX9kF6eaUwANvuAwKyJ+P42xeTBtMf9qQakZ
        YkhlJUiVz8UBPEiAmHTkm8c=
X-Google-Smtp-Source: ACHHUZ6lJOSY4YyGHdb0mNOlMsRF07ZZC3icGDJnoYpOswTVJkbwj3DNQM2bLa9YashmB3md0guUAQ==
X-Received: by 2002:a6b:e70d:0:b0:774:84f4:6ea with SMTP id b13-20020a6be70d000000b0077484f406eamr644195ioh.11.1686866005550;
        Thu, 15 Jun 2023 14:53:25 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:bba3:fc99:5334:6f55])
        by smtp.gmail.com with ESMTPSA id z3-20020a5ec903000000b0077ac811b20dsm6264272iol.38.2023.06.15.14.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:53:25 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: imx8mm-beacon: Change camera I2C address
Date:   Thu, 15 Jun 2023 16:53:12 -0500
Message-Id: <20230615215314.5402-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615215314.5402-1-aford173@gmail.com>
References: <20230615215314.5402-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI to HDMI bridge uses the address currently assigned to
the camera, so change the camera address to the alternative
address of 0x10 in preparation to enable the bridge.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index bc531175ff76..d5c6fc68d656 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -141,11 +141,11 @@ &i2c2 {
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
-	camera@3c {
+	camera@10 {
 		compatible = "ovti,ov5640";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ov5640>;
-		reg = <0x3c>;
+		reg = <0x10>;
 		clocks = <&clk IMX8MM_CLK_CLKO1>;
 		clock-names = "xclk";
 		assigned-clocks = <&clk IMX8MM_CLK_CLKO1>;
-- 
2.39.2

