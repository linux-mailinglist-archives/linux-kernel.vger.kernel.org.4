Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7D5F57B0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJEPlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJEPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:41:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729DB2C671;
        Wed,  5 Oct 2022 08:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhCIjnrgIGrD3/ZWV5XvLVnD5qIDnmdKHoKRkcmA+pbra1s+l3ukV7VfaM+ZX5pcGegkOdAq/QIDTD/TTJ/e6tgROZ8QX9cPLqwY6i3cy6oqK3IictXMmk521LijIOqbD20hhHsjznclJZGFZ8dtmps7Ac+uJBd/KvoWvfY8qe3wePlXPQ7JpZ0SxXEm1PC/KzZFkceJs6P1E9JkCDbi0b5HpTktxkP53bzKMArBikvbpEkyd7ME3FtANKMUpP7LL/aIsr12OdcXlQpq+Z5HbhzUG3leBhkTnap4RSgdKPRVny1UKUEkDD6g7ON8Jtc3DZizxKcQv/ard7EI2J13Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4EOvkiYXu8VfI9lSGAD64bCBW/oIM02Ekl4ynw+JMg=;
 b=ddnZ0Z/0/SThVjx5iRNtZC7S7FwPCGYETm2WTW5yJgcBFkCiMvkzc8QzjOh24laGMW65g6I8dQiZvbe9HzsXCVLCQXxCPhBmqllWrRR7nHYcwtSVJzVGpAeJgWlwqG3ojRtVKn0AP8MmyD1ewEPCxYUiXbvbCBMST9qxk6QzPGL4vmSzrTI+k13Q2okzaBafDT1XGSKNvuaFtsQeHRq+Aa6mZ+4UgXm4+etRAaUHr3ZTwwR01BeHbsoBWdLQeZ605qgs302VuaTE/8zYLS3/eLdCKc4e6cB0IUMz998iXUsBEKdEIbSJG6FzLmFkgDfNE2rCcWassMK+N14h7qMYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4EOvkiYXu8VfI9lSGAD64bCBW/oIM02Ekl4ynw+JMg=;
 b=rVOstegB4oIsmFmfzfWbgypqNxcx/vbJx2ODu5qVB1K+TWW6UFnSWZmTBEdQi49E2oEU84DknT7GZriZ+sgNR1KY51GZOUqryTxrvk9nORBZHzU6cpsvQskChewS/swk0teNDTa6jV1JXLQ6sKpvNuLuf5xpbhvAlt66/6aCPzs=
Received: from BN9PR03CA0805.namprd03.prod.outlook.com (2603:10b6:408:13f::30)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 5 Oct
 2022 15:41:18 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::76) by BN9PR03CA0805.outlook.office365.com
 (2603:10b6:408:13f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.29 via Frontend
 Transport; Wed, 5 Oct 2022 15:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 15:41:17 +0000
Received: from ashkalraubuntuserver.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 5 Oct 2022 10:41:15 -0500
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     <ashish.kalra@amd.com>
CC:     <bp@alien8.de>, <devel@acpica.org>, <james.morse@arm.com>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <robert.moore@intel.com>, <tony.luck@intel.com>
Subject: [PATCH] ACPI: APEI: Fix num_ghes to unsigned int
Date:   Wed, 5 Oct 2022 15:41:05 +0000
Message-ID: <20221005154105.454809-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221004230541.449243-1-Ashish.Kalra@amd.com>
References: <20221004230541.449243-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8e2b97-1ef1-43de-d1f5-08daa6e80b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vV7JKrkM54L87TVVqbvizKtb/OsdGtY67Uw+PuHfT/LA5ezUYM1VocaUl5XwpVE3bk59EX/2kwFwNHpLvEQQMahbnrFH0L2Ew6DGmerkIeBtwbJWsHlCg3MtJ/Yc9eOzUTZLT9dsG8hGLQfuqxY1QnOl6welQFJi6WmajcgqRqGL8c9jErsW/R1R6b6Uj3GE6A//Ad1EL5ddYv39RRThWaf7VDwyv9qs8nuko3b5U53yIdvHtRNhluEDMaH161KjouyP4X+TLa0XTdpiV1dtBsklDzOg304SFsEyemgDdEksDUtwbzLBpiIkWH+mQceKu5heuCMNSMiu0Moi+mOwuL4IN0vfq01mBr/FDc5dNFiInxBHhsSfJq+9/k5MYWu8s9cxNUE8jYhv4ifFk6X0Athl8YK17rOaItOJma7At51W3xJsVZpANWUZyIYzHSP4r/N4SpSowsfKi2MQ3+DQ8VQbeHyOviux9d2ekUwfgG/c4rRZzMHXTtmVN272DqAgVmlgRhQSKG19kB4GnMJriO3ddo7j+PnnpYRgMhL1K/N6f4xJwoVW3CytM8yvuzzVd+JObqiu+pCdnWmbfvRKt1DK8DR6J12Gxb693THtMJQI+d2qfbDXGdfosTTDJKJN07bJyd3D8JWQEoG8rCvTSlemk5As4yqPE4l+YMiG6mPE6VpYOcXRNfA5Qg+J5bdfVG/bITC6Y1f1cGu4+aeHEg7JiyOYG1baOFCBciIqb+8kQDb0fvG1tj9gyb9O1JPghHXIq6FgRZdWeyGSrLdPfOAevCSr0Y4dCS+LtYdxc85nRzL0VNkiZkFr6dDd+dE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(86362001)(83380400001)(316002)(8936002)(6862004)(8676002)(5660300002)(41300700001)(4326008)(82740400003)(70586007)(2906002)(356005)(36756003)(40460700003)(40480700001)(37006003)(6200100001)(70206006)(336012)(36860700001)(81166007)(426003)(26005)(2616005)(54906003)(16526019)(478600001)(6666004)(1076003)(82310400005)(47076005)(7696005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 15:41:17.6855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8e2b97-1ef1-43de-d1f5-08daa6e80b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, on one of our AMD EPYC processors, num_ghes is 32776 and we get the following call trace due to vmalloc() failure beacuse of the overflow:

[    9.317108] swapper/0: vmalloc error: size 18446744071562596352, exceeds total pages, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0-1
[    9.317125] CPU: 256 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc6-snp-host-61a51248451b #1
[    9.317129] Hardware name: AMD Corporation QUARTZ/QUARTZ, BIOS TQZ1002E 09/28/2022
[    9.317131] Call Trace:
[    9.317134]  <TASK>
[    9.317137]  dump_stack_lvl+0x49/0x5f
[    9.317145]  dump_stack+0x10/0x12
[    9.317146]  warn_alloc.cold+0x7b/0xdf
[    9.317150]  ? __device_attach+0x16a/0x1b0
[    9.317155]  __vmalloc_node_range+0x702/0x740
[    9.317160]  ? device_add+0x17f/0x920
[    9.317164]  ? dev_set_name+0x53/0x70
[    9.317166]  ? platform_device_add+0xf9/0x240
[    9.317168]  __vmalloc_node+0x49/0x50
[    9.317170]  ? ghes_estatus_pool_init+0x43/0xa0
[    9.317176]  vmalloc+0x21/0x30
[    9.317177]  ghes_estatus_pool_init+0x43/0xa0
[    9.317179]  acpi_hest_init+0x129/0x19c
[    9.317185]  acpi_init+0x434/0x4a4
[    9.317188]  ? acpi_sleep_proc_init+0x2a/0x2a
[    9.317190]  do_one_initcall+0x48/0x200
[    9.317195]  kernel_init_freeable+0x221/0x284
[    9.317200]  ? rest_init+0xe0/0xe0
[    9.317204]  kernel_init+0x1a/0x130
[    9.317205]  ret_from_fork+0x22/0x30
[    9.317208]  </TASK>

Thanks,
Ashish
