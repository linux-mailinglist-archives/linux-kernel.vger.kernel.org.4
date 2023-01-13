Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF13A669CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjAMPvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjAMPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:50:00 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED3F7D269
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:42:57 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id e76so22767862ybh.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcODqOMs4kmXyIK9NRLS6X4ag83qwdUq4JEzAmDRzvU=;
        b=NrIMn+EGvvyFQLNvTF2p3fDVX6y06gxhZmoOs3RcOqCBpp61cU+ch788tI/meEMgl8
         C+AcjQmTPQOCmC7Akkcr2HjewRJN/S5lJsVBTrv/nQNOqkON6peWr8HUTje/8oF5GOPc
         byHK2EJ5c38X/nvZ01I65IBPVaw6AVLgZEkfz9VKPVqN49gsWxJl3CiDAjvuNbdVeLPT
         TShjDscb+9g6Mlx6aH7r82rWW13GnL17zKAReE3vUtBJmFNbg9vMMm69kUXQIaXUrNta
         56JCZKjhZ3BNvAS2pmQRDv9kWcZIlX5xwXzDb+skwsgahphNCwZDmU4h19eq0maf1BKl
         Bw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcODqOMs4kmXyIK9NRLS6X4ag83qwdUq4JEzAmDRzvU=;
        b=rWANPustX8D70D5Vsfz2jA8enNCljoM2VIiZwS0GKwMHex4HIzNYmL1/V6f6jNBpfN
         bqvp2+StWzuy6IYXsvVFBX/qG0ZsDDVwB47n2WMkskvQDaVWmjJU+/vG/yKIu95pDcWe
         FWwoh0n9JcnVV0sdJy2SPJ+eZufGjR6OlCHN7tZ7CC6rmlHwHkvjsugR+Rl2HWJ/Nv5C
         cmGETERXaa1a2LaoezU6hB1PXKNBxmW9sb+WxpvgQDgcbnfVeLSqcSnH/zKDHO9QLfXG
         uU67GKqmI1Dvogf0gqGtk0nmw+tyihN1+NvZvIfAUWpaW8wpAOAXgRbLrBwFsitvkLLw
         3GdA==
X-Gm-Message-State: AFqh2kqDSR0waa7Ii1ooBorCmvNz1pZdzdDjAGe1rPgmFj8f1C5sDUmY
        iUA9BT5qudOHUgnJgKxcWyjVCA==
X-Google-Smtp-Source: AMrXdXsE8lqjUzTinL01kK0qcQ1nLyyGH4tcf9i7DwikeQBusCPoLcGcKu9VPICbR9Fal1Vu24+JOQ==
X-Received: by 2002:a25:d20b:0:b0:703:1e28:5734 with SMTP id j11-20020a25d20b000000b007031e285734mr8221723ybg.42.1673624576931;
        Fri, 13 Jan 2023 07:42:56 -0800 (PST)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id c15-20020ae9ed0f000000b006fafc111b12sm12716266qkg.83.2023.01.13.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:42:56 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, david@redhat.com,
        quic_charante@quicinc.com, lizhe.67@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3] mm/page_ext: Do not allocate space for page_ext->flags if not needed
Date:   Fri, 13 Jan 2023 15:42:53 +0000
Message-Id: <20230113154253.92480-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is 8 byte page_ext->flags field allocated per page whenever
CONFIG_PAGE_EXTENSION is enabled. However, not every user of page_ext
uses flags. Therefore, check whether flags is needed at least by one
user and if so allocate space for it.

For example when page_table_check is enabled, on a machine with 128G
of memory before the fix:

[    2.244288] allocated 536870912 bytes of page_ext
after the fix:
[    2.160154] allocated 268435456 bytes of page_ext

Also, add a comment before page_ext_operations that describes the
field, and remove check if need() is set, as that is now a required
field.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ext.h | 19 +++++++++++++++++++
 mm/page_ext.c            | 14 ++++++++++++--
 mm/page_owner.c          |  1 +
 mm/page_table_check.c    |  1 +
 4 files changed, 33 insertions(+), 2 deletions(-)

Changelog:
v2: Fixed field name in page_owner.c that caused build error.
v3: Added comment before page_ext_operations, removed check if
    need is null.

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 22be4582faae..be0b465c7d78 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -7,15 +7,31 @@
 #include <linux/stackdepot.h>
 
 struct pglist_data;
+
+/*
+ * Each Page Extension client must define page_ext_operations in
+ * page_ext_ops array.
+ * offset  offset to the client's data within page_ext. Offset is returned to
+ *         the client by page_ext_init.
+ * size    the size of the client data within page_ext.
+ * need()  function that returns true if client requires page_ext
+ * init()  (optional) called to initialize client once page_exts are allocated.
+ * using_shared_ext_flags  true when client is using shared page_ext->flags
+ *         field.
+ */
 struct page_ext_operations {
 	size_t offset;
 	size_t size;
 	bool (*need)(void);
 	void (*init)(void);
+	bool using_shared_ext_flags;
 };
 
 #ifdef CONFIG_PAGE_EXTENSION
 
+/*
+ * The page_ext_flags users must set using_shared_ext_flags to true.
+ */
 enum page_ext_flags {
 	PAGE_EXT_OWNER,
 	PAGE_EXT_OWNER_ALLOCATED,
@@ -31,6 +47,9 @@ enum page_ext_flags {
  * page_ext helps us add more information about the page.
  * All page_ext are allocated at boot or memory hotplug event,
  * then the page_ext for pfn always exists.
+ * Note: that if none of the users of page_ext is setting
+ * using_shared_ext_flags to true, the field cannot be used,
+ * as it will be overlapped with another data.
  */
 struct page_ext {
 	unsigned long flags;
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4ee522fd381c..d14dbd44fa49 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -71,6 +71,7 @@ static bool need_page_idle(void)
 }
 static struct page_ext_operations page_idle_ops __initdata = {
 	.need = need_page_idle,
+	.using_shared_ext_flags = true,
 };
 #endif
 
@@ -86,7 +87,7 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 #endif
 };
 
-unsigned long page_ext_size = sizeof(struct page_ext);
+unsigned long page_ext_size;
 
 static unsigned long total_usage;
 static struct page_ext *lookup_page_ext(const struct page *page);
@@ -106,7 +107,16 @@ static bool __init invoke_need_callbacks(void)
 	bool need = false;
 
 	for (i = 0; i < entries; i++) {
-		if (page_ext_ops[i]->need && page_ext_ops[i]->need()) {
+		if (page_ext_ops[i]->need()) {
+			if (page_ext_ops[i]->using_shared_ext_flags) {
+				page_ext_size = sizeof(struct page_ext);
+				break;
+			}
+		}
+	}
+
+	for (i = 0; i < entries; i++) {
+		if (page_ext_ops[i]->need()) {
 			page_ext_ops[i]->offset = page_ext_size;
 			page_ext_size += page_ext_ops[i]->size;
 			need = true;
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2d27f532df4c..1a62ab3fc00e 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -99,6 +99,7 @@ struct page_ext_operations page_owner_ops = {
 	.size = sizeof(struct page_owner),
 	.need = need_page_owner,
 	.init = init_page_owner,
+	.using_shared_ext_flags = true,
 };
 
 static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 93e633c1d587..74cfe89d5f53 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -45,6 +45,7 @@ struct page_ext_operations page_table_check_ops = {
 	.size = sizeof(struct page_table_check),
 	.need = need_page_table_check,
 	.init = init_page_table_check,
+	.using_shared_ext_flags = false,
 };
 
 static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
-- 
2.39.0.314.g84b9a713c41-goog

