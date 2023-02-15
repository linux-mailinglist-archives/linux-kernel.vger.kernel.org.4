Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3665698889
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjBOXDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBOXDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:03:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E48B902E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:03:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0E1D61DE7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89883C433EF;
        Wed, 15 Feb 2023 23:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676502188;
        bh=UKPr8oh22HzQYTrLgMsIu2vdyosO47eeoc8UdL0ln30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRN/etESUyuiZB3K3jWcCHT/Vlvrlx9cP+9haAT0fEkyexVuIGTJczYfGWgHa36/V
         qRLIIOF+FjArs5oN4Qcd6izqOzLs16cg5Q+yz7S+xxpkmVPaggs64E2UTIZbwIRlXZ
         SEjpDrkQY2duscuoD2Lz75jV8cy4Wx7qHvd3yKk27HUNxX8DgtJOFrJxoB8ZhFxiCv
         QKCc0MghhRzIrI3MESAmaMyiZAwyDSxn4xRC2UaIZEwP90cf3OCuO+DvULghKkjn8d
         qdSrtChI4nh242kgB2Luputd0TQfHj4lvtrA05S1Fk1ALjbwtXG3Ps7EUa0ijWYpwJ
         YaVHgucqHaCiQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/memory_hotplug: return nothing from do_migrate_range()
Date:   Wed, 15 Feb 2023 23:02:59 +0000
Message-Id: <20230215230300.61125-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215230300.61125-1-sj@kernel.org>
References: <20230215230300.61125-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value mechanism of do_migrate_range() is not very simple, while
no caller of the function checks the return value.  Make the function
return nothing to be more simple.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/memory_hotplug.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bcb0dc41c2f2..6c615ba1a5c7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1620,8 +1620,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-static int
-do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
+static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
 	struct page *page, *head;
@@ -1721,8 +1720,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			putback_movable_pages(&source);
 		}
 	}
-
-	return ret;
 }
 
 static int __init cmdline_parse_movable_node(char *p)
-- 
2.25.1

