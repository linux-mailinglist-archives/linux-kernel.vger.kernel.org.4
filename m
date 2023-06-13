Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25472EAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbjFMSYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239242AbjFMSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F30E41;
        Tue, 13 Jun 2023 11:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D23C62F59;
        Tue, 13 Jun 2023 18:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78518C43331;
        Tue, 13 Jun 2023 18:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680680;
        bh=8QtwSYO8fDJCyX3Iukfsqd/4jzpKwmY5DKHH76v+mD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLe1oDvvlDNZZOS+fcGdvyQGzbtGAu6o52EhnNihiyzLUr40EX0ESaFKJ+C8VUGm7
         3B2ao510PdqLceIpEBAQHFLcjZDj+ibxFG7xGS2v0dddzUw3h9BDOlOh2aekouM0Nu
         8nsaioUIkdfb8YTTx0QtWEsnKUwW++YXrqthph+T0P/yjJ2eynVkbejNRgItTykowt
         zbA5omcQSINpvyzkw4GpVzcHGp7DyKDrdU0DHhG+EsP9vghbx5JdekUGLUkIMmTQxY
         CzLuNzhTNlmKdzbqMJA2pAABmPikZJ6HKDqArYJF1d8BIAl7ySLIT4H3rHAUxInWDp
         9J5JMtL7eFIzQ==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] Docs/RCU/rculist_nulls: Assign 'obj' before use from the examples
Date:   Tue, 13 Jun 2023 18:24:32 +0000
Message-Id: <20230613182434.88317-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613182434.88317-1-sj@kernel.org>
References: <20230613182434.88317-1-sj@kernel.org>
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

Lookup example code snippets in rculist_nulls.rst are using 'obj'
without assignment.  Fix the code to assign it properly.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/rculist_nulls.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 253ecd869fc2..94a8bfe9f560 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -54,7 +54,7 @@ but a version with an additional memory barrier (smp_rmb())
     struct hlist_node *node, *next;
     for (pos = rcu_dereference((head)->first);
          pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
-         ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
+         ({ obj = hlist_entry(pos, typeof(*obj), member); 1; });
          pos = rcu_dereference(next))
       if (obj->key == key)
         return obj;
@@ -66,7 +66,7 @@ And note the traditional hlist_for_each_entry_rcu() misses this smp_rmb()::
   struct hlist_node *node;
   for (pos = rcu_dereference((head)->first);
        pos && ({ prefetch(pos->next); 1; }) &&
-       ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1; });
+       ({ obj = hlist_entry(pos, typeof(*obj), member); 1; });
        pos = rcu_dereference(pos->next))
     if (obj->key == key)
       return obj;
-- 
2.25.1

