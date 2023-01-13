Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7266A365
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjAMTdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjAMTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:31:09 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADE56C054
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:04 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id u8so11214268ilq.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMbqFdT/JDbk6t20JvgexRk0zFVQ3CnaOgmAmhMmoxs=;
        b=fKgaTMeKfzcqUfAoemEcsC8YuW2QdVhaDfa6TQ7dB9H++nXnzumgfjDbDOaSXTlsiI
         8l2owubojC/NE1uAXHlOSh6N7FChBcCf5jPSaT1lfB98BZm89yNIJ+IvYRUPl1C2wcEc
         bMF4k8sPQB9TtECRFYzDFROaP3Dk4ZBn9M89opTudqwUuQsLOx0pY+Gwai7EbueylZ7z
         HTYZ27hIsC+v/TAhy5OFLTsAHB3rbwSTXW70Zl1NM4ZzSb/+oHctn+IdG3/DwnhJXzBF
         OtnQKGdkAxIYZmqUWiu5JdLVXtBVGrXrt0rVEvp6zXxt7zDyhkfeWq2A13rOHoMJbN1s
         WEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMbqFdT/JDbk6t20JvgexRk0zFVQ3CnaOgmAmhMmoxs=;
        b=moy37Epsci/iXN1lTFPUJiROWkkAXQSGBzmT+YrB9L3zTibZSothwk7Fr1m3UE7mRy
         jMT279ywwthOkwLQ/X+MQYlVXf27UCUQBl2uyAgdvg3bnlhhTib/9nEIwI0OUjlHXE0C
         +C9SFZ0V4Q1uX/Ee7vi+AUJXWRWnIiuBWGZvUQk79HEkynTGtlVqZYcPX6lI7MqKiU6C
         N1GVSqUFfGXOLh5Ac072ycbnQFGXA0WA9BwWTggnnYYEzOz7RuqM9UJhgrV8Xgm0ic/y
         bnpHb3N9qzbF9tagMmf2vmSJvRgcAJAhfZ5nMMNP6BSvqR1Rq1H5mvQ3pETdKJSc36Dw
         tFWA==
X-Gm-Message-State: AFqh2krukXoBJ4W2mkogbAlBp7yk+ldcZiEH1nhESTc8rkySuxs564KO
        w7CZTzvyOC0NZz7QQepZ/z5/uVzToqDQIw==
X-Google-Smtp-Source: AMrXdXvGslnAVKLoPH+t01+Ripv46/ISSZmTMAWZank9F3QWH6C5s89RkS8L/E/8JmO84IbTeA0dtA==
X-Received: by 2002:a92:c26f:0:b0:30d:6de3:268b with SMTP id h15-20020a92c26f000000b0030d6de3268bmr36191703ild.19.1673638263209;
        Fri, 13 Jan 2023 11:31:03 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:31:02 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 19/20] dyndbg: unwrap __ddebug_add_module inner function NOTYET
Date:   Fri, 13 Jan 2023 12:30:15 -0700
Message-Id: <20230113193016.749791-20-jim.cromie@gmail.com>
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

The inner func has a base arg which is unused in the body, so theres
no point in having the inner fn.

Its one-time purpose was to expose a wider interface to the internal
caller: dynamic_debug_init(), to allow communicating each module's
offset in the builtin _ddebug[] table.

That purpose was obsoleted by cited commit, when ddebug_add_module()
was converted to pass a *ddebug_info, which is used as a cursor by the
caller.

TODO: the cited commit gives another reason for base, to provide an
index in support of de-duplicating column data.  Refresh that patchset
to see if its still true.

Fixes: b7b4eebdba7b ("dyndbg: gather __dyndbg[] state into struct _ddebug_info")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 19bf66229d45..eb1fb10d7272 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1348,8 +1348,7 @@ static void ddebug_attach_client_module_classes(struct ddebug_table *dt, const s
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
-			       const char *modname)
+int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
@@ -1391,11 +1390,6 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 	return 0;
 }
 
-int ddebug_add_module(struct _ddebug_info *di, const char *modname)
-{
-	return __ddebug_add_module(di, 0, modname);
-}
-
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
 static int ddebug_dyndbg_param_cb(char *param, char *val,
 				const char *modname, int on_err)
@@ -1538,7 +1532,7 @@ static int __init dynamic_debug_init(void)
 			mod_ct++;
 			di.num_descs = mod_sites;
 			di.descs = iter_mod_start;
-			ret = __ddebug_add_module(&di, i - mod_sites, modname);
+			ret = ddebug_add_module(&di, modname);
 			if (ret)
 				goto out_err;
 
@@ -1549,7 +1543,7 @@ static int __init dynamic_debug_init(void)
 	}
 	di.num_descs = mod_sites;
 	di.descs = iter_mod_start;
-	ret = __ddebug_add_module(&di, i - mod_sites, modname);
+	ret = ddebug_add_module(&di, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.39.0

