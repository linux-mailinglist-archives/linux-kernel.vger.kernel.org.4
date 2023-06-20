Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9116073610E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjFTBSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjFTBRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E232FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIGfCuzUzu5g0HZ+VTdldCh87mFNiiFQOvNerHIHEWfLUiL62ta9kjhYxhWhdnnPCjQTp7TtYPwllyBHfBiqpzLc3HrjSTabRTkf7GXqOgFmUHyx+qVYRIFhkc2vB66xbIj0fSKXcJ+1wVVAJ4LyF+TdI2wcrF8Bnkp9sX/++Lx1YJcmmLuOd+fSSvHsWNxUVEmoeyU9bDOBw/BKIsFH3YuYFi4gcdMiG9Oh4y3D3RywZbp3bEHIJMgIdOoaRUf+OXuNdONRrThy8ju7/2CnQmyofFT0m25IenvsD5kXcq/ndsBOiEYQy/q2cAuZ/yxWGy1UAAFCRIg8DOqMpvRPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcAlKHerk5VQh9Nf0GPXXyu2H5vBR4yo7s+VUgObnFs=;
 b=lNKxQeT8oYQORrOvsq8oZSTLw4NokgoI0HFcfsz95B37ulW9o/gNtyuuJ6A7EETlqlMsKPfjy2GbeAzqlMlIuqLwNahE5wNLQTv99Y39gKBQ5nXXZmH8xxlwuwvP93hPq/eROZev1TXSzGOgjY++lKqNjYbWfBCA1qm5d27EoQtPtM6uU0c18B6z5s+H1J7UBjU5v1OeVkr8jT4D27iOLQGdFVZxBUq47l3UPzy43eSfbDcDtQljAGANc8IOzIQd7y8VlWvyEVDh9DQBuRNznPvyfymcDzV1owl56So8IV9z6PEKPJJ4EV4gFjFTICg73pnbAFk0B0nb7eR2/BfC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcAlKHerk5VQh9Nf0GPXXyu2H5vBR4yo7s+VUgObnFs=;
 b=SIwQg1o+9Lplkbm53VvSvbt7Gy3tmKAFwLFjSbpwe8OUxVeWzPb32hDU1uYHOmbqTFqN7pEqkjBx29DPlKAMFczEGQRQGqZkKdo+yY70jYIXiRbAzkqMhOUpqFDgK/iBLjMKa659NNoz4tL2cfyBBBwKH7fsPpsnJUY45V58DvnrxWmjQEMw3HtHaE2xtqvZx8lTde/lCeugDYzNbDPTYNUPiLEnyPgiEpm0W/Kw99RfqZIqmRbRQUEh4kKkHnhXejRh3FYyPDzFWofnaAZrLburFNhSvvu7SstyPNQmLkG3LLjVK3GahdRIz5ZGhwZK+9MfG4aIt7oojMnFekH1Jw==
Received: from SA1P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::12)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 01:17:32 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::d8) by SA1P222CA0010.outlook.office365.com
 (2603:10b6:806:22c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.44 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Tue, 20 Jun 2023 01:17:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:17:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:17:24 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 18:17:24 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 10/11] selftests/mm: move uffd* routines from vm_util.c to uffd-common.c
Date:   Mon, 19 Jun 2023 18:17:18 -0700
Message-ID: <20230620011719.155379-12-jhubbard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 8675e8b7-af85-4e64-2a4f-08db712c1f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0fOJC2zkjlIrgLWUOj/cZmm7Lw5yAFDhm6S44yFUMK7ORxQK8nMD0VfL2JL3sVo6FPjUv97RaH4efHwmxn+ifmlfLg7zWRU5MKx7zudVhlcroO95cMLl4xe8d80RDXvLhtayKkd985JZtE1KtmtPPT7dEFg30eeZi7ggPw0DLmQRlorK32NQJetqqXXkI0+bj/VjYEBio7VkCpmNZROAooE+5EU9y3TdI4ARvfZL16s4/Rzzaedav6KVvYHhpfrv0fxVjyJM3HTRTXaaISxYV0jhf13HBn1ntC839AgLuhgwE7OhFJKmEI49JJsDdIe/8FEqPoQU4gHLX0HM9gYixAZOvbZ5uBgVpvobwQeyRSvjEOxZOuw3GXpHMkcYAMConehzXLcZ0M+fHYQto2s902S1MSumWxQcpxdhD0bC4c5gyQTyqSKuUcYG7ZbUkgkP42k+8Mw+GkLv/IJf8hWE/mcY6NT5dPHsf1O5l86Bs4B49fO9FTRKDOA/zPFL5o+efE1/3ls/dwmK5yJLl0NzV4aB81lYwEjgfEBwF1uGtWE3r3jrQhEoDHV553NecTuKc4zpycJ409/gF3qsyzWBEBYvqVkz+uoOzQaLBlQfR9aZEN6j7MgtrYiAMjPr3RHmP3RHiphEvOprHT8mF8upHcVjljIsDm3lRzRFwaO6D0RmrEFClTawKE4klsWua3iZ/9vsktWfsmli0Rrd1Gn4irlEj+anrsdY/vKTES8qjM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(356005)(336012)(426003)(2616005)(86362001)(83380400001)(2906002)(47076005)(7636003)(36860700001)(5660300002)(82740400003)(4326008)(40460700003)(54906003)(110136005)(82310400005)(70586007)(186003)(70206006)(8676002)(8936002)(478600001)(36756003)(41300700001)(40480700001)(1076003)(26005)(7696005)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:31.6180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8675e8b7-af85-4e64-2a4f-08db712c1f1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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

Move the uffd*() routines to their natural home. Note that
ksm_functional_tests.c also depend, intentionally (due to a recent
commit [1]), upon uffd-common.[ch].

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/Makefile           |   7 +-
 tools/testing/selftests/mm/hugepage-mremap.c  |   2 +-
 .../selftests/mm/ksm_functional_tests.c       |   2 +-
 tools/testing/selftests/mm/uffd-common.c      | 105 ++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.h      |  12 +-
 tools/testing/selftests/mm/vm_util.c          | 104 -----------------
 tools/testing/selftests/mm/vm_util.h          |  10 --
 7 files changed, 122 insertions(+), 120 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 23af4633f0f4..a15572758954 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -109,8 +109,11 @@ include ../lib.mk
 
 $(TEST_GEN_PROGS): vm_util.c
 
-$(OUTPUT)/uffd-stress: uffd-common.c
-$(OUTPUT)/uffd-unit-tests: uffd-common.c
+$(OUTPUT)/uffd-stress:          uffd-common.c
+$(OUTPUT)/uffd-unit-tests:      uffd-common.c
+$(OUTPUT)/hugepage-mremap:      uffd-common.c
+$(OUTPUT)/write_to_hugetlbfs:   uffd-common.c
+$(OUTPUT)/ksm_functional_tests: uffd-common.c
 
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index cabd0084f57b..8158fe909f5e 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -24,7 +24,7 @@
 #include <sys/ioctl.h>
 #include <string.h>
 #include <stdbool.h>
-#include "vm_util.h"
+#include "uffd-common.h"
 
 #define DEFAULT_LENGTH_MB 10UL
 #define MB_TO_BYTES(x) (x * 1024 * 1024)
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 26853badae70..648188ad73fa 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -22,7 +22,7 @@
 #include <linux/userfaultfd.h>
 
 #include "../kselftest.h"
-#include "vm_util.h"
+#include "uffd-common.h"
 
 #define KiB 1024u
 #define MiB (1024 * KiB)
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 61c6250adf93..e1ad63668a05 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -6,6 +6,7 @@
  */
 
 #include "uffd-common.h"
+#include "vm_util.h"
 
 #define BASE_PMD_ADDR ((void *)(1UL << 30))
 
@@ -616,3 +617,107 @@ int copy_page(int ufd, unsigned long offset, bool wp)
 {
 	return __copy_page(ufd, offset, false, wp);
 }
+
+/* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
+int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
+			      bool miss, bool wp, bool minor, uint64_t *ioctls)
+{
+	struct uffdio_register uffdio_register = { 0 };
+	uint64_t mode = 0;
+	int ret = 0;
+
+	if (miss)
+		mode |= UFFDIO_REGISTER_MODE_MISSING;
+	if (wp)
+		mode |= UFFDIO_REGISTER_MODE_WP;
+	if (minor)
+		mode |= UFFDIO_REGISTER_MODE_MINOR;
+
+	uffdio_register.range.start = (unsigned long)addr;
+	uffdio_register.range.len = len;
+	uffdio_register.mode = mode;
+
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
+		ret = -errno;
+	else if (ioctls)
+		*ioctls = uffdio_register.ioctls;
+
+	return ret;
+}
+
+int uffd_register(int uffd, void *addr, uint64_t len,
+		  bool miss, bool wp, bool minor)
+{
+	return uffd_register_with_ioctls(uffd, addr, len,
+					 miss, wp, minor, NULL);
+}
+
+int uffd_unregister(int uffd, void *addr, uint64_t len)
+{
+	struct uffdio_range range = { .start = (uintptr_t)addr, .len = len };
+	int ret = 0;
+
+	if (ioctl(uffd, UFFDIO_UNREGISTER, &range) == -1)
+		ret = -errno;
+
+	return ret;
+}
+
+int uffd_open_dev(unsigned int flags)
+{
+	int fd, uffd;
+
+	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+	uffd = ioctl(fd, USERFAULTFD_IOC_NEW, flags);
+	close(fd);
+
+	return uffd;
+}
+
+int uffd_open_sys(unsigned int flags)
+{
+#ifdef __NR_userfaultfd
+	return syscall(__NR_userfaultfd, flags);
+#else
+	return -1;
+#endif
+}
+
+int uffd_open(unsigned int flags)
+{
+	int uffd = uffd_open_sys(flags);
+
+	if (uffd < 0)
+		uffd = uffd_open_dev(flags);
+
+	return uffd;
+}
+
+int uffd_get_features(uint64_t *features)
+{
+	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
+	/*
+	 * This should by default work in most kernels; the feature list
+	 * will be the same no matter what we pass in here.
+	 */
+	int fd = uffd_open(UFFD_USER_MODE_ONLY);
+
+	if (fd < 0)
+		/* Maybe the kernel is older than user-only mode? */
+		fd = uffd_open(0);
+
+	if (fd < 0)
+		return fd;
+
+	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
+		close(fd);
+		return -errno;
+	}
+
+	*features = uffdio_api.features;
+	close(fd);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 6068f2346b86..a1cdb78c0762 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -19,8 +19,6 @@
 #include <signal.h>
 #include <poll.h>
 #include <string.h>
-#include <linux/mman.h>
-#include <sys/mman.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
 #include <sys/wait.h>
@@ -110,6 +108,16 @@ int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
 int copy_page(int ufd, unsigned long offset, bool wp);
 void *uffd_poll_thread(void *arg);
 
+int uffd_register(int uffd, void *addr, uint64_t len,
+		  bool miss, bool wp, bool minor);
+int uffd_unregister(int uffd, void *addr, uint64_t len);
+int uffd_open_dev(unsigned int flags);
+int uffd_open_sys(unsigned int flags);
+int uffd_open(unsigned int flags);
+int uffd_get_features(uint64_t *features);
+int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
+			      bool miss, bool wp, bool minor, uint64_t *ioctls);
+
 #define TEST_ANON	1
 #define TEST_HUGETLB	2
 #define TEST_SHMEM	3
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 01296c17df02..c64a0134f83c 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -198,110 +198,6 @@ unsigned long default_huge_page_size(void)
 	return hps;
 }
 
-/* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
-int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
-			      bool miss, bool wp, bool minor, uint64_t *ioctls)
-{
-	struct uffdio_register uffdio_register = { 0 };
-	uint64_t mode = 0;
-	int ret = 0;
-
-	if (miss)
-		mode |= UFFDIO_REGISTER_MODE_MISSING;
-	if (wp)
-		mode |= UFFDIO_REGISTER_MODE_WP;
-	if (minor)
-		mode |= UFFDIO_REGISTER_MODE_MINOR;
-
-	uffdio_register.range.start = (unsigned long)addr;
-	uffdio_register.range.len = len;
-	uffdio_register.mode = mode;
-
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
-		ret = -errno;
-	else if (ioctls)
-		*ioctls = uffdio_register.ioctls;
-
-	return ret;
-}
-
-int uffd_register(int uffd, void *addr, uint64_t len,
-		  bool miss, bool wp, bool minor)
-{
-	return uffd_register_with_ioctls(uffd, addr, len,
-					 miss, wp, minor, NULL);
-}
-
-int uffd_unregister(int uffd, void *addr, uint64_t len)
-{
-	struct uffdio_range range = { .start = (uintptr_t)addr, .len = len };
-	int ret = 0;
-
-	if (ioctl(uffd, UFFDIO_UNREGISTER, &range) == -1)
-		ret = -errno;
-
-	return ret;
-}
-
-int uffd_open_dev(unsigned int flags)
-{
-	int fd, uffd;
-
-	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-	uffd = ioctl(fd, USERFAULTFD_IOC_NEW, flags);
-	close(fd);
-
-	return uffd;
-}
-
-int uffd_open_sys(unsigned int flags)
-{
-#ifdef __NR_userfaultfd
-	return syscall(__NR_userfaultfd, flags);
-#else
-	return -1;
-#endif
-}
-
-int uffd_open(unsigned int flags)
-{
-	int uffd = uffd_open_sys(flags);
-
-	if (uffd < 0)
-		uffd = uffd_open_dev(flags);
-
-	return uffd;
-}
-
-int uffd_get_features(uint64_t *features)
-{
-	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
-	/*
-	 * This should by default work in most kernels; the feature list
-	 * will be the same no matter what we pass in here.
-	 */
-	int fd = uffd_open(UFFD_USER_MODE_ONLY);
-
-	if (fd < 0)
-		/* Maybe the kernel is older than user-only mode? */
-		fd = uffd_open(0);
-
-	if (fd < 0)
-		return fd;
-
-	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
-		close(fd);
-		return -errno;
-	}
-
-	*features = uffdio_api.features;
-	close(fd);
-
-	return 0;
-}
-
 unsigned int psize(void)
 {
 	if (!__page_size)
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 8aa543a3678b..f04f82771cd0 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -33,16 +33,6 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
 int64_t allocate_transhuge(void *ptr, int pagemap_fd);
 unsigned long default_huge_page_size(void);
 
-int uffd_register(int uffd, void *addr, uint64_t len,
-		  bool miss, bool wp, bool minor);
-int uffd_unregister(int uffd, void *addr, uint64_t len);
-int uffd_open_dev(unsigned int flags);
-int uffd_open_sys(unsigned int flags);
-int uffd_open(unsigned int flags);
-int uffd_get_features(uint64_t *features);
-int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
-			      bool miss, bool wp, bool minor, uint64_t *ioctls);
-
 /*
  * On ppc64 this will only work with radix 2M hugepage size
  */
-- 
2.40.1

