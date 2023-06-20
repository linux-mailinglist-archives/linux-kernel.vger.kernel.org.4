Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68D736E61
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjFTOKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjFTOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B83E68
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687270196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqzD+6X0IKQNZN3ZvD+oTa51EhB1X9vozv9qaWAmHMs=;
        b=UAeJ2dcF8Kx+I7ORW0oFvxxgUB6SP/SKXjw+sfeQLtmgb/mSQnI8yVuH/7W2KfTfjQbOgX
        5CNN0CgM/q3F2w1g3FkpKxWUXQ0wG3mBzqhznD74S1ZlLDo4UXVf4BZb/nLX0IajQAyJlb
        F/bkuRS7j2/43HoKRbckumdUpFcQELg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-VnIh31SuOY-wqOcCljomwQ-1; Tue, 20 Jun 2023 10:09:25 -0400
X-MC-Unique: VnIh31SuOY-wqOcCljomwQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82C6228EA712;
        Tue, 20 Jun 2023 14:06:32 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7CDF425357;
        Tue, 20 Jun 2023 14:06:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Robin Jarry <rjarry@redhat.com>,
        Joe Mario <jmario@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/5] x86/speculation: Provide a debugfs file to dump SPEC_CTRL MSRs
Date:   Tue, 20 Jun 2023 10:06:21 -0400
Message-Id: <20230620140625.1001886-2-longman@redhat.com>
In-Reply-To: <20230620140625.1001886-1-longman@redhat.com>
References: <20230620140625.1001886-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes it is useful to know the states the SPEC_CTRL MSRs to see what
mitigations are enabled at run time. Provide a new x86/spec_ctrl_msrs
debugfs file to dump the cached versions of the current SPEC_CTRL MSRs.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/cpu/bugs.c | 79 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 182af64387d0..f6e5910a4a2d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -17,6 +17,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/debugfs.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -1733,6 +1734,84 @@ void cpu_bugs_smt_update(void)
 	mutex_unlock(&spec_ctrl_mutex);
 }
 
+#ifdef CONFIG_DEBUG_FS
+/*
+ * Provide a debugfs file to dump SPEC_CTRL MSRs of all the CPUs
+ * Consecutive MSR values are collapsed together if they are the same.
+ */
+static ssize_t spec_ctrl_msrs_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	int bufsiz = min(count, PAGE_SIZE);
+	int cpu, prev_cpu, len, cnt = 0;
+	u64 val, prev_val;
+	char *buf;
+
+	/*
+	 * The MSRs info should be small enough that the whole buffer is
+	 * copied out in one call. However, user space may read it again
+	 * to see if there is any data left. Rereading the cached SPEC_CTRL
+	 * MSR values may produce a different result causing corruption in
+	 * output data. So skipping the call if *ppos is not starting from 0.
+	 */
+	if (*ppos)
+		return 0;
+
+	buf = kmalloc(bufsiz, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		val = per_cpu(x86_spec_ctrl_current, cpu);
+
+		if (!cpu)
+			goto next;
+
+		if (val == prev_val)
+			continue;
+
+		if (prev_cpu == cpu - 1)
+			len = snprintf(buf + cnt, bufsiz - cnt, "CPU  %d: 0x%llx\n",
+				       prev_cpu, prev_val);
+		else
+			len = snprintf(buf + cnt, bufsiz - cnt, "CPUs %d-%d: 0x%llx\n",
+					prev_cpu, cpu - 1, prev_val);
+
+		cnt += len;
+		if (!len)
+			break;	/* Out of buffer */
+next:
+		prev_cpu = cpu;
+		prev_val = val;
+	}
+
+	if (prev_cpu == cpu - 1)
+		cnt += snprintf(buf + cnt, bufsiz - cnt, "CPU  %d: 0x%llx\n",
+			       prev_cpu, prev_val);
+	else
+		cnt += snprintf(buf + cnt, bufsiz - cnt, "CPUs %d-%d: 0x%llx\n",
+				prev_cpu, cpu - 1, prev_val);
+
+	count = simple_read_from_buffer(user_buf, count, ppos, buf, cnt);
+	kfree(buf);
+	return count;
+}
+
+static const struct file_operations fops_spec_ctrl = {
+	.read = spec_ctrl_msrs_read,
+	.llseek = default_llseek,
+};
+
+static int __init init_spec_ctrl_debugfs(void)
+{
+	if (!debugfs_create_file("spec_ctrl_msrs", 0400, arch_debugfs_dir,
+				 NULL, &fops_spec_ctrl))
+		return -ENOMEM;
+	return 0;
+}
+fs_initcall(init_spec_ctrl_debugfs);
+#endif
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
-- 
2.31.1

