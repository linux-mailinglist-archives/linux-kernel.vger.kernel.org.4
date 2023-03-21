Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AC36C39F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCUTKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCUTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:09:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C45FF5;
        Tue, 21 Mar 2023 12:09:57 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LJ9INM030048;
        Tue, 21 Mar 2023 19:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mwWJGWUbmOuS2RR0wWyJM/97XQxfYEgeMaNATuPMHNE=;
 b=mPtLIZF+l3zXk0ixmGcJfci3kmtjI/005cYYgiiW7znGPw9CH6gUtrhNzLQiMyg1BoiD
 Tu4fnTXewwE+BaMAqNrSjKEsgkbeghTnVdQtpAwso1SwgBNY+3mPbQ0IL5rQnNg6PsOa
 1Zb0uWXkgGJ+6AmleltOZHl24JRqVLtwxgJul8uJaMSfxX0cEizyKsFOdNFFxayxqfTp
 HUYSFS5vKPiI2ZRI59NQVzeJLlQuV4Jy/EdDg+XbIrVMXl75Hyg3gELUezDBZFfNFAV6
 RSOkbviCEztE+bHSrAnd/F+kAKmEfavlx6FAq1QXqQJ3AMBBbv3N7OZzeASOqdo/RtwG sg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf85y9kmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 19:09:34 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LI0JK6011439;
        Tue, 21 Mar 2023 19:09:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x6vbkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 19:09:32 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LJ9VMh34013776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 19:09:31 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01D445804E;
        Tue, 21 Mar 2023 19:09:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFF315803F;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 32D3F74A480; Tue, 21 Mar 2023 14:09:30 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v3 5/5] ARM: dts: aspeed: p10bmc: Change power supply info
Date:   Tue, 21 Mar 2023 14:09:14 -0500
Message-Id: <20230321190914.2266216-6-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
References: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D4OC63YXOQZbfC3I3JYkdGhkFigMghCv
X-Proofpoint-GUID: D4OC63YXOQZbfC3I3JYkdGhkFigMghCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=771 adultscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210152
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

