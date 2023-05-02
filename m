Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD106F4942
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjEBRnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjEBRnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:43:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F78EE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHtlXUquzRcL9SiiEVZIS72h1+6fCeqVq7iFH/oEUN1cX5IFo+8+YfP5SnNDvH9AQQHGPqIi93zeL5TdLrXFkBq3bXz3LuU2RbT7Mh8SU29ir+mmBjXT5DX+R7vID8TCNMzfRL8Zm8xmT10oMiQvhw+RrY+4UsNNMARO2U2K5sApqlGvbHY3hr2VX8hmtmqAcDUss+58ZHYCoodkPyM7zY4tiMCYpXCtYUnyrxsBc+KFQRABDHrIQnyi6MQGzkh/hP27FJXirTZb2zntlzP2iNw8dnDyTHoqBU0ODinm+x0A/mzyVyxZXfj2ltJVnYPMrLK6AH/3tGTwPsefZVSxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/mFip/kfL4IEkPaUnnVV4EiZgY95eLCyJmNjatX2IA=;
 b=Y6t3gbVD8779nY1zdvO+aVseIrpWzRl6gMwN9ozh6pvuey3cudAqpN22XDAe2a/pbxGl3j5QkK5oEmJQ3CaYmdj8QdzeshwgbLxPA7tCmHyQlL0xrbnFxp3z4IJU3Zy0bNcO6NHhsxVyqtsNDF9VTNvVDGrvwL3aeKU2kzQkY7ENQnRwblo7wDNW2ll5Pcux6fUwd63EnwypsfcW8NcERPm4SRh9LDz1aT+XvICjs4KcRozGYYcGlFV2lUNSzUDSlrmquFfk5tkfoaFqP1egv/7PieMEE++ebGWjw5hFLTrp4PWn8KHc4RdY7POH84PobTi824YkI//WR4QW2pNUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/mFip/kfL4IEkPaUnnVV4EiZgY95eLCyJmNjatX2IA=;
 b=KCIdHvA9Yi5Zb0PjefxWlIQO3C1U+gfUG15LoT8DWlalnr2xbbIbKtjsuptdOXGuhYydk7W1qdtjVC93aC+W/Z7zPBHuE+O8ZWvJleZ6dgEu4cYfJLfpEcuJc3T1diCCsUzPtsiBM/9pQE0SUCJ6d8jUur2BWDvHAzDB6CgBYv4=
Received: from DM6PR02CA0051.namprd02.prod.outlook.com (2603:10b6:5:177::28)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 17:42:52 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::35) by DM6PR02CA0051.outlook.office365.com
 (2603:10b6:5:177::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 17:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 17:42:51 +0000
Received: from wookie.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 12:42:51 -0500
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bpetkov@amd.com>,
        <nathan.fontenot@amd.com>
Subject: [PATCH] x86/microcode/amd: Remove unneeded pointer arithmetic
Date:   Tue, 2 May 2023 12:42:32 -0500
Message-ID: <20230502174232.73880-1-nathan.fontenot@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: d66cea7a-ba29-4fec-c5e6-08db4b34a74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0WqtbLxrpgk8mJ1WVb5FU4XhGUgKDTjGWTyY+45nA4qKrY3L4WM0GskxHNyDgC7ytCEglh3YPdTW3UZkXsmtDX7NZD2JTnmREd9UPZZYvhGmM8BYxtgtoVKxnehVwQqmWlsm9u+0+j7hR4dc0TrTYwqZE04N0pE016bwUJCISzPr7kOCKr9NvOIMVUe9MKljbh7kdfGhFXdxpJSWauZGO0ybyudJSMleG7KI5BfPeIY7ZIfriRLKIpdX2A+O0yhNxCbsrfnqczCNtury4hSd6LGxz3hcFXosbcb2IiVy5nSbJtC7o/AL1ebtd0zQRUjD9+EV/byGUwlWRldvdsRt7GnWXcFeHJeZWSz0pPoKEtxqJszr9O8hOiI7l5+uISv5HP+1HOZannaZkozdPtpKFj526SicW8jg9ZfY6tdNMERNfGQ1cPnUMOq+xU3d8SSbxYwdJOpbs6BK2jma0pcoTFGH2SEArUJzWJzP/qfHXTOHzoL4Vdp96MZ1XxXk0NzN1PQ60FNXzZxngINt0YDO8FyxEUgg7E/a3L3gYIhdgWu3SeOabghtVS0+PrJry/Hw5ukShSWfzEF3AT3U1eNcAZGiqV9Aq+Z0H7YTIrrboUuKYU9ORO29gxZSFl8tN5Mo+OIFW/G1wNb3B/ZYIr1SWU4dhCijgO1I2lp1NICgajdXBNngoA8bm4oSOC5rA32gz79FLuXC5GZ1Aoq3Yb32a5cTlSz6X9bQT+IrNPnFH4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(86362001)(82310400005)(81166007)(356005)(40460700003)(16526019)(54906003)(4744005)(44832011)(2906002)(6666004)(478600001)(40480700001)(36756003)(7696005)(186003)(1076003)(26005)(70206006)(70586007)(83380400001)(316002)(6916009)(8676002)(8936002)(5660300002)(4326008)(41300700001)(47076005)(336012)(426003)(2616005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 17:42:51.9681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d66cea7a-ba29-4fec-c5e6-08db4b34a74f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Fontenot <nathan.fontenot@amd.com>

Remove unneeded pointer increment arithmetic, the pointer is
set at the beginning of the loop.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f5fdeb1e3606..0f7cbc2f3a95 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -78,8 +78,6 @@ static u16 find_equiv_id(struct equiv_cpu_table *et, u32 sig)
 
 		if (sig == e->installed_cpu)
 			return e->equiv_cpu;
-
-		e++;
 	}
 	return 0;
 }
-- 
2.25.1

