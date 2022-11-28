Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3809063B203
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiK1TQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiK1TQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:16:25 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3FB2A726
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g10so11120953plo.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+uMQ1ItOkPZCYgWOP1o+0fNZIWxA74Wiz+rf0diPIk=;
        b=mOBGBJZ7OABTvFUk36b1YD2VXURC5VWzKV8eesthXAyoyPSB+PXrQg60yl9zNo2Fe6
         5R+vCBcdHWDJSwYwRE8bxkcD1HE+J+n8xVi1PJ2GN4Tkc+LJGg0hvIho2uUOnWhBSEd3
         iwd7sUGiLgOAdvU/hkrLPYXFWbiaYOwuNvbAcrYKaT5WbuY6OYM6lV4nWrFQvpOvNADG
         Cdea8r/LMopjvcb4eJQ8XeTvuV6rjbOX0Adyb5fWTY8Jo3itY02O4XcLSch8reL4He38
         lwFd26FA3CgiMjzo5fhii63nJUqb4QQHeUw50avhWQrbPMn+MO7Rq6JAeWvim3PXQTgr
         N5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+uMQ1ItOkPZCYgWOP1o+0fNZIWxA74Wiz+rf0diPIk=;
        b=30ScGkXtsg/UYD4XKu/WaUL2Pfm7189H9xZwqJKVwiz0eoHo2D2AsDicnsaypKiA7b
         ujc3D3aDmhdk9dnCgwcXP2lTYz30Yd/c/uxO+kQmrqE1PLc8WW0RKU9lg6RCp0iKQ5SJ
         U7jpzj7wLJQkbDhCF9r2EqsFufJGJUuTBtDqivQ6hHZY/KOhLfZLB1Om9B5I1UikefMe
         e7LFp73k5ApYKdFtDwUne2wkm1fZXTZt3SkEWyzr502C1/oklhMmWG/BHiSSqegWdSGK
         J+R1vbUb9XH8BAcLz+aVa4KprkuvG0u0DJaJHYTh7oiHWFrtwOpX3+gPiBa/0poAkwEI
         Ja1A==
X-Gm-Message-State: ANoB5pk3+RaNvCDCHv7D8vhE9HqFO1uG/OtjV/hKfcokfXePvDPHcJR1
        lmIbCdlJ/wec+S4AM6D683A=
X-Google-Smtp-Source: AA0mqf7BhiiwUiOLsHG8xP4tWbnATiNkWArLtdQfxMZhqLlRBpCQEXvsOymAXRXARI6nxTmj42BqcA==
X-Received: by 2002:a17:902:b493:b0:176:a6fb:801a with SMTP id y19-20020a170902b49300b00176a6fb801amr33820008plr.97.1669662984133;
        Mon, 28 Nov 2022 11:16:24 -0800 (PST)
Received: from localhost (fwdproxy-prn-009.fbsv.net. [2a03:2880:ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id w28-20020aa79a1c000000b005754106e364sm1900230pfj.199.2022.11.28.11.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:16:23 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v7 5/6] zsmalloc: Add zpool_ops field to zs_pool to store evict handlers
Date:   Mon, 28 Nov 2022 11:16:14 -0800
Message-Id: <20221128191616.1261026-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128191616.1261026-1-nphamcs@gmail.com>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
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

This adds a new field to zs_pool to store evict handlers for writeback,
analogous to the zbud allocator.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b1bc231d94a3..d06f9150b9da 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -242,6 +242,8 @@ struct zs_pool {
 #ifdef CONFIG_ZPOOL
 	/* List tracking the zspages in LRU order by most recently added object */
 	struct list_head lru;
+	struct zpool *zpool;
+	const struct zpool_ops *zpool_ops;
 #endif

 #ifdef CONFIG_ZSMALLOC_STAT
@@ -382,7 +384,14 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
 	 * different contexts and its caller must provide a valid
 	 * gfp mask.
 	 */
-	return zs_create_pool(name);
+	struct zs_pool *pool = zs_create_pool(name);
+
+	if (pool) {
+		pool->zpool = zpool;
+		pool->zpool_ops = zpool_ops;
+	}
+
+	return pool;
 }

 static void zs_zpool_destroy(void *pool)
--
2.30.2
