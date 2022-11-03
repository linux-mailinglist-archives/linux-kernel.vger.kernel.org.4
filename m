Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C156188A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiKCTUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKCTTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:19:33 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E942228D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:17:51 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id cj8-20020a056a00298800b0056cee8a0cf8so1158991pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RaENZZ+GWDWTk8XGrNapWkSpGibTFkge1Sudd3c5rdk=;
        b=NXvjDD5wNdIz5znJCl5x/NrG3Jx7WQSFRMVPyLEbWNCN9o6i7oixpULeKCuf3WJ+Ql
         laEtRsNeonQmEF/DvDz+1+H0hRuvXGXuQlwJMa8tjp7+NfXRFjx+pWriWUSNwksebuEp
         7olbijglZr6HcWI84Y6ittQoWMhvcKPr+t2TGACEY8hXAscCWf7a+OHp83sYJUwNSy0A
         7w6ceiAG9zY8AuEgenGW3WbgosBidtt0vFd4EWAIA7l4rXVlWpe1ah50StPhC71nnT3l
         LHMzSuo4chnOv3rYj/TXVULzzYgdRWrBFyMhRhOao26XLCDXLVpQZAD4R6Ia7P/nPkAg
         7O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RaENZZ+GWDWTk8XGrNapWkSpGibTFkge1Sudd3c5rdk=;
        b=YrmGcJafA8JBiqI7B/77GJRtlY3jubd/XqRa+RcYfkeyQMLq7RNVLKZdPMJYhgIgrA
         J4Dq7bF7rWy5ZR4PEJTYUCShgEoLK4NJLPpm5ZL5A1P6u9G0fRPm/62x9HySzzaHH0KR
         aVRkhQ6/cewVypBDVfpXe+3dNbuAkpdFjuLyKUgBhV6vrTB7Vmu74OYuGd9FHFyzjbyt
         NpN4SGE+X65Wdiq8v0OX/joQt0U7cCOcHXWmKcSqWWpg1zlt1Sp6w3oZcYGNYCoYGl/K
         B2HazC//GuArRu2+qMdOBp4hIvFXmk1zlbCZYsHgITibbxG5f5G43g5IMptRZGE8EQsx
         4I6g==
X-Gm-Message-State: ACrzQf3SSFPHp48TY5OdnSemaHvK26F0JT82bJlKCWvpKv3ICR9GtPh2
        XPVXEBeO28s5CYdQn4sK7wmIoay580hy
X-Google-Smtp-Source: AMsMyM5/PPziVhsU4y38at8hO4hsBOzfZK108bmUzJrxzA99ROyvuYSYxXAa3IDCppvmLlM8b73dAMQ5Tcqv
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:eb0c:b0:213:8ff3:a46a with SMTP id
 j12-20020a17090aeb0c00b002138ff3a46amr37766470pjz.158.1667503053110; Thu, 03
 Nov 2022 12:17:33 -0700 (PDT)
Date:   Thu,  3 Nov 2022 12:17:16 -0700
In-Reply-To: <20221103191719.1559407-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221103191719.1559407-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221103191719.1559407-5-vipinsh@google.com>
Subject: [PATCH v9 4/7] KVM: selftests: Use SZ_* macros from sizes.h in max_guest_memory_test.c
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace size_1gb defined in max_guest_memory_test.c with the SZ_1G,
SZ_2G and SZ_4G from linux/sizes.h header file.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/max_guest_memory_test.c        | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
index 1595b73dc09a..8056dc5831b5 100644
--- a/tools/testing/selftests/kvm/max_guest_memory_test.c
+++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
@@ -11,6 +11,7 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/atomic.h>
+#include <linux/sizes.h>
 
 #include "kvm_util.h"
 #include "test_util.h"
@@ -162,8 +163,7 @@ int main(int argc, char *argv[])
 	 * just below the 4gb boundary.  This test could create memory at
 	 * 1gb-3gb,but it's simpler to skip straight to 4gb.
 	 */
-	const uint64_t size_1gb = (1 << 30);
-	const uint64_t start_gpa = (4ull * size_1gb);
+	const uint64_t start_gpa = SZ_4G;
 	const int first_slot = 1;
 
 	struct timespec time_start, time_run1, time_reset, time_run2;
@@ -180,13 +180,13 @@ int main(int argc, char *argv[])
 	 * are quite common for x86, requires changing only max_mem (KVM allows
 	 * 32k memslots, 32k * 2gb == ~64tb of guest memory).
 	 */
-	slot_size = 2 * size_1gb;
+	slot_size = SZ_2G;
 
 	max_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
 	TEST_ASSERT(max_slots > first_slot, "KVM is broken");
 
 	/* All KVM MMUs should be able to survive a 128gb guest. */
-	max_mem = 128 * size_1gb;
+	max_mem = 128ull * SZ_1G;
 
 	calc_default_nr_vcpus();
 
@@ -197,11 +197,11 @@ int main(int argc, char *argv[])
 			TEST_ASSERT(nr_vcpus > 0, "number of vcpus must be >0");
 			break;
 		case 'm':
-			max_mem = atoi_paranoid(optarg) * size_1gb;
+			max_mem = 1ull * atoi_paranoid(optarg) * SZ_1G;
 			TEST_ASSERT(max_mem > 0, "memory size must be >0");
 			break;
 		case 's':
-			slot_size = atoi_paranoid(optarg) * size_1gb;
+			slot_size = 1ull * atoi_paranoid(optarg) * SZ_1G;
 			TEST_ASSERT(slot_size > 0, "slot size must be >0");
 			break;
 		case 'H':
@@ -245,7 +245,7 @@ int main(int argc, char *argv[])
 
 #ifdef __x86_64__
 		/* Identity map memory in the guest using 1gb pages. */
-		for (i = 0; i < slot_size; i += size_1gb)
+		for (i = 0; i < slot_size; i += SZ_1G)
 			__virt_pg_map(vm, gpa + i, gpa + i, PG_LEVEL_1G);
 #else
 		for (i = 0; i < slot_size; i += vm->page_size)
@@ -260,7 +260,7 @@ int main(int argc, char *argv[])
 	vcpus = NULL;
 
 	pr_info("Running with %lugb of guest memory and %u vCPUs\n",
-		(gpa - start_gpa) / size_1gb, nr_vcpus);
+		(gpa - start_gpa) / SZ_1G, nr_vcpus);
 
 	rendezvous_with_vcpus(&time_start, "spawning");
 	rendezvous_with_vcpus(&time_run1, "run 1");
-- 
2.38.1.273.g43a17bfeac-goog

