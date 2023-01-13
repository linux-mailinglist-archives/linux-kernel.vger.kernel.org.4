Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C2566A35A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjAMTcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjAMTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:30:52 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688F787F03
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:51 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n85so3275472iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pKYcyxobqjkxw/cQW3qOcS+2FHDD+NQD5zTk5vyKT0=;
        b=kv1hHXeGS4Ae++h9FVHklLDkqQoIlKy2J/FnU2oFkPWRn5YRlU8UZcTs1RIDYWwwMO
         TBL4TmhQtrizT8dE0OVmt0zOTsf+k6Fva2BqdiHvacmnGEvy+iO06Q4Og8mLBeAe5QFl
         kuxpcjdby0PKyEBCSTTqCYgEPqqQgvUkZyytdXCsUgQIy6zX/aZ5G9Prr7L38uwY1Ijk
         20d022OjY5k6l8B8c9ZFZ1KDQzGPvYabn8hhO+JAdSSCH8O7HvIxPwHLDaI4Jb8qJRMg
         oh/Qq1f07LPCOL9D0gNAF5QNsdyexH02UUdxytsJvwBSGbhUC5rGGWWu+1G1uJGPwAaV
         NMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pKYcyxobqjkxw/cQW3qOcS+2FHDD+NQD5zTk5vyKT0=;
        b=7t2RstGuvgaGYGvXHgRHOgQ0kA2dJXyHVb4+Zgfz+eUXhK/UgMVB3JH9nF2HBvsq7j
         DkYdQUW12l0qM7efMDGVoXLq6RxNJ8o2wDf1D8ZkbDEll5XjiUIbU95Mi/o0ImxUGBCP
         cKQj61Qe3Om00KjOgesh63cxoY5HepPdiUEuEiAVoaI2uXrQbjzO4x1U/HpnzgSsYGZV
         /CRERVBgbY8gE2kk9Gjpvl/Jnp9QV5VJxPZIhY34yoMkJGNhkslLuTQ0XBaEHxx9IGRn
         ICuZlOTLllRX2cSC2hdxjt10nI5+Kgxy6I2Iakuare+b5KWt/qyrJ+v2+6go8gdPjBni
         erOQ==
X-Gm-Message-State: AFqh2kp6JdgnroKpNiDxlMyaSVDHevrUJWGI/+C06qC9++F9zsu0mBcm
        5icCAQiHIop6Fdn6Owti+G1p6mJEvs9ZDQ==
X-Google-Smtp-Source: AMrXdXunTbUvqnk+KDACxZ3sT1a4zW0ivzpLR0SZLpWQKg8LPzuEA6wE5v95Q3wtvppI9IfGoav9Gw==
X-Received: by 2002:a05:6602:2083:b0:704:9ab4:ea1c with SMTP id a3-20020a056602208300b007049ab4ea1cmr507697ioa.6.1673638250500;
        Fri, 13 Jan 2023 11:30:50 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:30:49 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 08/20] dyndbg: tighten ddebug_class_name() 1st arg
Date:   Fri, 13 Jan 2023 12:30:04 -0700
Message-Id: <20230113193016.749791-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113193016.749791-1-jim.cromie@gmail.com>
References: <20230113193016.749791-1-jim.cromie@gmail.com>
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
The fn doesnt need any other fields in the old type.

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
2.39.0

