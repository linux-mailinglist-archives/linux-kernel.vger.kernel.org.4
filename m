Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC3E72180B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjFDO6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFDO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:58:17 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A0E1B1;
        Sun,  4 Jun 2023 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685890617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxdaZYpsh0LWTwoNnhJ3KSRH4Xn+PKI7zDErKH1NAn4=;
        b=KJwxIzN+abhzTB0FcY+2sgcOJlie3P3sZhcpZ+osNAXkIhLe4iFSQcJF3I33Tfz1pVTS4X
        V94SLH0XNQTnNpERzkPXha+nEBvGiYFmXHELAlpRyL6fDZ0E5a6pJzuFUA24LotyNVZqM0
        VEPsB2xwAMQ0UbwCHEv83N4eoXqX/hI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/9] MIPS: DTS: CI20: Parent MSCMUX clock to MPLL
Date:   Sun,  4 Jun 2023 16:56:39 +0200
Message-Id: <20230604145642.200577-7-paul@crapouillou.net>
In-Reply-To: <20230604145642.200577-1-paul@crapouillou.net>
References: <20230604145642.200577-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to clock the SD cards much higher, as the MPLL is
running at 1.2 GHz by default. The previous parent was the EXT clock,
which caused the SD cards to be clocked at 24 MHz maximum.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index b7dbafa1f85d..bdbd064c90e1 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -129,10 +129,11 @@ &cgu {
 	 */
 	assigned-clocks = <&cgu JZ4780_CLK_OTGPHY>, <&cgu JZ4780_CLK_RTC>,
 			  <&cgu JZ4780_CLK_SSIPLL>, <&cgu JZ4780_CLK_SSI>,
-			  <&cgu JZ4780_CLK_HDMI>;
+			  <&cgu JZ4780_CLK_HDMI>, <&cgu JZ4780_CLK_MSCMUX>;
 	assigned-clock-parents = <0>, <&cgu JZ4780_CLK_RTCLK>,
 				 <&cgu JZ4780_CLK_MPLL>,
-				 <&cgu JZ4780_CLK_SSIPLL>;
+				 <&cgu JZ4780_CLK_SSIPLL>,
+				 <0>, <&cgu JZ4780_CLK_MPLL>;
 	assigned-clock-rates = <48000000>, <0>, <54000000>, <0>, <27000000>;
 };
 
-- 
2.39.2

