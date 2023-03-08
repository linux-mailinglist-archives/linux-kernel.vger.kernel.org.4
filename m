Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AFB6B032E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCHJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCHJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:41:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85CB3291
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:41:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12714B81C17
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1ACC4339E;
        Wed,  8 Mar 2023 09:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678268488;
        bh=nxbvrZboLg9dZQ5/M7cVi+ZACd7kAmzqj1YWR08+kKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4zMp2Yn7HDfIOkHs2LHrjV9yaXYJYlXB/aKnJzLJ/PF5ZrlqK+R5tPO7fbFxNUxs
         IOg7AHUKv7exmJro4ZoTEYmbvSPOoqa73BwAI14TlGIR/CFSFZ+7ZTm1F0MbW4ELt4
         6jMh8OZGtB42IpkD0kOZcf1Woaq6cEJMzUTm34te4vtlC80/UgPKBHW7wvG4rsoFI6
         CQmqk2kwLGUSJ4nEjQYF3tw0ODzEx2YVylfv2/ajUcNhSCG99D43hWVU28PhQ7/TUw
         8u+3ARAC6O8BItMDilZ/vzwy8gnulVEiyO5ZbkV8lD3YZSazdBAqfut4kR1L6muYwQ
         DRYHul/m47P0w==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [RFC PATCH 2/5] mm/unmapped_alloc: add debugfs file similar to /proc/pagetypeinfo
Date:   Wed,  8 Mar 2023 11:41:03 +0200
Message-Id: <20230308094106.227365-3-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230308094106.227365-1-rppt@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Present statistics about unmapped_alloc in debugfs

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 mm/unmapped-alloc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/mm/unmapped-alloc.c b/mm/unmapped-alloc.c
index fb2d54204a3c..f74640e9ce9f 100644
--- a/mm/unmapped-alloc.c
+++ b/mm/unmapped-alloc.c
@@ -3,6 +3,7 @@
 #include <linux/gfp.h>
 #include <linux/mmzone.h>
 #include <linux/printk.h>
+#include <linux/debugfs.h>
 #include <linux/spinlock.h>
 #include <linux/set_memory.h>
 
@@ -213,3 +214,37 @@ int unmapped_alloc_init(void)
 
 	return 0;
 }
+
+static int unmapped_alloc_debug_show(struct seq_file *m, void *private)
+{
+	int order;
+
+	seq_printf(m, "MAX_ORDER: %d\n", MAX_ORDER);
+	seq_putc(m, '\n');
+
+	seq_printf(m, "%-10s", "Order:");
+	for (order = 0; order < MAX_ORDER; ++order)
+		seq_printf(m, "%5d ", order);
+	seq_putc(m, '\n');
+
+	seq_printf(m, "%-10s", "Free:");
+	for (order = 0; order < MAX_ORDER; ++order)
+		seq_printf(m, "%5lu ", free_area[order].nr_free);
+	seq_putc(m, '\n');
+
+	seq_printf(m, "%-10s", "Cached:");
+	for (order = 0; order < MAX_ORDER; ++order)
+		seq_printf(m, "%5lu ", free_area[order].nr_cached);
+	seq_putc(m, '\n');
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(unmapped_alloc_debug);
+
+static int __init unmapped_alloc_init_late(void)
+{
+	debugfs_create_file("unmapped_alloc", 0444, NULL,
+			    NULL, &unmapped_alloc_debug_fops);
+	return 0;
+}
+late_initcall(unmapped_alloc_init_late);
-- 
2.35.1

