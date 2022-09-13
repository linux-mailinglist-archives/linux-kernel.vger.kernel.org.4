Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8A5B6642
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIMDo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIMDoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:44:25 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D480131DC5;
        Mon, 12 Sep 2022 20:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKN6/Jxd94P31mkVhwrAOEZu6BJryXw1nW3cX/PNxEZ4NWZwl7/rKZ9WO/8coxQ+Re+ZD5hk43KxszZ9CjXtJleA6n0n8yMb7n6a/7jbGoEBCPi+GkMrBOsndaYk8fr9zHN7inQoQa1s68ZI7jEi8u+yFFue3S8478Eeka45RIZizNPGhfqJ8VhYxXaaxjtGGA0y67/fX+o/3rsFC4vIyl9PHZNgTEh3l4rbk6wbspiujxUla/Y5OgNK9MgY9QdVX5/5Uply9xHyZyh3TAoooiUBoJhBNs0sj0nZQJeThYnFDjnXfyaQcmC8AkyHGJzZwnnf6TC76NXKYDHkPhkVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev7hTLT83OP4x5hBmVCE99pJHN/eW2TTjGyimGEsREg=;
 b=JlIImsQPmOGyUO04jKuGQApGBjzqaBgItXg8E8dql59grIKf+kiIgreUmEg56EwA7xIt1vX446HEWpuLt1U//D8imC31qRb5FVEgin9s5WrM2bFPtMCgI8SLtHfQAdoq/LQFymYZ05Y5AFT6F11bcU0CIAIKn8rMwamI/sgw3+UtoOiHNhSbADTrsH0/Uf5WlzYaR5OiCCNZJdFRa2Rh++nPnWfXV4wqA0NbBh8QyZFTGottbRXtZvQpUPihrqWXO4N8MPccGX+b+5lwyfVTscGqOeUOXM3Ghf5atnhEVY2cunc0N8Geo8DCMVMJ9U+qwpV/jwa0GM7D3mqNf/e0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev7hTLT83OP4x5hBmVCE99pJHN/eW2TTjGyimGEsREg=;
 b=nzf2542nOafDbaDfCyIxUOAjRgkTgjacQfzG8le/pgKu9TX8KtldBcQo+T11HPBoxDcxa/ljf/GA9rSZMFvvKqx0fEzRakm8xRepST2ZjV2w2t3h0sGX4EsTCCIWZLSy65nROd1AGyUy5MxTOvtSLdBtCjfpdIMgYaeVkD/XgSDaOgmnJeVWoYQUV78ho21ibvo/RWJWJOZkWHDCmfsYPQATu1GwwvAcWO2c4zaljbCvVGZpVz8kWclDmn19Y5KKSRYgLZWyKcACbWQPm5710zlHxRcBuc4BgZLkM1kBZYQWX+z4jdE88zQw7ngjeGt9wli/OoO5+x4t6uUCmjjJ+A==
Received: from DM6PR17CA0022.namprd17.prod.outlook.com (2603:10b6:5:1b3::35)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 03:44:20 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::e8) by DM6PR17CA0022.outlook.office365.com
 (2603:10b6:5:1b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Tue, 13 Sep 2022 03:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 03:44:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 13 Sep
 2022 03:44:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 20:44:18 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 12 Sep 2022 20:44:16 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH] ALSA: hda: Fix tegra hda dp infoframe struct
Date:   Tue, 13 Sep 2022 09:14:10 +0530
Message-ID: <20220913034410.17502-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|MW4PR12MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc6a189-4f5c-435e-eb07-08da953a3dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LAZQlUMI9gZDEO6vqVTvRwr3G6zRzbdKza4tNyYlGtAZTwQjRdqUBrOyp/uQnga9DD/wt/tmgPwesJntQUwE+lYj0tqSYOygfp9XkpfN/tTtqq5Jq+LYdFPGFPciKP059wtAySKvZlJVETQX40e8R+V3a80ShRI/kDDV7th1RgZNZXUmJUxtaH5heKoELd+KLl76GccZ8YKtkzrIvjCwaJLDdt0OtjecN0YPeylWIWyJ4LW1h8TDpxk16JV07f4zyXqGf+hsbzBnpdh53s0Cdmyvq79jNGXhBH4Bc2gzOyrOTJV5Kb1hTx6EnxHwq3edisHLmynWoyPq+jHJyrMZ8UmfIMhviwhdSCqy1eLsdAaHYKHovMA3oCpMdTnbYvuXv3P7X5DHkENydXP/SWcCztYoRn0qlCGN4B2PY5xO7eGVamLu7E+jQL2VvuwtAZYDZD7NUMw2Ax8hsAEMt093Jfw2e0wr9tEXXqlPBCqlJanrCXiMbn/DC5v/CEIiuJ6ppWoDdLiLJ3t2myLow7a3320C8qRoNF5wD9fCDrkePg0gMxQZbL/mp20uDc6/JF+u5IunyQX6XalqKu6tWvqjov0SUV83IO/D290HWZ/TpsKaOALna488vZTfGsO5/51utbqPBOGnUXpxJi8Q7Xpw+SQR6cdNPuZ2DG53iCh1nMe0GiLfnJ7NngkDv1v8rWufqANh1nNmbhy43RvheRbzSRSjKlmwNAh601WYBHFAUNyPaIiyLyiO1f+u0k+6W72qrwbyOE82W2K8Z21LblMIy+JP7tti7EKBv/AeMBuLKw=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(186003)(86362001)(5660300002)(1076003)(6666004)(41300700001)(4744005)(8676002)(316002)(4326008)(81166007)(356005)(107886003)(110136005)(426003)(7696005)(36860700001)(47076005)(82310400005)(2616005)(82740400003)(336012)(40460700003)(2906002)(36756003)(54906003)(26005)(478600001)(70206006)(70586007)(83380400001)(8936002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 03:44:20.0390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc6a189-4f5c-435e-eb07-08da953a3dad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra HDA HW expects infoframe data bytes order same for both
HDMI and DP i.e infoframe data starts from 5th bytes offset.
This hw behavior mandates to have dummy bytes for dp infoframe
structure for Tegra.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 6c209cd26c0c..a52e764db2e0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -218,6 +218,9 @@ struct dp_audio_infoframe {
 	u8 type; /* 0x84 */
 	u8 len;  /* 0x1b */
 	u8 ver;  /* 0x11 << 2 */
+#if IS_ENABLED(CONFIG_SND_HDA_TEGRA)
+	u8 checksum; /* Tegra HW expects infoframe bytes from 5th offset */
+#endif
 
 	u8 CC02_CT47;	/* match with HDMI infoframe from this on */
 	u8 SS01_SF24;
-- 
2.17.1

