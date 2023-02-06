Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55368C006
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjBFO1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjBFO1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:27:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD44C1448C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:27:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a25c883000000b0086349255277so9899969ybf.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4qqnrGkVhs9Vc4bivD45fxgO+no6959irDZQgiBvynQ=;
        b=aU5LgoD87HNQDMM6kdWC+HI88B2eqXW/hyZ40asuoB9u29j3Jt4jLJqwCGxAipiUgO
         /E+u/yRG9sLqgS8qo4/KoH9OKz72x7llBOGEl7vOShmStMlvDam6BroGlvwWqwMlTjip
         ILKvVLw6fbzHJW5OFg3/ympPbW/5edttt7TZ9GBq8GvbZgsZAOrKHK8Cch76lpiHn7cx
         6CNBybLegfgEo4gSsDMJzDhVmqv2CXahZblflhWTSVS8NbZnP5g7n1hlM49a0p2w9SDs
         25tSeY8A3gnrIOUGukXG6giph4Ze8b7aMt1NZKib4z3ikv8AveOgNMeMkOFLsxWRE90P
         BoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qqnrGkVhs9Vc4bivD45fxgO+no6959irDZQgiBvynQ=;
        b=H1s4EUz4eWZO6XAILTqFGgushzNjxn7VxIhpDmRwNOsIxN447lyXiVJpBOUAHEKF8Y
         m18vQUelWkdMzPSLbpMbqPi2aKuSourmsM1nrjcPN7YW8qVDv9j5Mm5ZUiQaFejQCPSi
         59MVljFLo9s9PvEtSJjpBaP0H2EPxizbJF/bjXQkL3XY/OcuneLVsHWC9ep2WBAWrNgw
         Qg9EREMM6NR5/xyfBlp7KnEMn1C6NUU7cCKHERYkRTPHCHrRrTmUGNumYWjsaPdeRdeF
         5NOrkJvaVXkFixRsO8dnWIEeDqshTexvgUnt3MeMufKl57laF2vCzNToyCcIFp+R3q1R
         BjVQ==
X-Gm-Message-State: AO0yUKXtjTNggADnhagG9OfcXoByM7j/IjW3UWF7Jt2598A+6NqMKuxu
        0F3n0MJYUzv1DN1DH5Gh0pcbkJCzbBxthLE=
X-Google-Smtp-Source: AK7set+zEVPM0p7yMnswQPtt3wYKg8y3aDA7rz/3kbSqsy9NgvFzYi6BgDZwRaNbyiV49huUxWExWR1QvRWe7QU=
X-Received: from liumartin.ntc.corp.google.com ([2401:fa00:fc:202:9373:4bd4:5bf3:5d5c])
 (user=liumartin job=sendgmr) by 2002:a05:690c:38c:b0:524:ae14:59ac with SMTP
 id bh12-20020a05690c038c00b00524ae1459acmr16ywb.5.1675693639587; Mon, 06 Feb
 2023 06:27:19 -0800 (PST)
Date:   Mon,  6 Feb 2023 22:27:14 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230206142714.4151047-1-liumartin@google.com>
Subject: [PATCH] of: reserved-mem: expose reserved-mem details via debugfs
From:   Martin Liu <liumartin@google.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        surenb@google.com, minchan@kernel.org, tkjos@google.com,
        liumartin@google.com
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

It's important to know reserved-mem information in mobile world
since reserved memory via device tree keeps increased in platform
(e.g., 45% in our platform). Therefore, it's crucial to know the
reserved memory sizes breakdown for the memory accounting.

This patch shows the reserved memory breakdown under debugfs to
make them visible.

Below is an example output:
cat $debugfs/reserved_mem/show
0x00000009fc400000..0x00000009ffffffff (   61440 KB )   map     reusable test1
0x00000009f9000000..0x00000009fc3fffff (   53248 KB )   map     reusable test2
0x00000000ffdf0000..0x00000000ffffffff (    2112 KB )   map non-reusable test3
0x00000009f6000000..0x00000009f8ffffff (   49152 KB )   map     reusable test4
...
0x00000000fd902000..0x00000000fd909fff (      32 KB ) nomap non-reusable test38
0x00000000fd90a000..0x00000000fd90bfff (       8 KB ) nomap non-reusable test39
Total 39 regions, 1446140 KB

Signed-off-by: Martin Liu <liumartin@google.com>
---
 drivers/of/of_reserved_mem.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 65f3b02a0e4e..a73228e07c8c 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -23,6 +23,7 @@
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
 #include <linux/cma.h>
+#include <linux/debugfs.h>
 
 #include "of_private.h"
 
@@ -446,3 +447,41 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
+
+#if defined(CONFIG_DEBUG_FS)
+static int of_reserved_mem_debug_show(struct seq_file *m, void *private)
+{
+	unsigned int i;
+	size_t sum = 0;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		const struct reserved_mem *rmem = &reserved_mem[i];
+		unsigned long node = rmem->fdt_node;
+		phys_addr_t end = rmem->base + rmem->size - 1;
+		bool nomap = (of_get_flat_dt_prop(node, "no-map", NULL)) != NULL;
+		bool reusable = (of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+
+		sum += rmem->size;
+		seq_printf(m, "%pa..%pa ( %7lu KB ) %5s %12s %s\n", &rmem->base,
+			   &end, rmem->size / 1024,
+			   nomap ? "nomap" : "map",
+			   reusable ? "reusable" : "non-reusable",
+			   rmem->name ? rmem->name : "unknown");
+	}
+	seq_printf(m, "Total %d regions, %zu KB\n",
+		   reserved_mem_count,
+		   sum / 1024);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(of_reserved_mem_debug);
+
+static int __init of_reserved_mem_init_debugfs(void)
+{
+	struct dentry *root = debugfs_create_dir("reserved_mem", NULL);
+
+	debugfs_create_file("show", 0444, root,
+			    NULL, &of_reserved_mem_debug_fops);
+	return 0;
+}
+device_initcall(of_reserved_mem_init_debugfs);
+#endif
-- 
2.39.1.519.gcb327c4b5f-goog

