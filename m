Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB09F736107
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjFTBRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFTBRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51419A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlvJv67lxOYFQcXQ1l/j1w2GdPy6UMW0Z747ygdko2qaam7M6UmkKmD2bPjUOhpUTVh1Gjb2ehFayqX7RH6ZNAsNr6g3U5kiRgnX4fbQp5JbLoEO53/vJx2JSdC9R78E1Mn6dKUr2HuTXtMNECOrwqX/lQUrjACfhM+7F3M0CDre9SIBJAp/prTdqctyNf5meYHUnfSET7BY5YE5JP9xV38aB1y8+YyQP35XySptwo+oeAqzsxU02SuHSBbNHMwrHmbQbGKi3x9Z07JE9Oj8llwLHczzzjRqeL5Wd9gfyfB6kht8p1X88XPIj2EcZWsvgv/YFi0ocvaiI/437Y6ayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQZhGUwkoU04C3ryaMpvsp8ELkjH/HHSIJHZlngWhEc=;
 b=fif1m3bUE2JzsfkjvuwZPzE/DpcJbA22WWXwovqKtuLSWZfGMFWTlYKwg6QXROyOjL720EuDZick404G5rrD1MDCzh741qRumv+JYXzXXx10BauWleodrIfxfd2fB5+9HmVEZkimXXG6AgpPn8mv4uKvP07VHomvKG+4qOWtNj35qpmJYfCfOa8kAFJ32tuPzYeI05PJIMzwxz7TGApUDzecFnmp3QX6Z6zjYNUkcmD65GwZtR8dLz6qQ0Bs7fl3YfoZuB/DcvNdrcKApNbOTrNXpcUB9B9ZP18DPkTxicr5+6WALs+vIAB3utrg/QeeGf8XvZfMpxjDbHDnJyKAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQZhGUwkoU04C3ryaMpvsp8ELkjH/HHSIJHZlngWhEc=;
 b=DuFfD3/+AK6g1xZB4WJ6v1rZk72ET9aSyc037210l3K4drrCZL2G8ID+qYWzWT7DqfTTf0/lvGYDNHZ1J/XxLYnKarM9FDSFpvWFMPxG/s5lvRBY6qfzal628OHxgUGVydJ2VITPpUbB3x7sSaWElfy7gLfUzSnILHk4in9DGHSr3/KB2R86XsrhBa0cMkqkpiO2r58KyhVPJKvzZIy/lXjwB2sKSM9JFtUcggD7JhwuQg9WhiAhhhZ5DpaRHhbKVWcWLq9i5LIGeiO032GhmCpnU51D5Mh/wYxbDEt4EwDbzqJG9A+rPaw1ysl+SzDSCERQi6iAo2zfVuivVvUExw==
Received: from SA1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:806:2cf::18)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 01:17:27 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::ad) by SA1PR02CA0007.outlook.office365.com
 (2603:10b6:806:2cf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Tue, 20 Jun 2023 01:17:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:17:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:17:21 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 18:17:21 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 02/11] selftests/mm: fix unused variable warnings in hugetlb-madvise.c, migration.c
Date:   Mon, 19 Jun 2023 18:17:10 -0700
Message-ID: <20230620011719.155379-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620011719.155379-1-jhubbard@nvidia.com>
References: <20230620011719.155379-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a834292-c643-4a9d-dceb-08db712c1caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyohEzqtaKpeQcuMKVUtYdyEL0NrUli5DUZW5KA/QcsRw3PjayjMpfi3Tk85Rzj5i7lsmDIegP2WV4IE6ymUoOh1sto4GqNWq2J8bYv87eysj3PH7rfgVjsv/AqaJmld2VpBXnUgfBIfmBM7I0VB7nxcfGNGGuZcGsM+hW65vVJ5EWCxmwvY7bPnAf9T91VKEldtDUc0/4qlomaF9vAwfyN2RZnPzzGPGZ/zjZcWFtxMPetjam6eaJV+8Qc+gGEbCDUsHBNkXJJsyTvh8e7TyuLJw9wjaoGS2kvJy0aDFSjCKKSaqlf2/E117rBC8dBfNIZSVRMKZWQfRXz8cRWOKkDz63NGY+XJ4bMA/jTWFfE2FyYzx6+4JZ43fKwKa4RkxtaVixL0ypeFcrDlawHxevlQ/GoytqH+1xfJ4BhYMV9B5xtIFvmgHfTQr0Dqk+fmjjdg97Dh61Wc0QBlHjXlRQ0B9PE51uacCUpbvlYVve/aavrSmI5IBoFpwKDMweyLVH2CMr7Z6l36L3QjRfg2p6u0AdBY5fqaigsPR59mk+Mstbg1+K3nnhJkGxNRvb/DLe4a3bJmryYX9ROnvU2j0UKAp8fmBAu/39ETWDgFqHuBbLJJNXA5minUAZ7rIqN0oNJP5ExJDgBJWJAUoH8QYl7JrHGTIN9WRrMWmyUXxjx0nHB1v5RtSkCWVJ9obdvK5cxJrUkJ2aNm5DayYE3afQ3LocMb5Ob4rzTO/e57WhJsQm2jsdeToCAUzmMr1izz
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(336012)(83380400001)(426003)(47076005)(86362001)(6666004)(7696005)(7636003)(356005)(54906003)(70586007)(82740400003)(110136005)(316002)(70206006)(26005)(1076003)(4326008)(186003)(2616005)(8676002)(8936002)(5660300002)(2906002)(40460700003)(41300700001)(40480700001)(36756003)(36860700001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:27.5266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a834292-c643-4a9d-dceb-08db712c1caa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dummy variables are required in order to make these two (similar)
routines work, so in both cases, declare the variables as volatile in
order to avoid the clang compiler warning.

Furthermore, in order to ensure that each test actually does what is
intended, add an asm volatile invocation (thanks to David Hildenbrand
for the suggestion), with a clarifying comment so that it survives
future maintenance.

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/hugetlb-madvise.c | 8 ++++++--
 tools/testing/selftests/mm/migration.c       | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index 28426e30d9bc..d55322df4b73 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -65,11 +65,15 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
 
 void read_fault_pages(void *addr, unsigned long nr_pages)
 {
-	unsigned long dummy = 0;
+	volatile unsigned long dummy = 0;
 	unsigned long i;
 
-	for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < nr_pages; i++) {
 		dummy += *((unsigned long *)(addr + (i * huge_page_size)));
+
+		/* Prevent the compiler from optimizing out the entire loop: */
+		asm volatile("" : "+r" (dummy));
+	}
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 1cec8425e3ca..379581567f27 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -95,12 +95,15 @@ int migrate(uint64_t *ptr, int n1, int n2)
 
 void *access_mem(void *ptr)
 {
-	uint64_t y = 0;
+	volatile uint64_t y = 0;
 	volatile uint64_t *x = ptr;
 
 	while (1) {
 		pthread_testcancel();
 		y += *x;
+
+		/* Prevent the compiler from optimizing out the writes to y: */
+		asm volatile("" : "+r" (y));
 	}
 
 	return NULL;
-- 
2.40.1

