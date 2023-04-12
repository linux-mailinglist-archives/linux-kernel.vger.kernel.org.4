Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEE6DEAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDLFXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDLFXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:23:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF8E1BD9;
        Tue, 11 Apr 2023 22:23:37 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C3Mm8R030197;
        Wed, 12 Apr 2023 05:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lACip7+EkKWDEeQBT2iYREjHR0TDo6jILmW0mTPMejc=;
 b=oqN4ftVzRHBxrHDViDNPrnjopurtMs5kFTLLnRVqHmedQw97ygbQwqJUyWT7Y1ZTCR3E
 RanVLNK1vwKXuU2X+I8ScJwo9rS3Ug5DGqcSinJULQ1vh36Fpgin3J5nNHDI2LroZshh
 JWacYEecN3gwqGnHSEd5dVyQY7oAs/1J+k7wZ2hb9ZeOrix37sj1f9RnNh6qhaFlfBi2
 R/6ZHCFInG7ckUgOpdqA/m0jnhDLUTO7p0J24IdSFBeJZaQ/aw4awQmuN/xYR37qfKwE
 KjCNadyLAhE9NgYoxRgljhW46VArnNu6uq+bo9ecn7QNE2x8VV1pyfmPIKlbv3whyciD dw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwmpgkca4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:12 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C2NLfL002001;
        Wed, 12 Apr 2023 05:23:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pu0kts39n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:11 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C5N99235455426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 05:23:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E8A258059;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FE6B58068;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id ACC55745150; Wed, 12 Apr 2023 00:23:08 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v6 5/5] ARM: dts: aspeed: p10bmc: Change power supply info
Date:   Wed, 12 Apr 2023 00:23:05 -0500
Message-Id: <20230412052305.1369521-6-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
References: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w68V_EN8AQBuNLIZB56mm0wGXSuXgE4g
X-Proofpoint-GUID: w68V_EN8AQBuNLIZB56mm0wGXSuXgE4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=852 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bonnell system supports new ACBEL FSG032 power supply on
I2C addresses 5A and 5B. Update the device tree with new
power supply information and device addresses.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
index a5be0ee048ec..4f959a4f8b58 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
@@ -552,14 +552,14 @@ ucd90160@64 {
 &i2c3 {
 	status = "okay";
 
-	power-supply@58 {
-		compatible = "ibm,cffps";
-		reg = <0x58>;
+	power-supply@5a {
+		compatible = "acbel,fsg032";
+		reg = <0x5a>;
 	};
 
-	power-supply@59 {
-		compatible = "ibm,cffps";
-		reg = <0x59>;
+	power-supply@5b {
+		compatible = "acbel,fsg032";
+		reg = <0x5b>;
 	};
 };
 
-- 
2.37.2

