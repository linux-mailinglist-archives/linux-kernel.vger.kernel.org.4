Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81574D986
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjGJPG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjGJPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:06:25 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E04FE8;
        Mon, 10 Jul 2023 08:06:24 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AEYah4014972;
        Mon, 10 Jul 2023 17:05:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=2cjSDo7sl+IkM/MEjjre6A5rcyDXhS8UL70yC06tCfg=;
 b=PA+nBCN3uV/aEfrFFIw6+S3vdJq0aZ88Tp//L4eLyjhnyV/zZmo5zvaZdVoY0uCLITIR
 aNLSeXdt3PTYuWVqCRURmSq6mSMI3ONve7eY2TJmaiQQggjIQk5wll9Lc/84cO8/EVcM
 IRhPCS1X3UI1UqmgA03w4x4j0dZoA12WIiyhGGG2kSW8QpXj8ajQPc/Fvk/lu5msjc/g
 OzBwqdaB1j3ESVzEt6fW9X4SJp9UDpkyWnvfoyO1TpXrvILG4zBh7jgFmjQ+c9Bv4yq3
 i2b797C4dbUa9SKBNrlsMxYda61XR+CK0lwTNgW3WatiZmAS2XfETrYnl5r2eoTUasQn UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rrkvb071m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 17:05:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7619010005A;
        Mon, 10 Jul 2023 17:05:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6DBE126028E;
        Mon, 10 Jul 2023 17:05:25 +0200 (CEST)
Received: from localhost (10.201.20.20) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 10 Jul
 2023 17:05:25 +0200
From:   Etienne Carriere <etienne.carriere@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH] ARM: dts: stm32: leverage OP-TEE ASync notif on STM32MP13x Soc family
Date:   Mon, 10 Jul 2023 17:05:15 +0200
Message-ID: <20230710150515.2127124-1-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.20]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_11,2023-07-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables use of GIC PPI#15 for OP-TEE asynchronous notifications
on stm32mp13 platforms.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index d163c267e34c..02f872b99f1d 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -33,6 +33,8 @@ firmware {
 		optee {
 			method = "smc";
 			compatible = "linaro,optee-tz";
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
 		};
 
 		scmi: scmi {
-- 
2.25.1

