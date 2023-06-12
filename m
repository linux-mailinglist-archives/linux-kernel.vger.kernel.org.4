Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71A372C34B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjFLLng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjFLLmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:42:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA59F4EE1;
        Mon, 12 Jun 2023 04:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/i09m6LLH6+fAq/6zNzIEJZv15TEDPadO03B7DkyJD9nxGAWzv2yOmjq5Pnd3NSXb/OT9sy32C32qMoxXnHYeZmykFdHeiVES2GpoE7EJwsdVycUjkJIqJxSOwmwwxTZ1pWOj/dZaUQhaHfbdE7vsdgXsubz/R17eXgXkzPqP+TWublARoJcYmMsymbkkOD1G1XnSomyX7K/DQwdbpoNipiYsfYjNexQzN3DTmy07Svya5NKy3mU9OZbtarqTMXmGfYgaZI2IeMNUqteyFsdWfqm2dWHHbNONz3jFsKhgMc6uB8lpS7TZXAI9Y5d+XqHImipmDeNhh8sW423K9WhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08dezVOyliFmCB4PBHoFHMu3G3BJpz2Cw90gGGoJX/g=;
 b=UgW4hP33CvOIqywW7QhyWu23sEABELX97gRO4tN1+ad3ULryt2h1u/e0JM/1sNZ7KJK1yq+T6aOYdXK8yPuVQabRPnTkpkVjM6OUR3InyRowr8ecLHfIMhTtZqWzW5Qjqh5iy4GsSBRpCvZgPXva9dhxEyzs4S63QRKmxfVcb4HyvYWqMjcdHIui+/0+VHgF8N3m75+2xYClBVnJrsbLmJX24eRXT/hnzi245Kiw43cEZTt1WGO65Tk4+Z8SuUwdSqUNM/a9lgpX13LjseKDoClKDRLvWv/NXA+Ow+47573RF5LF1462Tf6LYZRO6iXb8qO3Zm4gSvusskieobgNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08dezVOyliFmCB4PBHoFHMu3G3BJpz2Cw90gGGoJX/g=;
 b=m0eebZQPY9XLzaIRIUWp+MGpFvYgZmAJXp7vmUBk8opWIVenlulX6BJqvVb6Ij6+Gx0u0o9RLsANvUWW/H7HDCL6UoBQ8SGS4Q4QDyDNeg2LLtN9VFwT+2PFyVCclN5pTDpYMhtgYxPFEYTPSimJVj83Vflw+iOa2tnqpXYNGj8=
Received: from BN0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:408:e6::20)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Mon, 12 Jun
 2023 11:37:06 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::81) by BN0PR03CA0015.outlook.office365.com
 (2603:10b6:408:e6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 11:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 11:37:05 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:37:01 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <trenn@suse.com>, <shuah@kernel.org>
CC:     <gautham.shenoy@amd.com>, <Mario.Limonciello@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/6] amd-pstate: Make amd-pstate epp driver name hyphenated
Date:   Mon, 12 Jun 2023 11:36:10 +0000
Message-ID: <20230612113615.205353-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612113615.205353-1-wyes.karny@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f5581b-1df7-4aa7-dde1-08db6b395951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVk2bFUzt7xuFYgfh1435EUBET5zRAaf9j4j8mVY4akYODMBPQgL015DhIBrMgpVctbHvKtHC68S+HR9feIa6vQnvhEL3nrvzmpDESlkmHqXe1lo7j8JJbAC4xH7Q0Y1s/BmwRu9VhrfXefI1jN8DfdLvCnW4qfwyMsSqmouzWU9AuJEayOD0iH9+AJiIHVHXYv9LNrf4UQ1pQ4kGKZCC13qOaBvsgHulKvpUlkZlspzKsuwYLQag7+ISuZdS+oeMVnQeRAeLi7eLQUZ9FSYlxivbdKJHjDdfhsX7UZNJzo5CkAFU66CSjppnmEr5Jp8/znu7h7505+FgOf2jUV9wzpPb+rxGJRm2Rjfkat0kjyia0Wbc+v6TvouhlqxcC/5nCASubeRP0MFuloYNucdA2C61hyUG9iiiEf81EFuc9jUIYaQkODCT0AcmygT3URk3PHGW9mm3R/8Jr2cMrlbwDIz6vV2LxOUSfvCIe9UIyE2qSmvrLny5EZoBDYP/MS7uOXce8E3RJsYOR/s7rvfECkQ8TNMQJB3P53AIgcPUgle3bheK4ru+GLRU3O40cFvkctMEFSQWk7fiVdrT8f9PvzBH7r279AENESWS5LTIgoJtAQd9NnEqvYkHb9VWHXh8xq3UnM1FmlCUbYF9laYJYB2OnESDFCzwqD/EWPoRsxChnD90k0ykyLvD8V9ynvUiMvZnH/nDbSBMmfYl3X2yEDSOnHjy4sQg93p88h7cTxl7hqhYLC4H7SeS+QXcW8+gfmK0/UTFkd/BwYhpvGVzTrhwmpIx03+d4+CssURilE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(82310400005)(2906002)(4744005)(44832011)(36756003)(40480700001)(83380400001)(47076005)(7696005)(26005)(1076003)(16526019)(336012)(426003)(186003)(36860700001)(6666004)(82740400003)(478600001)(356005)(110136005)(40460700003)(81166007)(54906003)(316002)(4326008)(8936002)(41300700001)(70206006)(70586007)(8676002)(5660300002)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:37:05.8590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f5581b-1df7-4aa7-dde1-08db6b395951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd-pstate passive mode driver is hyphenated. So make amd-pstate active
mode driver consistent with that rename "amd_pstate_epp" to
"amd-pstate-epp".

Cc: stable@vger.kernel.org
Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ddd346a239e0..a5764946434c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1356,7 +1356,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
-	.name		= "amd_pstate_epp",
+	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
 
-- 
2.34.1

