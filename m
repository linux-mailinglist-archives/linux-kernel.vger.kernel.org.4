Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B666BBCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjCOSri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCOSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:47:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD71C21974;
        Wed, 15 Mar 2023 11:47:07 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FGg4dY023383;
        Wed, 15 Mar 2023 18:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=FUwOquj9z1MgPQVXWJffGH5SCJGct9pa82QsRDPwz70=;
 b=atDszGfnREgynZx4wKwJ4hgPLH7igeZGGUXS5s281Y2mmF4vATv1/35Vwc75TVrejMQi
 qVZIkXZYwu/PcrcOKMgVJeOOLBWlNpQ4cxUFXlMz0MmotTNOqSd3hcyMqfS57RcaHYjn
 6Uv2okOlUa8p9PrOZoNFkRIk29bRrIbNEC6Mz2Kam7bVpTtA731kG9CcPsfAPRf4RnkI
 E/3WRGQ9jlUnb5v2rX8MiR699jtMZ8O+7BZutvi/Wk/BXjEsifhH9ovOJyKNbWN7OgvZ
 QA1i/VzHxVlPpF7NP4o77vm6Tg998Jnq6oqTYG3v3OZX1BixCUB03wYF9sucP0vUPPb1 eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbh02ux0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:46:58 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32FGgpRB025630;
        Wed, 15 Mar 2023 18:46:58 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbh02ux02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:46:58 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32FHIN4J019825;
        Wed, 15 Mar 2023 18:46:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3pb29svs2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 18:46:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32FIkviZ38863268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 18:46:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F37275805A;
        Wed, 15 Mar 2023 18:46:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E54ED5805F;
        Wed, 15 Mar 2023 18:46:56 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Mar 2023 18:46:56 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 995A474A47B; Wed, 15 Mar 2023 13:46:56 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ylakshmi@yahoo.com, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add prefix for acbel
Date:   Wed, 15 Mar 2023 13:46:33 -0500
Message-Id: <20230315184633.766968-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C-NDakY5UXl72Ke6HJMNOvXpBXrXykNv
X-Proofpoint-GUID: ByD7ezcjNfFyTdygG1UNnaw9DCcmV0mR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_10,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 mlxlogscore=662 suspectscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

