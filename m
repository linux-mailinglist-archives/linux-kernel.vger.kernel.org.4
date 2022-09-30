Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740785F05B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiI3H1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiI3H1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:27:42 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8101F44FD;
        Fri, 30 Sep 2022 00:27:36 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U7L1hm007950;
        Fri, 30 Sep 2022 09:27:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=XQ2RjHrD5OmQOB3f11vVWaaLLinei2zk5PlRb2eY9lM=;
 b=d1JIz6AQBodLsNIlAzTG9khjhBn8omPZCGqNAzJ28rjB7Kj7Q6z3Hzk7JtBXila+W67F
 ie8B4+qh/Z1eAcdxQc7x1Sr1qdA1/EnIf70y2r2IoZAGUliVFxp9Za9Cwe6EKi2JeBx+
 mrCzVrOXcIAXka2raBhuRh2xjqNOWHpb9MSXPp2/FFbj8ujinKruSnVBXuCbaP68llX5
 Fu0tcpr45T306sHIuzpbKPLJeta0ZqnuS98R2R4dT4j/7zslrajDqxISv+pc0q7pY70i
 M4Viz6l/JsJm3AMIw8cQxYDXryOwN3QFN/DyvrOvrQ2F0BTCIWne4TgpzzZmbHSP9qqb 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jsrsk56ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 09:27:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 389B5100034;
        Fri, 30 Sep 2022 09:27:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0FB17215157;
        Fri, 30 Sep 2022 09:27:10 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 09:27:09 +0200
From:   <patrice.chotard@foss.st.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@foss.st.com>, Jerome Audu <jerome.audu@st.com>,
        "Felipe Balbi" <felipe@balbi.sh>
Subject: [PATCH v2] usb: dwc3: st: Rely on child's compatible instead of name
Date:   Fri, 30 Sep 2022 09:27:07 +0200
Message-ID: <20220930072707.516270-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
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
 drivers/usb/dwc3/dwc3-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 166b5bde45cb..fea5290de83f 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -251,7 +251,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	/* Manage SoftReset */
 	reset_control_deassert(dwc3_data->rstc_rst);
 
-	child = of_get_child_by_name(node, "dwc3");
+	child = of_get_compatible_child(node, "snps,dwc3");
 	if (!child) {
 		dev_err(&pdev->dev, "failed to find dwc3 core node\n");
 		ret = -ENODEV;
-- 
2.25.1

