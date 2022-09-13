Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D68D5B6744
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiIMFVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIMFVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:21:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB804DB07
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:21:31 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id r20so7158116qtn.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kZHSFFRZ5TYJ5atwJqJfGrRx7CUtt+wggh+E31jFl6g=;
        b=QXvfE6sb6vwl8GWA/j8nnaaaNhLCHayCCPovK1KNtkT98dndw/e2zKIRAo+hTDUtii
         Jdkw31+GvK7b2k4K2T8fitmsTrdqIxwCTQX3c4/yXm2+ALkiMMN0e4znx5IGHhSmETrZ
         802vc/ylwMjrgmwZYJaqH5W6ns9Aw4gLLbiVOQ2ajPCqXCvIWuTkpfRf0hyjYo1jCCMy
         Kljzz28RJo7S8Y3fobHkdw7jhAYAEJAcwhxyPrmuv1YASXEP/ESN7wSgjTSGNPbdacnG
         SLNUXCwMBnamOnQMS5Eh7FcoKt/twz/jS0OhNfBds/ZJq4l+i/1hkZau6yH0IdC2yK7H
         qZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kZHSFFRZ5TYJ5atwJqJfGrRx7CUtt+wggh+E31jFl6g=;
        b=5UN5Z/eJ9by0qVM27H5Ck9oH7es4Pu4e92vGaWPtGv1iamfVn0mesESFkPGdQQ48tX
         wIreBXePztMXvXNUl8isZDu8NrFJvdhOGNIjUy8gxyfgj09exMalGx8SvFcDvk4igJ5d
         DKci7umFAS3ijBmYv06hQFYKDxhG+3bWxHIHHsjrlFA0CUdMOUMoGTdtArBrERdcP1y1
         nRcR24XT2lj4M1L+7Wr1VBH7bIS6NoD84ld1r9/luOYyfo+WTci7HE0ItHyMJII1DnLC
         HpUMjJ1d9QWA3CozglBGaT48gXtBZInF+PkIZqP8rN+57+FzpIVCqivFuu0LWNJhrZkX
         T+Uw==
X-Gm-Message-State: ACgBeo0diQnX7nJYG7qtcq+SAyLU+3W/SGcTEohJ4Y2Tm5NPT2Ji/x86
        H0AT9wDodh2LHZxKxBiNX5Q=
X-Google-Smtp-Source: AA6agR6gWUmYOn0H0LRL1BMOcPC2iZJZPoir/yUiTe7eQaLLpfhUb6OxGbY4EFjA4P8UsWtDTrZxjg==
X-Received: by 2002:a05:622a:13:b0:35b:bb0f:e90a with SMTP id x19-20020a05622a001300b0035bbb0fe90amr3781984qtw.441.1663046490539;
        Mon, 12 Sep 2022 22:21:30 -0700 (PDT)
Received: from sophie ([45.134.140.166])
        by smtp.gmail.com with ESMTPSA id m5-20020ac807c5000000b0035a70a25651sm7861405qth.55.2022.09.12.22.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 22:21:29 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v6 1/4] memblock tests: add simulation of physical memory with multiple NUMA nodes
Date:   Tue, 13 Sep 2022 00:21:09 -0500
Message-Id: <4566d816a85f009268d4858d1ef06c7571a960f9.1663046060.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663046060.git.remckee0@gmail.com>
References: <cover.1663046060.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function setup_numa_memblock() for setting up a memory layout with
multiple NUMA nodes in a previously allocated dummy physical memory.
This function can be used in place of setup_memblock() in tests that need
to simulate a NUMA system.

setup_numa_memblock():
- allows for setting up a memory layout by specifying the fraction of
  MEM_SIZE in each node

Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
16 NUMA nodes.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 .../testing/memblock/scripts/Makefile.include |  2 +-
 tools/testing/memblock/tests/common.c         | 31 +++++++++++++++++++
 tools/testing/memblock/tests/common.h         |  4 ++-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
index aa6d82d56a23..998281723590 100644
--- a/tools/testing/memblock/scripts/Makefile.include
+++ b/tools/testing/memblock/scripts/Makefile.include
@@ -3,7 +3,7 @@
 
 # Simulate CONFIG_NUMA=y
 ifeq ($(NUMA), 1)
-	CFLAGS += -D CONFIG_NUMA
+	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
 endif
 
 # Use 32 bit physical addresses.
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index eec6901081af..3f795047bbe1 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -9,6 +9,7 @@
 #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
 #define PREFIXES_MAX				15
 #define DELIM					": "
+#define BASIS					10000
 
 static struct test_memory memory_block;
 static const char __maybe_unused *prefixes[PREFIXES_MAX];
@@ -72,6 +73,36 @@ void setup_memblock(void)
 	fill_memblock();
 }
 
+/**
+ * setup_numa_memblock:
+ * Set up a memory layout with multiple NUMA nodes in a previously allocated
+ * dummy physical memory.
+ * @node_fracs: an array representing the fraction of MEM_SIZE contained in
+ *              each node in basis point units (one hundredth of 1% or 1/10000).
+ *              For example, if node 0 should contain 1/8 of MEM_SIZE,
+ *              node_fracs[0] = 1250.
+ *
+ * The nids will be set to 0 through NUMA_NODES - 1.
+ */
+void setup_numa_memblock(const unsigned int node_fracs[])
+{
+	phys_addr_t base;
+	int flags;
+
+	reset_memblock_regions();
+	base = (phys_addr_t)memory_block.base;
+	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
+
+	for (int i = 0; i < NUMA_NODES; i++) {
+		assert(node_fracs[i] <= BASIS);
+		phys_addr_t size = MEM_SIZE * node_fracs[i] / BASIS;
+
+		memblock_add_node(base, size, i, flags);
+		base += size;
+	}
+	fill_memblock();
+}
+
 void dummy_physical_memory_init(void)
 {
 	memory_block.base = malloc(MEM_SIZE);
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 78128e109a95..def71648887f 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -10,7 +10,8 @@
 #include <linux/printk.h>
 #include <../selftests/kselftest.h>
 
-#define MEM_SIZE SZ_16K
+#define MEM_SIZE		SZ_16K
+#define NUMA_NODES		8
 
 enum test_flags {
 	/* No special request. */
@@ -102,6 +103,7 @@ struct region {
 void reset_memblock_regions(void);
 void reset_memblock_attributes(void);
 void setup_memblock(void);
+void setup_numa_memblock(const unsigned int node_fracs[]);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
 void parse_args(int argc, char **argv);
-- 
2.25.1

