Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8D6715CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjE3LI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjE3LIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:08:24 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E500DE8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP62ke7hIgWY7tJ6sxN7YVjBgMR6SOItfZvqG6E7P5CqRdzRZydN20GbugjzqdXAxRuefEa3GtXi4nKS0+12ptaRHWolk4RrOSVsowE0hpvOcHoLyF19J4K2qUwMFc5G+Sov8tIWiPsoUwNYRaPcrmGHQaUvTM+KO0FZ8oYjricmnY5C5Z/thD0Dan5gBFN21rn5IlAvRowCep/kWO/yqocQA8D3EcEXAqf0SZTbgzN4Gyk0W6saOgeRtyLEV2KhDDh0sYQen9r6WD/pVDd58cVliExjgWMwIW7EjvseLy4pAPKzpTiy9ftOadk/Y6pdNojiiBFZEbnbZrhmSwg2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ5E8Mqqi6jmoFputkOrGeuiCt5jREYjAQ7svZGSrQs=;
 b=BI3jpPPMuv0grPOyYPSZe5RSGVMD4mn+i0tUSRHHvMIHt4ldkE1rEkTidosBfihs5KUUe+VBltzi54SEr8+mJ+JGWwTODc+v8BjWYflOZDwc+f9ynrnXvmDCtCp199+xaws2tbi4kQEgrivR+UBGsCmfwigOpa5XWyIlDz3fMHNvTS/MirAmGViQPFVBRbfGUKrFGRnYDlnds8VmB7xwy8aeC0Tq2HR12Iy3lu9cmo0iiOdXDtlfSeQzjjJOK6X1zzS1f2wRFnthWNMCrqC93SSam/esmhtxavhf+g1bXyzy1HxsM5/+ld52Zx/EC0GrIGo25vPvsUr9cf0WnLPUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ5E8Mqqi6jmoFputkOrGeuiCt5jREYjAQ7svZGSrQs=;
 b=IK/ryO0FvcVjNOOmAIYS1kqefs+eaIltli0Cq7wELEPztNh5w3GHs/ZKs1RO+KDF7mXXl6uo2SU9pXcPMEYnnEqgQ3gxJpZmjVJJxbSPkkFb6LrdC8LWeoQL2WLqycVrceCGwzSEMRzyU/5iKEslslmEgi+nE44sDjYMoKCn9sI=
Received: from CY5PR15CA0058.namprd15.prod.outlook.com (2603:10b6:930:1b::14)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:08:20 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::4) by CY5PR15CA0058.outlook.office365.com
 (2603:10b6:930:1b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 11:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.18 via Frontend Transport; Tue, 30 May 2023 11:08:20 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 06:08:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 04:08:06 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 30 May 2023 06:08:03 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>, <akondave@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: vangogh: Add check for acp config flags in vangogh platform
Date:   Tue, 30 May 2023 16:37:58 +0530
Message-ID: <20230530110802.674939-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CO6PR12MB5425:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c12d6f-0a55-4417-9449-08db60fe2d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppnnty37sXuNnyamXrzkNnnXO/iDy7tv1bvxdEyQHxvNYM0OEl1p4UaOUb8XBnnili5uFySWxtRtPcOM9aRqcT9BqKDolsnLA7G9Cql+hswwbA0QNvY5VWMZ3acJ8gRdXvdZyONaQidrF77JEL+Ojsg//Hj2T0OoRAPYR3ugluoYxdHEbspOkCHRmt0iLiAg6Icx5y/gKNP8v+E97Za68qqbmoMjB0/WEp8qrSLiCcY+r7tZClf/ooDIYOqcJ6kB/GHDe3zCTUAwMidWqu3mTZ1IDTll8rC81OjfMWWEoLDpcr9BOu2r3buSLtJGxsA4Bihj4LGVwa6ay4NGgqF/maJUMMKE0iHYO5xrWSuYLSiPCOZa9OUZfotweWG9YhjBV7sJx7wjqz4TPeEgstEa6J11DhBpL1GxeQ0cJKbYPT81RFSxcKZVnh96Hr3pzHIXyKN6Ln6vtyhwgsCmbhVyFEDA0zaHAoDNK8D786nhMb7TfaVfFiYQ/o1dnoZWfMsB1/CgVxaKAHoKQRXtOqGUwPyDCWmcZVqEjzS6E/Y2aLjxeqcIFHHvukpHnC6wliOnnnY5nvz8kXsW+CAG8Rf/bM+5vf6R4ePzRUvMSYs5A2mioPbS85Ns48zC0QPBlEdXoVAbS/uIZwGL9iTfhyvw9PT2holK4ccx5Oc+PfJH3Q0Kh/CkTJ3+xPzmJ0UaMSntGo4YluMaqorb8nUC5b77sKephynzachBpcSIex6kwyQYKc0vNPsrQrQWYBlsJsTq6Akg3z2EawXOhhXdI3vaOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(86362001)(41300700001)(7696005)(40480700001)(40460700003)(6666004)(4326008)(316002)(36756003)(70206006)(70586007)(36860700001)(5660300002)(186003)(2906002)(478600001)(26005)(1076003)(2616005)(83380400001)(47076005)(426003)(336012)(8676002)(54906003)(8936002)(82740400003)(356005)(81166007)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:08:20.0400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c12d6f-0a55-4417-9449-08db60fe2d51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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

We have SOF and generic ACP support enabled for Vangogh platform
on some machines. Since we have same PCI id used for probing,
add check for machine configuration flag to avoid conflict with
newer pci drivers. Such machine flag has been initialized via
dmi match on few Vangogh based machines. If no flag is
specified probe and register older platform device.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/vangogh/acp5x.h     | 2 ++
 sound/soc/amd/vangogh/pci-acp5x.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index bd9f1c5684d1..ac1936a8c43f 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -147,6 +147,8 @@ static inline void acp_writel(u32 val, void __iomem *base_addr)
 	writel(val, base_addr - ACP5x_PHY_BASE_ADDRESS);
 }
 
+int snd_amd_acp_find_config(struct pci_dev *pci);
+
 static inline u64 acp_get_byte_count(struct i2s_stream_instance *rtd,
 				     int direction)
 {
diff --git a/sound/soc/amd/vangogh/pci-acp5x.c b/sound/soc/amd/vangogh/pci-acp5x.c
index e0df17c88e8e..c4634a8a17cd 100644
--- a/sound/soc/amd/vangogh/pci-acp5x.c
+++ b/sound/soc/amd/vangogh/pci-acp5x.c
@@ -125,10 +125,15 @@ static int snd_acp5x_probe(struct pci_dev *pci,
 {
 	struct acp5x_dev_data *adata;
 	struct platform_device_info pdevinfo[ACP5x_DEVS];
-	unsigned int irqflags;
+	unsigned int irqflags, flag;
 	int ret, i;
 	u32 addr, val;
 
+	/* Return if acp config flag is defined */
+	flag = snd_amd_acp_find_config(pci);
+	if (flag)
+		return -ENODEV;
+
 	irqflags = IRQF_SHARED;
 	if (pci->revision != 0x50)
 		return -ENODEV;
-- 
2.25.1

