Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA9C6DEB07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjDLFXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDLFXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:23:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0559558B;
        Tue, 11 Apr 2023 22:23:42 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C5DcZZ008736;
        Wed, 12 Apr 2023 05:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JBGUWeE4Kqhf4rYB4gtbBEROi3DJ1G04g/xw6cAMsFA=;
 b=ms49/7O6scAxj+rT8QHVTVfU4faL2lFcTw5uqWyLZyKaWdNeXpaY45cgNc52/jJAqjpd
 pJgtNUNfEibPz8ls4vhPRuTXaMmQHNxufjr7PJnWXjwZ2MptdmAz7aEvTWt1PDDG9smS
 PPQrAqWTc9I36lHkWPIQwslLrl3/jDfBStTiyf/ZY0d7Ao89s68X10u6E9EUjV1iDSNp
 +RnfQdliiYW3s6CPbkJGmNDCSNKsdJER6SEd3zz+JuWYOqRksjcPNhrl3iZWRwN9y+0H
 Ol8Pwr9Jh5ynFDh1Bq7ZP3OZ0dVkx22YiPpAL55u9vB4liutuKa2TKuQqITg2BU9iTTd mA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwm3ymdka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:11 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C3JBAX003076;
        Wed, 12 Apr 2023 05:23:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3pu0jb43hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:10 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C5N9ih57016598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 05:23:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C0DE58068;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2619558061;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 9E82D74514D; Wed, 12 Apr 2023 00:23:08 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/5] dt-bindings: trivial-devices: Add acbel,fsg032
Date:   Wed, 12 Apr 2023 00:23:02 -0500
Message-Id: <20230412052305.1369521-3-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
References: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E9NopzmqkJ91-7PHaBRyeJdZ2L9w4dyo
X-Proofpoint-GUID: E9NopzmqkJ91-7PHaBRyeJdZ2L9w4dyo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=781 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

