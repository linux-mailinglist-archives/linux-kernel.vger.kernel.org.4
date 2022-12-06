Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD36643A2E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiLFAgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiLFAfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:35:43 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEACF2037A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:14 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id v1so4151795ioe.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIsPuu8JRVrrUSQ7469SzfHROG7s67Vxgu75j/Nltzk=;
        b=D/2mvIxLzCrVymNZPIHU/akrweDVsfKHAFVoGDktna/W6aUgQ4Hqd3ZffCokk6nJu7
         +g/WPmIAl4D5dD0SG/iomeH0w7jfPWfvi0kmEz7X8/LgdCZUEHoYvrMl8Us4IiW6GKSQ
         oPCLKdl3ke+IqzQioDR6GVWR9XZb1SmV4jRHREc9afB8KmDkf1n1R4bCilgOUaP2H0/t
         L9rDFuqySibq0YXjC95Rqns7uLdHZWPMPX8V0cu/l2wDJwBVhHKrssRrxuIW2brjvQgb
         Ag9FQB6OC4CuGJJhgeFtrLCIcyx0/ewNuRy09SnIqQYU/hQREZORqAI3NpYqN5ZX+B2H
         r33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIsPuu8JRVrrUSQ7469SzfHROG7s67Vxgu75j/Nltzk=;
        b=qJMAIU3FipGvexQPrMj9sTbulRsX8b0eibn7uGQ4AprCCcRa2Yze1v59HWNHS3YyVf
         gfEImWHOmZwDNz3Pg/jF5bh/QYwY3fL9tfTKBH7Xpbdct1cvrIchnGz2P78ODUv4rJto
         dUBgop8PycRwbTFC26/YfLID93U6wTToLp3LvT6U04t+8mYAmneU5dl/PlVe/HFVTf+f
         mGMe//XNbAuQTcSmyNdWdNao5ha5ik1zB7DMeRNHZxW2JvVcDINNdg9kWKes1gRkvpD9
         OJGB8o1sZwudzasyH6n8w5ExsJcs6tq0uCHmdqCvWei1ppQ5M+/oAkvgHNV/V9zA9vCo
         Wj5g==
X-Gm-Message-State: ANoB5pl9DoAOp/le1n9a5zr69DBWzEqYbOwG3SlGlMxEgAEIs8S324OX
        fQ8pvXIPc8gaLwdd1AREC3Higybc6d5yAw==
X-Google-Smtp-Source: AA0mqf7ri2gro9V9fgZrgNh7kkATJcL+NRGjXlDE9UObbzfVKd4AWSefSQfvOw6hkPTvUYcEK+T1MQ==
X-Received: by 2002:a05:6602:418b:b0:6dd:813a:bfaa with SMTP id bx11-20020a056602418b00b006dd813abfaamr30093591iob.146.1670286913920;
        Mon, 05 Dec 2022 16:35:13 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:35:13 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 14/17] dyndbg: unwrap __ddebug_add_module inner function NOTYET
Date:   Mon,  5 Dec 2022 17:34:21 -0700
Message-Id: <20221206003424.592078-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206003424.592078-1-jim.cromie@gmail.com>
References: <20221206003424.592078-1-jim.cromie@gmail.com>
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
no point in having the inner fn.  Its one-time purpose was subsumed
into the ddebug_info record, which is used in dynamic_debug_init() as
a cursor to load the builtin _ddebug[] table.

TODO: cited commit gives another reason for base, to provide an index
in support of de-duplicating column data.  Refresh that patchset to
see if its still true.

Fixes: 6afa31514977 ("dyndbg: unwrap __ddebug_add_module inner function")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 45b8414fa130..02f36c553835 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1329,8 +1329,7 @@ static void ddebug_attach_client_module_classes(struct ddebug_table *dt, struct
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
-			       const char *modname)
+int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
@@ -1372,11 +1371,6 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
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
@@ -1519,7 +1513,7 @@ static int __init dynamic_debug_init(void)
 			mod_ct++;
 			di.num_descs = mod_sites;
 			di.descs = iter_mod_start;
-			ret = __ddebug_add_module(&di, i - mod_sites, modname);
+			ret = ddebug_add_module(&di, modname);
 			if (ret)
 				goto out_err;
 
@@ -1530,7 +1524,7 @@ static int __init dynamic_debug_init(void)
 	}
 	di.num_descs = mod_sites;
 	di.descs = iter_mod_start;
-	ret = __ddebug_add_module(&di, i - mod_sites, modname);
+	ret = ddebug_add_module(&di, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.38.1

