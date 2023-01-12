Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0454A667043
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjALKzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjALKyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:54:24 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010FF5D696;
        Thu, 12 Jan 2023 02:45:50 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C950Yp006896;
        Thu, 12 Jan 2023 11:45:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=dPaJwsRGXwCcMzZZwkQyfdVt8cCjBD6sB59ZnpGsKNA=;
 b=CwtdjhRiFpC2katfFWcHzcqzVuE2S/71jXIgXQxF1keJNH4QD0jOZ6eLQvsYBMLDDA2D
 u9Nvh2riNE2t5X7Q547J8rHjFag3c81Kq6/4UvtcFPt0VmK+mdMsjsOnjV0MZPzS6T4z
 VU2DFweO6GiM0V/MPPHuupLOP0bye7o3CBLKgcx8UaIAI17SIEAxTNRwcrK376C5tzXa
 cuwjX6IDYskQctKeLLyt1ti7qLKdDaYNaNsqR8snIuE5L5A76q8+yj31VyoQ9SvXTGN4
 Cxe4rPfHoeCsqtnvfsbYpNvkb9FWeJb+LPF+DF7Oq38Ub8SFn5oGASKOJK7cNt3w/56R 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n1tnmf867-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:45:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78C2D100038;
        Thu, 12 Jan 2023 11:45:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 72DAA214B11;
        Thu, 12 Jan 2023 11:45:06 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 12 Jan
 2023 11:45:06 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/10] ARM: dts: stm32: add vrefint calibration on stm32mp15
Date:   Thu, 12 Jan 2023 11:44:37 +0100
Message-ID: <20230112104446.1140551-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
References: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_06,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe vrefint calibration cell to be retrieved through bsec.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index dea1c53f2b1d..eec5e9992bff 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1632,6 +1632,9 @@ bsec: efuse@5c005000 {
 			reg = <0x5c005000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			vrefint: vrefin_cal@52 {
+				reg = <0x52 0x2>;
+			};
 			ts_cal1: calib@5c {
 				reg = <0x5c 0x2>;
 			};
-- 
2.25.1

