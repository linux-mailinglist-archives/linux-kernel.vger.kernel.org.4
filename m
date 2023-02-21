Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97A669DE32
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjBUKuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjBUKus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:50:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BAC25E16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:50:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cq23so15062628edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApMcsU4SYE3sBKMbTvqLq1Sm/IwL/ogI22P3eYaAobA=;
        b=nJjAKok+QWjwzqcccLIOmTbIbYB7wJCQ3D4e0bzfmx4InfttIlr0yypLruxx/+4TBN
         BAjbEUZrs9H2PfZWhEgfN5NWdPLdpGNMWpeS+FQEouQKqZEQOkdQTHOLjfocyJTQLae4
         dHwsK+bTdn1ds5WVdfsuIpV31GXbgKBnmIRLe6l9eUBsS41hFJzc8zxwTXdSehlw/H1r
         WAKBKUd/1ur1Rvq/uZxgTH9qPFOCCXcXynLucOvaU92XYzNs+Y0yTzonOK5h6E87PH2j
         /mlN8FyMW25orWMqoP6XMJ4ri64t5ELg/8hkZkWwSQieKMyqD8etdJMNRC/7ipoL0IFk
         L2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApMcsU4SYE3sBKMbTvqLq1Sm/IwL/ogI22P3eYaAobA=;
        b=kvYINR3xQ9VHRChgWWDEaUlFz0e0DSCMDLyDidWDJARXq+c7todqfVKBfSTKRAFS0Q
         d8NL5zquF+AUqksFxnVZjpL/hzq5xxfq3IOg0I0eZHZE445N+gVrb5PFJe1nLbq8oCoz
         /PjS9vcHagooAXZTJE73Sw2iHmtmbfsyo6q4Bpe5KAMhL0EfJDb+SQSkMvkXSzKxYotl
         RMPGfeqBz6lmua09hbmfyyRr7c3wY/JVWM50XJJkfzk3ssL1t+XRUWKDklkeZq0gYith
         5pkNopetCyjep6azdH+fIseuzfbuq7qY4TnkFT+UOGR+4tGXwedMHxP2fbHxrHD73ldy
         U5xg==
X-Gm-Message-State: AO0yUKUQgRjL8b+wYLwOKW18PAY7Ckq1RTzT5okF1t5LdHGgLDcmBsg8
        gLrrQySPYy/S9DXzXOrTbUqu9Q==
X-Google-Smtp-Source: AK7set+j0uiYd+nc5Eev9K2O5LttZtylg7DcBJhMz47XtJ2xRc+wNr3o7Q7QoDVUb89hIiYpT/WZGQ==
X-Received: by 2002:a17:906:9750:b0:8b3:946d:51c8 with SMTP id o16-20020a170906975000b008b3946d51c8mr17519162ejy.29.1676976644132;
        Tue, 21 Feb 2023 02:50:44 -0800 (PST)
Received: from fedora.. (dh207-97-58.xnet.hr. [88.207.97.58])
        by smtp.googlemail.com with ESMTPSA id bk26-20020a170906b0da00b0089d5aaf85besm6955802ejb.219.2023.02.21.02.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 02:50:43 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
        arnd@arndb.de, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/3] arm64: dts: microchip: sparx5: correct CPU address-cells
Date:   Tue, 21 Feb 2023 11:50:38 +0100
Message-Id: <20230221105039.316819-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221105039.316819-1-robert.marko@sartura.hr>
References: <20230221105039.316819-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason for CPU node #address-cells to be set at 2, so lets
change them to 1 and update the reg property accordingly.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 5eae6e7fd248e..a4fabacf5c2f7 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -24,7 +24,7 @@ chosen {
 	};
 
 	cpus {
-		#address-cells = <2>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 		cpu-map {
 			cluster0 {
@@ -39,14 +39,14 @@ core1 {
 		cpu0: cpu@0 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
-			reg = <0x0 0x0>;
+			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 		};
 		cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
-			reg = <0x0 0x1>;
+			reg = <0x1>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 		};
-- 
2.39.2

