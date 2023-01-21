Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A76676597
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 11:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAUKML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 05:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUKMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 05:12:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DB535AF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 02:12:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6636EB82B63
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C1BC433EF;
        Sat, 21 Jan 2023 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674295924;
        bh=V8MuxpP8Pi4nAo/iKbDQz0IVxXMZzusqzi08ucS3huo=;
        h=From:To:Cc:Subject:Date:From;
        b=pCEiqGdMg7Kmyme9ku4G6/FgCLG24oj128JxZx9nt4ZpU3Bm+nJ/+6LSWdBEIiAR8
         8oHoV3UtyoTETH6bsS88DBX/x+kqSN7Yc8a6leFJhD4sMkDiDdwPwnNYsE5qW1p4Qv
         axJjjmL+VDnk4tqX9JyqvEwgO2RZeDToxQJp1JXe6P95/WMp0wQwqHqCv+qxagnvBP
         CTgjmTOO0Q/u2Rinqbn3u0IGL03At9NFYFETimbwgOBSyiq3W7AxT2DQAs26d2lzxa
         jleAuSZcJG1zk6ykCKoUcND936na5GSsdHjLvxb5RWUJBn0ACSbInX60d3gK4HfRt9
         GdCqZZ6MpeSrQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH] mm/sparse: fix "unused function 'pgdat_to_phys'" warning
Date:   Sat, 21 Jan 2023 12:11:51 +0200
Message-Id: <20230121101151.1703292-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W=1 build with clangs complains:

mm/sparse.c:347:27: warning: unused function 'pgdat_to_phys' [-Wunused-function]
static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
                             ^
1 warning generated.

pgdat_to_phys() is only used by functions defined when
CONFIG_MEMORY_HOTREMOVE=y.

Move pgdat_to_phys() under #ifdef CONFIG_MEMORY_HOTREMOVE
to make clang happy.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202301210155.1E5zABb5-lkp@intel.com
Signed-off-by: Mike Rapoport <rppt@kernel.org>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 2779b419ef2a..fb7aeb1899a4 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -318,6 +318,7 @@ size_t mem_section_usage_size(void)
 	return sizeof(struct mem_section_usage) + usemap_size();
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
 static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
 {
 #ifndef CONFIG_NUMA
@@ -328,7 +329,6 @@ static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
 #endif
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 static struct mem_section_usage * __init
 sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
 					 unsigned long size)
-- 
2.35.1

