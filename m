Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC8A6679B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbjALPoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbjALPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:43:34 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFC71A399
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:33:52 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id b10-20020a4a9fca000000b004e6f734c6b4so4899570oom.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ubEBjBZWCZprxvg3hFb0J7l69r3LVSgsyPzd+ncfrs=;
        b=F/vNL4ncA2Wx1v6nHhyPY2j1Q6TgA7m1qi0ck+kX4IfwwviTOxM4YNEonMibKmrMgG
         2U4yyzaBkI/wf4kFyXlzFQzfHD3p+rBmQtdE85GOIFMOeXpPVtQ54OMh1e87Am4CPdFm
         DPjuttNKso0QHW4cVVr0dDKvVV/HwrT257jH7NDWbXzPB+SW7D56JnDqK0CJDr9S1rl5
         G2Pzk8BjRkof8WHiPNLH8TFHTQxR6IVlZdVoytWvDBiCkZhYpOti2pb71HiuO3egOTON
         0z2iQgADIaQ2TjIBRAqvgOs7Moc+UKZd+H6XwJrp4pspbWvQ8TWDi5bJ48u5irNal845
         2nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ubEBjBZWCZprxvg3hFb0J7l69r3LVSgsyPzd+ncfrs=;
        b=VRqE2gx1dMiN8XQfLDJ8ERpfctKvo15yUrRXpUz7wbqsMHuNl6LlvXmWddYNX72WK+
         YWAAYamrfwLtw+8iZKJ6s1pZFfCtyz/X/J+6sXwZvkZNHj6HKPkQxkMfHdqM7ax0C84p
         vsizhzA6L+8tTCkcwiXdOGtMWfyMdS/nikkOpKt9pO3yKrXwpY2PGaR1+M/v+eY9I+gv
         nAC7SP3dODUk8kb216bEq2jiaRzPg/CVIlWbrxZYnqnu6wcpgfXKN4sg4B2RPMiRfWXI
         u13xHRKGeytDltxWlanPPc/52a0os2O23NHMntLbBQxqKxY9jGUwJRGijIDSEPpSuA/+
         TsCg==
X-Gm-Message-State: AFqh2kqJcrno9jrU0roJ/3zGaT/0Gi0S7HhjFbVRSMXPjkV8wxmeWoNv
        PnxRluxjPI8XusW81v0YAobtHA==
X-Google-Smtp-Source: AMrXdXs32cUCLr2B0L+g5wRnD/cB216iGpqeyA7gyHvA2oYBav2gm6xGjCyUSPYovsFYFANcwGWSyg==
X-Received: by 2002:a05:6358:5bce:b0:ec:ed9a:9b4b with SMTP id i14-20020a0563585bce00b000eced9a9b4bmr154475rwf.7.1673537631552;
        Thu, 12 Jan 2023 07:33:51 -0800 (PST)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a454800b006fc7302cf89sm11113288qkp.28.2023.01.12.07.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:33:50 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, david@redhat.com,
        quic_charante@quicinc.com, lizhe.67@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] mm/page_ext: Do not allocate space for page_ext->flags if not needed
Date:   Thu, 12 Jan 2023 15:33:48 +0000
Message-Id: <20230112153348.3202173-1-pasha.tatashin@soleen.com>
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ext.h |  7 +++++++
 mm/page_ext.c            | 12 +++++++++++-
 mm/page_owner.c          |  1 +
 mm/page_table_check.c    |  1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

Changelog:
v2: Fixed field name in page_owner.c that caused build error.

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 22be4582faae..29909e135052 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -12,10 +12,14 @@ struct page_ext_operations {
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
@@ -31,6 +35,9 @@ enum page_ext_flags {
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
index 4ee522fd381c..7443a797b96b 100644
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
@@ -105,6 +106,15 @@ static bool __init invoke_need_callbacks(void)
 	int entries = ARRAY_SIZE(page_ext_ops);
 	bool need = false;
 
+	for (i = 0; i < entries; i++) {
+		if (page_ext_ops[i]->need && page_ext_ops[i]->need()) {
+			if (page_ext_ops[i]->using_shared_ext_flags) {
+				page_ext_size = sizeof(struct page_ext);
+				break;
+			}
+		}
+	}
+
 	for (i = 0; i < entries; i++) {
 		if (page_ext_ops[i]->need && page_ext_ops[i]->need()) {
 			page_ext_ops[i]->offset = page_ext_size;
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

