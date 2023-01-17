Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9529B670B33
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjAQWGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjAQWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:04:19 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B97E16307
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:21:07 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id k6so24590147vsk.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1zg9S1unmML51wggskQ/tkuvQeGqpwGJV4esxPGJRUo=;
        b=JLJdOl009aot+nrMeCM5C1JKpOsuZ+h6D/BvkaK2hT/o43mwon77NvHBk8/izyWUU/
         i4GDL4FiTOUIKYQ4bY45laKBk9oKN7aZpQIRNjxGZ9HWQBNJmj1ofpDh6TszP7ypZnl1
         5agrjCZEJqDVIH2sSO9SvqiiCoxwoTmtlW2u5LR3aFl48S3ayOug2Z/AOa44qng1KUXZ
         mbw7zcRzH78ACfXIbaHsVHG4bpojz6Ij2lq+oWV1KXyw7iLFr1kGonrvPuJSSaAnBXNJ
         hr8OpSHmTW49bkLzLu8cjybfTO2H0269g4qYuuteaekUdDRV6GT0COSq81Wodp7bbWhQ
         NFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zg9S1unmML51wggskQ/tkuvQeGqpwGJV4esxPGJRUo=;
        b=GN2EpqxjP3Rxi6lbUMuXBUgmj8jSECIxpiGAppIgbUhwAgt5BNihbeFjFbKzsYqa1X
         asp5wbDA104bHRmAdXR6XyXxGnTnolA/3wvjKanJtSUJExxdM/oI3j8BIicEKUxqJMuc
         fhm4X2JZf9kYcbtYMVop7ga2zBI8SyjUs8ZvSfrxKSZ1pkpLpGuCHuk3+Oim5bJLxzGi
         X2nOYc/KpUWE5cdabETPekZXRjNw61JFlqYCFy4HdBQ5lSmtifaM3/5ID1ik/vtbV0fv
         DobC5uquti2YT+zhv0dvo2by7XAFcQX5Nr5Uia7GAQxSRz5vsBBQlyKucvsJp3Y2222F
         RAzA==
X-Gm-Message-State: AFqh2kqm3W/gddXIARs93Ppcu9CJ11VGGQjCtOR5Jx3cDDNkdbllSAWc
        edAtmZNpAhgTIf1pst8DOWC4FQ==
X-Google-Smtp-Source: AMrXdXs6SG+Ub80KW1QWuDv3yN7xOZkTR5LMb4bbNvgE4IDL8MMconCg45Kq7GyVqxf+E5jUhPr8jw==
X-Received: by 2002:a67:ffd3:0:b0:3d0:a5f0:bee5 with SMTP id w19-20020a67ffd3000000b003d0a5f0bee5mr2177202vsq.18.1673986866455;
        Tue, 17 Jan 2023 12:21:06 -0800 (PST)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 195-20020a370ccc000000b007023fc46b64sm20688193qkm.113.2023.01.17.12.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:21:06 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, rppt@kernel.org,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, quic_charante@quicinc.com,
        lizhe.67@bytedance.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4] mm/page_ext: Do not allocate space for page_ext->flags if not needed
Date:   Tue, 17 Jan 2023 20:21:03 +0000
Message-Id: <20230117202103.1412449-1-pasha.tatashin@soleen.com>
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

Also, add a kernel-doc comment before page_ext_operations that describes
the fields, and remove check if need() is set, as that is now a required
field.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page_ext.h | 18 ++++++++++++++++++
 mm/page_ext.c            | 14 ++++++++++++--
 mm/page_owner.c          |  1 +
 mm/page_table_check.c    |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

Changelog:
v4: Addressed comments from Mike Rapoport, added Acked-by's.
v3: Added comment before page_ext_operations, removed check if
    need is null.
v2: Fixed field name in page_owner.c that caused build error.

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 22be4582faae..67314f648aeb 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -7,15 +7,33 @@
 #include <linux/stackdepot.h>
 
 struct pglist_data;
+
+/**
+ * struct page_ext_operations - per page_ext client operations
+ * @offset: Offset to the client's data within page_ext. Offset is returned to
+ *          the client by page_ext_init.
+ * @size: The size of the client data within page_ext.
+ * @need: Function that returns true if client requires page_ext.
+ * @init: (optional) Called to initialize client once page_exts are allocated.
+ * @need_shared_flags: True when client is using shared page_ext->flags
+ *                     field.
+ *
+ * Each Page Extension client must define page_ext_operations in
+ * page_ext_ops array.
+ */
 struct page_ext_operations {
 	size_t offset;
 	size_t size;
 	bool (*need)(void);
 	void (*init)(void);
+	bool need_shared_flags;
 };
 
 #ifdef CONFIG_PAGE_EXTENSION
 
+/*
+ * The page_ext_flags users must set need_shared_flags to true.
+ */
 enum page_ext_flags {
 	PAGE_EXT_OWNER,
 	PAGE_EXT_OWNER_ALLOCATED,
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4ee522fd381c..e2c22ffdbb81 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -71,6 +71,7 @@ static bool need_page_idle(void)
 }
 static struct page_ext_operations page_idle_ops __initdata = {
 	.need = need_page_idle,
+	.need_shared_flags = true,
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
+			if (page_ext_ops[i]->need_shared_flags) {
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
index 2d27f532df4c..f0553bedb39d 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -99,6 +99,7 @@ struct page_ext_operations page_owner_ops = {
 	.size = sizeof(struct page_owner),
 	.need = need_page_owner,
 	.init = init_page_owner,
+	.need_shared_flags = true,
 };
 
 static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 93e633c1d587..25d8610c0042 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -45,6 +45,7 @@ struct page_ext_operations page_table_check_ops = {
 	.size = sizeof(struct page_table_check),
 	.need = need_page_table_check,
 	.init = init_page_table_check,
+	.need_shared_flags = false,
 };
 
 static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
-- 
2.39.0.314.g84b9a713c41-goog

