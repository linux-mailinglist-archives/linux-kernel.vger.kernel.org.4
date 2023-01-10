Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38D664205
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbjAJNgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjAJNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:36:35 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFD8BA3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:36:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZJNeww_1673357787;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VZJNeww_1673357787)
          by smtp.aliyun-inc.com;
          Tue, 10 Jan 2023 21:36:27 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mm: compaction: Remove redundant VM_BUG_ON() in compact_zone()
Date:   Tue, 10 Jan 2023 21:36:18 +0800
Message-Id: <740a2396d9b98154dba76e326cba5e798b640ead.1673342761.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
References: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compaction_suitable() will never return values other than COMPACT_SUCCESS,
COMPACT_SKIPPED and COMPACT_CONTINUE, so after validation of COMPACT_SUCCESS
and COMPACT_SKIPPED, we will never hit other unexpected case. Thus remove
the redundant VM_BUG_ON() validation for the return values of compaction_suitable().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 62a61de44658..5e6f5e35748d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2313,9 +2313,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
 		return ret;
 
-	/* huh, compaction_suitable is returning something unexpected */
-	VM_BUG_ON(ret != COMPACT_CONTINUE);
-
 	/*
 	 * Clear pageblock skip if there were failures recently and compaction
 	 * is about to be retried after being deferred.
-- 
2.27.0

