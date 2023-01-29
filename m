Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC267FDB8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjA2JBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjA2JBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:01:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302691F93B
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:00:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so8493062pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYTls0sLItJ13BlNlV0fsMcWHYqjuL06p2oUDvfLpbs=;
        b=UFQl5hEC0tJ60XZnw0j93sFZpoUKuGUXfyhozpIZq3GnRl464fgjOON43UUnFIYpdJ
         8mScMX7qr/Hnfj4oPxgmw/sqDNW1hYrzSXy1GzGLt7WkMQ/X0FJP6qjOO1wMUeZY0G48
         U0QjLYuB0dqlXrEmo0uE1qAFaUohDFxJIqYf/1C998UfNdzNlOAUlpNt95Ye/cUoL0BI
         cgqe8kynjmkFUI2CurYeemPqHGxmskY+/ctViSZivmBj5L6KdThHpEScBJYmj7S+ean3
         rPNIMWxzCHUcoiR1y/8fhbLOjGQweESSE1RJulSUnXSkwNs38AuTXZ5sTDAkqa5fZ3IR
         pTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYTls0sLItJ13BlNlV0fsMcWHYqjuL06p2oUDvfLpbs=;
        b=tGg2sxjeeyEbNNDTAHWVEg6GyB+QBPiMGBQ2/JQQze5xcOFy2XQ8zoWo5NdfXaoumw
         qfT8owhJ3U+zDsx3SoOATrX6TYYujphGDzTi37VPIMPI5/aXGZQox6slorVjAfynU6/b
         VCx4A6p1+U76nHHVvpNUgLpzsJXUEkJnWUxKg43LhjR8vdg7wU2wfgnBD2qdyQUYikov
         06SGkObd78Ad8jpsYWrFNaRwWTQ/U/QFkkehzfykbdzPI2T6AkMPMSmXhb8AG3vvAlZ7
         qNVuD0db19ja0jgH41ahG3uQ1jxB/M8q9E4HYpOJ26RRAOOPDpYqTUbLvhMkk0StJE4y
         su5Q==
X-Gm-Message-State: AFqh2koSxzrbofSq6DD1W3/xv7NRcODMjjKKGRU4/c8CO9+T6F8IrIKv
        OyvuP3YLzDOTWEPGtFqajG9FIw==
X-Google-Smtp-Source: AMrXdXvtZ6K3ezMB4q3Sdf5+3dLUAIUc/en72O7s8vYwY1nAA3TJGhJrK6jvRhHG+wFds1NfEhjJpQ==
X-Received: by 2002:a17:902:b60e:b0:192:8b0e:98e1 with SMTP id b14-20020a170902b60e00b001928b0e98e1mr39675938pls.54.1674982846728;
        Sun, 29 Jan 2023 01:00:46 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b0019607984a5esm2142689plf.95.2023.01.29.01.00.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Jan 2023 01:00:46 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 1/2] memblock: Make a boundary tighter in memblock_add_range().
Date:   Sun, 29 Jan 2023 17:00:33 +0800
Message-Id: <20230129090034.12310-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230129090034.12310-1-zhangpeng.00@bytedance.com>
References: <20230129090034.12310-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When type->cnt * 2 + 1 is less than or equal to type->max, there is
enough empty regions to insert.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 mm/memblock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 685e30e6d27c..836eb71ea3ea 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -601,11 +601,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	/*
 	 * The worst case is when new range overlaps all existing regions,
 	 * then we'll need type->cnt + 1 empty regions in @type. So if
-	 * type->cnt * 2 + 1 is less than type->max, we know
+	 * type->cnt * 2 + 1 is less than or equal to type->max, we know
 	 * that there is enough empty regions in @type, and we can insert
 	 * regions directly.
 	 */
-	if (type->cnt * 2 + 1 < type->max)
+	if (type->cnt * 2 + 1 <= type->max)
 		insert = true;
 
 repeat:
-- 
2.20.1

