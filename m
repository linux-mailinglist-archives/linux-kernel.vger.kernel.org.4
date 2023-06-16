Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F47733CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345788AbjFPXgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345777AbjFPXgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D03A3AB3;
        Fri, 16 Jun 2023 16:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E69B9623C4;
        Fri, 16 Jun 2023 23:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90E3C433C8;
        Fri, 16 Jun 2023 23:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686958592;
        bh=Lcfm0OdItYB2zZ/FXd8OC9BkWFuELqxJlr2ec9I0ACI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6iOOxAImFvfzsq3NLrXc9ruXfxNGqrgXYH/eyLxngnCVEL/jmDC9OccFZ+RLMrxa
         w2+woDg/eqFXS1GB2sBBnxNNxId+ZvRFFuUx7wQANr64cj/vKQjQGbMIGJxjU3alTW
         0wPb8+l+ldF5OEFSQF6pkL/EcaP6utn7hcSIZyrZCcRdQ3zrywjt5hQhBoA31Tm3DZ
         oVG8wbkw+e5fqOXDDEc5CUFJ/XWRyipqd7UdboPEldHvjky6zBg6RfG0uWQ2xC5i9p
         7/q6qsgdXlXL1k73LYccPkm3fFVF20Z76QevEhsR+2KUAsbkyFqx2KZCgrAE+2rjHQ
         cFj6tqhkRHuKg==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] Docs/RCU/rculist_nulls: Specify type of the object in examples
Date:   Fri, 16 Jun 2023 23:36:24 +0000
Message-Id: <20230616233626.83906-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616233626.83906-1-sj@kernel.org>
References: <20230616233626.83906-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of 'obj' in example code of rculist_nulls.rst is implicit.
Provide the specific type of it before the example code.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/rcu/43943609-f80c-4b6a-9844-994eef800757@paulmck-laptop/
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 94a8bfe9f560..a6827cc31791 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -18,7 +18,16 @@ to solve following problem.
 
 Without 'nulls', a typical RCU linked list managing objects which are
 allocated with SLAB_TYPESAFE_BY_RCU kmem_cache can use the following
-algorithms:
+algorithms.  Following examples assume 'obj' is a pointer to such
+objects, which is having below type.
+
+::
+
+  struct object {
+    struct hlist_node obj_node;
+    atomic_t refcnt;
+    unsigned int key;
+  };
 
 1) Lookup algorithm
 -------------------
@@ -142,6 +151,9 @@ the beginning. If the object was moved to the same chain,
 then the reader doesn't care: It might occasionally
 scan the list again without harm.
 
+Note that using hlist_nulls means the type of 'obj_node' field of
+'struct object' becomes 'struct hlist_nulls_node'.
+
 
 1) lookup algorithm
 -------------------
-- 
2.25.1

