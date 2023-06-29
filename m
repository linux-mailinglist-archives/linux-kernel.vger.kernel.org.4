Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FFE742A36
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjF2QEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjF2QEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE6C10D5;
        Thu, 29 Jun 2023 09:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9FE96156D;
        Thu, 29 Jun 2023 16:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D0BC433C9;
        Thu, 29 Jun 2023 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688054639;
        bh=kecJ7j1mmrkVEupftE0qUI4crvKvKvDb/jves3wo4F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNvpacQZCKhYQq0u34fEhS/M05Vbgc2zSsPVWnBSBjsYihTTq4GETbJAt5V0CmitM
         yhHawHUZOqsGxIG3amSA/Ik0QwKPrBUnsJCSKOSZXF5n4Y5YXLU4A4rwkiyDRUNoR7
         AAs27VNslKEYpDQk8yqWmodKY3+zfTInYoBXnKI1GleH7IZgtEEPL/KycXaHZeRSWp
         L1tNtqfK4d5ntfL4FzjEt4D0G5yBitStGgMT0bNYvyI9wNz/Io0we7sRLWLB4h3IrL
         g656gucy5TjjdzFJw9tVKIAhjVsYmrh0sMQLrspo9JZ1S1QPSmGxlloAURpNAa/Okp
         akf/g91y3VYdg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] kconfig: menuconfig: remove jump_key::index
Date:   Fri, 30 Jun 2023 01:03:51 +0900
Message-Id: <20230629160351.2996541-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629160351.2996541-1-masahiroy@kernel.org>
References: <20230629160351.2996541-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You do not need to remember the index of each jump key because you can
count it up after a key is pressed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.h  | 1 -
 scripts/kconfig/mconf.c | 7 ++++---
 scripts/kconfig/menu.c  | 8 --------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 9c9caca5bd5f..4a9a23b1b7e1 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -275,7 +275,6 @@ struct jump_key {
 	struct list_head entries;
 	size_t offset;
 	struct menu *target;
-	int index;
 };
 
 extern struct file *file_list;
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 7adfd6537279..fcb91d69c774 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -22,8 +22,6 @@
 #include "lkc.h"
 #include "lxdialog/dialog.h"
 
-#define JUMP_NB			9
-
 static const char mconf_readme[] =
 "Overview\n"
 "--------\n"
@@ -399,6 +397,7 @@ static int handle_search_keys(int key, int start, int end, void *_data)
 {
 	struct search_data *data = _data;
 	struct jump_key *pos;
+	int index = '1';
 
 	if (key < '1' || key > '9')
 		return 0;
@@ -408,11 +407,13 @@ static int handle_search_keys(int key, int start, int end, void *_data)
 			if (pos->offset >= end)
 				break;
 
-			if (key == '1' + (pos->index % JUMP_NB)) {
+			if (key == index) {
 				data->target = pos->target;
 				return 1;
 			}
 		}
+
+		index = next_key(index);
 	}
 
 	return 0;
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 5578b8bc8a23..198eb1367e7a 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -735,15 +735,7 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 	}
 	if (head && location) {
 		jump = xmalloc(sizeof(struct jump_key));
-
 		jump->target = location;
-
-		if (list_empty(head))
-			jump->index = 0;
-		else
-			jump->index = list_entry(head->prev, struct jump_key,
-						 entries)->index + 1;
-
 		list_add_tail(&jump->entries, head);
 	}
 
-- 
2.39.2

