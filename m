Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAA26C3561
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjCUPRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCUPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:17:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51200231F8;
        Tue, 21 Mar 2023 08:17:13 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LEfHcX031372;
        Tue, 21 Mar 2023 15:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dhhNXJsGDiYrFRftxc7OOljCn824ZAzW6LGRuHROY7M=;
 b=UNkxUlo7RrrMKtKByKTmuwSRd+b6JPnz5pTKXY+J7MIpCFMcU4r0gLB5bs4zmkVVumYz
 6o6X02kQbFZjj2I4FKUXAAgKe4bz4tbsUGgtu/U1+wfoF8ljQxDCNEHPuAHYZfo+1MWX
 ZCZgivIVNwYYrDvgVlTTXFQKIm8uSQtulsLrd9YgJIZG8glV+9KtJFbdKFLDUCkogPiS
 k1RkogLtTB1FBrtTAQ4n9O9IxbnILSkrjMok6GoEbEfGOPFWebQKrPyfi+e2yV//C+6o
 X5wA5p3pgIVEaTHi0zW9R8wsim76ehpYG0ZZaRRh6xOtNyZ+dAEvz2w2gPF2+5DQP43N 2Q== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfat97mem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 15:17:01 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LFEa3X029517;
        Tue, 21 Mar 2023 15:17:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pd4x77y42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 15:17:00 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LFGwgX34406890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 15:16:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 784D858067;
        Tue, 21 Mar 2023 15:16:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F112C58063;
        Tue, 21 Mar 2023 15:16:56 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.111.39])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Mar 2023 15:16:56 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 4/4] ARM: dts: aspeed: bonnell: Add DIMM SPD
Date:   Tue, 21 Mar 2023 10:16:42 -0500
Message-Id: <20230321151642.461618-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230321151642.461618-1-eajames@linux.ibm.com>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3j_M-v25EPzmbn1EcklvNePnDon_0Bi3
X-Proofpoint-GUID: 3j_M-v25EPzmbn1EcklvNePnDon_0Bi3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_10,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=653 bulkscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DIMM SPD to the processor I2C busses.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
index 79516dc21c01..72186020e75a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
@@ -232,18 +232,38 @@ cfam0_i2c1: i2c-bus@1 {
 
 			cfam0_i2c10: i2c-bus@a {
 				reg = <10>;	/* OP3A */
+
+				eeprom@50 {
+					compatible = "atmel,at30tse";
+					reg = <0x50>;
+				};
 			};
 
 			cfam0_i2c11: i2c-bus@b {
 				reg = <11>;	/* OP3B */
+
+				eeprom@50 {
+					compatible = "atmel,at30tse";
+					reg = <0x50>;
+				};
 			};
 
 			cfam0_i2c12: i2c-bus@c {
 				reg = <12>;	/* OP4A */
+
+				eeprom@50 {
+					compatible = "atmel,at30tse";
+					reg = <0x50>;
+				};
 			};
 
 			cfam0_i2c13: i2c-bus@d {
 				reg = <13>;	/* OP4B */
+
+				eeprom@50 {
+					compatible = "atmel,at30tse";
+					reg = <0x50>;
+				};
 			};
 
 			cfam0_i2c14: i2c-bus@e {
-- 
2.31.1

