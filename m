Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA25B6F1778
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345607AbjD1MRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjD1MRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:17:39 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFAE6182;
        Fri, 28 Apr 2023 05:17:26 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S8i5kq027432;
        Fri, 28 Apr 2023 14:17:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=uLm/HGEnqROJmmncqly7r5V/8GYfRwITdoBvoKdZJsg=;
 b=TEy2wpOgHqwyo4cNbCD5pzo1wSK8nOwyPyUkFBG++gDsGjNwPlPclHU5tVfoaCkBvSqM
 KRw3rkQHRpYwRDg5QeF0T3NxHNZ8ah24s0f0iszQWTmvoHDMSY5CRhNCO0JVnh5iG+7H
 6a3a2Pfptvox70FDa8d1+PBAHE+Bq+EctRE7tNNgK0nG9H0gyD7EBhFH5lJ/SXhoeYFv
 LwWTRKtw1oaLeLM6xBu5rhcf0hISxqIpZNGZJpyTZK0WlutV05Fg7LYPLnEFbDSJL7qy
 d5jAspoXny7ceM6WMGXuG67LYxhgNDzLIuKjsssGRK/xQ3huSH1tAzwErF/bziHNZhNE 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q87qfu0y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 14:17:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E3DA1100034;
        Fri, 28 Apr 2023 14:17:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D6B86227EF5;
        Fri, 28 Apr 2023 14:17:15 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 28 Apr
 2023 14:17:15 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 6/7] dt-bindings: spi: stm32: add stm32h7 st,spi-slave-underrun property
Date:   Fri, 28 Apr 2023 14:15:23 +0200
Message-ID: <20230428121524.2125832-7-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428121524.2125832-1-valentin.caron@foss.st.com>
References: <20230428121524.2125832-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is used to enable and configure stm32h7 SPI controller to
handle underrun that could appear in slave mode.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 .../devicetree/bindings/spi/st,stm32-spi.yaml     |  8 ++++++++
 MAINTAINERS                                       |  1 +
 include/dt-bindings/spi/spi-stm32.h               | 15 +++++++++++++++
 3 files changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/spi/spi-stm32.h

diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index 1d26fa2658c5..e946ea71a247 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -28,6 +28,7 @@ allOf:
       properties:
         st,spi-midi-ns: false
         spi-slave: false
+        st,spi-slave-underrun: false
 
 properties:
   "#address-cells": true
@@ -70,6 +71,13 @@ properties:
       In case of spi-slave defined, if <0>, indicate that SS should be
       detected via the dedicated HW pin
 
+  st,spi-slave-underrun:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      First parameter enables and selects slave underrun reaction.
+      Refer to "dt-bindings/spi/spi-stm32.h" for the supported values.
+      Second parameter is the pattern in case of SPI_SEND_PATTERN mode.
+
 patternProperties:
   "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-f]+$":
     type: object
diff --git a/MAINTAINERS b/MAINTAINERS
index 007a9cdb9cc8..9dcf861834fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19790,6 +19790,7 @@ M:	Alain Volmat <alain.volmat@foss.st.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 F:	drivers/spi/spi-stm32.c
+F:	include/dt-bindings/spi/spi-stm32.h
 
 ST STPDDC60 DRIVER
 M:	Daniel Nilsson <daniel.nilsson@flex.com>
diff --git a/include/dt-bindings/spi/spi-stm32.h b/include/dt-bindings/spi/spi-stm32.h
new file mode 100644
index 000000000000..260109fd1631
--- /dev/null
+++ b/include/dt-bindings/spi/spi-stm32.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause) */
+/*
+ * This header provides constants for STM32_SPI bindings.
+ */
+
+#ifndef _DT_BINDINGS_SPI_SPI_STM32_H
+#define _DT_BINDINGS_SPI_SPI_STM32_H
+
+/* st,spi-slave-underrun first parameter */
+#define SPI_NO_ACTION			        0
+#define SPI_SEND_PATTERN		        1
+#define SPI_REPEAT_LAST_RECEIVED_DATA	        2
+#define SPI_REPEAT_LAST_TRANSMITTED_DATA        3
+
+#endif
-- 
2.25.1

