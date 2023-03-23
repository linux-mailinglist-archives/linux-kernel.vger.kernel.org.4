Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954326C6778
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjCWMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjCWMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:01:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5268594
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97641B8208F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1859EC433D2;
        Thu, 23 Mar 2023 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679572781;
        bh=me8lIKVzX4f4kEhtj/IZ/N62RywMeIeThO/YQFbwteI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PoRZ7T4VeuvD6lVxWJCeAYNQqpd4RILWHk5vcprJ5zLlgoNJl7XH8sN9RE4DNe/6D
         Gm2fsLvFXKKAhi2TKnz5Y1QJj+hj2GePh81dWspUUTWCHpD6x6h3AntosNQLuaU49A
         pXS7jvc2FraInbauw8rpnt2muQaZpATfJfiv+TeJXMxwaXx9GwEE7+F9DYgjViQfDO
         KPiM+NOhvH3zhggkxDwkLvZFehojjyyBNwvyaUsyAvimIOKWwj/v9UM4bsFC/OwzVW
         BiADB8RPVYiMwojAeD5E7vnJSMNyVfscO1dP6vwSxljAyRbwtFyo0s1pPWVxvJGDA7
         T5QhZQ8KyjN1g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: vmalloc: fix vmap_ram_vread_iter() return value
Date:   Thu, 23 Mar 2023 12:58:35 +0100
Message-Id: <20230323115903.1483668-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323115903.1483668-1-arnd@kernel.org>
References: <20230323115903.1483668-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The error handling in vmap_ram_vread_iter() can return an
uninitialized value in some cases:

mm/vmalloc.c:3539:6: error: variable 'remains' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (!vb)
            ^~~
mm/vmalloc.c:3587:17: note: uninitialized use occurs here
        return count - remains + zero_iter(iter, remains);
                       ^~~~~~~

Move the initialization up a few lines.

Fixes: d9cab54f7737 ("mm: vmalloc: convert vread() to vread_iter()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ebfa1e9fe6f9..fb216495fe5a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3521,7 +3521,7 @@ static size_t vmap_ram_vread_iter(struct iov_iter *iter, const char *addr,
 	struct vmap_block *vb;
 	unsigned long offset;
 	unsigned int rs, re;
-	size_t remains, n;
+	size_t remains = count, n;
 
 	/*
 	 * If it's area created by vm_map_ram() interface directly, but
@@ -3545,7 +3545,6 @@ static size_t vmap_ram_vread_iter(struct iov_iter *iter, const char *addr,
 		goto finished_zero;
 	}
 
-	remains = count;
 	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
 		size_t copied;
 
-- 
2.39.2

