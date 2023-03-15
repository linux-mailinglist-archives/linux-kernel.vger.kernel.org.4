Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5B86BBCD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjCOS6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjCOS6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:58:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8380E95447;
        Wed, 15 Mar 2023 11:57:59 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FI2JBW037995;
        Wed, 15 Mar 2023 18:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=47IPnaWi3GryIRG2aGPGhl/NJ5wDTsJyUvWbit6GXUg=;
 b=WWHP5yk18vDo2jpXs2BuEqxpknr5yFKD+VKeZ9ckGLZG9yKGT1xt39P9abVUdjaYkDit
 DueeFqshLMjBLwIT5QwhQQZvT0m6x2drnL/IttH0AsE6L66O42p/uyb5x8RM2rYhSN8j
 1Josqm/qPc7KiMb1eRW4s09ZFsdXaNvmv7TR0EJlrAbXlxa/eBgDOhYGG/O81jZ0PKR+
 RCwyK5MpEoO3mZ6/rILKMoGNonjUGlxASX6FJ0j9+iumI0nRjCCNJM0HnJw7APnycau1
 KA27+ueSkeaxRCZbI9zMAPQg6KKYIO7SbS8snREM1M2Xf6GfdIEAE2ngrLokrLaiUdsP bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbf9g0ee6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:57:53 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32FEOo4V022996;
        Wed, 15 Mar 2023 18:57:53 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbf9g0edr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:57:53 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32FHAaWN023620;
        Wed, 15 Mar 2023 18:57:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pb29smu24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:57:52 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32FIvot950332018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 18:57:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE75E58056;
        Wed, 15 Mar 2023 18:57:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B30D458054;
        Wed, 15 Mar 2023 18:57:50 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Mar 2023 18:57:50 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 222D774A47B; Wed, 15 Mar 2023 13:57:50 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@aj.id.au, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     ylakshmi@yahoo.com, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH 4/4] ARM: dts: aspeed: p10bmc: Change power supply info
Date:   Wed, 15 Mar 2023 13:57:39 -0500
Message-Id: <20230315185739.1204530-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wBaF_clpwBdPWJSUTvx8fB9zpA0lgkFF
X-Proofpoint-ORIG-GUID: sc1eWa3_UPmca3qFN6pVU8ANLRJ8FNBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_10,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=786 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2302240000
 definitions=main-2303150155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change power supply driver and device address.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
index a5be0ee048ec..414191b5aeba 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
@@ -552,14 +552,14 @@ ucd90160@64 {
 &i2c3 {
 	status = "okay";
 
-	power-supply@58 {
-		compatible = "ibm,cffps";
-		reg = <0x58>;
+	power-supply@5a {
+		compatible = "acbel,crps";
+		reg = <0x5a>;
 	};
 
-	power-supply@59 {
-		compatible = "ibm,cffps";
-		reg = <0x59>;
+	power-supply@5b {
+		compatible = "acbel,crps";
+		reg = <0x5b>;
 	};
 };
 
-- 
2.37.2

