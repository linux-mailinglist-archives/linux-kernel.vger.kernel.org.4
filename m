Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A66DC26E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 03:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjDJBpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 21:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjDJBph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 21:45:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723FB35A7;
        Sun,  9 Apr 2023 18:45:36 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 339N7gHj002478;
        Mon, 10 Apr 2023 01:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lACip7+EkKWDEeQBT2iYREjHR0TDo6jILmW0mTPMejc=;
 b=L0y3esTzbs4xYZXU3LAeItzl76oVXJBmhHlelmp7GfVM+mO97QJRgQvybWruO8F0v7gb
 274YQ+MDaHX3axi57YbfwcNlrYEWmk2cWiZfemdY1gSanAHkf3IjPgHPidZHTgGgcmI/
 Ni24zbFW95PsCh8MQuq65wp26aE1Dh+3JtjvqgrQoRO2asf2AC9XadLuW8W8BawsUKaU
 NZG25acLyhajOTYaumA3y5mTSENgEoToh24e6yF4/qUaPjz97+s41KK+9yh7N74AsFAu
 FghTh8zex1tpJZ/CSydWCbLc6J1w0ZN/yZGH/Bj2MqaoemRUyavcjOKzcPruEVwR0DZ4 /w== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj2tjk0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 01:45:09 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 339Mq140030378;
        Mon, 10 Apr 2023 01:45:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pu0ktabu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 01:45:08 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33A1j70311076192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 01:45:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00EC958057;
        Mon, 10 Apr 2023 01:45:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5D2D58061;
        Mon, 10 Apr 2023 01:45:06 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Apr 2023 01:45:06 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id AEE5E74514F; Sun,  9 Apr 2023 20:45:06 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v5 5/5] ARM: dts: aspeed: p10bmc: Change power supply info
Date:   Sun,  9 Apr 2023 20:44:45 -0500
Message-Id: <20230410014445.458385-6-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230410014445.458385-1-lakshmiy@us.ibm.com>
References: <20230410014445.458385-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MFVw4rAws1ngeJerebW_fc5YDxFswB6U
X-Proofpoint-ORIG-GUID: MFVw4rAws1ngeJerebW_fc5YDxFswB6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-09_18,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=852
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100011
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

