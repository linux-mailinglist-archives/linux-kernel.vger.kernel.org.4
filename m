Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EEA647D57
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 06:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLIFiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 00:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLIFiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 00:38:05 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6971248
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 21:38:04 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8Jjc5h002003;
        Thu, 8 Dec 2022 21:37:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=HiIykd16Jp1D2JvnVXWWdYpYbATlNq3Q1gAU5oyHKWQ=;
 b=J0OhxL5iLRfcMtpgluG51ov6U2tSCYrdeZIZ7HRwzcIqsHGb0p8fdiPgepZTMnsCt93J
 sccMQe/SZcXix1EiNa7p3qs4gsRlkDo6brptzQZjpKlxyUCAc1NSp98HlgCHRHLBzGgP
 Y6LLl6V0VuYpXlR3EQn4QArUnzB/t5E1t1Ay1NwwUdqTTEb1CT1ofN3bLRY2oB2BkIXP
 aTEaoN5thx14WF5lWWzKEh1jWHPIYyldur0Qj+28xWfJZN3zflLUhyaFtZuvFFgjs4xf
 N3I8tnys5DHnaRJ5MuNhltU4Q/9Wef91h85yDurVOh6cZ0rDhm1vOAchmU77Zu0HZjoP 9Q== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mb22sxc5f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 21:37:57 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 8 Dec
 2022 21:37:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 8 Dec 2022 21:37:55 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id EB6E23F7062;
        Thu,  8 Dec 2022 21:37:52 -0800 (PST)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gcherian@marvell.com>,
        <bbhushan2@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH] perf/marvell: Add ACPI support to TAD uncore driver
Date:   Fri, 9 Dec 2022 11:07:15 +0530
Message-ID: <20221209053715.3930071-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zbf-8vhCefATiqRtJGEfxToshKdogTBM
X-Proofpoint-GUID: zbf-8vhCefATiqRtJGEfxToshKdogTBM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_02,2022-12-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ACPI based device registration so that the driver
can be also enabled through ACPI table. 
While at that change the DT specific API's to device_* API's so that 
both DT based and ACPI based probing works.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_tad_pmu.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 69c3050a4348..b1f5580e070a 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -13,6 +13,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
+#include <linux/acpi.h>
 
 #define TAD_PFC_OFFSET		0x800
 #define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
@@ -254,7 +255,7 @@ static const struct attribute_group *tad_pmu_attr_groups[] = {
 
 static int tad_pmu_probe(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct tad_region *regions;
 	struct tad_pmu *tad_pmu;
 	struct resource *res;
@@ -276,21 +277,21 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ret = of_property_read_u32(node, "marvell,tad-page-size",
-				   &tad_page_size);
+	ret = device_property_read_u32(dev, "marvell,tad-page-size",
+				       &tad_page_size);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't find tad-page-size property\n");
 		return ret;
 	}
 
-	ret = of_property_read_u32(node, "marvell,tad-pmu-page-size",
-				   &tad_pmu_page_size);
+	ret = device_property_read_u32(dev, "marvell,tad-pmu-page-size",
+				       &tad_pmu_page_size);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't find tad-pmu-page-size property\n");
 		return ret;
 	}
 
-	ret = of_property_read_u32(node, "marvell,tad-cnt", &tad_cnt);
+	ret = device_property_read_u32(dev, "marvell,tad-cnt", &tad_cnt);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't find tad-cnt property\n");
 		return ret;
@@ -369,10 +370,19 @@ static const struct of_device_id tad_pmu_of_match[] = {
 };
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id tad_pmu_acpi_match[] = {
+	{"MRVL000B", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
+#endif
+
 static struct platform_driver tad_pmu_driver = {
 	.driver         = {
 		.name   = "cn10k_tad_pmu",
 		.of_match_table = of_match_ptr(tad_pmu_of_match),
+		.acpi_match_table = ACPI_PTR(tad_pmu_acpi_match),
 		.suppress_bind_attrs = true,
 	},
 	.probe          = tad_pmu_probe,
-- 
2.25.1

