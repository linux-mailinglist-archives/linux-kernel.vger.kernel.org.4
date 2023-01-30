Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491E3681DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjA3WIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjA3WIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:08:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0080D31E2A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:08:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtOQp8jouvrrPcErNM2Rt1dJ3yuEeWrZEzNn4rHMgKzIUmWJHe6iBxribnrVnMgg9p3C/IAuOVqiQ1ygd4l7wl0iDPvRRoNJmSbe3xDT8f2DDhNXsSskVsCqI9LDXsBU/Vb3/dACqH9mNX+G4+eqDcCqujhhqUw+6w2JgNlA8Udikeh4+FUtwI6BPLNVW0WqXJv0kkf1Y2LkApvlmxv6+Yr5LiYBEfeoii+3l06N1O5PA4ab0ozOfL+4AdspqOm6UAB7+o5gILTcKFw9kjjis4QRIxI0IL3ArVXYyjSiqtYCK7P4YwowzN1inKVsQrpmPTj7DmBwLUZwly92iWFENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtTA9PwUwiy3U/Dloa2J49BaxS2dkptgUr+JvrRziMg=;
 b=aE4yMrfoQlX7d+CwZQYDgX3ba1wDsaCzx9aKRDzfXNMu9upA3w8pSZ3SMVodYWMVGsQpQmMil5v3iZN8yMHv0ldRkRGBMkc5Wn6ZmMcVKoGB05RIMO9nT5JC2D7J4QJzXRpY7ba3Om29OrS3fWQ1rc/wq/oUJPkLSq41iNZDlCh5CIlvu3371MuYVfKV2b43/BsdDxN/T19rutcXTOWfX3k4lMJBGiUz+TpfCl9zlTndNk5GqmE9Dnolfqv/lLEv21vMaffjIJf8uAsts1CWzQHqIELC1//K7ugTUaGMDpp4/JA4tIvSk21/Ui79vLY0jvJQH1nlcmMohDQy8KYj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtTA9PwUwiy3U/Dloa2J49BaxS2dkptgUr+JvrRziMg=;
 b=K3TkAfPh0rctCleBRSgiJCqyWFTaBFeT2LouDHKX1iM4DI/zAZBCr1FCiCsencqaW6V94FhTuR97nFzSuPsdI01jQkFJUJOSwcJ2p7P2vGuwyLgkFyvj3ysMCjYvXIO5AU1hFVa7mxIAnS3LDF0YzZX3kMEYBdoHRVDJKRHthog=
Received: from DS7PR05CA0014.namprd05.prod.outlook.com (2603:10b6:5:3b9::19)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 22:08:10 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::7f) by DS7PR05CA0014.outlook.office365.com
 (2603:10b6:5:3b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19 via Frontend
 Transport; Mon, 30 Jan 2023 22:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 22:08:10 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 16:08:09 -0600
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
Subject: [PATCH v2 3/6] ASoC: amd: renoir: Adjust the gain for PDM DMIC
Date:   Mon, 30 Jan 2023 16:07:51 -0600
Message-ID: <20230130220754.8379-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cbfa7e-4181-47df-e55e-08db030e7961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LiYR4PX+DloZQF6r1hDkYXQGFIbdZU6nA6ldSYmDcGbUr0TXvM1uFxbXxaaF+IWLELBzZ1YdsOaX64vUZkS9gPltaHAq5dfh27Xuo9z85i0VCvuGsC+0rskgEZ9mnyGAH4anFrgefr184QS0uqK8ASLdYYDyL6bJ4KSP8Q9m6H1ORrOTyi50rtKpkq4lKqD2YtAVR2n/zr5AmhLMv2FFShbk2d9Sg467noTnMtj9YBhgTRbUam3kzWAdwct3jv9q8Z2BhzBtLDK0OjP9YZZlycGvM4u58HKO23RkKJzg3bhtBj8rfwy8KuKKydf70SnU0Y88OkXkDnWGMyglwFbNi4DGRi7BzJz20lfMORicEHPBM+7pLC9aQErv4pq6Cbr1JNXg/k92Cvjz5XwrmvEBjNudZt8UNTOw+SBjG6+oGDIgtDR5Z+DyZrdIFUFuSEP3fSwkAuAg9eRVTDmL3tEWKrpVZyA+1cX0gb4Cz7EYS5y5jxKlWjA4dewubw6zqraDasYljC908EUCIlTJSw2wa+Esoc5cIVVKK9sgqYZdl4gFZ+z6GGYINmwCW5OKfMgpEaI8baOBFlzA0lBB68K4+Fpy8NLGdUGP/8Ia4UoXUOEZciokCibK+G+H7GDdzxqy7SXvT8qLLKERK5mFllb03pS9TvmpknsTtCO45gzSp4vzUxdLuTFEdmybldYWrrEofqSwWAM084S2JB2qrTwgd2NB5685DOAjKAK24FwtSY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(47076005)(7696005)(70206006)(8676002)(4326008)(36860700001)(41300700001)(8936002)(70586007)(336012)(426003)(83380400001)(478600001)(86362001)(2906002)(316002)(6666004)(40480700001)(82740400003)(82310400005)(1076003)(81166007)(5660300002)(16526019)(44832011)(186003)(4744005)(356005)(26005)(36756003)(110136005)(2616005)(54906003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 22:08:10.3160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cbfa7e-4181-47df-e55e-08db030e7961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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

