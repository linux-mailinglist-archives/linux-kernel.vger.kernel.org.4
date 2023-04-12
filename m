Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80186DEB08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDLFX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDLFXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:23:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AF159E1;
        Tue, 11 Apr 2023 22:23:43 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C4BYq2013656;
        Wed, 12 Apr 2023 05:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=uTa3FQ+xG5oEQO2Mnd2mbHEOM10OZO8eUlLgwbHNbmE=;
 b=tEg0/HOy1deHuqNNBrrMYxf8G1IdKie6ww7lXMzvTgXs9cBBVJiH0n5zvueWvFHHQFCK
 x4NR0tZ1zOb/mMPeTus6OA46929WXKU34NdJCOrTO6ISHfX2IFvrow9vntXqHCsjjUiy
 C6Ec6jzVUdGqo0hnASqhTvfDlncxKuDzDcMS4o2ljChnGuziNO+qUodFpvJIHsZPJ/LQ
 9xmyDEt3tzkwYTgHOsBO6YOPuxeD+pgtGQrd3hrG1o7iSD+9Tvx5V7NcJdGanHCPk5ag
 wLBh+IALUos4x3172Ej8kIRqnMPLjP0FWbXIpmDjGaJou2YevWzbUA6e72eqzb7C/Mmp eQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwk7re5ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C2NF3H027962;
        Wed, 12 Apr 2023 05:23:11 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pu0jj93b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:11 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C5N9qc64356814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 05:23:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4919E5806F;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D49D58066;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 99DBD74514C; Wed, 12 Apr 2023 00:23:08 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/5] dt-bindings: vendor-prefixes: Add prefix for acbel
Date:   Wed, 12 Apr 2023 00:23:01 -0500
Message-Id: <20230412052305.1369521-2-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
References: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h6OmavAcCXiH094oS8KcIIDolII6hx2Q
X-Proofpoint-ORIG-GUID: h6OmavAcCXiH094oS8KcIIDolII6hx2Q
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=569 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120044
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

