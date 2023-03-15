Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608316BBB16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjCORlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjCORlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:41:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E2A5C138
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:41:01 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FHP9ct001380
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2DAycKkNR5JzI421DzdYC9jkhTO5VG8838Qgc06IF9c=;
 b=nPWn7Uj5H6oxZgLx54vNRLAAL5o6tEEVWz0PkNvrhBdcpNGjV3bAYL129srzXvZvTDrn
 JEkq3V8rZGnvcJv59g8wQFoNQ0MLSci31RSyppdLEEYuFDlYYAOBLPyPZOOQXzRvRvg9
 uPkIX37NfThtBdYRXlN2mkrG6P/RGNcDYlQEimpLKYXqOSLl94bGhOflwpWACBEHGJir
 Sa0cGcJutb/D2dVZRp5zOgJJgu6ueJ9/ASA6l3b9wUKqkaPY6ao0vty8R0Ny/KZ/dzjf
 2AutcLgR5FC/IT5Jw2re6xxTY5rITCJ9cCmjS14yFIJKHmmgRe3A8d0Q+tmE0gr9OBSL 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbjdcgbfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:41:00 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32FHQ8fd003305
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:40:59 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbjdcgbf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 17:40:59 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32FGXE2K010526;
        Wed, 15 Mar 2023 17:40:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pb29tnmfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 17:40:59 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32FHeuBC30933702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 17:40:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 999CE5805F;
        Wed, 15 Mar 2023 17:40:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 843B55805E;
        Wed, 15 Mar 2023 17:40:56 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Mar 2023 17:40:56 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id E440574A47D; Wed, 15 Mar 2023 12:40:55 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, ylakshmi@yahoo.com
Subject: [PATCH 2/4] dt-bindings: trivial-devices: Add acbel,crps
Date:   Wed, 15 Mar 2023 12:40:25 -0500
Message-Id: <20230315174027.3540015-3-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230315174027.3540015-1-lakshmiy@us.ibm.com>
References: <20230315174027.3540015-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2enhaekZWlWKtDHLJpBbzvAfJdKqnLcE
X-Proofpoint-ORIG-GUID: o88e86X1rAVjNi9XWVM3T7Bnl7CvFta6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=625 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

