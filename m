Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E806B033A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCHJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCHJlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:41:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0355B2571
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:41:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75F1761723
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA97C433A0;
        Wed,  8 Mar 2023 09:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678268496;
        bh=GyhXyClHrKgOJtAqFaxPxOscSnZByfdcCSJ4z9LZSNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pkmvdm5Ytxnt5h8jxKV6y+9spytNeNwCgY/lva+XKpCfpv2UDmFkQKXBEAPoZcPry
         ht6/BanBBGO/Ng+UwA4oJEes3D7Do1tSgu0fOyzsrsuFhVAaq8Fsf0yp5RspB2D/Lu
         lH3YM2i5lENWXxwTFZya+4DVuWQsaPy6gdGfUDbtqepQy68XZdfv9XAzN+HqlVtRDZ
         ekAyOV3eAfFITQHTYyjo73txVENSz2Zeqo+39fJfmKQc0sbRYnTO1sCtQWFCpyp6Em
         ZjhRFv88SpQ75C8j8pLGdjLo+iZuPCKs/sCi988FtUl7CBJI2C/MuBNLv8SxEFu5VZ
         OMu/uN9ykVk5w==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [RFC PATCH 4/5] EXPERIMENTAL: x86: use __GFP_UNMAPPED for modele_alloc()
Date:   Wed,  8 Mar 2023 11:41:05 +0200
Message-Id: <20230308094106.227365-5-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230308094106.227365-1-rppt@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/x86/kernel/module.c | 2 +-
 mm/vmalloc.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 84ad0e61ba6e..845ed70ba5ab 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -67,7 +67,7 @@ static unsigned long int get_module_load_offset(void)
 
 void *module_alloc(unsigned long size)
 {
-	gfp_t gfp_mask = GFP_KERNEL;
+	gfp_t gfp_mask = GFP_KERNEL | __GFP_UNMAPPED;
 	void *p;
 
 	if (PAGE_ALIGN(size) > MODULES_LEN)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ef910bf349e1..84220ec45ec2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2892,7 +2892,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * to fails, fallback to a single page allocator that is
 	 * more permissive.
 	 */
-	if (!order) {
+	if (!order && !(gfp & __GFP_UNMAPPED)) {
 		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
 
 		while (nr_allocated < nr_pages) {
-- 
2.35.1

