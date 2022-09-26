Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FDD5EA870
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiIZObn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiIZObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:31:17 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA8101F;
        Mon, 26 Sep 2022 05:44:33 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QCTkkH003043;
        Mon, 26 Sep 2022 14:44:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=NcxmZqB476BNQQv7ckeLKtwAuOIYz7JSs+NWFIFH+fo=;
 b=N5cxXb86vI2+/qhfxBAnEPFEauhPJZKBY90D7NIbkVqnwOqDIuYenaD5yZU58G5K5aOg
 igY/ce17mwc4IFgM0UWYdFPJA+fq7exqkXm7RWLXrSoX0ghRbaUr9oogW+lpCbpSDXbJ
 D2F4kWePvPhDC+DkXQeYck0IK/6StstXDzzq6Y1+olmQjbMip4vkPRW7FqA055mO7Mcf
 nnLomLor8Mm7+m85MLHhzP/lS6UJpxvrcQhLYKK5DProyFZPLeMb/cFNRfrYL2sDTMt7
 tOIgboSX1XclZ1G+zQ3eCKz8Q8OW+8SWKvs6ZCNasU0sJ2sx83pwXp2XnGGVW/COY1K7 Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jsqam31uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 14:44:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5911F10002A;
        Mon, 26 Sep 2022 14:44:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 12E1F22A6C5;
        Mon, 26 Sep 2022 14:44:10 +0200 (CEST)
Received: from localhost (10.75.127.119) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 14:44:09 +0200
From:   <patrice.chotard@foss.st.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Serge Semin" <Sergey.Semin@baikalelectronics.ru>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@foss.st.com>, Jerome Audu <jerome.audu@st.com>
Subject: [PATCH] usb: dwc3: st: Fix node's child name
Date:   Mon, 26 Sep 2022 14:43:59 +0200
Message-ID: <20220926124359.304770-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Update node's child name from "dwc3" to "usb", this fixes
the following issue:

[3.773852] usb-st-dwc3 8f94000.dwc3: failed to find dwc3 core node

Fixes: 3120910a099b ("ARM: dts: stih407-family: Harmonize DWC USB3 DT nodes name")

Reported-by: Jerome Audu <jerome.audu@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/usb/dwc3/dwc3-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index 166b5bde45cb..6c14a79279f9 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -251,7 +251,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	/* Manage SoftReset */
 	reset_control_deassert(dwc3_data->rstc_rst);
 
-	child = of_get_child_by_name(node, "dwc3");
+	child = of_get_child_by_name(node, "usb");
 	if (!child) {
 		dev_err(&pdev->dev, "failed to find dwc3 core node\n");
 		ret = -ENODEV;
-- 
2.25.1

