Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490DF708BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjERWkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjERWkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E6E6E;
        Thu, 18 May 2023 15:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82A1E65290;
        Thu, 18 May 2023 22:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A613C433A8;
        Thu, 18 May 2023 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684449619;
        bh=SJxI8K9C2w5GlQmZqTJRQSZCMc1JRXWEVEA8cvqdWaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhW0Cn0f1RevzDaWU0j6r2dq/quj3SUeeEW9Q9uD+27BTcyCxAb8DWP1oDoUuMmXw
         7ggKr9g+nTi86Tpgg7dH1+pt+DGTN11r3tG+SXLNV6vQrRBNH7WNq/SrCE1TKXwsMU
         Adz0O/wz/WwiebYlIBVbmv7NPVkv5x9/gLFBHYBgdcAfW7ZThG9JqZFxL6ucL4u9nI
         K4Saj11CePhstbNsuvKC6qqEhRwOvzhxXj2bfPFN0cfN5mcXh6f1dnHDuT0lKoZ1Uw
         468aEX5WhFycuC7x24O6V3IQgfcdhGg4/u4Bk85AWG9IdvvvL0ihojMMoW2FSxfvET
         xxvGip7ZvV0PA==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Docs/RCU/rculist_nulls: Fix trivial coding style
Date:   Thu, 18 May 2023 22:40:05 +0000
Message-Id: <20230518224008.2468-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518224008.2468-1-sj@kernel.org>
References: <20230518224008.2468-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lookup example of non-hlist_nulls management is missing a semicolon, and
having inconsistent indentation (one line is using single space
indentation while others are using two spaces indentation).  Fix the
trivial issues.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 9a734bf54b76..253ecd869fc2 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -26,7 +26,7 @@ algorithms:
 ::
 
   begin:
-  rcu_read_lock()
+  rcu_read_lock();
   obj = lockless_lookup(key);
   if (obj) {
     if (!try_get_ref(obj)) // might fail for free objects
@@ -68,8 +68,8 @@ And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb()::
        pos && ({ prefetch(pos->next); 1; }) &&
        ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
        pos = rcu_dereference(pos->next))
-   if (obj->key == key)
-     return obj;
+    if (obj->key == key)
+      return obj;
   return NULL;
 
 Quoting Corey Minyard::
-- 
2.25.1

