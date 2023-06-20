Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A3973610D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjFTBR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFTBRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5856C1A5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+bfb4+wOadMyFziIn9B2YE8uJpjiHGuVQ3aGd55Rc5g2EPFMMpFXztZ+1l72Zdb8PW4Zc4Dih1M4qvKdNTkFrgTr60z9QOWH/NzYFm/UQstKH2Pw8/x0eumqPJY+7dgbw48TIFdiaOGRGfZ7C1Xy3GPwjD56pDfzxQOc3WhDbxf+XrkKSsVnV79GETnSs22fNxv0wnheZgiUTqiF7P3Pobl7WbxdQNPTWkOpaT5w4ACHp16w3kKKavCFd225Z5wGkzTJ4fkAFas7PBZL/VDRgUA8NX5MI0BNS5F/5xAV4RO1bRKlafOXB+he5srHqBJuaDciwVve5a8jl11hE0xOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DWMqFfWmcM0S74ipR90Z5t8Em5oNzomwf7Su2Dj4R4=;
 b=LvK3mJ+f3wT7/B3h0z2DGxNsDCK7MeEkstwmZRKBC7OZ9cXAvBPeNhj6/xlIE1EcxQuM9bY5KvHjd+oMfrbvj8EO+iFuddGRXR7/SBFnES12fEX8ARgQXbxJXBDWiYaihpQ3IDQfl8hnDzFQrIL42HcdQg7urDhkwydu708oNF3MChKrDIXZKjh+PqUp66oQc+6TvFKDBBZi6lvdoEwzjWWbEYbJYsBjnPdlFjw0aJsRjbtuW44vvdUewkj/eanF195acFwJOMcEwg6PeC/aU5nQkIwLmR13ZH6ZfUepNRtE/2TeCcUWn0URTf9ZR2Hv2VP15F/IQDwg45pVJ2GD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DWMqFfWmcM0S74ipR90Z5t8Em5oNzomwf7Su2Dj4R4=;
 b=dpy1OEzJSDw8Yk1kC/IUWf461IjLK7tcw1vpOof2xtGTVXKuT6sGqkU8birP62dvv+gcydMKUItT8zO/kOOQXnnEOdSyUblfWJTWcepm+MtQjfwH9Kr87BXZO4O5hPfmtJ1x0nfECc0N6HkpOEfe7YuUkGdX7XpuqxEMb0mKeeTVA28PhuoYGGkA1Qzf8qnZFq/NggqN10fKeuVuyZw3ZVNa0BPBU+gDPfKmB8KfSa8omZ416ehYFBwcwPu3dvT8YcoM5/cRbqVcRQnXGA4Aoj1sFZ/L0OSFswenJ3abFn/hnRnHzyHcXKBRdb3C1NmuXCgbCQOIl7h8jaQBMKHMwg==
Received: from SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::30)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Tue, 20 Jun 2023 01:17:30 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::5a) by SA1P222CA0028.outlook.office365.com
 (2603:10b6:806:22c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.44 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Tue, 20 Jun 2023 01:17:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
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
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 09/11] selftests/mm: move psize(), pshift() into vm_utils.c
Date:   Mon, 19 Jun 2023 18:17:17 -0700
Message-ID: <20230620011719.155379-11-jhubbard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 2238d7b7-92a2-471c-6d53-08db712c1e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZCBp5tWmdj7pmlABKKWKbZ4UONcS5OP+7txez7jwpGlQwCjQIq2Z/9cJ+hN4teATs9DNTRBJyJ95+0WwuxLiv+SOemsZlESgv0uODEidGcu/Ud2dnBw+ms3uGbPnGVhCRYJ9DSK7oBh/7F9UlOPodn7V0VzqXXB///6crMZA6k+g0opiJ3IX6g3f3UyykvLpBMsRSegCjmYZUrwF1LBgpGfy9JuGMFgOrXGlR0Ean1IGFaYAQqsyHq5cPqxYVwzxxbUpyWBkMzrp2ERZco5A9z3lIomtnZMu6SFjn3vtJCW59C7bnKafWAJ0beHkv6CfIgzmveWXZBTQxw70ZRclnfIA71C0sdkLdX1v6NcNQK3KzRbJcjZoDIPcWoyzMo4ygOqnPDvIQkkAxSX8GU977CsfLKhhwbrIcl+Rdk+FilFSBfeLhcGKcAtR4LpPsDwVZRtL8PLn7/rH3/FfGgJNmbt+4qKAIgusubx36lCzVVi6eTHxRXC1seZKw6Y8QY/tXXpSSMfHyInm5AwOwEBernNJfZnPPzgN4Kfxo6jNDJH63DTSxdqY4BoIYFcwXeqtZD5Nx7lBZuMDnxgoD0BKI+uGbmvXfhPe5djUMAAVAjhzIC54EO+o/RFXZB6Eu+TiVlSHepxrvRr3Ky6Vs1cLiRAwn929LSX1SwQWNIFnXIw3wwzI+7srpBp3hd6EsnBWIVB53jXKHBsmIGvRFkfR6bJ5hbiFGye7NuwK/ahlMtX84R1CnO81T7zJn9RQx7D
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(186003)(110136005)(478600001)(7696005)(6666004)(86362001)(26005)(1076003)(54906003)(2616005)(336012)(426003)(316002)(82740400003)(83380400001)(70206006)(70586007)(356005)(4326008)(7636003)(36860700001)(47076005)(8676002)(8936002)(5660300002)(2906002)(40460700003)(41300700001)(40480700001)(36756003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:30.5712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2238d7b7-92a2-471c-6d53-08db712c1e7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is in preparation for linking test programs with both vm_utils.c
and uffd-common.c. The static inline routines, while normally not a
problem, in this case complicate an already fragile header file
situation: the header files including other header files leads to
compilation failures in a subsequent patch that moves code around.

Anyway, there is no particular need for inlining here, so turn these
into normal functions, as a workaround to avoid refactoring the header
file includes for now.

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/vm_util.c | 14 ++++++++++++++
 tools/testing/selftests/mm/vm_util.h | 16 ++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 9b06a5034808..01296c17df02 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -301,3 +301,17 @@ int uffd_get_features(uint64_t *features)
 
 	return 0;
 }
+
+unsigned int psize(void)
+{
+	if (!__page_size)
+		__page_size = sysconf(_SC_PAGESIZE);
+	return __page_size;
+}
+
+unsigned int pshift(void)
+{
+	if (!__page_shift)
+		__page_shift = (ffsl(psize()) - 1);
+	return __page_shift;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 07f39ed2efba..8aa543a3678b 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -3,7 +3,6 @@
 #include <stdbool.h>
 #include <sys/mman.h>
 #include <err.h>
-#include <string.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
@@ -17,19 +16,8 @@
 extern unsigned int __page_size;
 extern unsigned int __page_shift;
 
-static inline unsigned int psize(void)
-{
-	if (!__page_size)
-		__page_size = sysconf(_SC_PAGESIZE);
-	return __page_size;
-}
-
-static inline unsigned int pshift(void)
-{
-	if (!__page_shift)
-		__page_shift = (ffsl(psize()) - 1);
-	return __page_shift;
-}
+unsigned int psize(void);
+unsigned int pshift(void);
 
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
-- 
2.40.1

