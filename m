Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139CF6DC26F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 03:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDJBpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 21:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDJBpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 21:45:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8482B2D6B;
        Sun,  9 Apr 2023 18:45:37 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 339Mk1r1023482;
        Mon, 10 Apr 2023 01:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JBGUWeE4Kqhf4rYB4gtbBEROi3DJ1G04g/xw6cAMsFA=;
 b=VBBzRBH3umlOvCTEMxU/xZJoCTv5HHMEWB5eqDRptjZSTZ+mlfAUycyzqbt/OG/tpAtN
 DY97bBtn2R4NDBc6CftA4jBzT6egly2LztdTjKOkfxSU8jLhZtGrslADs4Dh/YwxT9xs
 Wy9Av5XBg0+S9igvmyplLdNkLSv+y4e4P2mmilapEPFWudZHQdZq8lFy0pphcm0U8J7J
 oAVkUD8ChxnRg63U04BrWwOtfWhQkRMyvrHnGQ8i+KsgRmuFCWMXzyWB9hFDsJrwdeG/
 GqpPBS8JZ0KLSCebFTt6Gg8HHRS6SmUI8PvMaS2+Dm2xBZig2/rILuIKdUDI9jY1VcTZ 4g== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj1etmn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 01:45:10 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 339MgOld019860;
        Mon, 10 Apr 2023 01:45:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3pu0fq2bws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 01:45:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33A1j7Pw30278324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 01:45:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C57A58045;
        Mon, 10 Apr 2023 01:45:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26A4F58054;
        Mon, 10 Apr 2023 01:45:07 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Apr 2023 01:45:07 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 9E84E74514C; Sun,  9 Apr 2023 20:45:06 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/5] dt-bindings: trivial-devices: Add acbel,fsg032
Date:   Sun,  9 Apr 2023 20:44:42 -0500
Message-Id: <20230410014445.458385-3-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230410014445.458385-1-lakshmiy@us.ibm.com>
References: <20230410014445.458385-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hUik0e7ZhdYcFMOZqoflwL_1UhY9kjJf
X-Proofpoint-GUID: hUik0e7ZhdYcFMOZqoflwL_1UhY9kjJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-09_18,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxlogscore=780 phishscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304100011
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new Acbel FSG032 power supply to trivial devices.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6f482a254a1d..246863a9bc7e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -29,6 +29,8 @@ properties:
   compatible:
     items:
       - enum:
+            # Acbel fsg032 power supply
+          - acbel,fsg032
             # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
           - ad,ad7414
             # ADM9240: Complete System Hardware Monitor for uProcessor-Based Systems
-- 
2.37.2

