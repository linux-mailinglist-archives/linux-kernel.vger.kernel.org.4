Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC367EA4D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjA0QDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjA0QCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:02:53 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B9F88CCA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:02:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOZ2TlMg2xc5jxtutiau0q0bqe9MTfIJGU2bcVKam83fMneI/gSGp/t6ZxO5Go5my0OGAankzeMRw1Fb1qGv0Q0wUNH6zqL9yUtEg6Jp4+R/oflTba4qoNaCYggBti2C46t0PSMK0OpkISbuxIDIz34WIYbQh2QSCwnXgFQzIbadHS2cRXzdv5yg5ZNAmRUMwPEFDPbKcAIT3mcGjKyy5gQ1Hk7CoMz7rBMmPPlRoHim5oyKlUQyK3Ioc/wuiWf47P8YJAKgc4ksqJCEb8xT+B/AGm+rmXfX46H2Y2dHNtqBRUooS1R0aUhVOUtW5vILu5Ta+/MDKbEb8UVR3c3ZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtTA9PwUwiy3U/Dloa2J49BaxS2dkptgUr+JvrRziMg=;
 b=E9iihzRjVwi5jP0kYwc2/fiAtiAErGsd8sdAxbR2KFDpwdQ/5vTN78fBcD+vNa64V/47PBRV2UhDaWz3Ez5HGEz5m6u5aPxx8S+NxaY6CJCsCl4NF7dzksG4K3epi0gOP0+Qs9S+L+niRH4TNpD+03w0rau0BdmRZ6bK9paToXwR/rVEDjkJdeIQd40/GZTAU8A7KbwO25puZmg5rzM2XDFyHREzKSlfkl4R20jvKaBSlueYgLN4zGzSwKvYk8Zs10y3uwDDKuX1CO+RygO0GfWrfdmRrI/8wer6vhyYHs0e01UTbfT4i1o/mWimpSDeLgu2g9KjvnLf9ng6/16pWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtTA9PwUwiy3U/Dloa2J49BaxS2dkptgUr+JvrRziMg=;
 b=SPsjgFbdlI5SO9gCQVx2dnfheOhV9s23ugH1Cc8seZuA0FUWzQsSdDs3poiRmh44mTnEq9KGMyahWJPSLTlGy+E1D3c/cGDtXQyReIIR/9U4pdKo/nEoVjANKDiWhpNL1enabY9K38nzRKnk3wHa9dRJKulMZAViKCiCqIhNtm8=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 16:02:16 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::6d) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Fri, 27 Jan 2023 16:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Fri, 27 Jan 2023 16:02:15 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:02:13 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH 3/6] ASoC: amd: renoir: Adjust the gain for PDM DMIC
Date:   Fri, 27 Jan 2023 10:01:30 -0600
Message-ID: <20230127160134.2658-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127160134.2658-1-mario.limonciello@amd.com>
References: <20230127160134.2658-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|PH0PR12MB5402:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab78940-40c5-457c-25a6-08db007fdc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbGz8Zo5rEYAbgHDFxylx8/egTLa37DtdO9cDrEWSmp94OBlx0KAunloB57is9Y4DEvdEs7KwI1Vbp7KgtusSyCe7Y4JLYE8KtQzvqQGD5bQBpCvPVmUZ152PVyHs1PVrqeQNb5RK5EE6QFW764f6XTlJS3583S37ZPT5L54kakxyAEvHw8p7noJuTH+sxMjdcUMvjNHKFuTq7SrwTnl5BW4asnOlYtkb//sJJv5qQh1+BOTJUPwphmSOlzaEFLQ7IsRM0oD0lx6MXlKcLr2MLQDjpRtG0Heh+k33D83rnf3L5y8yodu+pIjtlKNxNL2Ixu6koOydw7ObKs8rsqzv3tmoZJHmuc4DiaUgP/gZyWZpNcvyeGmVqD2m253LnmAjPIpSigYFat6B0+CHXcd97KwdNzwYiFg35Uc7wwmV5xTJhAO36pT3gIqoCFmpb0xEbJYBkGApnKgTcBD3O/wkoDAouiVoGUbHqW+zMwputmK66f8ZDfE+X3mx+IMRoKJltrrB3+8A+ATT1xb/Jual1d4DlnGAqs+l9fXwK+RJL+WWaU8wadaFrbV0iBKQHPBVuwhhbFNua88EFEz/AimDAcZyWCadv9fyjfwkW5kaW9rQduULgHu98NbpdZUwq/HFdgOdk/SyHPLny2QmROf65rADihAHS6CN1jnPfmun26Egeetx+CiBQii6dfRajrR3f431FfXmcsyA0mu6oJGDvh2TpdJoh707c2g8ubrp9k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(4744005)(44832011)(478600001)(7696005)(36860700001)(40460700003)(2906002)(40480700001)(336012)(82310400005)(26005)(426003)(83380400001)(86362001)(186003)(16526019)(2616005)(6666004)(5660300002)(1076003)(47076005)(70586007)(41300700001)(8676002)(4326008)(70206006)(356005)(316002)(81166007)(8936002)(110136005)(36756003)(82740400003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 16:02:15.4518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab78940-40c5-457c-25a6-08db007fdc12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A similar issue that was reported on Rembrandt based laptops with
low DMIC volume is also being reported for Barcelo based laptops
that use renoir acp3x.

Increase the PDM gain to overcome this problem.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/renoir/rn_acp3x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/renoir/rn_acp3x.h b/sound/soc/amd/renoir/rn_acp3x.h
index ca586603d7203..c174f84650d24 100644
--- a/sound/soc/amd/renoir/rn_acp3x.h
+++ b/sound/soc/amd/renoir/rn_acp3x.h
@@ -34,7 +34,7 @@
 #define ACP_ERROR_STAT 29
 #define PDM_DECIMATION_FACTOR 0x2
 #define ACP_PDM_CLK_FREQ_MASK 0x07
-#define ACP_WOV_MISC_CTRL_MASK 0x10
+#define ACP_WOV_MISC_CTRL_MASK 0x18
 #define ACP_PDM_ENABLE 0x01
 #define ACP_PDM_DISABLE 0x00
 #define ACP_PDM_DMA_EN_STATUS 0x02
-- 
2.34.1

