Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524A16B4D25
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCJQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjCJQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:36:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B791194C5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:34:10 -0800 (PST)
Date:   Fri, 10 Mar 2023 17:29:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678465747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uBAEWUyZKwUmKqqazL7gQLTZOP1jiWdjfH5fZ0edGUU=;
        b=NNSiKyB5IHTrbMB6dmMGiaJR/tftZeADFMcbX6qlAmPMVpm4BNi+71bCAY99Fu5GianfuH
        qqPCjRR402JCDU/QYbl7b4ccm0S7dljJ2zAPiSYSKNVmawQyXBLlWxynf2Hg1wedOgNVMC
        J6zIk+EP4Y9tHMztNCeFEgLRCurwqVDEPP2x/+q8larNso2hwgfYkZsmzMX37tysq1+PTL
        FtLEc5rjUXrTMYlgrLBJZUPj7rGiaKmrT9jhMRH83fkWQOsB460ziWx+Q952ScHQdTIs04
        n2UxtsrZziUQBS5ULb94KRqsReshl0en9jRXMU3vYVEf5xQYn53seuSeFw6+gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678465747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uBAEWUyZKwUmKqqazL7gQLTZOP1jiWdjfH5fZ0edGUU=;
        b=1m605YEJfNMKkZvmYF5/huSgj0u4P+9jWQI0PxQVSk46rYUwrfXNs1X5gf1+WyTNPcUIgV
        qcP6tOSAO91Vs5Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: [PATCH] io-mapping: Don't disable preempt on RT in
 io_mapping_map_atomic_wc().
Message-ID: <20230310162905.O57Pj7hh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io_mapping_map_atomic_wc() disables preemption and pagefaults for historical
reasons. The conversion to io_mapping_map_local_wc(), which only disables
migration, cannot be done wholesale because quite some call sites need to be
updated to accommodate with the changed semantics.

On PREEMPT_RT enabled kernels the io_mapping_map_atomic_wc() semantics are
problematic due to the implicit disabling of preemption which makes it
impossible to acquire 'sleeping' spinlocks within the mapped atomic sections.

PREEMPT_RT replaces the preempt_disable() with a migrate_disable() for
more than a decade. It could be argued that this is a justification to do
this unconditionally, but PREEMPT_RT covers only a limited number of
architectures and it disables some functionality which limits the coverage
further.

Limit the replacement to PREEMPT_RT for now. This is also done
kmap_atomic().

Reported-by: Richard Weinberger <richard.weinberger@gmail.com>
Link: https://lore.kernel.org/CAFLxGvw0WMxaMqYqJ5WgvVSbKHq2D2xcXTOgMCpgq9nDC-MWTQ@mail.gmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Richard reported it against the i915 driver. I got offlist another
report and this reporter confirmed that it fixes the issue while no
glitches or other problems were observed (in the kernel log and on
screen).

 include/linux/io-mapping.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index 09d4f17c8d3b6..7376c1df9c901 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -69,7 +69,10 @@ io_mapping_map_atomic_wc(struct io_mapping *mapping,
 
 	BUG_ON(offset >= mapping->size);
 	phys_addr = mapping->base + offset;
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+	else
+		migrate_disable();
 	pagefault_disable();
 	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
 }
@@ -79,7 +82,10 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 {
 	kunmap_local_indexed((void __force *)vaddr);
 	pagefault_enable();
-	preempt_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	else
+		migrate_enable();
 }
 
 static inline void __iomem *
@@ -162,7 +168,10 @@ static inline void __iomem *
 io_mapping_map_atomic_wc(struct io_mapping *mapping,
 			 unsigned long offset)
 {
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+	else
+		migrate_disable();
 	pagefault_disable();
 	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
 }
@@ -172,7 +181,10 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 {
 	io_mapping_unmap(vaddr);
 	pagefault_enable();
-	preempt_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	else
+		migrate_enable();
 }
 
 static inline void __iomem *
-- 
2.39.2

