Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ED45BEE50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiITUO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiITUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:14:52 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D613E9B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDL/O1IX9gR92l1KMmLlE3bE34QY6yPMNimSyBSxJq/D1BlUDq4+eVn1ejLMQHGcdLw/XkjEVb7pbtVN/9PghxFI4GkfhT0eESCOj4HrioLSJkZXEOnX/TcRfAanBfIJtndMiHWLX69Djl+uISsTDvceqjloSTM02sznO4Omy33ihu2bblQgNgN/LxFFRm2f1CDT9Wmz4KfNCQhtn2PUldV0hM5IAAdl4xmt04eODnqhvRS8A3zy9qc9eO8SwZIMKOfLVRItwdzIyRdQYLLAhRHgABwViSKt2bRdSyy8+qUsyg7kyAK3CKSj9K+owpypOrzrpjj8bByvTHYvKzPnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh2wCj7T0acBU7P/TwlkrC10HoHpBBI6sjMzDPqAluQ=;
 b=KrFM+mS0NU9eBN5vYuBKetffwqsVq9CaLLrS0SL2sLegMAxSEO7vYj6GOYJLb6MkCe7xTur1IBcVBYI5mU8HrlX3zXobreLa6K3r8ZQGaNw8k+oGho8T0bOXMQRQ5Y+huawkuj0xSHJmXwT9yiwd8o5Zv3A9lhTJA1sSU3ahU7GyPlrrXIC+ThhrPsZiY2uhw2gZjIenvGEYsoVHF7R5zQmUQ25B2ASygPNpU0PaLtUmIe8sz88HeWUh/L2i0Z/tuh1LqYU4CcfHk0B22oDGwTHWpo60V5Omb+P3WdcgytWf+T2ZQojHvuBJutH/XRU8Fd9sRH85jdwG9LhvU8dvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh2wCj7T0acBU7P/TwlkrC10HoHpBBI6sjMzDPqAluQ=;
 b=yG7mOnhPMiFkK2bdhTM1Z0UVUGud34qO4Zgyb+DNeFMwHVyvExGk58Ir+zeNFdLmOhmCvVq2QTiukqKo6yIBIe2KFfG8tskP2/bhPPhCEoAy68mqpAUv+kgmC043shKyLEtvW0LZZbBLefXP1h4lp2U7BvR4ryNYvy6y03AdNe8=
Received: from BN9PR03CA0869.namprd03.prod.outlook.com (2603:10b6:408:13d::34)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 20 Sep
 2022 20:14:46 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::6b) by BN9PR03CA0869.outlook.office365.com
 (2603:10b6:408:13d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 20:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 20 Sep 2022 20:14:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 15:14:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Travis Glenn Hansen <travisghansen@yahoo.com>,
        Sebastian S <iam@decentr.al>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add some models into acp6x quirk list
Date:   Tue, 20 Sep 2022 15:14:33 -0500
Message-ID: <20220920201436.19734-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: fb509b11-d90f-46fc-dfac-08da9b44c33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3Am2qqdeA/HZdjeu95+3jgyZwHQQH/sY9si0o1P6W5oIRm+VrquLmnGPVjxblpN/LqluGcLNEwJHUc/iKTu8t8DSFf/8ggKPnuM74u2XtFoi22V9nIYaKwJHpSJu99SdwZVihmODBLaktCm/QZB3gb5ZGl0PgnyAMkTWxchYu+XuLhQDVAiVDAxu5mL+phy/GMO0Um328A25IFu64KcWPB+eN6S0daML72Vp1b4wbIw8tx7cSnfUi5H6Iw0n15/4Pxk20damSgibar24yKkvBGHQroMSG8BqCocWfdf+J8IDybvhBAofUDV725FFWyir9HzznRJxs2iWdBlYYNKlyk62SBb5zNADUabyNDyNYCi+uuZk22ne4XxAUalIgjGSIrXiUbMwCdu6W+aFu/B95p819KdLxLYRhCdFwSLbMyWv5L+QehR/TTIxZII0vJZVpmI4y7rDdyIABthJFONcVnx495c4UtXboel2g9+PjdWpq8fq+SOorKeeNiT6GsqGmEYQbXxbonYPrXCyS21OOlVzymDnh4AkiHZcg1NH51jk70WD8Q8ozF04NZ2DnKgF5Jyb6HfPBhembjGmTNaRcSH0SBQM/11fbB8+c9IBonjmJTVb4guCB+UKoiZdEfGhTeLhpjKQxWgcR6WvhfHi2pZ5QfnyJaPhpAk/yHR3Fs0WqXzmvMHHtstgjaHZEJ5CVCdl/XmTMFOxOVeUb+7znYfQmuKCF6qB+LzsDkvBRA9wrPPSk9lADfD7MY43dN6YzKIupyShSn/XdWs/cPy5JdBZMsm7jyOLApBkBO1rnLN2H3hm0kyl8QKzztroe/dsvLWpz60rao87ayIw1Nymg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(82740400003)(356005)(81166007)(6666004)(70586007)(2616005)(8936002)(186003)(36860700001)(82310400005)(336012)(47076005)(5660300002)(40480700001)(86362001)(54906003)(40460700003)(44832011)(478600001)(426003)(16526019)(1076003)(6916009)(4744005)(36756003)(8676002)(70206006)(4326008)(316002)(26005)(2906002)(7696005)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 20:14:46.1077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb509b11-d90f-46fc-dfac-08da9b44c33f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622
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

v2->v3:
 * Add my missing S-o-B for 1/2
Mario Limonciello (1):
  ASoC: amd: yc: Add Lenovo Yoga Slim 7 Pro X to quirks table

Xiaoyan Li (1):
  ASoC: amd: yc: Add ASUS UM5302TA into DMI table

 sound/soc/amd/yc/acp6x-mach.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.34.1

