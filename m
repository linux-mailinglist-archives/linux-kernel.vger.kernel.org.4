Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183BE709302
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjESJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjESJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:28:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A5319A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B36336558D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8DBC433EF;
        Fri, 19 May 2023 09:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684488501;
        bh=oqaxusc9buD7w2Ddys91pietI0uocG68+c+khpbA3To=;
        h=From:To:Cc:Subject:Date:From;
        b=RSXpt6Iby9HAjPxnV5GqCjOfqn643OHr3L4k3vxbYnukfGCAjM8QvcsWOHa7GEPGd
         VmOzown06OswYEEihZXC1G30nLZA/aHpwM8SDpNdo7bO+cwPACVkrQy4nz/yizbGXw
         0G4UvKWb07imYX+alpJ8DYT1n3rQk7VL8XH6fS0cS+3wi0SAk7mo9PtYiR7za2OshX
         LlKTQRtQAmBzc0zF3s1N4J8jdEX1tktBv6yvysz42HZCIldxKsBAEZGL4/kGg8zuLo
         HANvZ3FDY+b/Hw5CttK0f7sRDyfP/H5k2OZAzTBQfGupho9LQ/vW58DGGuS73rQYTN
         TKi+vOzAyre4w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm,page_owner: mark page_owner_threshold helpers as static
Date:   Fri, 19 May 2023 11:27:43 +0200
Message-Id: <20230519092800.3772196-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added functions have no prototype:

mm/page_owner.c:748:5: error: no previous prototype for 'page_owner_threshold_get' [-Werror=missing-prototypes]
mm/page_owner.c:754:5: error: no previous prototype for 'page_owner_threshold_set' [-Werror=missing-prototypes]

Evidently they are only meant to be used locally, so just mark them static.

Fixes: daed0e400a81 ("mm,page_owner: filter out stacks by a threshold counter")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/page_owner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 28c519fc9372..bbec66cd1b72 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -745,13 +745,13 @@ const struct file_operations page_owner_stack_operations = {
 
 unsigned long page_owner_stack_threshold;
 
-int page_owner_threshold_get(void *data, u64 *val)
+static int page_owner_threshold_get(void *data, u64 *val)
 {
 	*val = page_owner_stack_threshold;
 	return 0;
 }
 
-int page_owner_threshold_set(void *data, u64 val)
+static int page_owner_threshold_set(void *data, u64 val)
 {
 	page_owner_stack_threshold = val;
 	return 0;
-- 
2.39.2

