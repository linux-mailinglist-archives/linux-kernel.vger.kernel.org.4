Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C0C6BB510
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjCONql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjCONqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:46:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E716B6BC22;
        Wed, 15 Mar 2023 06:45:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 662351FD76;
        Wed, 15 Mar 2023 13:45:52 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 4E21C2C141;
        Wed, 15 Mar 2023 13:45:52 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: sibyte: remove no longer needed board_mem_region
Date:   Wed, 15 Mar 2023 14:45:48 +0100
Message-Id: <20230315134548.79898-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_FAIL,SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the direct use of memblock interface board_mem_region is no
longer needed.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/sibyte/common/cfe.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index 1a504294d85f..2503f60271e8 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -35,11 +35,6 @@
 #endif
 #endif
 
-#define SIBYTE_MAX_MEM_REGIONS 8
-phys_addr_t board_mem_region_addrs[SIBYTE_MAX_MEM_REGIONS];
-phys_addr_t board_mem_region_sizes[SIBYTE_MAX_MEM_REGIONS];
-unsigned int board_mem_region_count;
-
 int cfe_cons_handle;
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -141,16 +136,6 @@ static __init void prom_meminit(void)
 					size -= 512;
 				memblock_add(addr, size);
 			}
-			board_mem_region_addrs[board_mem_region_count] = addr;
-			board_mem_region_sizes[board_mem_region_count] = size;
-			board_mem_region_count++;
-			if (board_mem_region_count ==
-			    SIBYTE_MAX_MEM_REGIONS) {
-				/*
-				 * Too many regions.  Need to configure more
-				 */
-				while(1);
-			}
 		}
 	}
 #ifdef CONFIG_BLK_DEV_INITRD
-- 
2.35.3

