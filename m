Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1018261EEFC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiKGJ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKGJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:29:38 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7E115732;
        Mon,  7 Nov 2022 01:29:37 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f5so28427062ejc.5;
        Mon, 07 Nov 2022 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C4ZpIu9MoFe/21Uj/Vi0AVSvYvZIvhlEsa/ecQ+D1U=;
        b=jOs+RksedWn2abnSKpQ1jJsuiitFNo12IAfdDaIE3X0PObmWfJuN8RX77sN4cYiYx6
         2v+xMqbkZz5+rYNAIR0x7vl1Xwd5WnWT9OjpaQC/arJ7a3moVxFoDhKiw0XwKbwPiBc8
         sbaT36vI5RKbxmm+zd6sXAN4w87VeMxdyXanncMxRHCVc0Hx56RF2NdsKFGvysdpDeBJ
         CjRG9QBNZzaNU6xc6jeeA1gss5FCUDEUti6Wb2wRdkNsBlvUlbFrd1Zfw7NfyhCK1mCq
         oD1IxEOtcydCAdFljN15WO4q+ymPSLH5SA4IzwVqt90VINQHhP3dKXosgxf64DxeHWKE
         yNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C4ZpIu9MoFe/21Uj/Vi0AVSvYvZIvhlEsa/ecQ+D1U=;
        b=1D49ioXc605wMPBAvoUpsJdmTRZrD3i7wFWqn/NqUxvnbxFWiZ6p2HDznF9FnbzCKO
         4jMo03IgiWbZ9NlZQkY1JuUR8vKb2LxgvmA2afjpdfU6KPBEK6TkB7gpZkzSApWBH6Pe
         ceby8T7Dt2CRaVe2LEyPbu1cfrMfXmDL0vPzr43bfug94Kkl8OGlsvUe5EJfnMOxvpwV
         0pnQ3Vt7+j9eKUxX+Y5x8A1rWPQlkgXmXn8c5rip6lyZSmUrTaptOxr3PdChXKYFD6Gp
         AGFbbcw+KdBLJs46E29AufDpbz9/LchtHx/YRrjLVXjeNs/cX57kqDQAADJnkVzajfoJ
         8GSA==
X-Gm-Message-State: ACrzQf3VDhSBuNhCPG+zF7nHextrC//qKbyu2K/7k3nGXe0s46MAXgmK
        0zAFNKrYPbqQK9upAuxPhjI=
X-Google-Smtp-Source: AMsMyM6y/wC+MJslmKIVv6GrQApqPb1rv72L0C9GHzobMnQcDkSbAck3Cm8dKTcnGoCFXwSc4PCizw==
X-Received: by 2002:a17:907:a4e:b0:77d:94d:8148 with SMTP id be14-20020a1709070a4e00b0077d094d8148mr45090255ejc.607.1667813376243;
        Mon, 07 Nov 2022 01:29:36 -0800 (PST)
Received: from fedora.. (dh207-98-26.xnet.hr. [88.207.98.26])
        by smtp.googlemail.com with ESMTPSA id u10-20020a056402110a00b0045b3853c4b7sm3912837edv.51.2022.11.07.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:29:35 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/3] arm64: dts: qcom: hk01: use GPIO flags for tlmm
Date:   Mon,  7 Nov 2022 10:29:30 +0100
Message-Id: <20221107092930.33325-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107092930.33325-1-robimarko@gmail.com>
References: <20221107092930.33325-1-robimarko@gmail.com>
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

Use respective GPIO_ACTIVE_LOW/HIGH flags for tlmm GPIOs instead of
harcoding the cell value.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index b60b2d4c2ea5..c3f3f78271e9 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -4,6 +4,7 @@
  */
 #include "ipq8074.dtsi"
 #include "pmp8074.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ8074-HK01";
@@ -52,12 +53,12 @@ &blsp1_uart5 {
 
 &pcie0 {
 	status = "okay";
-	perst-gpios = <&tlmm 61 0x1>;
+	perst-gpios = <&tlmm 61 GPIO_ACTIVE_LOW>;
 };
 
 &pcie1 {
 	status = "okay";
-	perst-gpios = <&tlmm 58 0x1>;
+	perst-gpios = <&tlmm 58 GPIO_ACTIVE_LOW>;
 };
 
 &pcie_phy0 {
-- 
2.38.1

