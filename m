Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF66731FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbjFOSK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbjFOSKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5C295C;
        Thu, 15 Jun 2023 11:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CAFA6104D;
        Thu, 15 Jun 2023 18:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2046C433C0;
        Thu, 15 Jun 2023 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686852612;
        bh=BGArqnN0cuqkluggRcsoV7lA0nFMtudLK2PV5oM2SLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dg7w2Q4eFBTgBpgKnDq/sZZYe9EfGxulIUr82J0bCnZopXm069n/34WAAy6cD1vwO
         dzVlmrSLFAD9Sd4IeMhdQzy/4UuFJHbwdfqYhJCzcymyt8womLR/A7PUUz0ysTA8rR
         oMM4HIaFoENgdA5jVNwq56H6Y4Vj6qw+ydz/xi1aL4OcVDhaozOjSqQdQTKLOekGY0
         tXStzxRXsroFSKaIQLBd6aPC+ZuGJv/pK05PSu9p54+3pFkAAA6wNnzOSEd8g9wzio
         ARHwJ7MqtcKwaIk7vB00eLmLl2jS7UivS148GUWuxkwkfhx7+hKzgIRjo3ulzQWGGp
         Eml0K6jEmwbBg==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] Docs/RCU/rculist_nulls: Fix text about atomic_set_release()
Date:   Thu, 15 Jun 2023 18:10:04 +0000
Message-Id: <20230615181004.86850-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615181004.86850-1-sj@kernel.org>
References: <20230615181004.86850-1-sj@kernel.org>
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

The document says we can avoid extra _release() in insert function when
hlist_nulls is used, but that's not true[1].  Drop it.

[1] https://lore.kernel.org/rcu/46440869-644a-4982-b790-b71b43976c66@paulmck-laptop/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index a24783ebc5df..58a32dad21b8 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -138,8 +138,7 @@ very very fast (before the end of RCU grace period)
 Avoiding extra smp_rmb()
 ========================
 
-With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup()
-and extra _release() in insert function.
+With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup().
 
 For example, if we choose to store the slot number as the 'nulls'
 end-of-list marker for each slot of the hash table, we can detect
@@ -194,6 +193,9 @@ Note that using hlist_nulls means the type of 'obj_node' field of
 2) Insert algorithm
 -------------------
 
+Same to the above one, but uses hlist_nulls_add_head_rcu() instead of
+hlist_add_head_rcu().
+
 ::
 
   /*
-- 
2.25.1

