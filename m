Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4CD6B673B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCLOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCLOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:41:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B16F457CB;
        Sun, 12 Mar 2023 07:41:16 -0700 (PDT)
Date:   Sun, 12 Mar 2023 14:41:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678632074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNiI+K/uDME8lIOLd0254ouP3TSGpYvgkL8w+k81abs=;
        b=SBt074EYKLdmcaOnKqzJVYZB4dmbOKcA10P0kvEoHVqhhTswhEVmYjPXqTwM6l9cMx6K9E
        rOksGxiZpH4ydr0tS4MIJjkHJnRG5kEfwmj+R71hGTU7znyOKuIT2RzLTSH2zbynpYr1fT
        Aexl59uxTuQqRoFALHFM2FOtVv0b3NknITOzIgZqE9lTMu62wSMcDhjQtvmVx2Ogr7XLi9
        uXgrNpzLWJiO1qDzsbTymY0kptalLu4uygN8JDFdKL8foZmByLa2Pz7SU8JYCcJgCVASGg
        tPAPmXNowYsI7nISL+R6sQUiJm3rklY2L2P+pMTQhS76GaTFBL4eAJrTqxTziw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678632074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNiI+K/uDME8lIOLd0254ouP3TSGpYvgkL8w+k81abs=;
        b=Jv8GwNd3c1+X/Xxe3CgbL72oHaRQj8At3Wll9q/yFamMnCjB4rrhfbbiqfTnTEMl0oAeca
        J0YBrAbURDzBW+Dg==
From:   "tip-bot2 for Andrzej Hajda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] llist: simplify __llist_del_all
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Shyti <andi.shyti@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118154450.73842-4-andrzej.hajda@intel.com>
References: <20230118154450.73842-4-andrzej.hajda@intel.com>
MIME-Version: 1.0
Message-ID: <167863207410.5837.11889564974236848879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ce27b24cbf7f62b74c4cbf807a06f42a14ccf981
Gitweb:        https://git.kernel.org/tip/ce27b24cbf7f62b74c4cbf807a06f42a14ccf981
Author:        Andrzej Hajda <andrzej.hajda@intel.com>
AuthorDate:    Wed, 18 Jan 2023 16:44:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Mar 2023 14:03:59 +01:00

llist: simplify __llist_del_all

llist_del_all uses xchg, let's use __xchg here.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/20230118154450.73842-4-andrzej.hajda@intel.com
---
 include/linux/llist.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d..4dc1d18 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -50,6 +50,7 @@
 
 #include <linux/atomic.h>
 #include <linux/container_of.h>
+#include <linux/non-atomic/xchg.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 
@@ -241,10 +242,7 @@ static inline struct llist_node *llist_del_all(struct llist_head *head)
 
 static inline struct llist_node *__llist_del_all(struct llist_head *head)
 {
-	struct llist_node *first = head->first;
-
-	head->first = NULL;
-	return first;
+	return __xchg(&head->first, NULL);
 }
 
 extern struct llist_node *llist_del_first(struct llist_head *head);
