Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693C2731FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbjFOSKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbjFOSKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2792960;
        Thu, 15 Jun 2023 11:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8905A6102A;
        Thu, 15 Jun 2023 18:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586F0C433CB;
        Thu, 15 Jun 2023 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686852611;
        bh=U6h6ZVnX1R+TPZKq+FI4cbLfEjWQ4SmBj/oLpCWrvdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEZlK7GCdb9WE0sL23de54xVIUpj9JSjgpgizcOcQf65VgF3Y9YHrYcfE36RoYDCO
         jlJ9aTzLeztjAvJXhDxv2B5P0KPrtyFgHMch9XmU0P8ntPEwAdbRZmCJSEA8QNgIl5
         GHORoF4RnwMkZBg4R3XkoY/ZgR7plNGJPf/PgBmAg9ybrQJQACTyOc2Apw12Ncvzvg
         60BncB3GqgSNcWwqxv0UD1+YM+7dpRCKg5ewIUK+kNz1+D/h/iittKEKVOM2hw8HvI
         s8tNTMRPDrAQav5j4OXBCCjIkEO1czVyUaVt7d9u1bSqj3WJS02mZcylu0xF5xAEAB
         KfXc6WUzD9QgQ==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] Docs/RCU/rculist_nulls: Specify type of the object in examples
Date:   Thu, 15 Jun 2023 18:10:02 +0000
Message-Id: <20230615181004.86850-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615181004.86850-1-sj@kernel.org>
References: <20230615181004.86850-1-sj@kernel.org>
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

The type of 'obj' in example code of rculist_nulls.rst is implicit.
Provide the specific type of it before the example code.

Suggested-by: aul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/rcu/43943609-f80c-4b6a-9844-994eef800757@paulmck-laptop/
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 94a8bfe9f560..4b66e2fd2fb5 100644
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
+    refcount_t refcnt;
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

