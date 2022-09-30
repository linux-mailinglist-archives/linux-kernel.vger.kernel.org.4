Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A705F0D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiI3OVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiI3OUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:20:42 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0B070E79;
        Fri, 30 Sep 2022 07:20:39 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UD1nI3032525;
        Fri, 30 Sep 2022 16:20:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=/EZmdozygV0BZ7sk10V8fgsfTC0ReB20DWquzbP5hNE=;
 b=7qfxi7rW2IdOcohJFSpVMSev1dmWkDTg5zl5obsYGUFjo7WfiUMkLWa1DVGbEtZEzRQ1
 ZDVcP7kOCzMV6t2D33H4m9kd5Ql0Ze18HaQUPg6Az08kyMDizZPKZBcVPlablf/4DGy7
 vTHYDGd6MhoNc7eIgCskyH7FfXPKJIapzQhzUxczR1hvilFBbFq7b7JSr42VkOcS9pKF
 r0ilJ6WJAoIDBEKZfNqbKEwa+dAJ6A8eO0ookL2rEMJCu9eQCwlbvMxQTM1+Kj5zl5rD
 YfgbHckryTe1TVRA7TCFDq4IpV97E1xWnt332cD1dNwAgNpAmVFMg+g6E7o42HA9kL0Y /g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jwxnmhbry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 16:20:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 030DC10002A;
        Fri, 30 Sep 2022 16:20:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0FDF2309E9;
        Fri, 30 Sep 2022 16:20:20 +0200 (CEST)
Received: from localhost (10.75.127.119) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 16:20:20 +0200
From:   <patrice.chotard@foss.st.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@foss.st.com>, Jerome Audu <jerome.audu@st.com>,
        "Felipe Balbi" <felipe@balbi.sh>
Subject: [PATCH v3] usb: dwc3: st: Rely on child's compatible instead of name
Date:   Fri, 30 Sep 2022 16:20:18 +0200
Message-ID: <20220930142018.890535-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE6.st.com (10.75.127.70) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

To ensure that child node is found, don't rely on child's node name
which can take different value, but on child's compatible name.

Fixes: f5c5936d6b4d ("usb: dwc3: st: Fix node's child name")
Cc: Jerome Audu <jerome.audu@st.com>
Reported-by: Felipe Balbi <felipe@balbi.sh>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
v3: - rebase on correct branch
v2: - add missing reported-by
    - add Fixes
---
 drivers/usb/dwc3/dwc3-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 6c14a79279f9..fea5290de83f 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -251,7 +251,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	/* Manage SoftReset */
 	reset_control_deassert(dwc3_data->rstc_rst);
 
-	child = of_get_child_by_name(node, "usb");
+	child = of_get_compatible_child(node, "snps,dwc3");
 	if (!child) {
 		dev_err(&pdev->dev, "failed to find dwc3 core node\n");
 		ret = -ENODEV;
-- 
2.25.1

