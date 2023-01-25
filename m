Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF2767BCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjAYUiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbjAYUiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:11 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B025DC2F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:05 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id a9so33306ilb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GZxyiBPwjVVw5bY+5L1X1rDI1qOdjAKyHdasBC3ULQ=;
        b=Pcm5M1jZT5rDnxcOuBf1EHnK+chJTeNxSetfhfy3aAneipKuw7P/qqJEYUu1PfXVDn
         ourG/Oc62k1oVHB3Jc45ggCT4sdFo1fdyqeHpzpGfSCaRIK13rosa2fPqwk4FoS1YksD
         0ZprA/6L3TU1PLwDorZXYuVM0tt3VrJNnGLKM84l9lZkPZjFb3PhhPROQhkMi+PUacQH
         sdTPnHOOba8rz18+MYnwdJYT+7SxGlH2Z0fTVQBFpRqQu+SR4yj/7f85t7eK6+tpIeWc
         L3HG7ieWv0v7O+p9/p3p6h+zOm/eZmBAb2484Xb7sGNyur0c06GJN8KiSIwxxHLYJMbH
         o+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GZxyiBPwjVVw5bY+5L1X1rDI1qOdjAKyHdasBC3ULQ=;
        b=cXsBWiSLy4GvPbuzwO/dBqItcwnaWkXepuMwh/+cu+62lTgqwArG2L9riF0qXfF/gO
         FZ6KTUp/oI36aromT/+rlXoaUmKKm2p5y271g1c+9Ip7w8S/Y+FfUkxEoiZDDLHo0Yxt
         sZI/RpEBQ/7KCduqRDbAckO5ZqcTg9wvKzkIx6sOtdSY1N+L364ek3pps+HMHa8bzkZi
         xhK1da35l3fYxhyZgH4pY+3lVr6dyKCfXidoW2lbRYRWQN+ErRHdTW2ZtJEUdCwzieVW
         cn0iigssfJp3mYbkaVnthLUwiN2AqOP0jZUTeYWTET9tQMejkQr9FZzSI0S9+ALANYHu
         xuJQ==
X-Gm-Message-State: AFqh2krPqMrTApUFtc+O45AdMBtlWdVP40gzsp2isiroFZjQKqgkGLnq
        2m4ntY4gywoq25yafNjj/rHejfLlKHc=
X-Google-Smtp-Source: AMrXdXssegA9kYKRjlrOctGbbeJm4011Wdthjge82j3e0r523u23oEz8BG/Sm+GZIoGEVbQv9Xy7ug==
X-Received: by 2002:a92:1a50:0:b0:30f:3ea9:79f9 with SMTP id z16-20020a921a50000000b0030f3ea979f9mr16985406ill.3.1674679084893;
        Wed, 25 Jan 2023 12:38:04 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:04 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 07/19] dyndbg: reduce verbose/debug clutter
Date:   Wed, 25 Jan 2023 13:37:31 -0700
Message-Id: <20230125203743.564009-8-jim.cromie@gmail.com>
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
2.39.1

