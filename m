Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B4467BCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbjAYUi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjAYUiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:13 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BF95DC39
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:06 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id m8so8576ili.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3mh2Po5S0GZ5nMRIdtsGUfg1b0n2GFzCmBwQMpYGZ8=;
        b=cwnxSD1lO2UoA3ND/8ysyNhK+m3hJUFQWyuvBlRWa3ZlcQ2vUivawFa2qHsdqd2Yxb
         I7nMhI5TmTzKD9jAxA6Qu/biaZfMCs9EmkGzHvA92NAS4EbAXJ1NaZXW4KbrV8dnidNy
         N0A1zoROSXBLzrheK2IiHKVOipyXsUyDdE5gj0Fr1dZoBHN2ZPfAupYgYMTdidok+rA8
         WnjE82WcAY72ZVd9FjJMiqhuMYBrcxeyiwyYYJ8S32I1XDKgV5ZE9gQwiyhSnL6+dqpp
         JQMHQGhjmB3LYMV7XT/5f/En0DBvTOU/WfLuXPUOp7NmmcSceISL9STkQB7JeGqZgiGX
         9Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3mh2Po5S0GZ5nMRIdtsGUfg1b0n2GFzCmBwQMpYGZ8=;
        b=jK1NUrrzdgikE5/0TaXtVV4X7YGQjsLc70UEk8bleEei/DZBO9bUNO7wBJ1fkL8WE3
         e07nkPRsi11ZFLbLlqe4nLqkvp96MNP+L7iDq0h2yGe3zIEXY0WanVY5fOIIBBjuJikX
         xcLXJRkTRkK5G/y9O6dSZ95Fjx2WteluKlXg/D0Ey0AW1TPbzebCUcrgUquOgbQUrx5V
         Gxlv7v+EPLw3ew55afCO6JGfsDHy2WrBm6Yd/+Iu0KLcm1u6yVJ/iS4ByYj72dMmUd7W
         iSnmsYgvmg7mUeoVI69hojKX8ZYolUhu4OZc6RD0ejDDqt0rslO2D9lAu1eLqizA8wix
         /4uA==
X-Gm-Message-State: AFqh2kqE6Fzy7WZmhVqoCPHLFQyAjWtFrwfNekHUmGYH9qw5eeo2xeqv
        shHep3CWHiziq0wI8yFJf4EDdqA4XCo=
X-Google-Smtp-Source: AMrXdXvPM8t3vFwyNndtrfyKS5vIOllgROIQouuVnZ3VU8nVIZJ2wrfXnDHR4gwh6+zL7uWEumkpXw==
X-Received: by 2002:a92:b007:0:b0:30e:f02f:f1bf with SMTP id x7-20020a92b007000000b0030ef02ff1bfmr31186264ilh.30.1674679085895;
        Wed, 25 Jan 2023 12:38:05 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:05 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 08/19] dyndbg: tighten ddebug_class_name() 1st arg
Date:   Wed, 25 Jan 2023 13:37:32 -0700
Message-Id: <20230125203743.564009-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125203743.564009-1-jim.cromie@gmail.com>
References: <20230125203743.564009-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change function's 1st arg-type, by derefing in the caller.
The fn doesn't need any other fields in the struct.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2d4640479e5b..10c29bc19901 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1110,12 +1110,12 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 #define class_in_range(class_id, map)					\
 	(class_id >= map->base && class_id < map->base + map->length)
 
-static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map = iter->table->classes;
-	int i, nc = iter->table->num_classes;
+	struct ddebug_class_map *map = dt->classes;
+	int i;
 
-	for (i = 0; i < nc; i++, map++)
+	for (i = 0; i < dt->num_classes; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1149,7 +1149,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_puts(m, "\"");
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-- 
2.39.1

