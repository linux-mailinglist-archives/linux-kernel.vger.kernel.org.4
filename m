Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2A746C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjGDJAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGDJAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:00:53 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3F1127;
        Tue,  4 Jul 2023 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pdzv+xI6LcnCXo3BAyXVu+UZRpBEl0z68P4lik4FM0Y=; b=SptdBhtDVrom16wG6CY22PJmCD
        TW/O4kCLRacvGZHoseVkItjx/fiyEsQl2mku4SZ2+PJ79qxyh8qjJ+TcPIeT3MdU9MDRyJrraT029
        vBrAx9W2zj443I0oyLjSMmJA6S7wEB0WZbjaG2j3StRLjSUNMCf3k88KCFG3HIQkGexBnBPBn+4ml
        MNfNrCZAceWZp6Ta0CTcA5E1ry79b21fo2a7HN4U+P55f1X2h4UbC8zz7rkNe0YyLx5xa6g13ujEn
        mZgvBE+Uu/gQXNCq3GeCzYX8yGEefzB+CTr0vUPuTiZuYRsudQt48NHJMUKQW4sl1/3OCJTxRan5m
        QcSbqU8Q==;
Received: from [89.212.21.243] (port=50488 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1qGb19-009KMj-30;
        Tue, 04 Jul 2023 10:04:11 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, upstream@phytec.de
Subject: [PATCH 1/2] ARM: dts: imx6: phytec: fix RTC interrupt level
Date:   Tue,  4 Jul 2023 10:03:03 +0200
Message-Id: <20230704080304.816942-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230704080304.816942-1-andrej.picej@norik.com>
References: <20230704080304.816942-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC interrupt level should be set to "LOW". This was revealed by the
introduction of commit:

  f181987ef477 ("rtc: m41t80: use IRQ flags obtained from fwnode")

which changed the way IRQ type is obtained.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
index 1a599c294ab8..1ca4d219609f 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
@@ -182,7 +182,7 @@ i2c_rtc: rtc@68 {
 		pinctrl-0 = <&pinctrl_rtc_int>;
 		reg = <0x68>;
 		interrupt-parent = <&gpio7>;
-		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		status = "disabled";
 	};
 };
-- 
2.25.1

