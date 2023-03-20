Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440436C1A51
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjCTPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjCTPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0969A38B57;
        Mon, 20 Mar 2023 08:40:56 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KEqHdp010200;
        Mon, 20 Mar 2023 15:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=47IPnaWi3GryIRG2aGPGhl/NJ5wDTsJyUvWbit6GXUg=;
 b=Z50KgXT7st920Fp3w+zbZ5edHlguyi885F5e1smZ/ZROMNsgYMpgK4UHpFEST/VfEGDL
 KwNw8l9p1//gYqO0qHJdpzG1oo49/kv3jqVcurxcHk1bFGu1oi0Wultz1ez06eU3CcFh
 s4wDae6ZvBKKfsMoQpo5xDobdHowZWnnW7/TWzXoJGxi2ZavtEVuHrpfHo23EF4lPIgT
 ldftR1txkskieH3vG5VH/KaTzZPeHGLRGucHGdLRvoEcbpxoQ9WSlRdUrqK/zLBu8gok
 0hUIBM2f3fNiXsCgYvppY9UMt1Hnkdi58GD1IWSjBaaB2mwvG//JgGIm55KDGwrot04j ag== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pesmqs96v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:40:35 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KEb7P1020743;
        Mon, 20 Mar 2023 15:40:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3pd4x70vk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:40:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KFeW6e8848092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 15:40:32 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 677CC5804E;
        Mon, 20 Mar 2023 15:40:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EE0058067;
        Mon, 20 Mar 2023 15:40:32 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Mar 2023 15:40:32 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 2A19E74A480; Mon, 20 Mar 2023 10:40:31 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v2 5/5] ARM: dts: aspeed: p10bmc: Change power supply info
Date:   Mon, 20 Mar 2023 10:40:19 -0500
Message-Id: <20230320154019.1943770-6-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
References: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 87w3C5uC8l8mG6wyE6diQuQdaaNXZ0aY
X-Proofpoint-ORIG-GUID: 87w3C5uC8l8mG6wyE6diQuQdaaNXZ0aY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_10,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=702 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

