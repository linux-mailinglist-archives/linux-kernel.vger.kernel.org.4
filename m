Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282896BBB17
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCORlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCORlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:41:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709F5CEC4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:41:01 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FGg2Q4023302
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=FUwOquj9z1MgPQVXWJffGH5SCJGct9pa82QsRDPwz70=;
 b=nBCbeZU68toPgmB8rafxKnC8vrALR/I7S3PtIwR+iLcxWnewVHs1UIMwKh2Wcx46Kylm
 h/DmPgb6xqTsH3TviJGoOPO+4o0mhEznEukzJLYaX2SaE157WT3IoirvbjJQuj2fnWRy
 2iK/nCsmg06Mmcg/ymY5fDQl8ABP1lnZkXBlccynr15XjfOjayKOsgfOFdnAAhFrgr5p
 5NmdboLHWsVEjB0PsBsJBhSPrUxssqQSwSaspdtifEnFeXl0zIrF4wl55jiLbOmNqwXv
 CJ80LJHUdXwXphwjIiRHlHVEMqWgA6YdwDHH1kbJNr0aGimF2Zyokj9BI4XzLdRDQ/NW Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbh02tdb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:41:00 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32FHKSQP027165
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:41:00 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbh02tdav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 17:41:00 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32FHHi5Z022677;
        Wed, 15 Mar 2023 17:40:59 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3pb29rvgkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 17:40:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32FHeuPI7078558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 17:40:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 639B35805D;
        Wed, 15 Mar 2023 17:40:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6062258059;
        Wed, 15 Mar 2023 17:40:56 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Mar 2023 17:40:56 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id CBEDA74A47C; Wed, 15 Mar 2023 12:40:55 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, ylakshmi@yahoo.com
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add prefix for acbel
Date:   Wed, 15 Mar 2023 12:40:24 -0500
Message-Id: <20230315174027.3540015-2-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230315174027.3540015-1-lakshmiy@us.ibm.com>
References: <20230315174027.3540015-1-lakshmiy@us.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fSS-5bWB1QayROItZh235Q8sfdaziMUn
X-Proofpoint-GUID: Q8BgItZE7CvAp6zv3GlVmI2hPn1bEYNi
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 mlxlogscore=562 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150142
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

