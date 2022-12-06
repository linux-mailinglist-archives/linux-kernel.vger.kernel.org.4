Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9755D643A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiLFAfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiLFAfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:35:12 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651361FCC4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:06 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r72so3706060iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6tS42wKzHwFWcgmodnkZoyUX7n80tfZY9XLsxmA1Do=;
        b=k2iyRQqqWCIOrdGtkc621KTyw3Yr8i4hemurWthxx+uElc9rkOjhMkhs8AHFngTMCQ
         DfWICT9igcSRKiks8MRkStVkTnEnGVu8IxKxsxNdkh7fB8EFo0lqFMdEvIYom1OMEEnx
         X98+fIRvMweLWdzFtpDrqbHud15fbqJi2R5Ci4rcKWQaCrrXzysQ+fuzTLPkR8iP1ml2
         SPL/NVz0SSKg07HMy0YXbUs2Depj0h78qD79bjRgnT3SWAMB4HB/PdHCph86NMCeejN0
         Ru43E2K5KIKsm228N/Bmu/VimgR5R8oZhSxxyp+ltMAge/2LFzWVG9zNMN8qahivx0js
         z1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6tS42wKzHwFWcgmodnkZoyUX7n80tfZY9XLsxmA1Do=;
        b=pEVJd4nybKrT09jR8HGJVtORDhmt2s3wkvYKdiHCmQlK1Bddj9O19NR3TzzwagvtLb
         eoq04+QXBFv/T28ETGq1Cz5GrrE+/mnxyE1ZEkq2+pwVcjKvIxQMoodV7CLHDPULuOev
         EE5/gDD9LXHKPBDwSFsFdeSrFFjM5sS/QN7jU50NKCt25DN/i8HjCFUiOoqL28ii4itc
         lDRMrQaFlepUVSN1nlEB6k2yinahVVsGr1UASnuGxb4ZF3UOFafzyeLfd3Tds5oWeC4e
         ZJTsu6YTBpcHKXxSApZcMEnELK3ED3KR4NGYsifjJ6cVzSDY2DoS2wS4GuTGoLB4MhtA
         QL8g==
X-Gm-Message-State: ANoB5pnnP0LgqOu0yWu8rW0iuJAF0CQzBrWTjQl27libtQfYF0dH+66v
        CCI7P+moZtwDtl19VzxC3Uk+suS9jMnVYA==
X-Google-Smtp-Source: AA0mqf5SSiea/v3tuOJJOGljXEUfXKu8GfsiFh446yniBR0E8M7koAgABT3b+7L6x+ynzdBVfki9mg==
X-Received: by 2002:a05:6638:3e87:b0:363:798f:a924 with SMTP id ch7-20020a0566383e8700b00363798fa924mr39236651jab.172.1670286905378;
        Mon, 05 Dec 2022 16:35:05 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:35:05 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 08/17] dyndbg: reduce verbose/debug clutter
Date:   Mon,  5 Dec 2022 17:34:15 -0700
Message-Id: <20221206003424.592078-9-jim.cromie@gmail.com>
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

currently, for verbose=3, this is logged:

[ 3832.333424] dyndbg: parsed: func="" file="" module="amdgpu" format="" lineno=0-0 class=DRM_UT_PRIME
[ 3832.333888] dyndbg: no matches for query
[ 3832.334093] dyndbg: no-match: func="" file="" module="amdgpu" format="" lineno=0-0 class=DRM_UT_PRIME
[ 3832.334570] dyndbg: processed 1 queries, with 0 matches, 0 errs

This patch removes 2nd & 3rd lines;
 3 differs from 1 only by status
 2 is just status, retold in 4, with more info.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a0dc681cd215..445f25ef2461 100644
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
 
@@ -536,7 +533,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -554,10 +551,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
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
2.38.1

