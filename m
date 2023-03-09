Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6356B31E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjCIXGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjCIXGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:06:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA74F4033
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=H478EBfRc8YOP2keWn4dK4BIB7gGzmccWr6qJ1Nxgx8=; b=3S7FD3TXf9UwH4vZnN664p7upk
        YngkEO7ZO7iHs5EUB/KYcNJUo/BBNpSQIKzIX2veruPnCMScaqst8M6NFr920RF+Ka8GmIiv23fXF
        e+foHWC2ZT4xOTXoeG61Ldgxwl1krdl21xo/MYEYnmV491LOq4xx+g2ILjTCD4JWvm+gt/0lL8SzB
        7Bm9YAxy2MY4dP5fTR9VKWl1wIcNDc+iMCjK0hDYqtGPmSX4QavVkCiT3qr4JIHo/0u50GiK8JKGd
        LgqymKO7cQtlBE5EemwB6Nd2OqE+Og8haRrr/W8LciuaFC6uSXoTtZsSZUNijvsMRv9frTHiLnack
        9cLWBkwg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paPKW-00CIRO-3B; Thu, 09 Mar 2023 23:05:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/6] shmem: remove check for folio lock on writepage()
Date:   Thu,  9 Mar 2023 15:05:40 -0800
Message-Id: <20230309230545.2930737-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230309230545.2930737-1-mcgrof@kernel.org>
References: <20230309230545.2930737-1-mcgrof@kernel.org>
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
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
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

