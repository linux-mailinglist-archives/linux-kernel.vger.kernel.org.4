Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B55C5BEDFC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiITTqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiITTq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:46:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE186CF71
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0CX9lnzkldffKZDtDNxwgvuX/N2NAEGGZkWcVUNKmIcLItWUBf+nEbesIC7C3mcBcf7ia+wJ0peIx+kDP8Cr+/JqOmRms62BGE+REz+aXPsxnRp3zNMuFjBCLZc5Ma2e7sKZCVI+jNdPRfZQDYt9UD3Oc9HE5+KcX0kY5nxRchlmvbwj96vBOkD7YVO1Y/MYDbZsin3HQcBRWjypb948Y4EkI6VNGjwxv05kmAGZK3xtDWTPcbIFr9KoKYRiCkJCQbY3B+nD0cjbV8pPDoDhLkkI/poB72oKfS70Y8TjdAben5QMYKqjGihyJR0cSM+61L5zUFiVxTxqmMM07FkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KETA/lfNuwdT3pbVjMCGv3Uttsje02c/enkK/sbHbls=;
 b=a/QBMOBcwMTBmgWJUT8Bn9mXCYdD06VmhKXvEQuKkmyYYNaH8Kzx/6SQNn7okIzdwEDgV6YQNK7TjjQcHMZyVVtyXYOwuvTvwzxfDPsanYvNVvuNUwVQCcTah7XLOb11HYSrOQBweUXcaBhKt98dpvF5WnEKiSN8WA8GrQ1F/k4s5nsnoFAQP4+wrIUyXEZJcuBsszKGOtIQQnPa5Udce0RLhpslUXy++GRER+bqqMz6QcTQ4pY5vvc/A6wMuyfvLzYTUCD5u8UE6Zm9+N0MiManzbOX82NkzTy+Pyat0OAozfkot7VNTwCCCo9TuMisDPaYCtO0unyoYfx0sL/ScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KETA/lfNuwdT3pbVjMCGv3Uttsje02c/enkK/sbHbls=;
 b=oy92gZ2Md81xbSNsOEQy1XclqyNPOKJirHU1K2F/kgOFCFCPPA1dxPjV3iApy0buQ2weJV83YEAQWn5pBBeOpJdCrBV27AikczEKkO03Yngx/vYdAAIePdrK/oxrnCspiOJ5NrtpfedMZT4WO2GT8LfDnNkgStXhbieYqEyJtqs=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Tue, 20 Sep
 2022 19:46:25 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::8b) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 19:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 20 Sep 2022 19:46:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 14:46:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Travis Glenn Hansen <travisghansen@yahoo.com>,
        Sebastian S <iam@decentr.al>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add some models into acp6x quirk list
Date:   Tue, 20 Sep 2022 14:46:19 -0500
Message-ID: <20220920194621.19457-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: a500cebd-a260-40ec-3310-08da9b40cd44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07afbfB+Ymp0ORIJChlaW7Gz/1ij421/JTrGeaLSHnYE8iH2x/4DoZP7o6NyjaxNRg0ZW8zKEX0hselVnQPSyMX0P5OjOUNdmON+7mkywdyff1Dfeb38DCYSr2BcYsz5hw9EKBJUcEVduuDtrdupdAVLk/8NBckR2r/hgR5JfC1bu/u/8TpY4AziU5ak5V1YBLTkZiCicwCW2t1FmXVwGfpjhjNbkYhL2UMBECwkPGatuz0cDzdM8qy0o1M0qwf51RCUbJo3u4yhyKYlnnyI3cVlh+s0v7aiAZZBkM7EwyPaqJC0Nn9ZfQ2Dm65UihPyVcqvNfB77tgv+NR/3dNhCNsg5RKpyZ3/ydxGrWoDuTYhrPZ+dFC6A5mf8JH0keWSHoBjKmhktG/lA44EE67t0Nr6WSKeaCU8LpETqMhVgvRnenxHupm2Ht6+W4X1Nl3BrFGLN902UF7tnuNTh0MoEGCAB5O41266VF6VxY1f86F8UP4E0SFWfXci6zmkWvMu/M4Gcu7Lza0ym0pYoI1CoWZSSvyd+vhkywmHuR47nwM4ycQ24O2s/VldDgaax+CPf+IabEy+MSr7VzbzhuOHDyIpe1uRWKWdg9nc8KRd4DpzzxI87bT91QFbR24HpBWh0Iznzzoi5Zj2O2V5ZZqKqGeJFfWjy/esPszA2qcVyM6olXpyLpHCi5EvC8UwEktBzsS2K3DZ6bswoj87CRbZLryLpc6z1vbXRFuJrP0uImqu8xPOSR3CwdRZmk9T89N4ZbttUiW4SzQe5trhQ+mFY5nGsjNfdZF+hGnAwSCMf00T9MzWSEqp+bRyOMMghK+ROPjoUt2kNzkhyWqLkKmlWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(316002)(36860700001)(82310400005)(426003)(47076005)(2906002)(4326008)(8676002)(44832011)(36756003)(70586007)(70206006)(86362001)(40460700003)(356005)(81166007)(82740400003)(4744005)(478600001)(40480700001)(26005)(2616005)(6916009)(8936002)(16526019)(336012)(54906003)(186003)(5660300002)(1076003)(41300700001)(6666004)(7696005)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 19:46:24.8638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a500cebd-a260-40ec-3310-08da9b40cd44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another model from ASUS and Lenovo have been identified that
don't include anything in ACPI tables to indicate they require the
ACP6x DMIC driver to be loaded.

This series adds them both to the quirk list.

changes from v1->v2:
 * Both models were independently sent in v1 but touch the same code,
   so v2 collates them together.

Mario Limonciello (1):
  ASoC: amd: yc: Add Lenovo Yoga Slim 7 Pro X to quirks table

Xiaoyan Li (1):
  ASoC: amd: yc: Add ASUS UM5302TA into DMI table

 sound/soc/amd/yc/acp6x-mach.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.34.1

