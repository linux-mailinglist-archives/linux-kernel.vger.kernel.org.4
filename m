Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF16D2644
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjCaQyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjCaQyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:54:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F8FE04F;
        Fri, 31 Mar 2023 09:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIHtD0MI0ji6RMLzCDHW/vAmcSjQrcGsl5pgvIoQG+H4SXKFJFJsSfN4uWNTiHC7xBh1jHHVDxVi1YT7WXlmtcxcNneGJEBs5nnf1l80hx05pmuXPWzlntUnQmW+VncO44rW3rmiyEdQINHFV8RbKYO75ecCdJKqZPKq0IeCnd3vNo1EO0Rq5wFdAzm5+LoTniCLrN+LpThiIX51HlV0IL6In/IDoQQeGEerdjrSLoLRAUdgYuMfaOloAB03zWQmAjAzw9RU9GCiQHUEwZbfJhRYqaz42TK/29I5h6zE7UYXDf5wPRwpNzgrllx0UvIc8N2Q3OeaRG8NfBOgsXGm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcGd6nphsQKWLYKsablrYt5t0K4UQVmlowFKDJ7H0Pg=;
 b=ORTArhs1TxFpHarOJJSdUzRuh94pfPRIQvI/qPLV/zDWxIpj3dGcpLtVBOkWtDtrXOhV1tCTf7AtgKJBHovb8775aDAhD62ft+0B/UOCgLiAsHDoM3EZX+dCi4dWbIJJerbdd7zYOxMH9AfM9udLQZ+FuNcGULwPzx8DsOlLUQOKLRD/zkC6pdD6HLmJTtF7/LSlYdrTp3g9gN3QdiBCV1JdDmxrxl5aBazMYdyzKUG18xuBk5NOxQxoadtugkCrn0nXtThV7qsLMlRz3PMvpd9CvaJcUKCBcp3gzhxLkFya4jcnLRGJzRf7mWRk7FZbx8S55tzLXJeJGCcFHhFJUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcGd6nphsQKWLYKsablrYt5t0K4UQVmlowFKDJ7H0Pg=;
 b=cUCtiaEJa0cFhlFN92UZPNY0UVqmz0PzOnWeELx7FgOrstmnKGiiiyvkFyXsIkbTeZnAMhMja+6vsLA6J5hujBNEUR5F8J92ry7yy8AoocVpVTwaWwsi5hXv8VJxiy6f6mbbNQ5uaiTuax1ou9mc8oFBeIKwriLnBF6uvS4W/Rc=
Received: from CYZPR12CA0023.namprd12.prod.outlook.com (2603:10b6:930:8b::19)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 16:53:18 +0000
Received: from CY4PEPF0000C96D.namprd02.prod.outlook.com
 (2603:10b6:930:8b:cafe::9b) by CYZPR12CA0023.outlook.office365.com
 (2603:10b6:930:8b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Fri, 31 Mar 2023 16:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96D.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 16:53:18 +0000
Received: from fritz.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 11:53:14 -0500
From:   Kim Phillips <kim.phillips@amd.com>
To:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        <linux-doc@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Kim Phillips" <kim.phillips@amd.com>
Subject: [PATCH] docs/mm: Physical Memory: Fix grammar
Date:   Fri, 31 Mar 2023 11:52:54 -0500
Message-ID: <20230331165254.207526-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96D:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: abd276a9-11e6-4981-311a-08db32086dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SR3tp1oa7SAN2dLjHqBPKIYdbafOP137PS5AXHaPVb6jHiITIS0GNWgRilivb+yn0mrlzzcRZtYvSNADWs3ei7QDoNoimQa0z/bJ23G6wSybfH3Jq1/9ziXQfCrpM4W4e45nuk76lfrmgsYDYjNr5hEfYqPYJk4ftBFnParEYW1S/dCtokHBB1I7ivjEuKi+DzlRSeGf2Ye3XbJhR9GAwpEGqbbz3Ma34LZPx4OH9wSGorDdT3eAmscykzne4EiC4FbkfkTjg7jmsyrde7yzm8LazECDIgcM8Ai5+W8m9r37ptiCTuESsbkcaV4LZtuQ1spMzLiYPs+B9GfpqGjzH109Lszw75t1yJFPRSLUPlauQ7k3ZfjP1gzFZSUOHKX4mT0i5ors642IzmJsZxrM0amVHcvzSzh3pmWpjdSP6k/WgvWkG9RmdhvllB5FhtRsMV7/bwhZf/MBda1vcGgNezQx+8dQ2zRbMIxkzxclaoOe0gam97uI2XK4fBGk14SP/tgZMtbI/OiQrPL30EG8Fqhw9Rjsk7O3y5YNb5cWNz1ewyaQ8x9gORV9RAehktu0hm6kqfLJgh5JUk3r9NjBHFOCMdiyy8d02l+8TzMLnT+m6RlBZ9HFi1/yqVK7HyIc2B8gUZMvxLtkkedMR9PlKFrhgpdaC1f4E6m4UrqK4cBavKtB2LNenN/L5+Xh3UOVJJ/tHgb/CeGlhVJ9BXdbeSEgZqZp9izHiFMWO7FjB+E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(47076005)(83380400001)(16526019)(186003)(426003)(336012)(82310400005)(26005)(1076003)(7696005)(6666004)(2616005)(36860700001)(54906003)(478600001)(110136005)(8676002)(70586007)(70206006)(4326008)(316002)(81166007)(5660300002)(8936002)(41300700001)(82740400003)(356005)(86362001)(2906002)(40480700001)(40460700003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 16:53:18.4533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd276a9-11e6-4981-311a-08db32086dc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it's -> its
referenced to by -> referenced by

Fixes: 5d8c5e430a63 ("docs/mm: Physical Memory: add structure, introduction and nodes description")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 Documentation/mm/physical_memory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 1bc888d36ea1..df2ed81e3639 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -19,7 +19,7 @@ a bank of memory very suitable for DMA near peripheral devices.
 
 Each bank is called a node and the concept is represented under Linux by a
 ``struct pglist_data`` even if the architecture is UMA. This structure is
-always referenced to by it's typedef ``pg_data_t``. ``A pg_data_t`` structure
+always referenced by its typedef ``pg_data_t``. A ``pg_data_t`` structure
 for a particular node can be referenced by ``NODE_DATA(nid)`` macro where
 ``nid`` is the ID of that node.
 
-- 
2.34.1

