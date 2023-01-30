Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FDF681DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjA3WIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjA3WIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:08:10 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C515C305F9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:08:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwIqQ/7J/TlEuluJL4GVWJO4jTZrP0z7QsJCb1ypyUwos5O/dLQ+ZRgYJKpkJgprWPsS7jRrACAOVSaMw988SHzMxV6I9ZRgmOfx2/YCYNjZfJBHzGLO68EnGBlXphmKEEDZghLllzNOFXBnk1kpcxNENvFylhAA24yOCzLJM1Qqsf+1jzvrPFTQFhrcFCxqEX5CPYLDikSn46BAf4f4FCTOgUN0w6v4y/mdmyWJ7n5iEcVcqmo8TwmHjeMSqumSIoaMpeepNtulOyqa0x+2tbdK9rkp9wNQdR7I5PipAeHNsy9A4cIbrZHJaye0+yn0BlSzWVqydmh1taF1jQWJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aKmvnOZr7+ZbKfC741aJVN4sW9FPDgnJEvlymWjFz8=;
 b=D3fgKrv7aBecg75BEnDwl19UZwIoIEnoTMbu01nbrzBIW6Y/kGJX6MzmpxOx+xFuHnavt8/zHPvCO4K73Pc2o11VCt9tG5KGbu5vzLX2S/OUIKJA9iXuPF5bhlbCboZbMCyZxcH7l5OooepuoUfYlS+9hqRZMp7ONOBy+Y90PU0F1eo/OfZxlwWjWKOSiglfDQ5F9eK/fmLIT84MDylkiWzOO8ufHMViE3/CRMLlHn9sbPYli39Os9ZgJxKwB8MZfj3zvybJ0YqTp+fUzyvEbcxmuj2JQ1+POAr8fX1zqC8p+qRBGLczwUBIau4LGdhZUxr2qzcqgylnh50Tt4NmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aKmvnOZr7+ZbKfC741aJVN4sW9FPDgnJEvlymWjFz8=;
 b=hyyUCFClvEV8t8s/O4+mUkMt/CB93Aj0ms7dGmRBbYnhgKz60d38tWG9TBusCxfvQ0qM9blkhym+9rUlrIOGQ+wW5bcbC0GSpNHYYWocLglz55mchvET46aMWMEVyLRIxJlDSkNyFSsNTtHNga2ikUdxb5hwhdeKPwqfwqcmHLY=
Received: from DM6PR06CA0096.namprd06.prod.outlook.com (2603:10b6:5:336::29)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 22:08:08 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::35) by DM6PR06CA0096.outlook.office365.com
 (2603:10b6:5:336::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 22:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 22:08:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 16:08:06 -0600
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
Subject: [PATCH v2 1/6] ASoC: amd: yc: Adjust the gain for PDM DMIC
Date:   Mon, 30 Jan 2023 16:07:49 -0600
Message-ID: <20230130220754.8379-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130220754.8379-1-mario.limonciello@amd.com>
References: <20230130220754.8379-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 95617e9a-3206-4a55-178d-08db030e77d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpKOmrSsdyLwGrw6Wv+QTIbz6N9QXDTdbuRSybMJ8JQfSY+s+FGXQQlMRRF6L8ONYWPzyocdzvhVFt6vgzU7GGuOL3lhpz6bz6FlfuVrgz0PxhmPLXf169Ni4JMNLAuqbafcwQnHhqtZ4n0CPztFyuTTMylPdoG9rhgMxq/tyAnTXRr+VHTjmYtzYUHC2U6MVqbYs5o39tnrODVGhE5JVQntzkv9QYTGSwAmgE/Gd/Ic7FcH07tTj5hi0wYuI0JtxiyVlKUBKk/ADMlg8gAWZdslPTQZU/kXc5o2avXQQxy5eJZi+jPUDnfdehV0ClVN1xEsnyeUCglxPk3R+RI/tDXW9KnLfZcfJumM6nSWU+NFElGrsmbHNFF3pQTagZl4kQsm0GnVFKsZ1WzHrZQOj13fQxJ0uZ6MkT29Y+dwN+p37UALvljwj/NLqVgRtxAkU4lzFpFnCBW1wchqAxCwmBiIdh3oREjb2WSnJrSRqLbFBn7FSIpYtgiu/g8NWCc+u5J+nExAS+Mr306F1hYQEI6HAyPrNiCrd1pEHuS0Q4OeXIEWGzy8TZ/z0KQBPmjE1Lh9iCHn5nU8jg+E1l6ZOWpe3DghCgANdgR2vRmrF7EZH29OrCMmwcgRPhltftFQQV5XDpSwcPHqoN5fqGBSN7seveSdxCosncBnw04U0guiv2Uom7OrmHa+PKqGx+CXMCDUtB0CpasmpshlsKADQKnDCSyGb5yr6Gsr79u3RI8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(2906002)(36756003)(86362001)(82310400005)(16526019)(2616005)(26005)(186003)(70206006)(336012)(4326008)(70586007)(47076005)(8676002)(426003)(7696005)(110136005)(1076003)(40460700003)(6666004)(478600001)(316002)(54906003)(81166007)(82740400003)(4744005)(44832011)(5660300002)(356005)(40480700001)(41300700001)(36860700001)(83380400001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 22:08:07.7155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95617e9a-3206-4a55-178d-08db030e77d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of users for Lenovo Rembrandt based laptops are
reporting that the microphone is too quiet relative to
Windows with a dual boot.

Increase the PDM gain to overcome this problem.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/yc/acp6x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x.h b/sound/soc/amd/yc/acp6x.h
index 74b596e6807ad..846ca10e24d3f 100644
--- a/sound/soc/amd/yc/acp6x.h
+++ b/sound/soc/amd/yc/acp6x.h
@@ -31,7 +31,7 @@
 #define ACP_ERROR_STAT	29
 #define PDM_DECIMATION_FACTOR	2
 #define ACP_PDM_CLK_FREQ_MASK	7
-#define ACP_WOV_MISC_CTRL_MASK	0x10
+#define ACP_WOV_MISC_CTRL_MASK	0x18
 #define ACP_PDM_ENABLE		1
 #define ACP_PDM_DISABLE		0
 #define ACP_PDM_DMA_EN_STATUS	2
-- 
2.34.1

