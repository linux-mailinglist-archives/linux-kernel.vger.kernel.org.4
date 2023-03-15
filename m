Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088026BBCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjCOStw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjCOStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:49:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CC41284D;
        Wed, 15 Mar 2023 11:49:49 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FHBIaD031841;
        Wed, 15 Mar 2023 18:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=2DAycKkNR5JzI421DzdYC9jkhTO5VG8838Qgc06IF9c=;
 b=gjBAxHMfaIgOKmznyLxeGV9niFNj85vCgFfj2RUvteB95Fx9M7SgcZV3UYieZaXWV0my
 oBtGmDMakdyOJgVSeMgB9qqkM2ai+kbisUeeofh0lnxAlrtG2LhOx18Z/lJZR0YavKN/
 OU8z+Lvuf4zE9W8tXAZEKAfWsL6Qy9xEAyCKkRTtoCERJPW+nFQF0s3HRqdPv3pDC5BS
 +Z43K0OEX6fXO+8NDFigfTKJkIfA3GUmHq5AGCM4CF91kk6aytfsMqZC2XPKpe/dRozl
 IdWVTUiiF7wrnzM2xb7zee/WmxGZTTUHQtZmO5K3JFeuuFz90z0L9FIVbmIwCDf2vSLL Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbgey5ktt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:49:45 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32FFCYni000384;
        Wed, 15 Mar 2023 18:49:44 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbgey5kt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:49:44 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32FGiuTE018975;
        Wed, 15 Mar 2023 18:49:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pb29pdytu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:49:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32FIngfZ34275614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 18:49:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66F3458061;
        Wed, 15 Mar 2023 18:49:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51E1A5805F;
        Wed, 15 Mar 2023 18:49:42 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Mar 2023 18:49:42 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 880E574A47B; Wed, 15 Mar 2023 13:49:41 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ylakshmi@yahoo.com, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH 2/4] dt-bindings: trivial-devices: Add acbel,crps
Date:   Wed, 15 Mar 2023 13:49:21 -0500
Message-Id: <20230315184921.846813-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SLta1oyOqAlhqZ_tU9sVbuDQIcH2sJwv
X-Proofpoint-ORIG-GUID: F0foyglH7reGDBBenEZY5fTQeoUGVL0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_10,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 mlxscore=0 mlxlogscore=725 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Acbel CRPS Series power supply to trivial devices.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6f482a254a1d..ae2cf4411b39 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -30,6 +30,8 @@ properties:
     items:
       - enum:
             # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
+          - acbel,crps
+            # Acbel CRPS Series power supply
           - ad,ad7414
             # ADM9240: Complete System Hardware Monitor for uProcessor-Based Systems
           - ad,adm9240
-- 
2.37.2

