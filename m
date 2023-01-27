Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E695F67EA49
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjA0QDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjA0QCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:02:51 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513A875A0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDBhVDsfVBfFXyQ4YndsXWkTGIp7O6BvH43jHc/YgrgrgJq2OX+Vo6J6CfQcHsAi6HkVy73pfDwY2aeeIJJv9MyfcObthd88YZ0fA5IdelO/dBQMKWIlIHaCADtXgf9A2/h/pypEGAy13RWd1afMEqKb22sqoX3wFwIWV+ooPS8a5OMk2j6VWZYesEsiprTlrPBVrKEbUef83dvKqUHj9iHQSkCd8UIJjuCDjr95sJ1zhPUkmy5CPRSn4y+p8J8HBbNhl/zv6h9n4fxjpGC0YPJuSIIHDqUHU5UfDN1RctNk4coRHWxUkK/9AvHH+HZog6eO3a4MhIJkR6dsTc/ToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aKmvnOZr7+ZbKfC741aJVN4sW9FPDgnJEvlymWjFz8=;
 b=Oe2Oh0Fc+ZR118HVUHudiVzG0sUJ4ACmI6I2hsXD7JDZWWH6VCv2ZpPU8TvUgUnE+iXaLX5yOFMNZVZpeQ3CQx+KNlc/aghzA7H7Tk8EugcGy011eFcqddfheH24xN/qURnpPgCqEgnjMjI0piAzD/+xj3dV8ufE+XYWdz/h1liPlBNbFSVqPho/bpPgBPQwzFZ2uHHS736krGggZPcFLzGZYdwGCN0+FSYdf9I0SzHhzQivQZMeHcIP8EypT608+6ZJviGca2ZM3G8HY/yU4CN8moabgsVI1rarUGhD0JF9XaNjvDMfRJOz8vchSk+wwvme22KL5nL+zhKto7LHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aKmvnOZr7+ZbKfC741aJVN4sW9FPDgnJEvlymWjFz8=;
 b=WX9mSArnq8oY+6KPpY6mLjqp1wKviwQ7kMyczaBF5X4sqVQQI370AJsmK8QM3FNPa+4K2naMhT7HLx7dB47IoSZ39W1Q9BIjp/34B8+IRbUZPsHZ1VnvS2cCRmigVKDPHGPCsboQngShfyuaDYi4SunDEkmWx96I35UF5x13dDI=
Received: from MW4PR03CA0166.namprd03.prod.outlook.com (2603:10b6:303:8d::21)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 16:02:12 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::82) by MW4PR03CA0166.outlook.office365.com
 (2603:10b6:303:8d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 16:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Fri, 27 Jan 2023 16:02:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:02:11 -0600
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
Subject: [PATCH 1/6] ASoC: amd: yc: Adjust the gain for PDM DMIC
Date:   Fri, 27 Jan 2023 10:01:28 -0600
Message-ID: <20230127160134.2658-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f7a0b2-3758-4f37-9ce0-08db007fda24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CN5ENAAd9PHWnVnQPeNPo/pEIUc1XIeJuWnEhxcwCryFjfDPRQeJJLytLlpQ5SH/aF7lJt4vjUna6xX7z6aXanPQnGNsgk93A6j0rAFGcW3jjr4DibHSRp9G/M5jN5Z/ztWQVmkseQun2PNLjc2rVTmZPWjpjAxcwFJJLSerm6FDEayiBX64T9/sQzz8xgNcZQWk6WKSxuaOd9Kp47nFJJDYI5vTZHX50lUfPdcy54+/eGQ9b6NmwBAKdvPvGJEVKs5MuH931ysb+kbc/nH2oG7vBrnPsU7DC2+gofpODfmJP0YgsPtTpZztvMV81Gkb5RHP6nHG2u6X4zIRTXyge7SnmxE1a0TkWg7GFEFSbaEJMFz1Kuw85hgh0+Ng92Y/6x2+ig8sq6Hww1KApHn8n36GrkNg1NSC26Wn202Jb2h2XY351oAK5QGn0AVwD9reYwyeC1U/HNXMFw5D6CDJ77XVXKYlVgSUQUbe0DBGO86sSG38Q6nT9vpN+Zw+ZEchErJ31tswhuPLnU6M8quOqlBJjXHo4ylFXDBb1PcjidJh62yfsvTL1oycnz8yCbPuCFo9CYhX1jcNw9Nk0LK9gNcHnuTLhco0ZERm4/v9IHBE1m1gbbwvEGNBuUhtzGU97Uu7uj6pLhoUNJo59RO7LHj7HRlHKdJs8iVcyIcNlSCPHgOKJqBvFHf/lF3ixWbvtx2D3WnhFo1cLcFxYkhftzrcOY3GMcOf+DJmsOXBT0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(46966006)(36840700001)(40470700004)(1076003)(44832011)(2906002)(5660300002)(4744005)(41300700001)(36860700001)(426003)(47076005)(6666004)(26005)(8936002)(336012)(186003)(478600001)(2616005)(16526019)(70206006)(70586007)(83380400001)(356005)(36756003)(40460700003)(82740400003)(86362001)(81166007)(316002)(4326008)(40480700001)(7696005)(8676002)(82310400005)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 16:02:12.2173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f7a0b2-3758-4f37-9ce0-08db007fda24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074
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

