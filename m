Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA46C97D8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCZUpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCZUpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:45:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5D6189
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:45:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so28010229edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679863504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKotHhrSArMlYMD87zRBXjHIfz20EsMTTThdF51WPwM=;
        b=VCVLa21fd+C5o27Qx3JrI7Pw9/Bh/TOA8hFB3ta/N/0a0e1EOBnqxBaLMOB56YQBFI
         HIVz1/jZHSW7RFSmatOhlwB6o7HbhaSjxvapcuF9smjwKE9ouFj1Ly11AOoPM0+SsfP4
         wqEMvcTnzzq+fTcbNR/PnI+JNooz6DMS/Rvl1bwr55XdVZN4Kbs+sYrvZ9k4W0obApGI
         btb35zFGYPLuhy09WfKThW13Dn8QsvtSsaq8qnL6PvNcyhGNN6ff5KKIxq3pv/cMleBD
         lJ41duKO+XYEplnhtsAL4dQRtyY5KRkuV6R809WCzt6pYuMFW95d7+Q5ydXrLBr/JEk0
         MqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679863504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKotHhrSArMlYMD87zRBXjHIfz20EsMTTThdF51WPwM=;
        b=dStsKWVTfPQROFXKIaXE3gSlj9Bi70JtgEfl3Q0FmvD2bNUcS7hwYtc2uLRAgNyHxu
         0/7VftYPh8vGmaXGfTNBRCOS8RXakpi6xlzWnAhMMMYIjyUtljwrwf9Njrr7S4vSmpau
         CTOwycHQWdrN7t7K+6WP9FMHnV9EDyNR5jjf7G9zbIKnq/X9AJT6SYGQpXY7X6rGnk4k
         c4PG/TTND333oYAv6SOa3Lu7FbsTJCV2FQ0rSmy9ThDwSGXUAy7BsQ7Zv4ZnMdXmJ6Hc
         tjKqyGWaUPp7moWttr+URhnpXW47OriFbg7v+l1XwVJZxFTSr5SzAjzBLcPUG6zd6rY/
         NGmg==
X-Gm-Message-State: AAQBX9eOfdpBX7HpWSEL6/JL8R56gL0JMTeWFdAO7ZkhS1YAjZ2ow7z4
        TDftqlZ2VR2KD08vBCJ6VkWmng==
X-Google-Smtp-Source: AKy350ZN90o6ec4Uu19ORnJ37DvU+BxCitB1JQcNCAFuy2fgpfIPY8OMwkUTtAkqqcSYz3jdLwfiVg==
X-Received: by 2002:a05:6402:48e:b0:4ff:844a:ed4c with SMTP id k14-20020a056402048e00b004ff844aed4cmr10180632edv.0.1679863504328;
        Sun, 26 Mar 2023 13:45:04 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6b51:4748:3f3f:ffcf])
        by smtp.gmail.com with ESMTPSA id n7-20020a509347000000b005023ddb37eesm1578418eda.8.2023.03.26.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 13:45:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: imx8mq-mnt-reform2: drop invalid simple-panel compatible
Date:   Sun, 26 Mar 2023 22:45:02 +0200
Message-Id: <20230326204502.80794-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"simple-panel" compatible is not documented and nothing in Linux kernel
binds to it:

  imx8mq-mnt-reform2.dtb: panel: compatible: ['innolux,n125hce-gn1', 'simple-panel'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
index 200268660518..3ae3824be027 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
@@ -26,7 +26,7 @@ backlight: backlight {
 	};
 
 	panel {
-		compatible = "innolux,n125hce-gn1", "simple-panel";
+		compatible = "innolux,n125hce-gn1";
 		power-supply = <&reg_main_3v3>;
 		backlight = <&backlight>;
 		no-hpd;
-- 
2.34.1

