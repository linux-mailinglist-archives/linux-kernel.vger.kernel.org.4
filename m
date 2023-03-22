Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ACD6C49A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCVLsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCVLrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:47:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FC66189C;
        Wed, 22 Mar 2023 04:46:57 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MBCEek013324;
        Wed, 22 Mar 2023 11:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=FUwOquj9z1MgPQVXWJffGH5SCJGct9pa82QsRDPwz70=;
 b=oJeJOQ2hspG1Vtcwdhe2Y2IMox5PPpw0NkLwo/QHa+NQaNKOn0xJxda/aD2f2hafKLDN
 jOlNRlZ3ALxRYROEHcirV8CvvFcfXYKrmA6A2miF/NaEgBFTdrAsvXMz7Bw9ZBkLDHI9
 jMfy/N9a/6ptER/HgTrtUmdEIT4ZnHEfeDEdMQNVO8tDuZOivTYVXjQ6EyoNu4Rm1ZxF
 ZJM69S748G5Mlm5Jz+dGeZZ2aFB0PW9rfVEu5Bn96x+WHsPCwzSrwaLypF8ZvJcIFoOg
 NK33na0hLeRrBm2eGJ7ZFeRREeNMbKOFM0d/lPy22FnMMvgblkqibsnbXs9c8KO1Tzcw jA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pg0khgs2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 11:46:33 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32M96HqU022001;
        Wed, 22 Mar 2023 11:46:32 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pd4x7p0ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 11:46:32 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32MBkUt08585828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 11:46:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1637F58058;
        Wed, 22 Mar 2023 11:46:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0898B58057;
        Wed, 22 Mar 2023 11:46:30 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Mar 2023 11:46:29 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id C735774A47C; Wed, 22 Mar 2023 06:46:29 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v4 1/5] dt-bindings: vendor-prefixes: Add prefix for acbel
Date:   Wed, 22 Mar 2023 06:46:19 -0500
Message-Id: <20230322114623.2278920-2-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230322114623.2278920-1-lakshmiy@us.ibm.com>
References: <20230322114623.2278920-1-lakshmiy@us.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AmiuRsICSiZ0ornqT7jZQAAF9NpcDHEf
X-Proofpoint-ORIG-GUID: AmiuRsICSiZ0ornqT7jZQAAF9NpcDHEf
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_08,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=587 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220082
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix entry for acbel (https://www.acbel.com)

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca4..9dbb8f69be65 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -37,6 +37,8 @@ patternProperties:
     description: Abracon Corporation
   "^abt,.*":
     description: ShenZhen Asia Better Technology Ltd.
+  "^acbel,.*":
+    description: Acbel Polytech Inc.
   "^acer,.*":
     description: Acer Inc.
   "^acme,.*":
-- 
2.37.2

