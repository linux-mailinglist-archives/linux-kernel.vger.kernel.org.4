Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21B0733D00
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345840AbjFPXgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345821AbjFPXgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:36:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B53599;
        Fri, 16 Jun 2023 16:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C6EF62EF0;
        Fri, 16 Jun 2023 23:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEB0C433D9;
        Fri, 16 Jun 2023 23:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686958594;
        bh=zT5gbB7rVoap1E8WJihukUSBZgfptu3BhHsTT2AdGt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVdz3loJKxKxjdEMlRpBM4tKvO2y4Jrovl353vdDDH2FFxpc98MD95I/mEwiT4ob2
         8wZZX+QOiS3TLDzQbAAXJqtP541njXoNd8k68OJmrjPXZEkWbV2AVsOA275Fkv+jbC
         Nu0CkrUx949fmWRdKZA/wrp5lVh6pEzrUFt0u6LChu1Rpxdn0pPkx5m7hxVGEYm7bK
         0t1lAeWBRhZUomwU7zVRICIyyjyXXcOBdJ0H6fpjbv3BTHD8wN1/QW4l47DA66Oved
         vC1Y0VRlM3B5inFxlLn1/QjPRpS68s1ZPO10+fDXtibFlvvppIt8xZAWN3B9Qb2FSC
         if1YnUwwzSd7A==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] Docs/RCU/rculist_nulls: Fix text about atomic_set_release()
Date:   Fri, 16 Jun 2023 23:36:26 +0000
Message-Id: <20230616233626.83906-4-sj@kernel.org>
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

The document says we can avoid extra _release() in insert function when
hlist_nulls is used, but that's not true[1].  Drop it.

[1] https://lore.kernel.org/rcu/46440869-644a-4982-b790-b71b43976c66@paulmck-laptop/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 4afa11f2c906..660cc3f0f1e5 100644
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

