Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC16D5355
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjDCVTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjDCVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:18:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0318B3AAB;
        Mon,  3 Apr 2023 14:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DElE3wI18WYooNUq7V2tFLet+k6jHzq6ZO5DQSUTRZCt7WWtArhYiiypxbyauRKdfop71Ij2tT8ZwiUmVxQeni7XkQIW8UkFMMd3w/u6L8ET4Y0le/fQomUM1TjoZK4O1G+6emumljVPmp5UzyPmz0AA59HLl5EYhPlCBOdFciSKIkERlXmksympCmGbWO34ypKsoNi+CjNu5qYabXw45EFEEdKfW7Pz1vj8ekUAeOAIVfW3n2ie2Vg2zccFmjpOlhz/THyKXdp1J3Ifcs+ggA9CCn73SSb9UV2QYhpWEzDc6jETwG5PIoXHLmulsaClb05jlL9i5XzPfEQdtvh+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uyuYrzpFUD9AAiawcudYbjDPhPlJBKpXwXniY+Li4s=;
 b=I6T0VcclJ00TPYixxyWlaSEVq36/R5GwEe0sSyIdpZOOYkX1mDzDzGTCRHBLO1TILI+1y3NuC37CVaNRuuGvuKzYKhn50QW77gpfh0f8NnTf6W/8qoHTRINHXDkYnXO2kGrrGSvGCz81J0Btd9zeQrt35X82S5E5eq3WyvJFFQQvI4WrwZazqcxpj7Gj89c/iZJJHxTDZtTrj093X0cqQ9Si8ZtUYnVY3lJO0asgp8ZlYbb+WlAQU+RnXhOSfxwJYU59Z3x9FuWLUrJv5ZLRU0+RP9bBMqzaEn5U4+DyF4XZbP+cnGMdc0EvTvjQxVwh7MG18/fGHXdFKPm+ZskbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uyuYrzpFUD9AAiawcudYbjDPhPlJBKpXwXniY+Li4s=;
 b=u4BdtQax0cSngILdzZRZ/LJKYXeF5CYD03cN2Q+t0UKpNVOG29xmtW2BU3+/i5+R3fwWOqocsECGPYUe72awVvHX6/0Rm+WpJC1TrOk8v4iySATHoyj7KRPQB1s14eAPtMgpFFxMHCHB2f/UsR9NNhy2667wOfDSRt4bJtgh0Y0=
Received: from BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 21:18:52 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::87) by BLAPR03CA0027.outlook.office365.com
 (2603:10b6:208:32b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 21:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 3 Apr 2023 21:18:50 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 16:18:49 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
CC:     Raul Rangel <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        "S-k Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v6 3/4] platform/x86/intel/pmc: core: Always capture counters on suspend
Date:   Mon, 3 Apr 2023 16:18:29 -0500
Message-ID: <20230403211831.4010-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403211831.4010-1-mario.limonciello@amd.com>
References: <20230403211831.4010-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e90e549-4909-45dc-258a-08db3489054f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yPOmecdpwAsSRx4xZSRhLZ//O0qKowhcv/BdlxKDLeKfnOFElmNH/FIFEi69pSnYKvsx7RvCW5OUIvf2+XtH16IYiQr4XcJ5zTPyveAxGzAx5maA6dHQU4tonjgbkeVeo+4BnDarCGY/PeXe55105qbHCAmrPeQhan4pWJXQaVXtKMlNgxZ4off/bwqeblTz6G7cWB8sCXe4fMlwI+NEMXJsi+tpNU4ZmM+YrbsxDNUDXHyqPaQVCf5VwdYhK/IXtSH65DTqLS91gtYbTfzhYqDosag8Mb+giHeK6lrMZEZJnhuevgxxkdHo3EpODOnalqcZyCul5Vir28p/onsK6L5V2F/8s8uUdki+q38aPqzIUFLQeJESO+VrSdzt6lb6C6w30iDo4V928gNKqoBy9QSqbfX/GtypyJV4M3ezjDSDSrBjjM1LElyzVom4la66S7F7dk0SKEMrfSCA4y+WqFybhCVI0DrFU3uhd4B4E1m2LvhKgKgp0PYJI1JqdEGlTIvAh1h73OGmpIfPVBg2NbjokgCNaHQHT3vlkUuPxBh0QzRiTGap3+Gh8yUQY4di9e+YoJZySYgf83Zo1Zfn1hGwSuD9XRhamoZ+R5eDjX5H/U3/lNYcIdtuHxRXVUloYyYvKVzTx4MRRAbxGx7gXLYGOXNyJR11jdyBZ9RlKR5dNPC8Nr+wscfhwqEVve8jDtikCnB87Q2bCohtwrIem/VXilGchjFh9x69PSiYIs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(7416002)(186003)(16526019)(1076003)(26005)(40460700003)(44832011)(40480700001)(6666004)(478600001)(426003)(54906003)(36756003)(82310400005)(7696005)(15650500001)(36860700001)(110136005)(86362001)(70206006)(70586007)(47076005)(82740400003)(8676002)(4326008)(83380400001)(316002)(2906002)(356005)(41300700001)(81166007)(336012)(5660300002)(2616005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 21:18:50.6825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e90e549-4909-45dc-258a-08db3489054f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently counters are only captured during suspend when the
warn_on_s0ix_failures module parameter is set.

In order to relay this counter information to the kernel reporting
infrastructure adjust it so that the counters are always captured.

warn_on_s0ix_failures will be utilized solely for messaging by
the driver instead.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Pick up tag
v4->v5:
 * Squash patches together
 * Add extra pm_suspend_via_firmware() check for resume routine too
---
 drivers/platform/x86/intel/pmc/core.c | 13 +++++--------
 drivers/platform/x86/intel/pmc/core.h |  2 --
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index b9591969e0fa..925c5d676a43 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1179,12 +1179,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 
-	pmcdev->check_counters = false;
-
-	/* No warnings on S0ix failures */
-	if (!warn_on_s0ix_failures)
-		return 0;
-
 	/* Check if the syspend will actually use S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
@@ -1197,7 +1191,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	if (pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
 		return -EIO;
 
-	pmcdev->check_counters = true;
 	return 0;
 }
 
@@ -1233,12 +1226,16 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
 	int offset = pmcdev->map->lpm_status_offset;
 
-	if (!pmcdev->check_counters)
+	/* Check if the syspend used S0ix */
+	if (pm_suspend_via_firmware())
 		return 0;
 
 	if (!pmc_core_is_s0ix_failed(pmcdev))
 		return 0;
 
+	if (!warn_on_s0ix_failures)
+		return 0;
+
 	if (pmc_core_is_pc10_failed(pmcdev)) {
 		/* S0ix failed because of PC10 entry failure */
 		dev_info(dev, "CPU did not enter PC10!!! (PC10 cnt=0x%llx)\n",
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 810204d758ab..51d73efceaf3 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -319,7 +319,6 @@ struct pmc_reg_map {
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
  * @mutex_lock:		mutex to complete one transcation
- * @check_counters:	On resume, check if counters are getting incremented
  * @pc10_counter:	PC10 residency counter
  * @s0ix_counter:	S0ix residency (step adjusted)
  * @num_lpm_modes:	Count of enabled modes
@@ -338,7 +337,6 @@ struct pmc_dev {
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
-	bool check_counters; /* Check for counter increments on resume */
 	u64 pc10_counter;
 	u64 s0ix_counter;
 	int num_lpm_modes;
-- 
2.34.1

