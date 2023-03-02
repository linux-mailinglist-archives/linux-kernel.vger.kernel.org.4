Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5936A8D03
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCBX2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjCBX2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:28:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458872693
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=X3niQqWSDaRdijh0GPlKHY1yoysmmoQVBPzADYFTAAk=; b=A1T9i9l/KhB0qQZfQ43uw6v8kl
        DTCTRWDp8ClUN+kK4tmCnmWxFQZNAu7/KlswhmxIBSNnubcoAF/0v32hcIh7vsx/2fYebdrGuOFfD
        cAnCJAhSbnS1joVOILJsNws5NnKu+5mYSq1Eg2EeWdf/r2/gWG/2PiHtkicrXr4nv4g8KNvqyd+h5
        zSb4BZm/8ekQ3nBFaKCQSpzvzbNAJor5LMWh0xvyjEChMKRIwSW6QtvSbE5HH6mk+eiwxMNN1wRYL
        NN7yYd8Xgu8+6Yqm6vtCggq8UsMK7X8LuLapwpCc3bG7p2c7yZG4p+iTMZohqzaupylW/idKcbw0L
        a/8QUp7w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXsL9-003j3I-3W; Thu, 02 Mar 2023 23:27:59 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] shmem: remove check for folio lock on writepage()
Date:   Thu,  2 Mar 2023 15:27:53 -0800
Message-Id: <20230302232758.888157-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230302232758.888157-1-mcgrof@kernel.org>
References: <20230302232758.888157-1-mcgrof@kernel.org>
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
index 1af85259b6fc..7fff1a3af092 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1354,7 +1354,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 		folio_clear_dirty(folio);
 	}
 
-	BUG_ON(!folio_test_locked(folio));
 	mapping = folio->mapping;
 	index = folio->index;
 	inode = mapping->host;
-- 
2.39.1

