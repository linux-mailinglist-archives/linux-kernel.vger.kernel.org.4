Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF81C70B519
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjEVGd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEVGdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:33:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34439B;
        Sun, 21 May 2023 23:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqZ9EmSXUB2TnwnYlA4G0FdF9z/vfO+fKsGcv/gm/wvqfjETq3t8g8WOTvj99sZA1U/Phn1R+RvNmjU+OeomdQn40tpqgKOC3Oiy0p3seaY0HT9LPllzxCWOGrcvjkAIjXr0E8W6ZPuldYWszWLk9kOTJZ1Gsw28Fa7PyXmVee6QpWSKi/JUYK9/zpYWdAv5kJnG1+RhvcSOBuSOkVgxNMhRx2VP8FUEl18gQXgDxirhFUzNc2kCixtAIXokERgfMUMwaq5OfW5aakSIKnfU180YKMXk1DkMbs10a2nVj6Y5uXcZ8pZichqonGWss95tb6MpYOelsswlDvrPM7Ezpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scsB6jiqpDttYKZeh4iNtEIp9JIeI5nfSIdowqotk+8=;
 b=BWs4CyJ63KTAV1G79JEfBbZt0/jPHzgHtyAZOrwCsKtO2OYHzgih311xMM+A/DA6wCaqLktwENJEUo3/qY7ggCWb7mTafKy6bQ9e8LYdR37ewXWFfecRK2rCXHLfJTGrlb0X7ZmKZsTEr8DHYgmEztVsANf/oLJPhkKesGUXtMSTu8PH0eHIlRfm+O0ATLB+FDVxvERABAq30ap2c9CZPTum5FBgZ3RXvED6uVVtWaISZunGkyFvQwY/ByMDTkpJ9bXUtYdeQoaEO+pBzrZL9hfSeyDe8Xxo00NrBMYjV+ktkX+sIq1eFMKnQuvHvCeLW9lEKFJxyHPf0a6RiY7OfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scsB6jiqpDttYKZeh4iNtEIp9JIeI5nfSIdowqotk+8=;
 b=SNUhwu02rCyyFvOD91noO4g3l1Vxf18ndoUsRSBXm+UzeGRPA3COcobKtWnqQaFXG+UPVJG1EytdQRrNUkXn7QOfyHvinmlR3yRz3djyHJpzvjm5O9bARNkp+HNvtoyl63lSP51qnw4kSFAbgCdverf9FMN4oswA3/Ta0tlpv+8=
Received: from DS7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:8:54::12) by
 BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 06:33:47 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::5a) by DS7PR06CA0037.outlook.office365.com
 (2603:10b6:8:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 06:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 06:33:46 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 01:33:43 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <Mario.Limonciello@amd.com>, <Jinzhou.Su@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 0/2] amd-pstate: amd_pstate related fixes
Date:   Mon, 22 May 2023 06:33:23 +0000
Message-ID: <20230522063325.80193-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|BY5PR12MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: bff0d857-67a2-4177-6f1d-08db5a8e7f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjfc9nSnxc6TulzPvZ54ztdAyw0m4XTCb92n6hrEP2bkr1cMnuOJUzn0rkOK3OJek44Dn/85WtweupSnPqwIGYZwrOO84gzg72ph1LnQA5qWRdIdWGgf/cJP6q4rbdRp2IEgAUMcb4wa2CEkJjkInKBRq3oYqFoygr4mRY6tE5J+RuV2QoQdf1iaGNyQBcgNyfTaE/jH11YnyMKCm4IQO3lrwU1RVc23wwMVAgYp3S1JCg733iF/Enl6lg4zyyqmlMTN+ZjKc3Bt6b1hlU5xJekarrK4irQav1jFDNCxX1IR8VZZVkH9OoNduOvlTqByAHW6S6v6qn/TGQNAHD+DlhivnKRdObGuo2nhZ0RnUenpPQlITB8lksHYBmJlLqvHE6T5p374SENNkPjmg9w3kzJ29roW56hbbUfYer+RxsEvvcW5frH2M/3Roembw2NOVLx8M7Ug5twXa2CScF5J5xntp9CanI3zeC6t+yrjB1I5ya9hrnN15XR1Mu5g+VKESKwpj3eNeXQ0fkzWAoBnb8eA/WAmZpgHzL5siTBygB/hFPCLNctRU26ehy46ExxrbXAUkfZQToZiE9jg+dLsZkZwuhI7alDjN/scvtQzdrH9RcGiAzoPY6RrOjEufLS49mXHT8rbV7ctDQ/SSI/BDLJ3XPdhQVs34UaVck8hQJapEHw5fxny24k2hbcdP2yXOrMFHEQhHcEILYS+NSZ4cm2DbUSiuwyCa6PzsysQa9aVPaHvSqP2r+RdtHSEU1LCFneSnl8GK9Aldb3P0+oYs3u1gB5BvqpkkfVsyotJUN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39850400004)(136003)(451199021)(36840700001)(46966006)(40470700004)(44832011)(5660300002)(40460700003)(8936002)(8676002)(36860700001)(83380400001)(47076005)(2906002)(4744005)(16526019)(186003)(426003)(336012)(36756003)(2616005)(356005)(82740400003)(81166007)(86362001)(82310400005)(40480700001)(1076003)(26005)(110136005)(54906003)(316002)(6666004)(478600001)(4326008)(70586007)(70206006)(7696005)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 06:33:46.7422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff0d857-67a2-4177-6f1d-08db5a8e7f27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This 2 patch series has the following 2 fixes for amd_pstate:
- Currently, amd_pstate sets CPPC enable MSR for a single CPU. But ACPI
  specification recommends driver to set CPPC enable register per-core.
  Align amd_pstate driver with the spec.

- Remove some extra checks for active mode which are not required.

Wyes Karny (2):
  cpufreq/amd-pstate: Write CPPC enable bit for each core
  cpufreq/amd-pstate: Remove unnecessary active state checks

 drivers/cpufreq/amd-pstate.c | 64 ++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

-- 
2.34.1

