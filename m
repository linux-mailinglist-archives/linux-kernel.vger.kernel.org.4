Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B5B6AE1EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCGONJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjCGOMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20F87357
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB5F7B81903
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61930C433A7;
        Tue,  7 Mar 2023 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198140;
        bh=xuULnbPfbdttGoFOmg13d9wHbRDgqXccUG7zc0Xws00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngCYk9bgPrkWxLrO/DwctYGOfpl/Q05CONePs/WxVd+HIvSDWTC3xFQ8ZcQFBAKT5
         12xahHMOJ0OLIEJ8t3h0RxasgdkSgkaURegHIqbtzUAl6dfZ9dQ6qewtnRxvM2mshP
         oqp3nvPUxlXRcdhABrMVAn9DvTvUyEzpY4VDQytcYkKnKIU1wOMoeRENPGT3vRiuTC
         m1QkKryos2bl6wPHy0pQlORMSgRLAOJeYHCF9BQhCIFG9o/NW+zAKNJ2/87CqLuDYG
         WJmOEE1+W0Hh54MaowkecB17GiGnFHzVaFmWXKZCrzZOa9igvtuZYIEg5qW2nb9lxf
         QlHH6kjJU5OvA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 59/60] mm: add arch hook to validate mmap() prot flags
Date:   Tue,  7 Mar 2023 15:05:21 +0100
Message-Id: <20230307140522.2311461-60-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=ardb@kernel.org; h=from:subject; bh=xuULnbPfbdttGoFOmg13d9wHbRDgqXccUG7zc0Xws00=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdZeGyK2eU0oUmac6b8DmnMD7ezH3OIq2tu4KmLvTJX f1uWr50RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZgIlyLD/6qfL5S3a57yOmL8 6ewT7hB97bz6Y07vEsNkHuWGzFNhDGL4pydebBxtee/HmRUXhZfp9srMFLqW+lNEvCjoVXJR7J9 ePgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hook to permit architectures to perform validation on the prot
flags passed to mmap(), like arch_validate_prot() does for mprotect().
This will be used by arm64 to reject PROT_WRITE+PROT_EXEC mappings on
configurations that run with WXN enabled.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/mman.h | 15 +++++++++++++++
 mm/mmap.c            |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index cee1e4b566d80095..25ffe6948fa21ff8 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -120,6 +120,21 @@ static inline bool arch_validate_flags(unsigned long flags)
 #define arch_validate_flags arch_validate_flags
 #endif
 
+#ifndef arch_validate_mmap_prot
+/*
+ * This is called from mmap(), which ignores unknown prot bits so the default
+ * is to accept anything.
+ *
+ * Returns true if the prot flags are valid
+ */
+static inline bool arch_validate_mmap_prot(unsigned long prot,
+					   unsigned long addr)
+{
+	return true;
+}
+#define arch_validate_mmap_prot arch_validate_mmap_prot
+#endif
+
 /*
  * Optimisation macro.  It is equivalent to:
  *      (x & bit1) ? bit2 : 0
diff --git a/mm/mmap.c b/mm/mmap.c
index 740b54be3ed4140f..02ccd45df0194796 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1214,6 +1214,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		if (!(file && path_noexec(&file->f_path)))
 			prot |= PROT_EXEC;
 
+	if (!arch_validate_mmap_prot(prot, addr))
+		return -EACCES;
+
 	/* force arch specific MAP_FIXED handling in get_unmapped_area */
 	if (flags & MAP_FIXED_NOREPLACE)
 		flags |= MAP_FIXED;
-- 
2.39.2

