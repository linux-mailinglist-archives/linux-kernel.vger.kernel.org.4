Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3074BBEB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjGHFLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHFLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:11:20 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91221FEC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na4MrHjU4VWguws25sygKQRrLtTx7HFnqc9w4fzZmcbdynOF9oAAJ7dA23rFca0nr+SmSHgsbb/kKHkEztN6759CfXZ3YL3qApx2oGBdPi+5/MvTITSup6SxaU5MJy0GrfkuwHFTmUWesT4xk2a52mG3OLAD5MTCLr/bCvLoexN/CKxe2l1lvwNakKDGWDc9stTdyckD1OX4ctAndYQO1lYIVeKquQVieio9FTz+mLyDLCnOQUCzWN02BDNOd4wfMBOH627h2hmETEaqt3tEtIWRxgbp3iTQDiOoFMmt94jmwayKNhYe7y9xV+hTge31gVFUy+8EgfqZItBktaskaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5Dnu9iQZyuAdIIXTmz8i9e3lYvip75UtZfFO6Xdr0s=;
 b=l3DAiK78tVTawOTBv4smQTaJFzx5Qb8V24MsinZkcvFhAe7vdVaEqB3EcaImAbaU9NCosCxc5OzfXOHhvO+ipYfTmzovhMz+WNKRYzuyYD/AqcddyO2pqDiDR762ybJ/W8DfG/NgdfBI082HTknoO7nfFLWbhwgOLLNLlfthS0Zfc2UQxUNuAto/brc/Q7bkGYgr761SGBkuK0rQTSseFaQ2qcPAva/77An64AfNv0+VCaHKc19ux3V0g/fVTo+8LyGMPOWFl77V2gOUeqxvkWUirKjtDYo8RlZd1OIYVrlW4Ylzojjmabk6MIMJapLaa8egsOPaMxCdhLwTHEavDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5Dnu9iQZyuAdIIXTmz8i9e3lYvip75UtZfFO6Xdr0s=;
 b=4W7cFyWOiImw5V/4vFqfpxmaa7yMVMnYQRHSfkxZIBfQZNeqJcDvbsmY6F/odt+UCTPTLRq0M/qZqKTiyj5nUv5hSdmmxPb+2CigrlW17jb31FlJ+X4Ijj56LUkwuNETM4f7MU6kCwMpTCvfy+0DqpHoFA7olHD3uZxegn3PL3M=
Received: from BN0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:408:e5::8)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Sat, 8 Jul
 2023 05:11:15 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::3b) by BN0PR02CA0033.outlook.office365.com
 (2603:10b6:408:e5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26 via Frontend
 Transport; Sat, 8 Jul 2023 05:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.30 via Frontend Transport; Sat, 8 Jul 2023 05:11:14 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 8 Jul
 2023 00:11:06 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <Syed.SabaKareem@amd.com>,
        <Vijendar.Mukunda@amd.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH] ASoC: amd: ps: Fix extraneous error messages
Date:   Fri, 7 Jul 2023 21:52:08 -0500
Message-ID: <20230708025208.54272-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: d92ab2a2-31d2-45d0-3d97-08db7f71c10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/DvUEjAg4opJ7AcfxJ9Jpv/pXXfTFVBsnTOljCfguOTu0KCNdbCP5kzOppW0q22QIb9fZZRmS1gU+v8IL1Izmqe6P+ddeK3hP5LDAU38FPIPNFZmz4VRZ7vKia6rEnQ8LwCo/c2eF7G7u5rINvp931w+oB3QfiLyogQIKsnLO498h88XmA7Exzs8Dl2FX/BPqKvOw9K9GiuO0cW/D3ckBtkQXUdB7vuCvYqoAVG/IgL1kqTT0WQTiv3rSEEWb4vWXKGqlPZSZLwq00WtsXahYSoB3TwOCZNBMk2+qRjeimi5118mm9skR0EnGiZ+9kCfdcPUfS1BZ21WNiP1EFEJ919smife7cnnxMReQY0d5drMplEoLDRt6yamuWbqYP/ILkAIcGFRnZde8dZQ6TD9BUFEAmduL9sN6ZKf2/QQXCJFM7qG9PNCCzzQFSw1HLb3+r9Z6VO65mVvrFUJspqsxl5JCfSm8ixpnoyqa+Pveyw+d8p6qe06BS92vR/MSqf+54rFGRt2cuQXkLMwEMscUISpo15EA13IEG01uWGtKdRyBlNz3wfGaPimVceWHX/zP+VGilA9ergQm//ZIHZ8v3B+wy8UG8PYsS2bQhvLvD7mchZpEe7A1HccqXimVnqzebjx9AHchG5n+eNh41T0Dx4z59LrX4he/XkAnyoYYBjA/aVcQqWEW+CCdPpBQGaqfRISgRqPH8hAVK0AaTlNrjNj5e06nGc4Cy8MqWSOCZSZoDQavUsWzd0YNzklAbhcntpnK+koCC3FFMV/vPGWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(2906002)(82310400005)(356005)(40460700003)(81166007)(82740400003)(426003)(47076005)(83380400001)(26005)(40480700001)(2616005)(186003)(7696005)(36860700001)(5660300002)(336012)(1076003)(16526019)(86362001)(8676002)(15650500001)(44832011)(36756003)(110136005)(54906003)(478600001)(4326008)(6636002)(70206006)(41300700001)(316002)(70586007)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 05:11:14.9516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d92ab2a2-31d2-45d0-3d97-08db7f71c10b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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

On Pink Sardine machines that don't have SdW controllers in use, the property
`mipi-sdw-manager-list` won't exist.  There is no point in showing an error
to a user when this situation is encountered.

Furthermore if the machine doesn't have a DMIC connected to the ACP, there
may be no platform devices created either.

Downgrade the associated message to debug.

Fixes: d1351c30ac8a6 ("ASoC: amd: ps: create platform devices based on acp config")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 5b46dc8573f86..4af3c3665387d 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -257,7 +257,7 @@ static int sdw_amd_scan_controller(struct device *dev)
 					     &sdw_manager_bitmap, 1);
 
 	if (ret) {
-		dev_err(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
+		dev_dbg(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
 		return -EINVAL;
 	}
 	count = hweight32(sdw_manager_bitmap);
@@ -641,7 +641,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	ret = get_acp63_device_config(val, pci, adata);
 	/* ACP PCI driver probe should be continued even PDM or SoundWire Devices are not found */
 	if (ret) {
-		dev_err(&pci->dev, "get acp device config failed:%d\n", ret);
+		dev_dbg(&pci->dev, "get acp device config failed:%d\n", ret);
 		goto skip_pdev_creation;
 	}
 	ret = create_acp63_platform_devs(pci, adata, addr);

base-commit: 8689f4f2ea561dd080118eeb05c0255ac9542905
-- 
2.34.1

