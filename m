Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CE96F62A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 03:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjEDB3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 21:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjEDB30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 21:29:26 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD510F4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683163763;
        bh=ChUVnmTcKYnskiJX03Msq+VaqE0BCYSG0uVoH9Ivm5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xuygN5Uk+Hvtln/jqZyQY5taMTYykXzZu7+wCO+uCyRbm0ZIuMmTTsY20OVKDcLlr
         7fbMY8KxL3WB1WB5t0XoAP1KqH8RHZ5SxcGGhliMmFNn3kNi9FhgbblkCKmHU3pJRC
         Gm/5Uwj5Jquo7VWNULpF5BoBXA0A87/18pKeg19+eujMsfwNCA0/1L1ftETPKCAz/D
         rcUu3Sx3wyV2j7molHKbwRfMP1RL9XksCsg9vCtwDNUzkZAfFvnMcUeZTKP4bbTIEa
         IoaMbjSuW/wHXNbJy523mfiqu4kky5EJ20UvlzlBgj/i1y/NMQ5zV0Y9OTymCeO6oV
         EFlybCFs2SS+A==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QBbnv61Kbz11fg;
        Wed,  3 May 2023 21:29:23 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 4/4] llist.h: Fix parentheses around macro pointer parameter use
Date:   Wed,  3 May 2023 21:29:14 -0400
Message-Id: <20230504012914.1797355-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing parentheses around use of macro argument "pos" in those
patterns to ensure operator precedence behaves as expected:

- typeof(*pos)
- pos->member

The typeof(*pos) lack of parentheses around "pos" is not an issue per se
in the specific macros modified here because "pos" is used as an lvalue,
which should prevent use of any operator causing issue. Still add the
extra parentheses for consistency.

Remove useless parentheses around use of macro parameter (node) in the
following pattern:

  llist_entry((node), typeof(*pos), member)

Because comma is the lowest priority operator already, so the extra pair
of parentheses is redundant.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/llist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d02d65..45d358c15d0d 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -173,9 +173,9 @@ static inline void init_llist_head(struct llist_head *list)
  * reverse the order by yourself before traversing.
  */
 #define llist_for_each_entry_safe(pos, n, node, member)			       \
-	for (pos = llist_entry((node), typeof(*pos), member);		       \
+	for (pos = llist_entry(node, typeof(*(pos)), member);		       \
 	     member_address_is_nonnull(pos, member) &&			       \
-	        (n = llist_entry(pos->member.next, typeof(*n), member), true); \
+		(n = llist_entry((pos)->member.next, typeof(*(n)), member), true); \
 	     pos = n)
 
 /**
-- 
2.25.1

