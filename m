Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D936665E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjAKV7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjAKV7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:59:12 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFABB3F448
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:59:10 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id s5so10540784qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLlRGFfxK+N0AdFFVO3VU9eoPoiCOoB3+UBhQVqyXOc=;
        b=CmstqYp912NmC9R4Xxm0EZWE1EhKvjcarg8Dw/Wvo1asypNqfDTwrkBigSXdwnWl8a
         4ops4Q+AZ0AZAR9vQ87owdxKCGQyO1aJVUMY/IHzpPs8rGSv2PsogsQfOABGUB0wTC0+
         pJ065B57G02ECCMJGrn6Oc6MOKi8zH2FecW9PW7SWyWva98kX9k0AhQDxpjfolODUYhR
         CkQnwaYhwRcFKnLZoTLY9RtUZpKEpdLKWbtYd23OPbAfYQc8/SGGSy4dhN3BhPhW+vgL
         GbtU0c09nPenwJQh3RYSCB+o2ZH/R0FgrMVTAi51zP7oJ5FAioNBfWy8OxS77pzIG2Gg
         htLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLlRGFfxK+N0AdFFVO3VU9eoPoiCOoB3+UBhQVqyXOc=;
        b=c2wFvVCpQbS2UMAq1LgCzBrWVjD6RIZbXFl/vrDerFf2DGWsxvphvbqSnKO86PisqE
         Xqc++7otEawCDpCy8x/Bdg+uUVYsYaT1+agHHIr4rc8iZp8jULBlJRzwJP8oifqkwq/x
         4ZCitytlJb1fziC4/4SP1Wwb00IhQAfT0wycJwa2KFo5CotfOzB9y0SOMkj7pk/RPjzU
         enpvqXY/qppye7fuJGAXnu+Gkn4gIlpkUSuRf+8jeQevOcC59BWx/yL4CGInBDN5zhPu
         22KHT3M/X9kwPyIP5mq0NL58XP1IpOCjiavbxseoTD9a/Q8epb7Hv71W/XTn4DoibncP
         iZKA==
X-Gm-Message-State: AFqh2kpcRa4wu3yywXubbw1LwU+zSe9WrkSODdFarPziJGpN1JSmKI6z
        +YLKeksQtxMudDz+0LKvrknMEg==
X-Google-Smtp-Source: AMrXdXsI2I0zIUl7fjZav5IrW4r6Gg92vBY0uLe3rvbW4hymgGfFuhQ2srGQZjabnFysCNG8OZZtNw==
X-Received: by 2002:ac8:4509:0:b0:3a8:287c:8aa9 with SMTP id q9-20020ac84509000000b003a8287c8aa9mr104803620qtn.31.1673474349971;
        Wed, 11 Jan 2023 13:59:09 -0800 (PST)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id l12-20020ac8078c000000b003996aa171b9sm8001201qth.97.2023.01.11.13.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:59:09 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, david@redhat.com,
        quic_charante@quicinc.com, lizhe.67@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/page_ext: Do not allocate space for page_ext->flags if not needed
Date:   Wed, 11 Jan 2023 21:59:06 +0000
Message-Id: <20230111215906.2645056-1-pasha.tatashin@soleen.com>
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
index 2d27f532df4c..612a988373cc 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -99,6 +99,7 @@ struct page_ext_operations page_owner_ops = {
 	.size = sizeof(struct page_owner),
 	.need = need_page_owner,
 	.init = init_page_owner,
+	.using_shared_flags = true,
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

