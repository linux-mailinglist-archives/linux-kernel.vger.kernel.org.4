Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36725734B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjFSGBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjFSGBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3351BB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687154415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npvsI02z3jgn80ioRaeUDRVaANboeER9FhCASltPe50=;
        b=WHsyGYRXl7bWPA0OSbyhf9Xe8H/CXzeaOuiXShNatrIkZFZCU5rABt3gRWdWZuULt+34FC
        JWqt0Ki7a9sE9hwgQtUF1sh3Gvu1CmqRWl3r43Tf8kX8KwHv1JeHdhxB3PglmIST1BlP7H
        7CQ/iFSCFdJMHYseFaWyO7JxJucXGHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-o-LmskG3NvWmoSivbOLQRw-1; Mon, 19 Jun 2023 02:00:13 -0400
X-MC-Unique: o-LmskG3NvWmoSivbOLQRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E92AD101A54E;
        Mon, 19 Jun 2023 06:00:12 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-194.pek2.redhat.com [10.72.12.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDA9112132C;
        Mon, 19 Jun 2023 06:00:07 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, horms@kernel.org,
        chenjiahao16@huawei.com, linux-riscv@lists.infradead.org,
        x86@kernel.org, bp@alien8.de, Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH 2/4] kdump: add generic functions to parse crashkernel and do reservation
Date:   Mon, 19 Jun 2023 13:59:49 +0800
Message-Id: <20230619055951.45620-3-bhe@redhat.com>
In-Reply-To: <20230619055951.45620-1-bhe@redhat.com>
References: <20230619055951.45620-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In architecture like x86_64, arm64 and riscv, they have vast virtual
address space and usually have huge physical memory RAM. Their
crashkernel reservation doesn't have to be limited under 4G RAM,
but can be extended to the whole physical memory via crashkernel=,high
support.

Now add function parse_crashkernel_generic() to parse all possible
crashkernel parameters, including crashkernel=xM[@offset],
crashkernel=,high|low. And add function reserve_crashkernel_generic()
to reserve crashkernel memory if users specify any case of above
kernel pamameters.

This is preparation to simplify code of crashkernel=,high support
in architecutures.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |  31 ++++++++
 kernel/crash_core.c        | 144 +++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 6ec10ed5c6a6..1b12868cad1b 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,35 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+int __init parse_crashkernel_generic(char *cmdline,
+				 unsigned long long *crash_size,
+				 unsigned long long *crash_base,
+				 unsigned long long *low_size,
+				 bool *high);
+
+void __init reserve_crashkernel_generic(char *cmdline,
+		unsigned long long crash_size,
+		unsigned long long crash_base,
+		unsigned long long crash_low_size,
+		bool high);
+#else
+
+static inline int __init parse_crashkernel_generic(char *cmdline,
+		unsigned long long *crash_size,
+		unsigned long long *crash_base,
+		unsigned long long *low_size,
+		bool *high)
+{
+	return 0;
+}
+
+static inline void __init reserve_crashkernel_generic(char *cmdline,
+		unsigned long long crash_size,
+		unsigned long long crash_base,
+		unsigned long long crash_low_size,
+		bool high)
+{}
+#endif
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 57738ca0ee7f..b82dc8c970de 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,9 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/memblock.h>
+#include <linux/kexec.h>
+#include <linux/kmemleak.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -310,6 +313,147 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+int __init parse_crashkernel_generic(char *cmdline,
+			     unsigned long long *crash_size,
+			     unsigned long long *crash_base,
+			     unsigned long long *low_size,
+			     bool *high)
+{
+	int ret;
+
+	/* crashkernel=X[@offset] */
+	ret = parse_crashkernel_common(cmdline, memblock_phys_mem_size(),
+				crash_size, crash_base);
+	if (ret == -ENOENT) {
+		ret = parse_crashkernel_high(cmdline, 0, crash_size, crash_base);
+		if (ret || !*crash_size)
+			return -1;
+
+		/*
+		 * crashkernel=Y,low can be specified or not, but invalid value
+		 * is not allowed.
+		 */
+		ret = parse_crashkernel_low(cmdline, 0, low_size, crash_base);
+		if (ret == -ENOENT)
+			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+		else if (ret)
+			return -1;
+
+		*high = true;
+	} else if (ret || !*crash_size) {
+		/* The specified value is invalid */
+		return -1;
+	}
+
+	return 0;
+}
+
+static int __init reserve_crashkernel_low(unsigned long long low_size)
+{
+#ifdef CONFIG_64BIT
+	unsigned long long low_base;
+
+	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
+	if (!low_base) {
+		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
+		return -ENOMEM;
+	}
+
+	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
+		low_base, low_base + low_size, low_size >> 20);
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end   = low_base + low_size - 1;
+	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
+	return 0;
+}
+
+void __init reserve_crashkernel_generic(char *cmdline,
+			     unsigned long long crash_size,
+			     unsigned long long crash_base,
+			     unsigned long long crash_low_size,
+			     bool high)
+{
+	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
+	bool fixed_base = false;
+
+	/* User specifies base address explicitly. */
+	if (crash_base) {
+		fixed_base = true;
+		search_base = crash_base;
+		search_end = crash_base + crash_size;
+	}
+
+	if (high) {
+		search_base = CRASH_ADDR_LOW_MAX;
+		search_end = CRASH_ADDR_HIGH_MAX;
+	}
+
+retry:
+	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
+					       search_base, search_end);
+	if (!crash_base) {
+		/*
+		 * For crashkernel=size[KMG]@offset[KMG], print out failure
+		 * message if can't reserve the specified region.
+		 */
+		if (fixed_base) {
+			pr_warn("crashkernel reservation failed - memory is in use.\n");
+			return;
+		}
+
+		/*
+		 * For crashkernel=size[KMG], if the first attempt was for
+		 * low memory, fall back to high memory, the minimum required
+		 * low memory will be reserved later.
+		 */
+		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
+			search_end = CRASH_ADDR_HIGH_MAX;
+			search_base = CRASH_ADDR_LOW_MAX;
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+			goto retry;
+		}
+
+		/*
+		 * For crashkernel=size[KMG],high, if the first attempt was
+		 * for high memory, fall back to low memory.
+		 */
+		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
+			search_end = CRASH_ADDR_LOW_MAX;
+			search_base = 0;
+			goto retry;
+		}
+		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
+			crash_size);
+		return;
+	}
+
+	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
+	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
+		memblock_phys_free(crash_base, crash_size);
+		return;
+	}
+
+	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		crash_base, crash_base + crash_size, crash_size >> 20);
+
+	/*
+	 * The crashkernel memory will be removed from the kernel linear
+	 * map. Inform kmemleak so that it won't try to access it.
+	 */
+	kmemleak_ignore_phys(crash_base);
+	if (crashk_low_res.end)
+		kmemleak_ignore_phys(crashk_low_res.start);
+
+	crashk_res.start = crash_base;
+	crashk_res.end = crash_base + crash_size - 1;
+	insert_resource(&iomem_resource, &crashk_res);
+}
+#endif
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
-- 
2.34.1

