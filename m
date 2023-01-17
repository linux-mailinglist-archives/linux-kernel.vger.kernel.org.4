Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C2670D72
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjAQXaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjAQXaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:30:06 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C83C42DF4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:46:21 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id i185so33599266vsc.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmTkDMG76LtnP3d5zwBqn09xe+8G8F7vZ7HUcNnedBQ=;
        b=kwox8c1r6EFxK7FAaH08JtL7Sl+/rseUqoPyXySjH/FD6YBxd3eWCQ2WJcX6ENppUH
         BHgPzAdDWgK1Y2Gl7dpRbaR59aHLM1pJu0Rk7L4M+YDwt6c8yTimZCw0s4tdCy26SX5G
         2nyvXIys5V6KiCuDK1KIpUOji0Yv6+X0vS2nbxS+lW0VWBsJFhDmrc24PahipoCmXxXK
         1neoidWeSQmAZLUJRXZMwFzX2EVRfK+b0/fPRVgwPN3mlynfn6XFiy+BalH3Atv6gEwn
         Qzof7SVPDBNajsSH+SAbrC6MQnj2kU+JsGQjouOGRqZ1P6YRCL5s3V0cka9CJb9Lu9gW
         goVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmTkDMG76LtnP3d5zwBqn09xe+8G8F7vZ7HUcNnedBQ=;
        b=mFLy+ZUvlxPWyMRCCYe6HcFIuYMTQjS1Ax90keQJtsiEDq9x/WQvq/BZUK3S+3c9Cw
         NQtTBMCS4yzaeOkcT6sUdoeO4Ui0lRphxg/5Q2+GiLceWu4gpA+YV2THwAlE6zwYuTlI
         kMuhnLkDzwd0Vqv0HZUTXPFWU7vaxMgQ3kgFePnk5uMBgw9/JVJ9H/9BZ2ck8ZeK2rq+
         Jqk0b0q8dw4d4wybHrL//ueXPLSK9839pW80HTnggc6qhJAFmg3sS8/yprGRIIjsCA9K
         rWDNKhbdNBx1Xyt4iroi56+MsZw9EEswL7JrbmBuamPmmwwWZm7cJmgyXGYzap4u3yHc
         +Ncw==
X-Gm-Message-State: AFqh2krRQIhE1C5ACUJAsrZToBKhv6qMq7rxHk9G4GgO49vAyE8sWqu2
        acamT0y/wh1F2H6Wo9YFyDUiNQ==
X-Google-Smtp-Source: AMrXdXv7HOGWMOYatLm5GB8kzSH2OsvxQTTpLlhFPjkZucKddcElWy5Fv+RF6Qc6ZjQAbtuZjCviKA==
X-Received: by 2002:a05:6102:32c7:b0:3d0:a805:e6af with SMTP id o7-20020a05610232c700b003d0a805e6afmr2425156vss.15.1673988380818;
        Tue, 17 Jan 2023 12:46:20 -0800 (PST)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a401200b007064fa2c616sm6463581qko.66.2023.01.17.12.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:46:20 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, rppt@kernel.org,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, quic_charante@quicinc.com,
        lizhe.67@bytedance.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/page_ext: init page_ext early if there are no deferred struct pages
Date:   Tue, 17 Jan 2023 20:46:17 +0000
Message-Id: <20230117204617.1553748-1-pasha.tatashin@soleen.com>
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

page_ext must be initialized after all struct pages are initialized.
Therefore, page_ext is initialized after page_alloc_init_late(), and
can optionally be initialized earlier via early_page_ext kernel
parameter which as a side effect also disables deferred struct pages.

Allow to automatically init page_ext early when there are no deferred
struct pages in order to be able to use page_ext during kernel boot
and track for example page allocations early.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ext.h | 1 +
 init/main.c              | 6 +++---
 mm/page_alloc.c          | 6 +++++-
 mm/page_ext.c            | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 22be4582faae..1e9bcc37a342 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -36,6 +36,7 @@ struct page_ext {
 	unsigned long flags;
 };
 
+extern bool deferred_struct_pages;
 extern bool early_page_ext;
 extern unsigned long page_ext_size;
 extern void pgdat_page_ext_init(struct pglist_data *pgdat);
diff --git a/init/main.c b/init/main.c
index e1c3911d7c70..64cd2ff051c4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -855,8 +855,8 @@ static void __init mm_init(void)
 	pgtable_init();
 	debug_objects_mem_init();
 	vmalloc_init();
-	/* Should be run after vmap initialization */
-	if (early_page_ext_enabled())
+	/* If no deferred init page_ext now, as vmap is fully initialized */
+	if (!deferred_struct_pages)
 		page_ext_init();
 	/* Should be run before the first non-init thread is created */
 	init_espfix_bsp();
@@ -1628,7 +1628,7 @@ static noinline void __init kernel_init_freeable(void)
 	padata_init();
 	page_alloc_init_late();
 	/* Initialize page ext after all struct pages are initialized. */
-	if (!early_page_ext_enabled())
+	if (deferred_struct_pages)
 		page_ext_init();
 
 	do_basic_setup();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..5a3e0f00f31d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -430,6 +430,8 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 int page_group_by_mobility_disabled __read_mostly;
 
+bool deferred_struct_pages __meminitdata;
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /*
  * During boot we initialize deferred pages on-demand, as needed, but once
@@ -6761,8 +6763,10 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		if (context == MEMINIT_EARLY) {
 			if (overlap_memmap_init(zone, &pfn))
 				continue;
-			if (defer_init(nid, pfn, zone_end_pfn))
+			if (defer_init(nid, pfn, zone_end_pfn)) {
+				deferred_struct_pages = true;
 				break;
+			}
 		}
 
 		page = pfn_to_page(pfn);
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4ee522fd381c..918e2e131ab0 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -91,7 +91,7 @@ unsigned long page_ext_size = sizeof(struct page_ext);
 static unsigned long total_usage;
 static struct page_ext *lookup_page_ext(const struct page *page);
 
-bool early_page_ext;
+bool early_page_ext __meminitdata;
 static int __init setup_early_page_ext(char *str)
 {
 	early_page_ext = true;
-- 
2.39.0.314.g84b9a713c41-goog

