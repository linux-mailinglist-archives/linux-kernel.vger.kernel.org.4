Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEE35B6C83
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiIMLr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiIMLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:47:51 -0400
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EBF1DA61
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:47:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPgF9Ig_1663069663;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPgF9Ig_1663069663)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 19:47:45 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH] mm/damon: add MADV_COLLAPSE support in damos_action
Date:   Tue, 13 Sep 2022 19:47:35 +0800
Message-Id: <20220913114735.22841-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_COLLAPSE has large different with MDVA_HUGE in dealing with huge
pages, it doesn't need to rely on 'khugepage' thread to create THP.
So combining with it will give damon users more options.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h | 1 +
 mm/damon/vaddr.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 016b6c9c03d6..c44f9410d997 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -97,6 +97,7 @@ enum damos_action {
 	DAMOS_PAGEOUT,
 	DAMOS_HUGEPAGE,
 	DAMOS_NOHUGEPAGE,
+	DAMOS_COLLAPSE,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c2c08c1b316b..58c0d068563d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -655,6 +655,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
+	case DAMOS_COLLAPSE:
+		madv_action = MADV_COLLAPSE;
+		break;
 	case DAMOS_STAT:
 		return 0;
 	default:
-- 
2.31.0

