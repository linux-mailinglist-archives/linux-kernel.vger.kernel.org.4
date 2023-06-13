Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1272EAF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbjFMSZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbjFMSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A54DE41;
        Tue, 13 Jun 2023 11:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F36063365;
        Tue, 13 Jun 2023 18:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125D1C433F1;
        Tue, 13 Jun 2023 18:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680681;
        bh=tKaE0feCA4Misffydrf5UR6uG+RXTeYv2hshyi6erLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BhJ2cluNI4psNgHorBPau3CpVT1R9LA6maOtkq4Jg7r+eOP1b9SBvIOw2gL4U1U+p
         sJTDHRyT0xThUGQQ3SLFPV51kBaQry3fG6EpHHmfpVx6TLUEBMwzHlrlcuav0vhQaV
         BtJbiA9mYF3TaUyVgC1XDtp32cQR+GRJ5jE5SXiqkHGYF9M9LCMyC1VBaVAdeE8YB6
         rbd54j5/RMZflfPPq/WfFhiV2g7HBVbkOaX4veNpewafKHPPILbiiNeVGRg4OX1rSp
         24wcRcOPE9R4POUba/uQafK1PW/ggSSCEq1vPrrhTKW4g84QbMBGLbMau12YYQpZpk
         ouVO+GoDJhOzg==
From:   SeongJae Park <sj@kernel.org>
To:     paulmck@kernel.org
Cc:     SeongJae Park <sj@kernel.org>, joel@joelfernandes.org,
        mmpgouride@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] Docs/RCU/rculist_nulls: Fix wrong text about atomic_set_release()
Date:   Tue, 13 Jun 2023 18:24:34 +0000
Message-Id: <20230613182434.88317-5-sj@kernel.org>
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

The document says we can avoid extra _release() in insert function when
hlist_nulls is used, but that's not true[1].  Drop it.

[1] https://lore.kernel.org/rcu/46440869-644a-4982-b790-b71b43976c66@paulmck-laptop/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 5cd6f3f8810f..018cc100d19b 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -129,8 +129,7 @@ very very fast (before the end of RCU grace period)
 Avoiding extra smp_rmb()
 ========================
 
-With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup()
-and extra _release() in insert function.
+With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup().
 
 For example, if we choose to store the slot number as the 'nulls'
 end-of-list marker for each slot of the hash table, we can detect
@@ -182,6 +181,9 @@ scan the list again without harm.
 2) Insert algorithm
 -------------------
 
+Same to the above one, but uses hlist_nulls_add_head_rcu() instead of
+hlist_add_head_rcu().
+
 ::
 
   /*
-- 
2.25.1

