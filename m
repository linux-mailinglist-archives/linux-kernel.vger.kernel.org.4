Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1542F6C9682
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjCZQCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjCZQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:02:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250F01708
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD9560F0D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BC9C433EF;
        Sun, 26 Mar 2023 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679846548;
        bh=5GI+UWw52yzkDB1j5DJoxEVt+0WJ22Fk+zngw5zbp2U=;
        h=From:To:Cc:Subject:Date:From;
        b=qHDHGNkH/Bk3FiM4UUc3BsWI2eljV2UOe3Q1efpMYxYQexeDVTryU0WViuapsTxxE
         BicCNXRtjfb/NkoeQzBD0JwbBf7z3KWpklROvxUyWyFRTjkGjB+DI10Gtqo5KEJHcB
         nkvYuSf2lpz1wjEXxNpH519Bt8VHzcXF95vGQFlsBxchOZI1V/GVEzslNi/Xmbzlbd
         BK+Q91Ymies/cbC01ULtEAwLGXRKT8uy0w4kK76uZZN+FUFZPYw04R+WuscwJOZa8w
         pjLJqFFIdGq4kLNqVzeEkGrvXV+M4Mrqktf8Q7deeDpwU7zXMpLYOGiVS76wbSUVC/
         /ThU0pG9V8crQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: move free_area_empty() to mm/internal.h
Date:   Sun, 26 Mar 2023 19:02:15 +0300
Message-Id: <20230326160215.2674531-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

The free_area_empty() helper is only used inside mm/ so move it there to
reduce noise in include/linux/mmzone.h

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mmzone.h | 5 -----
 mm/internal.h          | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 72837e019bd1..3ccada5e8799 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -110,11 +110,6 @@ struct free_area {
 	unsigned long		nr_free;
 };
 
-static inline bool free_area_empty(struct free_area *area, int migratetype)
-{
-	return list_empty(&area->free_list[migratetype]);
-}
-
 struct pglist_data;
 
 #ifdef CONFIG_NUMA
diff --git a/mm/internal.h b/mm/internal.h
index c05ad651b515..18cda26b8a92 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -517,6 +517,11 @@ void init_cma_reserved_pageblock(struct page *page);
 int find_suitable_fallback(struct free_area *area, unsigned int order,
 			int migratetype, bool only_stealable, bool *can_steal);
 
+static inline bool free_area_empty(struct free_area *area, int migratetype)
+{
+	return list_empty(&area->free_list[migratetype]);
+}
+
 /*
  * These three helpers classifies VMAs for virtual memory accounting.
  */

base-commit: 51551d71edbc998fd8c8afa7312db3d270f5998e
-- 
2.35.1

