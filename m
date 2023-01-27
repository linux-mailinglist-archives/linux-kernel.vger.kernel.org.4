Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B1867EA44
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjA0QCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjA0QC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:02:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6368662B;
        Fri, 27 Jan 2023 08:01:58 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFe8eR015045;
        Fri, 27 Jan 2023 16:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0tcHV/Dlv4ShFcIEmal26a+260D96f+aRw22smTtopg=;
 b=XCeVdyiJahzmOHaQQU1tZo3A+xdL46kAJY4/fDJ6QJJhm4/oSQZ0Gh1hevWeNdASHAdJ
 VCWpqgKxE3V5iykoDQO5/aP3lT3/ibD7BKEVbm955XGbI2resdFyJ9/7pUJOPGWLC9Xm
 GSm/pLdMyuoAwKDS+noPq6o6/eFHMX1iMkfxzn3RykEs5aYrFzS7tkQv/8slcE41p65x
 Vui8LEO7J1qX8ulnl3hsnVEsdT76GUigZAlm9hOh/0jjYOFnU4vs/9x9xM9u7wUYUvzk
 U2VGWiSbCyANfWf/cA5ybeTAAoL4t2EmJyJuxSNyhZ0GqIQg3zpdChOYiGw9Wvpy2SPJ 4g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncheyr1sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:01:17 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30RG1GGO024374
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:01:16 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 27 Jan 2023 08:01:13 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 2/2] pstore/ram: Rework logic for detecting ramoops
Date:   Fri, 27 Jan 2023 21:30:52 +0530
Message-ID: <1674835252-31954-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
References: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1PNxq6JX5Cssz7Mn4WBvlVKsFESOd5Yh
X-Proofpoint-GUID: 1PNxq6JX5Cssz7Mn4WBvlVKsFESOd5Yh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270148
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved memory region for ramoops is assumed to be at a fixed
and known location when read from the devicetree. This is not desirable
in an environment where it is preferred the region to be dynamically
allocated at runtime, as opposed to being fixed at compile time.

Also, some of the platforms might be still expecting dedicated
memory region for ramoops node where the region is known beforehand
and platform_get_resource() is used in that case.

So, add logic to detect the start and size of the ramoops memory
region by looking up reserved memory region with of_reserved_mem_lookup()
api when platform_get_resource() fails also update the ramoops
documentation,

Cc: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com> 
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v4:
 - Updated the minor change in documentation.

Changes in v3:
 - Merged 2/3 and 3/3 into one.
   https://lore.kernel.org/lkml/1673611126-13803-2-git-send-email-quic_mojha@quicinc.com/
   https://lore.kernel.org/lkml/1673611126-13803-3-git-send-email-quic_mojha@quicinc.com/

Changes in v2:
 - Addressed the comments made by kees and Guilherme in v1.

 Documentation/admin-guide/ramoops.rst | 25 ++++++++++++++++++++++---
 fs/pstore/ram.c                       | 18 +++++++++++++-----
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index e9f8514..f701fab 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -16,8 +16,9 @@ survive after a restart.
 Ramoops concepts
 ----------------
 
-Ramoops uses a predefined memory area to store the dump. The start and size
-and type of the memory area are set using three variables:
+Ramoops uses both predefined and dynamically memory area to store the dump.
+The start and size and type of the memory area are set using three
+variables:
 
   * ``mem_address`` for the start
   * ``mem_size`` for the size. The memory size will be rounded down to a
@@ -70,7 +71,8 @@ Setting the ramoops parameters can be done in several different manners:
 
  B. Use Device Tree bindings, as described in
  ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
- For example::
+
+ Example of statically reserved ramoops region::
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -85,6 +87,23 @@ Setting the ramoops parameters can be done in several different manners:
 		};
 	};
 
+ Example of dynamically reserved ramoops region::
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		ramoops_region: ramoops {
+			compatible = "ramoops";
+			alloc-ranges = <0x00000000 0xffffffff>;
+			size = <0 0x100000>;
+			record-size = <0x4000>;
+			console-size = <0x4000>;
+		};
+	};
+
+
  C. Use a platform device and set the platform data. The parameters can then
  be set through that platform data. An example of doing that is:
 
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ade66db..17c9f46 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 
 #include "internal.h"
 #include "ram_internal.h"
@@ -643,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 {
 	struct device_node *of_node = pdev->dev.of_node;
 	struct device_node *parent_node;
+	struct reserved_mem *rmem;
 	struct resource *res;
 	u32 value;
 	int ret;
@@ -651,13 +653,19 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		dev_err(&pdev->dev,
-			"failed to locate DT /reserved-memory resource\n");
-		return -EINVAL;
+		rmem = of_reserved_mem_lookup(of_node);
+		if (!rmem) {
+			dev_err(&pdev->dev,
+				"failed to locate DT /reserved-memory resource\n");
+			return -EINVAL;
+		}
+		pdata->mem_size = rmem->size;
+		pdata->mem_address = rmem->base;
+	} else {
+		pdata->mem_size = resource_size(res);
+		pdata->mem_address = res->start;
 	}
 
-	pdata->mem_size = resource_size(res);
-	pdata->mem_address = res->start;
 	/*
 	 * Setting "unbuffered" is deprecated and will be ignored if
 	 * "mem_type" is also specified.
-- 
2.7.4

