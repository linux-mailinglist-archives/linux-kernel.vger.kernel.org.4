Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A6570E19B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbjEWQSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbjEWQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:18:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E37DD;
        Tue, 23 May 2023 09:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZpw3xCMy4YKFak0QbfQ+qvj4jTanE62kJPRbyO+BFEkyy44v7+CrshTM/PSZ8n4plvYzMth0UAl6DGJZfu99aFW/PHIdRwhOYrlc9EDFMo41LxY58+mZ/BtT0Lza8h7I2Zn+Wf9tkg0q8oTGuI/eJl0Lp5bR91aH1OrWI5HeEeT/R6TcI6QKxTWggf+Eq2eyF+1ZvxddQ8Rji/oN9IpkLrKtvQF7G0J2X/8vpD+cBkc219Uw9TwmfdTrYLQNzhRlz70ydPmoN+kcOerPssYAGqVoEqh6deK+EV6tmcNkU/sML68WwkO8nwSG4fh/aUa+NG/qims+xDrAxtuXR0MAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtXmwRgYr0kaXFCoj7uImWopg/xapK7mLzVlngMZRq0=;
 b=Q0bE+wZTqG9TULOBOc4e4P0pQYNm/1POaWmxam8xC4yirKFtWskiBzPG4dnZIKss9fctMSx9H+GSRhKcVyazAds4rxrnXzqI4CqA/TLEiVA3cZMNPUbZD1u/ks6GfB7HcBjuq3lzSIcG+ou8wP4wmDDOQX7NqlFzAurIQYmFd/1IzOAK8sv0ykRRKDLp51AYABuRrxl7u3oZe6Hv3C5K7cRQmlH3LDJeqsB/qfOoLSZOO8vHqRsO98bwBlJQtSACSNaGZSLgl4FAiTS4S9EGnewHs1cG9LKn6K135drH6yb4GrK1kssHfwAn3UPf7W8pUY7e4ds/c48w98c+XIBriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtXmwRgYr0kaXFCoj7uImWopg/xapK7mLzVlngMZRq0=;
 b=bFwhmyEz82I9+HmVsc/CfC5lUBlePrDfpMYcvFlPHMBVDa5VJeOfcbzxQMtuvpFOTOjDSdGLqCujg/Oo6MVkLmAKVfjp8cNKVgnUSNAdH1VF+T6kXb+Bgi/j3IRpQ3FfCi+0Di0H2NpVMUyhrxQuCX+wyLEAOYrVGSJudlAVv1I=
Received: from DM5PR08CA0027.namprd08.prod.outlook.com (2603:10b6:4:60::16) by
 IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 16:18:32 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::4) by DM5PR08CA0027.outlook.office365.com
 (2603:10b6:4:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 16:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 16:18:32 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 11:18:29 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <keescook@chromium.org>
CC:     <linux-acpi@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH] acpi: Replace struct acpi_table_slit 1-element array with flex-array
Date:   Tue, 23 May 2023 16:18:15 +0000
Message-ID: <20230523161815.3083-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 102e7f7a-4d1f-43af-a95e-08db5ba95a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hI46HvTZyB3ht6WXfjqu/b/7m4rDS95GcU+6UuKXUtmqv6UL4zPzdaP27O0qBQJrK2Nsvr57qtn5tfByv1X/6o6tp7d9t3m9dV66ts0aEpUQ7WnfTyIs+DeewiVc0OCj+TumjwS3Mc2h6fLFLIWltU9peCQEguxQqZOs+5B4YBAqCl3uEAif4UqPv4MTB6NhbbqxSpU4BUUX6S3E5aRuIv/cjGqYm3t2bbVNUxZ8766rJzxE90Ahu6EofGfs3uDXuWhcrwV+4jtQPPAONmd5QjraLzDO40uQWz8dSXMqohAPUZov3dyigJ9lD6X9UtZUl3tFmf/zdgd/199ilx4btdofoB2SfZPuzQZaty2MZZViVg78t5pmXd0fY7S3qtcrtcz29iEjctmn56d7OBtsi+Zp2o+vnu51pJ9pnr3k1TU0p5lFPnIytZj+xyret5KJ3vmQfyNeO89/E7yeyOhddykomJqlepl4JdqcNvWb5+FNMcaVQYtIj4Z42sRTHQFrvpsq0LsSr16mI7jlOpS4DqB0Bk22MebugF+NVsDoGHGz2CLu95PEBNQzFiWx6YiTJIT9XmT0TtfpExBHz/uGOHl20zf4+kIqVtiQjbGYtCQ9rtCfqhDBdcRQp8BzBv+cgobkEKXnSFOl2MLqSpb63KtKn9IbzhfwhTiP18pB4T1bREY7WfaYdWMyNo7SWJlvnmYzXp00CeFHthKYBHyDA4cqhW8RNzjJCYBG6M/iDarYWHFUYM7eqZ4FUb/9y2T2e/4c5QGyVZuC5AS+/EBnMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(44832011)(7696005)(26005)(1076003)(6666004)(316002)(40480700001)(82740400003)(81166007)(356005)(8676002)(5660300002)(8936002)(36756003)(40460700003)(86362001)(478600001)(82310400005)(2616005)(36860700001)(83380400001)(110136005)(54906003)(426003)(336012)(47076005)(2906002)(4744005)(70206006)(16526019)(186003)(70586007)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:18:32.5807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 102e7f7a-4d1f-43af-a95e-08db5ba95a5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct acpi_table_slit is used for copying System Locality Information
Table data from ACPI tables. Here `entry` is a flex array but it was
using ancient 1-element fake flexible array, which has been deprecated.
Replace it with a C99 flexible array.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 include/acpi/actbl3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index f51c46f4e3e4..000764ab3985 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -86,7 +86,7 @@ struct acpi_table_slic {
 struct acpi_table_slit {
 	struct acpi_table_header header;	/* Common ACPI table header */
 	u64 locality_count;
-	u8 entry[1];		/* Real size = localities^2 */
+	u8 entry[];				/* Real size = localities^2 */
 };
 
 /*******************************************************************************
-- 
2.34.1

