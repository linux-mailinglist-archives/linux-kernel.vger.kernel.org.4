Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F226C39FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCUTKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCUTJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:09:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3CC1E9F0;
        Tue, 21 Mar 2023 12:09:56 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LIVakT013781;
        Tue, 21 Mar 2023 19:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=FUwOquj9z1MgPQVXWJffGH5SCJGct9pa82QsRDPwz70=;
 b=Ca9S6yzb/m28/rAkm5oVi29mCEaLE8fMUKdFb2/CTfR3LJKghfeLStQ+1AzKevsPYf1l
 cAYMFlsDP2tF6U8p9VFAatK+J8noZKbQ2uUo6Qkjl14aJ4YqDXQUpEXavvYj7TdaFFUt
 +K4JD4jOJxd9bXEJMfCmtxh+B87vjOvpAfNlpo8naHSr6xqXz+T+5Ew12HRY0rATqCqq
 vc4XGQmnMEjdoUJ1OZIT3UQsh8J2rm3r6bKnAD2x11gWw5aWBINvLxUvCKS6ux0OQecd
 wlYcX5nfWZP5GWQOlsBpOBpKnRjKuu+NDThyqupCOKmHF9FCx3GccbGKGTftkQcspFNP EA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfhxh11cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 19:09:33 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LHTr2D009111;
        Tue, 21 Mar 2023 19:09:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x74bpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 19:09:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LJ9ULO39518700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 19:09:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B093158066;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B1C15805D;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 1C0C274A47A; Tue, 21 Mar 2023 14:09:30 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v3 1/5] dt-bindings: vendor-prefixes: Add prefix for acbel
Date:   Tue, 21 Mar 2023 14:09:10 -0500
Message-Id: <20230321190914.2266216-2-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
References: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gn_zW-IWMXvCgnAoxdctA5JoUh9aTBCg
X-Proofpoint-ORIG-GUID: Gn_zW-IWMXvCgnAoxdctA5JoUh9aTBCg
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=592 priorityscore=1501
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303210152
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

