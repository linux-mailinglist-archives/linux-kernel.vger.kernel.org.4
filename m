Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CAC66A359
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjAMTcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjAMTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:30:52 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015E88A30
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:50 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id a3so5290089ilp.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwGmRROjyglOeSoFqRG5imAXV3+5VTAH53vaW+53Odw=;
        b=A3HDe4nbCJ4aCNqOKtRPCFTfVuiuvhgXH9F+UoYsIB+aY6CSBSbXf0vrAqpewP471x
         HmjH4546ZKYNNDXXDIawZ0FDak6IdRz/gLYqC4lTzCvai2ZLX1bCOFXF+Jt+Qa7UQ+sc
         NhAmnTm1Jk3A0Lxj0ch1S+KT9Th9t6kJtXZ0p6V4Kyc4EwyHAHRp08ZPCP7Ze4UqoNY7
         0g9RzBzxz6QlQsSiMtc/2le+UF4O1cy7w47fw8zKe4VbIZ6ryF5EfvVz+NThI6ny3v/u
         BjS7ItVQJ4595l8/qQWVuf2CihOfJmIDHnA802ONMuyjGoZeZlfO2isRMr9LlBJixA6U
         5Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwGmRROjyglOeSoFqRG5imAXV3+5VTAH53vaW+53Odw=;
        b=rU0TLOxzvk2tJq+U5s88NGkODVNyj5VhySFPTGdS24tgPddIAL+SPXV7gxHdMzm+CV
         OGxLqFjfd1Hnjq4ZxD5RBAqCAiinb/pBftVIUv4yvVcej2srN2sIO1C9M0/Oos9yBLyP
         NqSk1lwe3YzBeVVDIWnbkn93l4R6tw12UBUuyv8y7IKd0WBzW82sUjDtAWDXaCUQRnVx
         OBvvOO31ZR0A7oUm8gEXuuoYYVQlfzLN4w0oqUOiecS8P1DKZLajR2z/EDinv0EcwtzB
         297KfO95HgSL5teiRVsc067nVIfJkzzvIN47PH3S4bHKp6zjaNcTtWdZERHRH56DQpeS
         00iQ==
X-Gm-Message-State: AFqh2kprY7Vcgw3htjNKsCcoP71V17LFKheUJmUiA3sK2JkCCmBJAzDe
        8qwqByQC6UJMnVwLMGApa92hDmlyePFqHw==
X-Google-Smtp-Source: AMrXdXsS+qp0ff9HeyA41fJjrhFgXevOlox2A1mtYYscRCcks+mT48KcI/kNjwYKXbQuXDyUlJFs0g==
X-Received: by 2002:a05:6e02:1b8e:b0:30d:7451:a58f with SMTP id h14-20020a056e021b8e00b0030d7451a58fmr10482235ili.0.1673638249189;
        Fri, 13 Jan 2023 11:30:49 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:30:48 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 07/20] dyndbg: reduce verbose/debug clutter
Date:   Fri, 13 Jan 2023 12:30:03 -0700
Message-Id: <20230113193016.749791-8-jim.cromie@gmail.com>
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

currently, for verbose=3, this is logged:

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"

 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff

 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=DRM_UT_CORE
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=DRM_UT_CORE
 dyndbg: processed 1 queries, with 0 matches, 0 errs

This patch:

shrinks 3 lines of 2nd stanza to single line

drops 2 middle lines of 3rd stanza
 3 differs from 1 only by status
 2 is just status, retold in 4, with more info.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0a5efc735b36..2d4640479e5b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -265,9 +265,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -496,7 +493,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -510,7 +506,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -526,7 +521,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -536,7 +531,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -554,10 +549,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
-
-	return nfound;
+	return ddebug_change(&query, &modifiers);
 }
 
 /* handle multiple queries in query string, continue on error, return
-- 
2.39.0

