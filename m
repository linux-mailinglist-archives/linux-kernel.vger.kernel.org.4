Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865646F775A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjEDUsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjEDUry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:47:54 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0725AD22
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230733;
        bh=dMinXl77eDsU1Swj1Mb43GwAjcr/wXhk2zDxp1xftSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKHvDn6Hf3v0PHsQWe1RYRYUrA6cXCyH8x79TPvgUZp1EldRddS1HoRHyXcsej3KL
         MzttQmErR1tipru+dWJxiPqeOpKCqohr0r0M5qbIOZDWXzAmLatxqJ0tLt1uCERr7M
         Q1RjExLIPDuvuxS/aMp9Onj9KvtqU/4ZrjjOaZtq1NKCsBDDqRUcsYWyo4xfZ95yBG
         PUyU6YuACzZPsntH2K4lvKUXxuthxoyYcHxMO9vgdK2AOqRmCg5mK8kNG7hTuoX9W/
         gz86VeH9i+KvGq8E07uXrGku3OO+Ub5r/oj/KUnkXfyjd3nMSC3dn7IEDYsroPjZDd
         V9kHHG34ChNxA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yn2d43z11qs;
        Thu,  4 May 2023 16:05:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [RFC PATCH 06/13] list_nulls.h: Fix parentheses around macro pointer parameter use
Date:   Thu,  4 May 2023 16:05:20 -0400
Message-Id: <20230504200527.1935944-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
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

- typeof(*tpos)
- pos->next

The typeof(*tpos) lack of parentheses around "tpos" is not an issue per se
in the specific macros modified here because "tpos" is used as an lvalue,
which should prevent use of any operator causing issue. Still add the
extra parentheses for consistency.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Dumazet <edumazet@google.com>
---
 include/linux/list_nulls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index fa6e8471bd22..74ffde881e44 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -127,8 +127,8 @@ static inline void hlist_nulls_del(struct hlist_nulls_node *n)
 #define hlist_nulls_for_each_entry(tpos, pos, head, member)		       \
 	for (pos = (head)->first;					       \
 	     (!is_a_nulls(pos)) &&					       \
-		({ tpos = hlist_nulls_entry(pos, typeof(*tpos), member); 1;}); \
-	     pos = pos->next)
+		({ tpos = hlist_nulls_entry(pos, typeof(*(tpos)), member); 1;}); \
+	     pos = (pos)->next)
 
 /**
  * hlist_nulls_for_each_entry_from - iterate over a hlist continuing from current point
@@ -139,7 +139,7 @@ static inline void hlist_nulls_del(struct hlist_nulls_node *n)
  */
 #define hlist_nulls_for_each_entry_from(tpos, pos, member)	\
 	for (; (!is_a_nulls(pos)) && 				\
-		({ tpos = hlist_nulls_entry(pos, typeof(*tpos), member); 1;}); \
-	     pos = pos->next)
+		({ tpos = hlist_nulls_entry(pos, typeof(*(tpos)), member); 1;}); \
+	     pos = (pos)->next)
 
 #endif
-- 
2.25.1

