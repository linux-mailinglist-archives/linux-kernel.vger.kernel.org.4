Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE075B99AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiIOLey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIOLew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:34:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7A4B24
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:34:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w2so7483408pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fTThPrnJpaHeuIoGEw8obeia0/MYZikqiW0fDRszi+8=;
        b=qy/fAFU92j26cseHPnplutz2c07wowoPocmrrC6ua4wwTccbPm4YOvszB8cusuMXcT
         0947vuapD63NyTJiqif+DJaVOwDLkcYM4r+nOaX9ZUYQyI6bY2UHAGzRLgEJfaVjnyJa
         dfWkhOkWx30zqPCVTr4IvjD6+WaTfHMlhYMf9IiXZBQqOh8UYjGNIpb/DwTaW7tqnnGU
         q0uPQp70s/rBK8sha4/2dj9SpL90Vke+BLoPOkWe/NXWj5NHRg8Y0smKhVZeKqwGSFAa
         FC6NYxt2Uf4gaCWoV036qB1glJYiW6okZiBVXxwa2eZMBKcKQDQ5MezIdl/MbgNZkXze
         jNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fTThPrnJpaHeuIoGEw8obeia0/MYZikqiW0fDRszi+8=;
        b=LxFgqUvUjwcWZULQzfmdJfYbAXUyPxe4vAOhePBnT57vwwxdR7uQn7fXDqUb6xXVKM
         svCXPqqNwWCz8g7B7M6jE1B2S91TDIQ0y+00UIyA8SBBAhyyI4aSwh/FRQBu6jXj/FcK
         /+JBrXw9Vwz/7jy7OdAtjZvil7xOoXsZuZxgUKiDhyUEV1FIJ52aVPvkKz1s55OjC3+w
         KEdWjvrwUbSfiwHojfvvnxwpv4jfYTM8N8pteP1hyqjMWkbEJJWxHbJK0WA9viGgXYE7
         X/S02TNY6iaFf/DlwXi73Y3wYF52AKt8Gu9xQw+G2K4kYALW4/P29YW5wzxWtsK2rD2f
         v0uA==
X-Gm-Message-State: ACgBeo3yXNw49y/IzuPXpYY6fet70i0YOGSn8Au8bKPy2L+O1CNXYMW6
        DBYHu3blxosp3VeINhBkTOYtKE9nSxBK
X-Google-Smtp-Source: AA6agR640OXsmX5cRg0YHwKSwjJU7hyGd438DG3WT93f0yjbNao+JFUJGApYi+n+XIlDbsPP2SYaUg==
X-Received: by 2002:a65:6951:0:b0:42b:b13:b253 with SMTP id w17-20020a656951000000b0042b0b13b253mr36828372pgq.555.1663241690274;
        Thu, 15 Sep 2022 04:34:50 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id g6-20020aa79f06000000b00537eb00850asm12114310pfr.130.2022.09.15.04.34.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Sep 2022 04:34:49 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon: use 'struct damon_target *' instead of 'void *' in target_valid()
Date:   Thu, 15 Sep 2022 19:33:41 +0800
Message-Id: <1663241621-13293-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

We could use 'struct damon_target *' directly instead of 'void *' in
target_valid() operation to make code simple.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 include/linux/damon.h | 2 +-
 mm/damon/vaddr.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c5dc0c77c772..1dda8d0068e5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -346,7 +346,7 @@ struct damon_operations {
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
 			struct damon_target *t, struct damon_region *r,
 			struct damos *scheme);
-	bool (*target_valid)(void *target);
+	bool (*target_valid)(struct damon_target *t);
 	void (*cleanup)(struct damon_ctx *context);
 };
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3f84584f9982..f53c2ff2bcc8 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -593,9 +593,8 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
  * Functions for the target validity check and cleanup
  */
 
-static bool damon_va_target_valid(void *target)
+static bool damon_va_target_valid(struct damon_target *t)
 {
-	struct damon_target *t = target;
 	struct task_struct *task;
 
 	task = damon_get_task_struct(t);
-- 
2.27.0

