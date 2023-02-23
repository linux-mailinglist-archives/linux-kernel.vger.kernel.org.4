Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45F66A0144
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjBWCo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjBWCo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:44:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DCB279B5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=krGz8JNPEfUKWYOBIr5M4Mxvx6mftCSbjb3cTtYDfCE=; b=WPU7CMVf2DgW2/TSJHS9J0wBbm
        7uuRWz2+zFq+EasHiqr1iOkkS9NL5LWxlcCD3ssYHfVxIZqQ+gtxv8xIAdydY8zeX2XXxPd32DMrA
        xH98Va7Idt0dDo+kqQgqTYTrqEJ2RAZYXxd257F82UMExgv3lmhVcPSPPsWAeKfauFFTA3TPeq+Di
        Uq9O1gx1dLSp7+uLiQvB2zJWZIz0xjOpuHO5MScdavofEmCokIJtKYMbj90wP8/izrEAVUewGnRZo
        UUKkZ2ofyPO4lPHlNe3XteK6m8dKpiwygeke619PsuduCvAAoLvnnP9ZRzHoaSHqgmML7d+uGrreJ
        IZ2d8kFg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV1ah-00EmN8-6C; Thu, 23 Feb 2023 02:44:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, dave@stgolabs.net,
        a.manzanares@samsung.com, yosryahmed@google.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 1/5] shmem: remove check for folio lock on writepage()
Date:   Wed, 22 Feb 2023 18:44:08 -0800
Message-Id: <20230223024412.3522465-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230223024412.3522465-1-mcgrof@kernel.org>
References: <20230223024412.3522465-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew notes we should not need to check the folio lock
on the writepage() callback so remove it. This sanity check
has been lingering since linux-history days. We remove this
as we tidy up the writepage() callback to make things a bit
clearer.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 28f3c699c8ce..b3ad619328bf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1351,7 +1351,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		folio_clear_dirty(folio);
 	}
 
-	BUG_ON(!folio_test_locked(folio));
 	mapping = folio->mapping;
 	index = folio->index;
 	inode = mapping->host;
-- 
2.39.1

