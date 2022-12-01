Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0CF63F2AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiLAOWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiLAOWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:22:08 -0500
X-Greylist: delayed 1806 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 06:22:02 PST
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 335C8ABA0B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BBFOF
        5hbXkx5sANxzuB/pHT2CFFBu2rT2z2PtghB9cA=; b=pcXuO6Ud+cMl17jGdi4Jy
        3AvIzyPm0mmbGZF6WXsDrl6uL10T5Ai7xjNV+Ug70rrdOSKmnSw/pTE2/qdvEaYA
        k3ai4XJ8Bv0i/2DaTWy+WA256Y9R8K9W31f0+8zf3U+RIQpQVNyyaha9i1t+/gEN
        BSZCbRjLw5BxfPgXug+/X0=
Received: from localhost.localdomain (unknown [221.228.128.183])
        by smtp2 (Coremail) with SMTP id DMmowABn7WE3sYhjaCrQEg--.8644S2;
        Thu, 01 Dec 2022 21:50:48 +0800 (CST)
From:   wonder_rock@126.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Deyan Wang <wonder_rock@126.com>
Subject: [PATCH 1/1] mm/page_alloc: update comments in __free_pages_ok()
Date:   Thu,  1 Dec 2022 21:50:45 +0800
Message-Id: <20221201135045.31663-1-wonder_rock@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowABn7WE3sYhjaCrQEg--.8644S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFyruFWDKF1DZr1ktr17trb_yoWfXFcE9a
        1qqry7ur4ftF9xKF47A3Z3JFyfKF18uryxuayftrZxtFy8ZFnrJa18JrnxCrWDWFs0gFWk
        GayvvFZrCw12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZyCp3UUUUU==
X-Originating-IP: [221.228.128.183]
X-CM-SenderInfo: xzrqvv5ubu0ubn6rjloofrz/1tbiuRnKgVpD-Q7q3wAAs0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deyan Wang <wonder_rock@126.com>

Add a comment to explain why we call get_pfnblock_migratetype() twice
in __free_pages_ok().

Signed-off-by: Deyan Wang <wonder_rock@126.com>
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2d4c81224508..52dd4fff280b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1702,6 +1702,11 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	if (!free_pages_prepare(page, order, true, fpi_flags))
 		return;
 
+	/*
+	 * Calling get_pfnblock_migratetype() without spin_lock_irqsave() here
+	 * is used to avoid calling get_pfnblock_migratetype() under the lock.
+	 * This will reduce the lock holding time.
+	 */
 	migratetype = get_pfnblock_migratetype(page, pfn);
 
 	spin_lock_irqsave(&zone->lock, flags);
-- 
2.25.1

