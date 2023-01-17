Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5830B66E45F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjAQRFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjAQRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:05:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D6A3B67C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:05:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD23AB8128D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F85EC433D2;
        Tue, 17 Jan 2023 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673975112;
        bh=x0X25cKQNML11LK6Kv5Po/7LOUOfaxLt4ZMA8R6qomk=;
        h=From:To:Cc:Subject:Date:From;
        b=bl8jn1kfSXFv8jjXN7ctyTELVTtO2ztNZWJ+28XCuuwNtD89nYTv/KdHetwAW0ai0
         kbocvxRUfBaGWJQnoX/UsIKqM9DGKOfDmyvzwroSw5zQn2kQOFhRBmGN3v9LY1TXWn
         vzl6pcYZZ5jGcc58ippBKZxmR6wajdSv2vMWwkKP0xKHjZT5Vu0M/F6CpOBvz/6Reh
         fzmVG0MS+eq97LXFZQG6+RrCIA+DNHKsbGwd0Fj4Yp6Gr/RDdECax5ZpGAI6UWVRlD
         Q8XEgXNdbAHPLJdDpJFSzehGcGB2a1Fpyydcwbpso46012u/aWbrU+1l6xMHjuKRwI
         U/DyLk5Lq9rpQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] zsmalloc: avoid unused-function warning
Date:   Tue, 17 Jan 2023 18:04:59 +0100
Message-Id: <20230117170507.2651972-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

obj_allocated() can be called from two places that are each
inside of an #ifdef. When both are disabled, the compiler warns:

mm/zsmalloc.c:900:13: error: 'obj_allocated' defined but not used [-Werror=unused-function]

Rather than trying to figure out the correct #ifdef, mark the
trivial function as 'inline', which implies __maybe_unused and
shuts up the warning.

Fixes: 796c71ac728e ("zsmalloc: fix a race with deferred_handles storing")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 723ed56d3fbb..9d27d9b00bce 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -937,7 +937,7 @@ static bool obj_tagged(struct page *page, void *obj, unsigned long *phandle,
 	return true;
 }
 
-static bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
+static inline bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
 {
 	return obj_tagged(page, obj, phandle, OBJ_ALLOCATED_TAG);
 }
-- 
2.39.0

