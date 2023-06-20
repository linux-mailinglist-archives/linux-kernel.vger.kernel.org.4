Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF273610F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFTBSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjFTBRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4B1A3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaGLqZdQUyrSn34bQAA00UCiIxSIrJjTfCNeZh+wdsmMtKn6Q1LuIH9ZS2WH4VtINhpelx6ncqyp9WHx+pDyEx/63GdLjbA3F4W4jZd2tP0zwHPTzRtvdkculEwpEnLvUyJXpUrOOhyTuu+2r2PQCjFyQMHnub2SnN51w8puVGCfGVFV8KZrjD92GC2pI4KwcTE1jz4gSV8TFXeAfgrXi0cswjzJkjqIccFP3wuqk+3ch2G5hB40Wz7iXZTMERgdYHn3X79xNo5q7hSEEaWfqWMWLeQnp21zikKkQpZq6NqNfONZ4L71DLoS5QEB2w4F0Dn4Q3snAq0WPvSneL3gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7qWJ0iKcBH5AScsmOvvAEPpASsgJNPE7K/FjHHYXLU=;
 b=VxSIArXYwrlSzOhnPD9mUZt+APk1z3haZMSD6+BrcfPl9SqeW5UmGLwa6F8IkwLUfKUHChDy8XlYR0IySNuZat5T2tci/zhbs9R1bKxDDngN9Rf2vB9eh2oQ0QVSUlKbtRLT4DN1KKFiW8qqrOsl8fgOH9HJZSF0ZZDMj0xJUPiWarDYH90Y7biIOdQV4o/PHzBXalNS6bPAPi4iZeDbPROCsHrOdufHlNMCC7Wg2ds/mRlTJR81HFsNjsPvyVYxqnlk9MkhjJsDraVg5+9u7oR9e5e/Sc0Jl8EfI3bjOgxTwxZByZepuVzdFynZ8EEsy97IVLdkOmXnjAiu89FjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7qWJ0iKcBH5AScsmOvvAEPpASsgJNPE7K/FjHHYXLU=;
 b=SbT+l55BOgfdunkORb4oXnB5J6O2o45OPbMqi1ZFnPDYcMXlkKIApsTanogXg9wR1l+SsUDd45WSdyPD9O3CCUe+hjsbWT+VpZVC041/7lbNOIlXYU+JfWtCepO2e0xkr8EbBEqyX9YCh1fHIFfQs8tuwGRfay3mZoCRC8JdaCYJTTqrI+s25EwPcSsbRv64w5WZUqmei92K90/ZGguaSz4BzODw6ppOqtgHA3uDUb6Hu6kW1cEuoSTXXTLr2MSC/2vkK2CzSEl2F/evvGPYS1eTPK1lFUUui8nDvJHdL8y4F+9wgMSmMe6pfYoFRiTg33UhF5WjO7urMWIZ7ejMZA==
Received: from SJ0PR13CA0082.namprd13.prod.outlook.com (2603:10b6:a03:2c4::27)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 01:17:34 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c4:cafe::74) by SJ0PR13CA0082.outlook.office365.com
 (2603:10b6:a03:2c4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.20 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 01:17:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:17:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:17:23 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 18:17:23 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2 08/11] selftests/mm: fix uffd-unit-tests.c build failure due to missing MADV_COLLAPSE
Date:   Mon, 19 Jun 2023 18:17:16 -0700
Message-ID: <20230620011719.155379-10-jhubbard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 357b87cc-2927-470d-01b5-08db712c2089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2DJACpwOOaBPQAlSCSmAlRJrd1GxOI+922JxlbOw9HAcliTwUA66JKqeayqI4CG9SW5b/99cU7tu42N+T5lEkMjOTpEbXx2cUEJgfcrBIVZ97juS5FXztBMuph2T5yP3qGTq6VjkRlK1BQiNyJdKNIFBe1R/ln9miwqacuEvolqFehF9eiU8YaMHXNrdtF0S1eTjswU3+rlzIVb04Jsxf2ZH9dS574jNZcGdSQV7I0R+LcvcnQSErD+UaxiCmpOtdBLtJzVwGDR2XbhvOeg/PEK2f7kYKVzsUkuHc4BZ8XvIfLq/tE00xSgdxb7Ad6pzE/27l1nhAFZFLCeQPwVUBG8ixSgl8fCzvXmezEyWeYfT9S7Djski6ayjj7we2RpV0aOcy2NF4PHEoJW3CZc50SDXjzP8XLxzU1HtM6pPE5oJtc2ovZNMjSxL63QSzzX9dE8NCQnHzvhmLn8Hikdkwz2CtMcFekiDT1vF099d+Z+/Fblpckg2OgjLHOankrjDEYYjOKk78tT+JYNTAdlG5klKspUNzK0YKDCfR/KBIr7Sk9BQ4mptj7F4UrdKPDk4faqG64hIqn+WxqtCXXippmcdB8LWlVcBiAiAqSKAk080lB5l8egZJvLU8c99dvlzrsUW4+8/S29ICVrN2LQpSSVFq1yGijlEnTZd3Yv3OiSH4Vdc/hwe0tkoAyIwO96Z0NFCu9XtEWEIClKTW2zxj3htAorBLy5i8hcHIeG7RJajKeb6rBU9qbvmC0638rQ
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(186003)(82310400005)(70206006)(70586007)(8936002)(8676002)(82740400003)(5660300002)(110136005)(54906003)(4326008)(40460700003)(316002)(6666004)(7696005)(478600001)(41300700001)(36756003)(26005)(1076003)(40480700001)(336012)(426003)(356005)(47076005)(7636003)(86362001)(2906002)(83380400001)(36860700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:33.9844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357b87cc-2927-470d-01b5-08db712c2089
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_PAGEOUT, MADV_POPULATE_READ, MADV_COLLAPSE are conditionally
defined as necessary. However, that was being done in .c files, and a
new build failure came up that would have been automatically avoided had
these been in a common header file.

So consolidate and move them all to vm_util.h, which fixes the build
failure.

An alternative approach from Muhammad Usama Anjum was: rely on "make
headers" being required, and include asm-generic/mman-common.h. This
works in the sense that it builds, but it still generates warnings about
duplicate MADV_* symbols, and the goal here is to get a fully clean (no
warnings) build here.

Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/cow.c        |  7 -------
 tools/testing/selftests/mm/khugepaged.c | 10 ----------
 tools/testing/selftests/mm/vm_util.h    | 10 ++++++++++
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index dc9d6fe86028..8882b05ec9c8 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -30,13 +30,6 @@
 #include "../kselftest.h"
 #include "vm_util.h"
 
-#ifndef MADV_PAGEOUT
-#define MADV_PAGEOUT 21
-#endif
-#ifndef MADV_COLLAPSE
-#define MADV_COLLAPSE 25
-#endif
-
 static size_t pagesize;
 static int pagemap_fd;
 static size_t thpsize;
diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 97adc0f34f9c..e88ee039d0eb 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -22,16 +22,6 @@
 
 #include "vm_util.h"
 
-#ifndef MADV_PAGEOUT
-#define MADV_PAGEOUT 21
-#endif
-#ifndef MADV_POPULATE_READ
-#define MADV_POPULATE_READ 22
-#endif
-#ifndef MADV_COLLAPSE
-#define MADV_COLLAPSE 25
-#endif
-
 #define BASE_ADDR ((void *)(1UL << 30))
 static unsigned long hpage_pmd_size;
 static unsigned long page_size;
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index b950bd16083a..07f39ed2efba 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -63,3 +63,13 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 
 #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
 #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
+
+#ifndef MADV_PAGEOUT
+#define MADV_PAGEOUT 21
+#endif
+#ifndef MADV_POPULATE_READ
+#define MADV_POPULATE_READ 22
+#endif
+#ifndef MADV_COLLAPSE
+#define MADV_COLLAPSE 25
+#endif
-- 
2.40.1

