Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87D6664BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbjAJTEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbjAJTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:04:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90196418
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:04:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5335CB8196F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB108C433D2;
        Tue, 10 Jan 2023 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673377445;
        bh=EpuEVUL614S47vXoslv07ySnDH61IdNVsBrU1EkLty8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCl8S7YiAsYSjVYQ6JjpL33E5Zdyh0Drih0OrdQyMBev/agRdKUdaHNWOrGbsRJsk
         CUm9xv0Q1qyvDy/JbGUNQAH4T2SCwyC0lwrr3By+XE5/gPxPZUEJTGvN8p9MNiYoUH
         fJNRL+cOlBex8DtmAvlIcioI4YLkXREUsKisYvBQRXNjsHzh6JIaPkyi0DG+RCkTkY
         BEggkVrMC5MbN75tGE5AjEaBQqvdq+bYZEszEMZhwLR2sFFK/im+NdyEMMbLFCwESC
         lsHWX7EzszK4qUGrr0DNzX1R9gXbytMa+c88X9+QFYpxaCrUt9mwFUlVLDKC/1LoiL
         p5PeAAxRCMc9g==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] mm/damon/core: update kernel-doc comments for DAMOS action supports of each DAMON operations set
Date:   Tue, 10 Jan 2023 19:03:53 +0000
Message-Id: <20230110190400.119388-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110190400.119388-1-sj@kernel.org>
References: <20230110190400.119388-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supports of each DAMOS action are up to DAMON operations set
implementation in use, but not well mentioned on the kernel-doc
comments.  Add the comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7907918ad2e0..3fa96d7c9fe4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -91,6 +91,12 @@ struct damon_target {
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
+ *
+ * The support of each action is up to running &struct damon_operations.
+ * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR supports all actions except
+ * &enum DAMOS_LRU_PRIO and &enum DAMOS_LRU_DEPRIO.  &enum DAMON_OPS_PADDR
+ * supports only &enum DAMOS_PAGEOUT, &enum DAMOS_LRU_PRIO, &enum
+ * DAMOS_LRU_DEPRIO, and &DAMOS_STAT.
  */
 enum damos_action {
 	DAMOS_WILLNEED,
-- 
2.25.1

