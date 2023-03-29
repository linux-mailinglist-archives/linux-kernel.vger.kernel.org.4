Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7F6CD7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjC2Ksa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjC2Ks3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:48:29 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74851FC3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:48:26 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 32TAlrt7027417;
        Wed, 29 Mar 2023 18:47:53 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 29 Mar 2023 18:47:51 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCH] mm: mark folio as workingset in lru_deactivate_fn
Date:   Wed, 29 Mar 2023 18:47:35 +0800
Message-ID: <1680086855-7989-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 32TAlrt7027417
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

folio will skip of being set as workingset in lru_deactivate_fn.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/swap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swap.c b/mm/swap.c
index 70e2063..4d1c14f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -603,6 +603,7 @@ static void lru_deactivate_file_fn(struct lruvec *lruvec, struct folio *folio)
 	lruvec_del_folio(lruvec, folio);
 	folio_clear_active(folio);
 	folio_clear_referenced(folio);
+	folio_set_workingset(folio);
 
 	if (folio_test_writeback(folio) || folio_test_dirty(folio)) {
 		/*
@@ -637,6 +638,7 @@ static void lru_deactivate_fn(struct lruvec *lruvec, struct folio *folio)
 		lruvec_del_folio(lruvec, folio);
 		folio_clear_active(folio);
 		folio_clear_referenced(folio);
+		folio_set_workingset(folio);
 		lruvec_add_folio(lruvec, folio);
 
 		__count_vm_events(PGDEACTIVATE, nr_pages);
-- 
1.9.1

