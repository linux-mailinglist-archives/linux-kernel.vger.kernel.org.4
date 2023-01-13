Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D42669679
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjAMMIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjAMMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:07:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C383EC;
        Fri, 13 Jan 2023 03:59:27 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBkUtx001890;
        Fri, 13 Jan 2023 11:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6hWI26l3Jwyuu7QZ+nzK5rxK2hb0HsoWPdDuFTTN52w=;
 b=nGYCWq1pV3A4/+udMvKPiz6/tQ02q+TQI3NXvQnXeVewpsFHdf8q1mliDvC06CY0xIB6
 7pPeXcUYoSl5o6aMeQfPbWD69NkCjbZEkq04ZofJvB3Y97HyELhjrQI/n6m3rkihKzRC
 lo6rvyA72c3dqBoIzUnN+QpY3tLwYs+SD4zj2Xm55KgSZrrCW6ImWehxD7QKSXHQnqVM
 du7OC9QFe/zoJpV9Ojlqccg8X2s2C1xdW10adQvoGe2G/FU1gMSZbWRgs6Z+9jOxPCi4
 HpOB5j4BGoLSSPb0BAwCqY18iaNdVsFJrMT6n9xye10cXXhgFyv04G/LIH7IwbJCIgOZ sw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2wqw15u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 11:59:15 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DBxEb3011711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 11:59:14 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 03:59:10 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <keescook@chromium.org>, <gpiccoli@igalia.com>, <corbet@lwn.net>,
        <tony.luck@intel.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v3 3/3] pstore/ram: Rework logic for detecting ramoops
Date:   Fri, 13 Jan 2023 17:28:46 +0530
Message-ID: <1673611126-13803-3-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
References: <1673611126-13803-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jsvihKr3v1r8tSt2qurtiRfeaIawUp5-
X-Proofpoint-ORIG-GUID: jsvihKr3v1r8tSt2qurtiRfeaIawUp5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_05,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved memory region for ramoops is assumed to be at a fixed
and known location when read from the devicetree. This is not desirable
in environments where it is preferred the region to be dynamically
allocated at runtime, as opposed to being fixed at compile time.

Also, some of the platforms might be still expecting dedicated
memory region for ramoops node where the region is known
beforehand and platform_get_resource() is used in that case.

So, add logic to detect the start and size of the ramoops memory
region by looking up reserved memory region with
of_reserved_mem_lookup() when platform_get_resource() failed.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v2:
 - Addressed the comments made by kees and Guilherme in v1.

 fs/pstore/ram.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

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

