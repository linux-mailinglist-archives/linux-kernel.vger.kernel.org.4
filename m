Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD41616D99
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiKBTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiKBTNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ACCC00
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667416362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1JWVYgtBAzl6u/DxnVU6Shc+eGWdb6J3WOY1PrwuZE=;
        b=MHlB/ehFMBjR/tA2XE+MqU2sTlv6khski9C4INFXaOfmRngSIzX5IPeVBfmHuTEYg1DW8+
        IFITs6JfYh4fuPZn+8yXpgpfOjyoHwMAF3+rHVmLBOz3bBWSqX+DEWgMHSz6oib/3QBmSZ
        Dq/acPlv99ZoziHpjpYponH0eZ3wPCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-qN1tKQ37MfeVrpYL5skHkg-1; Wed, 02 Nov 2022 15:12:39 -0400
X-MC-Unique: qN1tKQ37MfeVrpYL5skHkg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D03C38027EA;
        Wed,  2 Nov 2022 19:12:38 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA2149BB60;
        Wed,  2 Nov 2022 19:12:35 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Chinner <david@fromorbit.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v1 6/6] selftests/vm: anon_cow: add mprotect() optimization tests
Date:   Wed,  2 Nov 2022 20:12:09 +0100
Message-Id: <20221102191209.289237-7-david@redhat.com>
In-Reply-To: <20221102191209.289237-1-david@redhat.com>
References: <20221102191209.289237-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's extend the test to cover the possible mprotect() optimization when
removing write-protection. mprotect() must not allow write-access to a
COW-shared page by accident.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/anon_cow.c | 49 +++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/anon_cow.c
index 705bd0b3db11..bbb251eb5025 100644
--- a/tools/testing/selftests/vm/anon_cow.c
+++ b/tools/testing/selftests/vm/anon_cow.c
@@ -190,7 +190,8 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
 
 typedef int (*child_fn)(char *mem, size_t size, struct comm_pipes *comm_pipes);
 
-static void do_test_cow_in_parent(char *mem, size_t size, child_fn fn)
+static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
+				  child_fn fn)
 {
 	struct comm_pipes comm_pipes;
 	char buf;
@@ -212,6 +213,22 @@ static void do_test_cow_in_parent(char *mem, size_t size, child_fn fn)
 
 	while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
 		;
+
+	if (do_mprotect) {
+		/*
+		 * mprotect() optimizations might try avoiding
+		 * write-faults by directly mapping pages writable.
+		 */
+		ret = mprotect(mem, size, PROT_READ);
+		ret |= mprotect(mem, size, PROT_READ|PROT_WRITE);
+		if (ret) {
+			ksft_test_result_fail("mprotect() failed\n");
+			write(comm_pipes.parent_ready[1], "0", 1);
+			wait(&ret);
+			goto close_comm_pipes;
+		}
+	}
+
 	/* Modify the page. */
 	memset(mem, 0xff, size);
 	write(comm_pipes.parent_ready[1], "0", 1);
@@ -229,12 +246,22 @@ static void do_test_cow_in_parent(char *mem, size_t size, child_fn fn)
 
 static void test_cow_in_parent(char *mem, size_t size)
 {
-	do_test_cow_in_parent(mem, size, child_memcmp_fn);
+	do_test_cow_in_parent(mem, size, false, child_memcmp_fn);
+}
+
+static void test_cow_in_parent_mprotect(char *mem, size_t size)
+{
+	do_test_cow_in_parent(mem, size, true, child_memcmp_fn);
 }
 
 static void test_vmsplice_in_child(char *mem, size_t size)
 {
-	do_test_cow_in_parent(mem, size, child_vmsplice_memcmp_fn);
+	do_test_cow_in_parent(mem, size, false, child_vmsplice_memcmp_fn);
+}
+
+static void test_vmsplice_in_child_mprotect(char *mem, size_t size)
+{
+	do_test_cow_in_parent(mem, size, true, child_vmsplice_memcmp_fn);
 }
 
 static void do_test_vmsplice_in_parent(char *mem, size_t size,
@@ -969,6 +996,14 @@ static const struct test_case test_cases[] = {
 		"Basic COW after fork()",
 		test_cow_in_parent,
 	},
+	/*
+	 * Basic test, but do an additional mprotect(PROT_READ)+
+	 * mprotect(PROT_READ|PROT_WRITE) in the parent before write access.
+	 */
+	{
+		"Basic COW after fork() with mprotect() optimization",
+		test_cow_in_parent_mprotect,
+	},
 	/*
 	 * vmsplice() [R/O GUP] + unmap in the child; modify in the parent. If
 	 * we miss to break COW, the child observes modifications by the parent.
@@ -978,6 +1013,14 @@ static const struct test_case test_cases[] = {
 		"vmsplice() + unmap in child",
 		test_vmsplice_in_child
 	},
+	/*
+	 * vmsplice() test, but do an additional mprotect(PROT_READ)+
+	 * mprotect(PROT_READ|PROT_WRITE) in the parent before write access.
+	 */
+	{
+		"vmsplice() + unmap in child with mprotect() optimization",
+		test_vmsplice_in_child_mprotect
+	},
 	/*
 	 * vmsplice() [R/O GUP] in parent before fork(), unmap in parent after
 	 * fork(); modify in the child. If we miss to break COW, the parent
-- 
2.38.1

