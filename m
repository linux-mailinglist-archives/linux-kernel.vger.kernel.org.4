Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B445FBBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJKUB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJKUBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:01:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4129A9AF82
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:01:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 129so13709716pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4TJwuezge9Mh06wwbhfzGnSBhH+7qHpmKOCGYYt5js=;
        b=NAyYyKndvGerX3OhbNfX4E1T1IG9GxkYlz4nDLBUVurjW8EKYLMbdE23o4eaNEStF5
         eB88AsLwfbV41kQjBOO/Dxe+EFhgAj18GIe53KHvCXjRFFVlku3JMSwWnpDenf24lhlr
         AbnIvMER8N2Z4o0HCnIOgvu0/xptLWhn2mb9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4TJwuezge9Mh06wwbhfzGnSBhH+7qHpmKOCGYYt5js=;
        b=yET5PSca+VjFaWaXrurR5Mjo4+EIusAZpnqZsM1aYz34tXDD9VV/LZ3xvqXOpLda/x
         1BDkN7d6ZqEy8WSvaLFJxBjrV70W/3PnaBamNS6DE0x59RPms585h0kOhLGywY70803C
         hV9p1HrvDM0jKX0u7CyhA7i9KQmRyDMEXwEYB7oj0BSXRivA4GZIWu+omQPpS7KH/L4X
         Kv9J0xgG+nydVMs08swcs+Fx7aNDEHRL8fc5X1NXJXKX02usJ8mSe+N22h6eE2O7hCmD
         92piicDMteRKSYwtJy1ekCLRVoRotggBfO3Q08we5KV+3tIg0X3dvF/Gdti7HZdIy07D
         THQg==
X-Gm-Message-State: ACrzQf0hBn2qvOx55kxd5FexpJpDoWHETvHaK7cTnnrOkUW1SK0FDw6u
        TTo9lRXVK4CYzzwISBn8gdx23g==
X-Google-Smtp-Source: AMsMyM5kvs8CSEikdaNqPsNTkrOn5iGKqs5oNUUwZZVu4WwGJ92PFzSu0xJko+00sORNOLaqfaJPhg==
X-Received: by 2002:a63:f706:0:b0:462:4961:9a11 with SMTP id x6-20020a63f706000000b0046249619a11mr10481657pgh.462.1665518477706;
        Tue, 11 Oct 2022 13:01:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 189-20020a6205c6000000b00562adeac326sm9396039pff.102.2022.10.11.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:01:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] pstore/ram: Move internal definitions out of kernel-wide include
Date:   Tue, 11 Oct 2022 13:01:10 -0700
Message-Id: <20221011200112.731334-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011200112.731334-1-keescook@chromium.org>
References: <20221011200112.731334-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8843; h=from:subject; bh=LmJeC/PUQwSJn7nPeE53VD7aB+ZaBpI84i+Sx32jgYQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjRcuH1cA4HUNXpnFdiESiQwbNsrS7Yhj08TlaarYL x6G7qFmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0XLhwAKCRCJcvTf3G3AJlDkEA CfOhUK9wRIS0Fm0hlwbkgi57FaGFCz2w9XNVS2zYGuExCPIwu58CF0GsubEAKP1a9Dxn90zYmSQSsB nYMBdGpDHLzuK53wfgXXefFDvAXWOegqVzd2SQqKVwRBOS3jLGvex2k2EQWVAkgVNeBx2LHgCOQgTl 056Ub4HtS0opl0huj8ubp6aUMjJO8NsyN/9c6/RUDotziDxFTDqFA3hfWptQnG8LuHElH6YGGA6kBS 58nJ8r3qwZuJ4ZmAa/2M8WEqCdUYJWmOMqfOS983XCtvPl01YV9xhQysq5HDWwOrjeW91+Zq28EHX1 vzZEl3QHOVs92/9krTJ/Sy6VAid1MZ3emcc9aSLQkGBewI3WLfm/C+Phzf5Y5RZMqJY5zAiXHv2BE9 rXyD7+LFukmh8vOfpKiT8VsaBmvQW67tuU1YaKOzo5aJETjIPxVn3jIPBVzxsx9PV1zsvIaJ4ZesV7 hq8dfWfP5rgjDWWLnj40FExtdZP1BUbbHJ7aCVsNgnFu5fLCqYks/uheU5iCj3YwRoNMj7pwAkfc3U ax9fFkBKOvDyIkjVXVVzw28cnk4gMj0r8j2gJ3oPILDhjBT0JjoZu4vw5ULIqQcKn5s/BnzFham1bQ dM3KwFwm/l/WWLJufSxbvUsump9OP3jRjVX1mBEw1P4Y1zYJiL66aqLXXHqA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the details of the ram backend are entirely internal to the
backend itself. Leave only what is needed to instantiate a ram backend
in the kernel-wide header.

Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c            |  3 +-
 fs/pstore/ram_core.c       |  3 +-
 fs/pstore/ram_internal.h   | 98 +++++++++++++++++++++++++++++++++++++
 include/linux/pstore_ram.h | 99 --------------------------------------
 4 files changed, 102 insertions(+), 101 deletions(-)
 create mode 100644 fs/pstore/ram_internal.h

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 2f18563c8141..f5bf360cf905 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -18,10 +18,11 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/compiler.h>
-#include <linux/pstore_ram.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+
 #include "internal.h"
+#include "ram_internal.h"
 
 #define RAMOOPS_KERNMSG_HDR "===="
 #define MIN_MEM_SIZE 4096UL
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index a89e33719fcf..9e1047f4316d 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -13,13 +13,14 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
-#include <linux/pstore_ram.h>
 #include <linux/rslib.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 #include <asm/page.h>
 
+#include "ram_internal.h"
+
 /**
  * struct persistent_ram_buffer - persistent circular RAM buffer
  *
diff --git a/fs/pstore/ram_internal.h b/fs/pstore/ram_internal.h
new file mode 100644
index 000000000000..440ee7a35e10
--- /dev/null
+++ b/fs/pstore/ram_internal.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2010 Marco Stornelli <marco.stornelli@gmail.com>
+ * Copyright (C) 2011 Kees Cook <keescook@chromium.org>
+ * Copyright (C) 2011 Google, Inc.
+ */
+
+#include <linux/pstore_ram.h>
+
+/*
+ * Choose whether access to the RAM zone requires locking or not.  If a zone
+ * can be written to from different CPUs like with ftrace for example, then
+ * PRZ_FLAG_NO_LOCK is used. For all other cases, locking is required.
+ */
+#define PRZ_FLAG_NO_LOCK	BIT(0)
+/*
+ * If a PRZ should only have a single-boot lifetime, this marks it as
+ * getting wiped after its contents get copied out after boot.
+ */
+#define PRZ_FLAG_ZAP_OLD	BIT(1)
+
+/**
+ * struct persistent_ram_zone - Details of a persistent RAM zone (PRZ)
+ *                              used as a pstore backend
+ *
+ * @paddr:	physical address of the mapped RAM area
+ * @size:	size of mapping
+ * @label:	unique name of this PRZ
+ * @type:	frontend type for this PRZ
+ * @flags:	holds PRZ_FLAGS_* bits
+ *
+ * @buffer_lock:
+ *	locks access to @buffer "size" bytes and "start" offset
+ * @buffer:
+ *	pointer to actual RAM area managed by this PRZ
+ * @buffer_size:
+ *	bytes in @buffer->data (not including any trailing ECC bytes)
+ *
+ * @par_buffer:
+ *	pointer into @buffer->data containing ECC bytes for @buffer->data
+ * @par_header:
+ *	pointer into @buffer->data containing ECC bytes for @buffer header
+ *	(i.e. all fields up to @data)
+ * @rs_decoder:
+ *	RSLIB instance for doing ECC calculations
+ * @corrected_bytes:
+ *	ECC corrected bytes accounting since boot
+ * @bad_blocks:
+ *	ECC uncorrectable bytes accounting since boot
+ * @ecc_info:
+ *	ECC configuration details
+ *
+ * @old_log:
+ *	saved copy of @buffer->data prior to most recent wipe
+ * @old_log_size:
+ *	bytes contained in @old_log
+ *
+ */
+struct persistent_ram_zone {
+	phys_addr_t paddr;
+	size_t size;
+	void *vaddr;
+	char *label;
+	enum pstore_type_id type;
+	u32 flags;
+
+	raw_spinlock_t buffer_lock;
+	struct persistent_ram_buffer *buffer;
+	size_t buffer_size;
+
+	char *par_buffer;
+	char *par_header;
+	struct rs_control *rs_decoder;
+	int corrected_bytes;
+	int bad_blocks;
+	struct persistent_ram_ecc_info ecc_info;
+
+	char *old_log;
+	size_t old_log_size;
+};
+
+struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
+			u32 sig, struct persistent_ram_ecc_info *ecc_info,
+			unsigned int memtype, u32 flags, char *label);
+void persistent_ram_free(struct persistent_ram_zone *prz);
+void persistent_ram_zap(struct persistent_ram_zone *prz);
+
+int persistent_ram_write(struct persistent_ram_zone *prz, const void *s,
+			 unsigned int count);
+int persistent_ram_write_user(struct persistent_ram_zone *prz,
+			      const void __user *s, unsigned int count);
+
+void persistent_ram_save_old(struct persistent_ram_zone *prz);
+size_t persistent_ram_old_size(struct persistent_ram_zone *prz);
+void *persistent_ram_old(struct persistent_ram_zone *prz);
+void persistent_ram_free_old(struct persistent_ram_zone *prz);
+ssize_t persistent_ram_ecc_string(struct persistent_ram_zone *prz,
+	char *str, size_t len);
diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
index 9f16afec7290..9d65ff94e216 100644
--- a/include/linux/pstore_ram.h
+++ b/include/linux/pstore_ram.h
@@ -8,28 +8,7 @@
 #ifndef __LINUX_PSTORE_RAM_H__
 #define __LINUX_PSTORE_RAM_H__
 
-#include <linux/compiler.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
 #include <linux/pstore.h>
-#include <linux/types.h>
-
-/*
- * Choose whether access to the RAM zone requires locking or not.  If a zone
- * can be written to from different CPUs like with ftrace for example, then
- * PRZ_FLAG_NO_LOCK is used. For all other cases, locking is required.
- */
-#define PRZ_FLAG_NO_LOCK	BIT(0)
-/*
- * If a PRZ should only have a single-boot lifetime, this marks it as
- * getting wiped after its contents get copied out after boot.
- */
-#define PRZ_FLAG_ZAP_OLD	BIT(1)
-
-struct persistent_ram_buffer;
-struct rs_control;
 
 struct persistent_ram_ecc_info {
 	int block_size;
@@ -39,84 +18,6 @@ struct persistent_ram_ecc_info {
 	uint16_t *par;
 };
 
-/**
- * struct persistent_ram_zone - Details of a persistent RAM zone (PRZ)
- *                              used as a pstore backend
- *
- * @paddr:	physical address of the mapped RAM area
- * @size:	size of mapping
- * @label:	unique name of this PRZ
- * @type:	frontend type for this PRZ
- * @flags:	holds PRZ_FLAGS_* bits
- *
- * @buffer_lock:
- *	locks access to @buffer "size" bytes and "start" offset
- * @buffer:
- *	pointer to actual RAM area managed by this PRZ
- * @buffer_size:
- *	bytes in @buffer->data (not including any trailing ECC bytes)
- *
- * @par_buffer:
- *	pointer into @buffer->data containing ECC bytes for @buffer->data
- * @par_header:
- *	pointer into @buffer->data containing ECC bytes for @buffer header
- *	(i.e. all fields up to @data)
- * @rs_decoder:
- *	RSLIB instance for doing ECC calculations
- * @corrected_bytes:
- *	ECC corrected bytes accounting since boot
- * @bad_blocks:
- *	ECC uncorrectable bytes accounting since boot
- * @ecc_info:
- *	ECC configuration details
- *
- * @old_log:
- *	saved copy of @buffer->data prior to most recent wipe
- * @old_log_size:
- *	bytes contained in @old_log
- *
- */
-struct persistent_ram_zone {
-	phys_addr_t paddr;
-	size_t size;
-	void *vaddr;
-	char *label;
-	enum pstore_type_id type;
-	u32 flags;
-
-	raw_spinlock_t buffer_lock;
-	struct persistent_ram_buffer *buffer;
-	size_t buffer_size;
-
-	char *par_buffer;
-	char *par_header;
-	struct rs_control *rs_decoder;
-	int corrected_bytes;
-	int bad_blocks;
-	struct persistent_ram_ecc_info ecc_info;
-
-	char *old_log;
-	size_t old_log_size;
-};
-
-struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
-			u32 sig, struct persistent_ram_ecc_info *ecc_info,
-			unsigned int memtype, u32 flags, char *label);
-void persistent_ram_free(struct persistent_ram_zone *prz);
-void persistent_ram_zap(struct persistent_ram_zone *prz);
-
-int persistent_ram_write(struct persistent_ram_zone *prz, const void *s,
-			 unsigned int count);
-int persistent_ram_write_user(struct persistent_ram_zone *prz,
-			      const void __user *s, unsigned int count);
-
-void persistent_ram_save_old(struct persistent_ram_zone *prz);
-size_t persistent_ram_old_size(struct persistent_ram_zone *prz);
-void *persistent_ram_old(struct persistent_ram_zone *prz);
-void persistent_ram_free_old(struct persistent_ram_zone *prz);
-ssize_t persistent_ram_ecc_string(struct persistent_ram_zone *prz,
-	char *str, size_t len);
-
 /*
  * Ramoops platform data
  * @mem_size	memory size for ramoops
-- 
2.34.1

