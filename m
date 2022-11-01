Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE8615398
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKAUyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKAUyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:54:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8326563;
        Tue,  1 Nov 2022 13:54:10 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1J4SSk011938;
        Tue, 1 Nov 2022 20:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vrGR742i6UT4wMCamVewaOgnS4kjvz6dyoifD8CJsYo=;
 b=sV0yQ1DcYQesFkpjtNBivRlk87HIb6KwXUVPUhyJId4/g1TJ0Sicd7l4ErmovmNmpVZK
 ce7EbCsifnwgsKv875TauYpf6mnctGH9ZLU8WX0/E1BifA2eVagtuFbXTMn1reuxSbA4
 EY60m6MoqRCVLxARsLOGDN6g8TnnLAFP8G61Z/MYj6UcYF9KJIB1hlD2OMBRxdp6EAoE
 xBRbYonalZ33fTwsD7OUkAFqbg/+BdH+NOtBTKH5MewEsgknOpk7TjuDyZ8j4rxYO4p8
 D1PQ26skf9nW1oaxztAAiY63MBuqRNFY2w9ou9wAmS9La7Zp+nRw7M72VkDHOTnMpD0K EQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjtg5r6np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:53:49 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1Kokom004361;
        Tue, 1 Nov 2022 20:53:48 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 3kgutabxqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:53:48 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KrmuL36110752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:53:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD1955805A;
        Tue,  1 Nov 2022 20:53:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA4765805F;
        Tue,  1 Nov 2022 20:53:45 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.92.229])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:53:45 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, joel@jms.id.au,
        andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Setup watchdog pre-timeout interrupt
Date:   Tue,  1 Nov 2022 15:53:38 -0500
Message-Id: <20221101205338.577427-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101205338.577427-1-eajames@linux.ibm.com>
References: <20221101205338.577427-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Urz1o1Ls_Q7DovowQi2QNTaCyLyNcOpL
X-Proofpoint-GUID: Urz1o1Ls_Q7DovowQi2QNTaCyLyNcOpL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_09,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=810 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the interrupt lines for the base SOCs that support it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 3 +++
 arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 04f98d1dbb97..b4b98bf38e48 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -410,18 +410,21 @@ wdt1: watchdog@1e785000 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785000 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				interrupts = <27>;
 			};
 
 			wdt2: watchdog@1e785020 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785020 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				interrupts = <27>;
 			};
 
 			wdt3: watchdog@1e785040 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785040 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				interrupts = <27>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index ebbcfe445d9c..d9379fd7b1c2 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -539,23 +539,27 @@ uart5: serial@1e784000 {
 
 			wdt1: watchdog@1e785000 {
 				compatible = "aspeed,ast2600-wdt";
+				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x1e785000 0x40>;
 			};
 
 			wdt2: watchdog@1e785040 {
 				compatible = "aspeed,ast2600-wdt";
+				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x1e785040 0x40>;
 				status = "disabled";
 			};
 
 			wdt3: watchdog@1e785080 {
 				compatible = "aspeed,ast2600-wdt";
+				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x1e785080 0x40>;
 				status = "disabled";
 			};
 
 			wdt4: watchdog@1e7850c0 {
 				compatible = "aspeed,ast2600-wdt";
+				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x1e7850C0 0x40>;
 				status = "disabled";
 			};
-- 
2.31.1

