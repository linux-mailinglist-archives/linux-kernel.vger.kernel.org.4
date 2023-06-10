Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5432472AEE2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjFJUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjFJUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:54:48 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0034135BB;
        Sat, 10 Jun 2023 13:54:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0kDISr7t3izrJQDWoZrF/fnKiCE5CWE/0Foc9ELT0qgmpzr0IfyMpnmcWQURcnt+t/KnpTAbfutPwj0e13jYGxBubQ+3L6yfgBEvpscCwdzVz3qurHjssLt5TNvvXwy81psR8aiJ4sowq9vPHJEMZ75xDhVw7HMh7huL5cq4j5UvTYXLebMRzp4qEoMAc2vYpQsYufB1pejfvL7Czlq21GEMEkpgTkBOt6V6yWxLH1wVCEjPTl3Y22Er9B3kYBLmaRZlsK01JDJuh9QLJYdr0OJp818wxAcbdmq0xQWeexkBJfqp5qkwP1KXJiNPlbI3HNZH37BMujFR6RQdYbyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNJJKJ56fqKIL1+lznfaPOxV5osmbrRWq2OVi+lysXk=;
 b=WwserfByy3ObXI0ftelrsrCINj/49JoDWql2izA1homG0OcIrZbChiZAwO0w+M57ShtB9VhRipk5qYvMt9wSYoLkhJZKVKp4DfvLGb2qZeI3dA9KjqWe+zUt7wdYMomnN77rdj2xXxVvudRdBC3kdD8UZdZaora2vHGDQiXdtIRMtudgWdrgku63ddIjJsYZ/dybkryro+O50jYLQyb+aUnp0VLC6m/Z2dIb+5/66WtMSRFX6nv+Lqej0UBijDN344xj6xXmtXXXML3Lkz4ceLccSqDYLbYdbjNHU9qGLoCH44zkdb0QAaMfl+PsX4jCjFqzgJy9GMHub9roqUK7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNJJKJ56fqKIL1+lznfaPOxV5osmbrRWq2OVi+lysXk=;
 b=Rfn9HAMVMUUskxdfTqNRKBI0YpVWsrEG/3sF2oMcNpew3m3hCgI4Yn4I1wJxRbxyExUsIzUQBM8xzsqih4YeZpT8Hoh9TdyI/vLhZms7V2PbVa4Ui7EdEtwLzTBtmKdaT/ynH25C0CxZj4UajdJJR2WObmrul5tYpeVReZaM0vc=
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Sat, 10 Jun
 2023 20:54:44 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::eb) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29 via Frontend
 Transport; Sat, 10 Jun 2023 20:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.20 via Frontend Transport; Sat, 10 Jun 2023 20:54:43 +0000
Received: from amd-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 10 Jun
 2023 15:54:41 -0500
From:   Baskaran Kannan <Baski.Kannan@amd.com>
To:     <Mario.Limonciello@amd.com>, <babu.moger@amd.com>,
        <baski.kannan@amd.com>, <clemens@ladisch.de>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Baskaran Kannan <bakannan@amd.com>,
        Baskaran Kannan <Baski.Kannan@amd.com>
Subject: [PATCH] Enable AMD3255 Proc to show negative temperature
Date:   Sat, 10 Jun 2023 15:53:57 -0500
Message-ID: <20230610205357.5658-1-Baski.Kannan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0589a712-7499-4b57-e2d6-08db69f4eb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IciasRFSPGlnjQBtc3jx+MGac4NClMi5SUmnG/7clQxU6baP2a8dwueMgAut/UCO9uTeJY/GRTWM3AMTOt9VIcb+scEUzgXuElto1AVW7UO2KWWIMA+WsPwtGLpdIQ5QJ57MuXGZvoePASsZKohKdto+AxhxZLEE9R4VKtskT96UNmxGBuqMnFruUlBGtZIRXXOOu33DJiMirPDICdIAe2/WMyTXq7K8N1DGzOte+lDNiTv2VCCdP057vRlaD3E3F3Iook3RfF6nS+VFy/uQr8TIw/pymogsttDQfKhFK9FpUP6/7yPfjsKSvb4mrMgwsQxJBsv6bRo+PawqgM1PMlUiItE/RoGbsQzllTGVvCX85aDrrEhMdRMee4h5NkYjoU2zqLwPzRimZCRU+X0csj4W724uJd81UXrhXcqZWckzwzCFBM2y+BaKYqvgarAEm+sUXC09Qx84O7XjbbAIx15f1Gxufv+QOIXjZwWfvHPfz0kHxmfjXSgrsGekHCiovcMXxSFZ+GdC24B6i47dUYdH4dfQVjYqzr3/sCVn31ZHG3yiAL/7XTi3Q7kMmhblv3n0JVsQ3vxkKwk559hxqDWpYK5ikZ/9l24EtJhz/dk0YmrnPOHwtnccnSnhabm41XzWWRzC3OjrW+dyrQQzkU482Jq39q+zWcAbu7RLccw10YqzDOsIe7fNxgi48mluMyrgZ+lSWjCVR6+dzGhDV131zJf1tJHAPPC/ssSnZwMBQQ1XytURhVl6vliKJsfFUhyPkpu6320I+uwZX302n/EOk1NfFgZU5PiOQt+FTKo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(26005)(1076003)(16526019)(336012)(2616005)(426003)(36860700001)(47076005)(186003)(82310400005)(6666004)(356005)(70206006)(82740400003)(70586007)(2906002)(81166007)(478600001)(7696005)(40460700003)(54906003)(5660300002)(8936002)(8676002)(36756003)(110136005)(316002)(41300700001)(86362001)(40480700001)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 20:54:43.7488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0589a712-7499-4b57-e2d6-08db69f4eb03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baskaran Kannan <bakannan@amd.com>

Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
---
 drivers/hwmon/k10temp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 489ad0b1bc74..a79aac0596e5 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -77,6 +77,12 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
 #define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
 
+/* 
+ * AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
+ * Do not round off to zero for negative Tctl or Tdie values.
+ */
+#define AMD_I3255_STR				"3255"
+
 struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
@@ -86,6 +92,7 @@ struct k10temp_data {
 	u32 show_temp;
 	bool is_zen;
 	u32 ccd_offset;
+	bool disp_negative; /*Flag set for AMD i3255. Family 17h, Model 0x0-0xf */
 };
 
 #define TCTL_BIT	0
@@ -204,9 +211,15 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 		switch (channel) {
 		case 0:		/* Tctl */
 			*val = get_raw_temp(data);
+			if (*val < 0 && (data->disp_negative == false) ){
+				*val = 0;
+			}
 			break;
 		case 1:		/* Tdie */
 			*val = get_raw_temp(data) - data->temp_offset;
+			if (*val < 0 && (data->disp_negative == false) ){
+				*val = 0;
+			}
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
 			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
@@ -401,6 +414,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	data->pdev = pdev;
 	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
 
+	if (boot_cpu_data.x86 == 0x17 &&
+		strstr(boot_cpu_data.x86_model_id, AMD_I3255_STR)) {
+		data->disp_negative = true;
+	}
+
 	if (boot_cpu_data.x86 == 0x15 &&
 	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
 	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
-- 
2.25.1

