Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0791D6F7776
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjEDUwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEDUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:52:12 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ECD93FE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230733;
        bh=d1KfLyc6kB5wDCv4ypHLZjfVgQsbxIXbUETDS35Ubh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toqxukN7T7Av2eyJcYL2ReSsGzK35iliPKL5M9vE69O5uZjYjlUmjCXQrvge67SxK
         hP9j6ab2jjsexqBW5FeevpasCXjAp+BCOdVUEy5fj7Wsu76oJrbE+jcBb6E3K1J0S6
         a/DB/3f2G1yaU2zI24mI8/oZ9SziaFFLNf99ryEp8mnnwAZC8UeoqW6vxn9VWnE9NF
         SzcMpF+SbmjpAB2+18ZxFWorz57tY7oOcbmcXwkafxxBX84WvWHBoQ3OfRUj0qy8kG
         TgotT3nEWmSh86Z1yYRb6zKbuqlRMW4G8iKlykQDNbMuWFKcbYze6Oacc3KXPhIu3+
         60KbS6+/3qpzA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yn3w9Nz11qt;
        Thu,  4 May 2023 16:05:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nick Piggin <npiggin@kernel.dk>
Subject: [RFC PATCH 07/13] list_bl.h: Fix parentheses around macro pointer parameter use
Date:   Thu,  4 May 2023 16:05:21 -0400
Message-Id: <20230504200527.1935944-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing parentheses around use of macro argument "tpos" in those
patterns to ensure operator precedence behaves as expected:

- typeof(*tpos)
- pos->next
- "x = y" is changed for "x = (y)", because "y" can be an expression
  containing a comma if it is the result of the expansion of a macro such
  as #define eval(...) __VA_ARGS__, which would cause unexpected operator
  precedence. This use-case is far-fetched, but we have to choose one
  way or the other (with or without parentheses) for consistency.
- x && y is changed for (x) && (y).

The typeof(*tpos) lack of parentheses around "tpos" is not an issue per se
in the specific macros modified here because "tpos" is used as an lvalue,
which should prevent use of any operator causing issue. Still add the
extra parentheses for consistency.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@kernel.dk>
---
 include/linux/list_bl.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..450cca15496b 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -168,9 +168,9 @@ static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
  */
 #define hlist_bl_for_each_entry(tpos, pos, head, member)		\
 	for (pos = hlist_bl_first(head);				\
-	     pos &&							\
-		({ tpos = hlist_bl_entry(pos, typeof(*tpos), member); 1;}); \
-	     pos = pos->next)
+	     (pos) &&							\
+		({ tpos = hlist_bl_entry(pos, typeof(*(tpos)), member); 1;}); \
+	     pos = (pos)->next)
 
 /**
  * hlist_bl_for_each_entry_safe - iterate over list of given type safe against removal of list entry
@@ -182,8 +182,8 @@ static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
  */
 #define hlist_bl_for_each_entry_safe(tpos, pos, n, head, member)	 \
 	for (pos = hlist_bl_first(head);				 \
-	     pos && ({ n = pos->next; 1; }) && 				 \
-		({ tpos = hlist_bl_entry(pos, typeof(*tpos), member); 1;}); \
-	     pos = n)
+	     (pos) && ({ n = (pos)->next; 1; }) &&			 \
+		({ tpos = hlist_bl_entry(pos, typeof(*(tpos)), member); 1;}); \
+	     pos = (n))
 
 #endif
-- 
2.25.1

