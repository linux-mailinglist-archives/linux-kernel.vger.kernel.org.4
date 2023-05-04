Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8586F7778
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjEDUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEDUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:52:12 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80E41982
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230734;
        bh=dJQRAkXY/sZd+jGAwjtNNNkqluNx5CFdlblILWEd/ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxPC214CyqN3DWs2Lz4/8H6/dXwg9FXVbDVTrZWqDb53iOczpo8qSltyhMXsKwuUh
         mSGGhtlybyKW4PFy+3RZ0T4kXVvvAKZfEfsw595k3mDQC88GSyd96HZKORmxy7TUVi
         4x2hGCby5njBz7+1n1eHcSfOKRHXatuQfYo+JlzLfz5vtcR0IAKJSPVydnIwfIbixw
         YieXJzykgzJAAgUD7XiTv1NnDBZwtM7iPetRzlC1GsbFhNJAtPtWCsvcpc+RvXvzil
         tAVfs5s2eRdOsvr6/BJll1vB+hBp0drnQl1WEsbZpdrfIJp6nMwYZxHksGKdNsok70
         L+TBIKiWk4Ulg==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yn75Q6z11jG;
        Thu,  4 May 2023 16:05:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tejun Heo <htejun@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 09/13] klist.h: Fix parentheses around macro parameter use
Date:   Thu,  4 May 2023 16:05:23 -0400
Message-Id: <20230504200527.1935944-10-mathieu.desnoyers@efficios.com>
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

Add missing parentheses around "_name" parameter use in KLIST_INIT().
It keeps list macros consistent, and prevents unexpected operator
precedence situations, for example:

  struct klist a[1] = { KLIST_INIT(*a, NULL, NULL) };

Where the "." operator within KLIST_INIT() is evaluated before the "*"
operator.

Add missing parentheses around macro parameter use in the following
patterns to ensure operator precedence behaves as expected:

- "x = y" is changed for "x = (y)", because "y" can be an expression
  containing a comma if it is the result of the expansion of a macro such
  as #define eval(...) __VA_ARGS__, which would cause unexpected operator
  precedence. This use-case is far-fetched, but we have to choose one
  way or the other (with or without parentheses) for consistency.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/klist.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/klist.h b/include/linux/klist.h
index b0f238f20dbb..d7e0612ca4ff 100644
--- a/include/linux/klist.h
+++ b/include/linux/klist.h
@@ -23,10 +23,10 @@ struct klist {
 } __attribute__ ((aligned (sizeof(void *))));
 
 #define KLIST_INIT(_name, _get, _put)					\
-	{ .k_lock	= __SPIN_LOCK_UNLOCKED(_name.k_lock),		\
-	  .k_list	= LIST_HEAD_INIT(_name.k_list),			\
-	  .get		= _get,						\
-	  .put		= _put, }
+	{ .k_lock	= __SPIN_LOCK_UNLOCKED((_name).k_lock),		\
+	  .k_list	= LIST_HEAD_INIT((_name).k_list),		\
+	  .get		= (_get),					\
+	  .put		= (_put), }
 
 #define DEFINE_KLIST(_name, _get, _put)					\
 	struct klist _name = KLIST_INIT(_name, _get, _put)
-- 
2.25.1

