Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA65F647D56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 06:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLIFg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 00:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLIFgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 00:36:51 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC4962E97
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 21:36:47 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8JjZUs001924;
        Thu, 8 Dec 2022 21:36:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=vtWxq85+Kn4wg7fIvd4MdjxD2PWRFitUCpQG3biK9OI=;
 b=J6XVp59yBgbM64D8vbnGvsLzrjZf0CdpYdHwD8NZ9PFegSigdAZgP+Kqoo5/1iezBLu3
 Fx6rtRJcrEYpJ3tZLB1xDqouV9YtXJzJ4bwwTYZaJtzLfxOjSQNuf2addvdFcD49URPr
 0IT1BMQgVIxtLTExVEOqQDlONFLLmTDqpaBemaK/sAbDtsuVqEJUEODbNLI11xhsF2ah
 j8LD7/H9zhclmH59PGXNURXkE49Ai72APFjzMjdEarIi35a5qqZBl5CVtculP/zoMjZz
 WNB5ypa2EsnHwaEVsdNGXw1XABrb4Pd4ftcbyeWv9BlUJL/3q4rDhKQUFqHLIxRoW3zL TA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mb22sxc2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 21:36:36 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Dec
 2022 21:36:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 8 Dec 2022 21:36:34 -0800
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id 7667A3F7062;
        Thu,  8 Dec 2022 21:36:31 -0800 (PST)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gcherian@marvell.com>,
        <bbhushan2@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH] perf/marvell: Add ACPI support to DDR uncore driver
Date:   Fri, 9 Dec 2022 11:06:07 +0530
Message-ID: <20221209053607.3929964-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _RKBXP5kIzmDPXwwe3RfFrzWaK2AqBo_
X-Proofpoint-GUID: _RKBXP5kIzmDPXwwe3RfFrzWaK2AqBo_
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

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 665b382a0ee3..b94a5f6cc22b 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/perf_event.h>
 #include <linux/hrtimer.h>
+#include <linux/acpi.h>
 
 /* Performance Counters Operating Mode Control Registers */
 #define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
@@ -717,10 +718,19 @@ static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
 MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] = {
+	{"MRVL000A", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);
+#endif
+
 static struct platform_driver cn10k_ddr_pmu_driver = {
 	.driver	= {
 		.name   = "cn10k-ddr-pmu",
 		.of_match_table = of_match_ptr(cn10k_ddr_pmu_of_match),
+		.acpi_match_table  = ACPI_PTR(cn10k_ddr_pmu_acpi_match),
 		.suppress_bind_attrs = true,
 	},
 	.probe		= cn10k_ddr_perf_probe,
-- 
2.25.1

