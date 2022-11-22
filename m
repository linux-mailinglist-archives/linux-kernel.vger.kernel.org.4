Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66696348A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiKVUmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiKVUlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:41:01 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7655B85161;
        Tue, 22 Nov 2022 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149596;
        bh=i8g/GvauG/kg2WHWmSyOCdrT/ckBtsOzQscjDSY2tkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hURPSG/h3z0spYO9rFVodxRCnueLJfSWc/mTGHbZtemiALAqpSO/PdMCs+vrepjFZ
         DNJMhMuZxCBLYrOQMTXWKjuhEkOufiicSdQo8su52BXzYr/cvp90rURfbOBua0u3a9
         Hl0cxnClYJmIrA9q5+6zXfgUatIIfx3XsMjA6yj1krbyJGlGsSENuk4RJhgAsCbfJi
         ZpjKvjA4QUnkEA6oL7ZBvvdaqFYPrcfQPguNM94yTO4+DQJtDBi75gFvE4cLKGZUPA
         a6wVkgijjOhzIi5HErPL8Ohku9JBZkT4kc5U1xs8we6bHivzV3kOVKQPVAo81H/KpT
         oDQKUJsy/0Bfw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2h2zcwzXLT;
        Tue, 22 Nov 2022 15:39:56 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 29/30] selftests/rseq: Implement mm_numa_cid tests
Date:   Tue, 22 Nov 2022 15:39:31 -0500
Message-Id: <20221122203932.231377-30-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement rseq selftests for the mm_numa_cid struct rseq field.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/.gitignore       |  4 ++++
 tools/testing/selftests/rseq/Makefile         | 16 ++++++++++++-
 .../selftests/rseq/basic_percpu_ops_test.c    | 12 ++++++++++
 tools/testing/selftests/rseq/param_test.c     | 24 +++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h           | 19 +++++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 8a8d163cbb9f..e4dff7a20b3a 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -2,6 +2,7 @@
 basic_numa_test
 basic_percpu_ops_test
 basic_percpu_ops_mm_cid_test
+basic_percpu_ops_mm_numa_cid_test
 basic_test
 basic_rseq_op_test
 param_test
@@ -10,3 +11,6 @@ param_test_compare_twice
 param_test_mm_cid
 param_test_mm_cid_benchmark
 param_test_mm_cid_compare_twice
+param_test_mm_numa_cid
+param_test_mm_numa_cid_benchmark
+param_test_mm_numa_cid_compare_twice
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index a00b9dc8eec5..14119871f16f 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -14,7 +14,9 @@ OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS = basic_test basic_numa_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
-		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
+		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice \
+		param_test_mm_numa_cid param_test_mm_numa_cid_benchmark \
+		param_test_mm_numa_cid_compare_twice
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
@@ -52,3 +54,15 @@ $(OUTPUT)/param_test_mm_cid_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 $(OUTPUT)/param_test_mm_cid_compare_twice: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
 	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_CID -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_mm_numa_cid: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_NUMA_CID $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_mm_numa_cid_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_NUMA_CID -DBENCHMARK $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_mm_numa_cid_compare_twice: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBUILDOPT_RSEQ_PERCPU_MM_NUMA_CID -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index 887542961968..5631b4e7130c 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -24,6 +24,18 @@ bool rseq_validate_cpu_id(void)
 {
 	return rseq_mm_cid_available();
 }
+#elif defined(BUILDOPT_RSEQ_PERCPU_MM_NUMA_CID)
+# define RSEQ_PERCPU	RSEQ_PERCPU_MM_NUMA_CID
+static
+int get_current_cpu_id(void)
+{
+	return rseq_current_mm_numa_cid();
+}
+static
+bool rseq_validate_cpu_id(void)
+{
+	return rseq_mm_numa_cid_available();
+}
 #else
 # define RSEQ_PERCPU	RSEQ_PERCPU_CPU_ID
 static
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index bf951a490bb4..b32c45ec9a56 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -300,6 +300,30 @@ int rseq_membarrier_expedited(int cpu)
 			      0, 0);
 }
 # endif /* TEST_MEMBARRIER */
+#elif defined(BUILDOPT_RSEQ_PERCPU_MM_NUMA_CID)
+# define RSEQ_PERCPU	RSEQ_PERCPU_MM_NUMA_CID
+static
+int get_current_cpu_id(void)
+{
+	return rseq_current_mm_numa_cid();
+}
+static
+bool rseq_validate_cpu_id(void)
+{
+	return rseq_mm_numa_cid_available();
+}
+# ifdef TEST_MEMBARRIER
+/*
+ * Membarrier does not currently support targeting a mm_numa_cid, so
+ * issue the barrier on all cpus.
+ */
+static
+int rseq_membarrier_expedited(int cpu)
+{
+	return sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+			      0, 0);
+}
+# endif /* TEST_MEMBARRIER */
 #else
 # define RSEQ_PERCPU	RSEQ_PERCPU_CPU_ID
 static
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 6b682abf39b0..91923c7b74b0 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -86,6 +86,7 @@ enum rseq_mo {
 enum rseq_percpu_mode {
 	RSEQ_PERCPU_CPU_ID = 0,
 	RSEQ_PERCPU_MM_CID = 1,
+	RSEQ_PERCPU_MM_NUMA_CID = 2,
 };
 
 static inline struct rseq_abi *rseq_get_abi(void)
@@ -258,6 +259,8 @@ int rseq_cmpeqv_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
 		return rseq_cmpeqv_storev_relaxed_cpu_id(v, expect, newv, cpu);
 	case RSEQ_PERCPU_MM_CID:
 		return rseq_cmpeqv_storev_relaxed_mm_cid(v, expect, newv, cpu);
+	case RSEQ_PERCPU_MM_NUMA_CID:
+		return rseq_cmpeqv_storev_relaxed_mm_numa_cid(v, expect, newv, cpu);
 	}
 	return -1;
 }
@@ -278,6 +281,8 @@ int rseq_cmpnev_storeoffp_load(enum rseq_mo rseq_mo, enum rseq_percpu_mode percp
 		return rseq_cmpnev_storeoffp_load_relaxed_cpu_id(v, expectnot, voffp, load, cpu);
 	case RSEQ_PERCPU_MM_CID:
 		return rseq_cmpnev_storeoffp_load_relaxed_mm_cid(v, expectnot, voffp, load, cpu);
+	case RSEQ_PERCPU_MM_NUMA_CID:
+		return rseq_cmpnev_storeoffp_load_relaxed_mm_numa_cid(v, expectnot, voffp, load, cpu);
 	}
 	return -1;
 }
@@ -293,6 +298,8 @@ int rseq_addv(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mode,
 		return rseq_addv_relaxed_cpu_id(v, count, cpu);
 	case RSEQ_PERCPU_MM_CID:
 		return rseq_addv_relaxed_mm_cid(v, count, cpu);
+	case RSEQ_PERCPU_MM_NUMA_CID:
+		return rseq_addv_relaxed_mm_numa_cid(v, count, cpu);
 	}
 	return -1;
 }
@@ -313,6 +320,8 @@ int rseq_offset_deref_addv(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu_mo
 		return rseq_offset_deref_addv_relaxed_cpu_id(ptr, off, inc, cpu);
 	case RSEQ_PERCPU_MM_CID:
 		return rseq_offset_deref_addv_relaxed_mm_cid(ptr, off, inc, cpu);
+	case RSEQ_PERCPU_MM_NUMA_CID:
+		return rseq_offset_deref_addv_relaxed_mm_numa_cid(ptr, off, inc, cpu);
 	}
 	return -1;
 }
@@ -331,6 +340,8 @@ int rseq_cmpeqv_trystorev_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode per
 			return rseq_cmpeqv_trystorev_storev_relaxed_cpu_id(v, expect, v2, newv2, newv, cpu);
 		case RSEQ_PERCPU_MM_CID:
 			return rseq_cmpeqv_trystorev_storev_relaxed_mm_cid(v, expect, v2, newv2, newv, cpu);
+		case RSEQ_PERCPU_MM_NUMA_CID:
+			return rseq_cmpeqv_trystorev_storev_relaxed_mm_numa_cid(v, expect, v2, newv2, newv, cpu);
 		}
 		return -1;
 	case RSEQ_MO_RELEASE:
@@ -339,6 +350,8 @@ int rseq_cmpeqv_trystorev_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode per
 			return rseq_cmpeqv_trystorev_storev_release_cpu_id(v, expect, v2, newv2, newv, cpu);
 		case RSEQ_PERCPU_MM_CID:
 			return rseq_cmpeqv_trystorev_storev_release_mm_cid(v, expect, v2, newv2, newv, cpu);
+		case RSEQ_PERCPU_MM_NUMA_CID:
+			return rseq_cmpeqv_trystorev_storev_release_mm_numa_cid(v, expect, v2, newv2, newv, cpu);
 		}
 		return -1;
 	default:
@@ -359,6 +372,8 @@ int rseq_cmpeqv_cmpeqv_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode percpu
 		return rseq_cmpeqv_cmpeqv_storev_relaxed_cpu_id(v, expect, v2, expect2, newv, cpu);
 	case RSEQ_PERCPU_MM_CID:
 		return rseq_cmpeqv_cmpeqv_storev_relaxed_mm_cid(v, expect, v2, expect2, newv, cpu);
+	case RSEQ_PERCPU_MM_NUMA_CID:
+		return rseq_cmpeqv_cmpeqv_storev_relaxed_mm_numa_cid(v, expect, v2, expect2, newv, cpu);
 	}
 	return -1;
 }
@@ -376,6 +391,8 @@ int rseq_cmpeqv_trymemcpy_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode per
 			return rseq_cmpeqv_trymemcpy_storev_relaxed_cpu_id(v, expect, dst, src, len, newv, cpu);
 		case RSEQ_PERCPU_MM_CID:
 			return rseq_cmpeqv_trymemcpy_storev_relaxed_mm_cid(v, expect, dst, src, len, newv, cpu);
+		case RSEQ_PERCPU_MM_NUMA_CID:
+			return rseq_cmpeqv_trymemcpy_storev_relaxed_mm_numa_cid(v, expect, dst, src, len, newv, cpu);
 		}
 		return -1;
 	case RSEQ_MO_RELEASE:
@@ -384,6 +401,8 @@ int rseq_cmpeqv_trymemcpy_storev(enum rseq_mo rseq_mo, enum rseq_percpu_mode per
 			return rseq_cmpeqv_trymemcpy_storev_release_cpu_id(v, expect, dst, src, len, newv, cpu);
 		case RSEQ_PERCPU_MM_CID:
 			return rseq_cmpeqv_trymemcpy_storev_release_mm_cid(v, expect, dst, src, len, newv, cpu);
+		case RSEQ_PERCPU_MM_NUMA_CID:
+			return rseq_cmpeqv_trymemcpy_storev_release_mm_numa_cid(v, expect, dst, src, len, newv, cpu);
 		}
 		return -1;
 	default:
-- 
2.25.1

