Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAEC6C05DE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCSWBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCSWBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:01:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D871EBD3;
        Sun, 19 Mar 2023 15:00:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5123DB80B8A;
        Sun, 19 Mar 2023 22:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17416C4339E;
        Sun, 19 Mar 2023 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263248;
        bh=EYqScWvKSkV7BdC+HRlB0XJbRdBQ734VVz9MaIm+3GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGon4fhaJq517bPBRcHKmjkvN4o0CTIjBqWQ7HGujGdtR6/e1N65HwBjOyIcIUVW9
         tDfA6jl/oGozUz9exf6JhuiAK1fRBaCBLBZQwLiZ6h6cBOSPk6EgNww8ffo54jFMCk
         99TUCf1bgX4TdLghfR4z3OIXg3Iv6YP91TQyYK/LW3xkr0CljUk1W0NbwqGx4JNsKf
         IMjabdz34G4b94oIhDLS1kgx6k3Ha6F8ooBAOwkWk8rfbIj+e/NrR0W6thXB0OF3U1
         lm9woc3T1itzI8f9Cw7TK6yWn0iU506wYbkiU34TTT9y3cf4qZIVRPpsikb9koDCx5
         1PVwJYaQ236rA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 07/15] init: fold build_all_zonelists() and page_alloc_init_cpuhp() to mm_init()
Date:   Mon, 20 Mar 2023 00:00:00 +0200
Message-Id: <20230319220008.2138576-8-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319220008.2138576-1-rppt@kernel.org>
References: <20230319220008.2138576-1-rppt@kernel.org>
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

Both build_all_zonelists() and page_alloc_init_cpuhp() must be called
after SMP setup is complete but before the page allocator is set up.

Still, they both are a part of memory management initialization, so move
them to mm_init().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 init/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index b2499bee7a3c..4423906177c1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -833,6 +833,10 @@ static void __init report_meminit(void)
  */
 static void __init mm_init(void)
 {
+	/* Initializations relying on SMP setup */
+	build_all_zonelists(NULL);
+	page_alloc_init_cpuhp();
+
 	/*
 	 * page_ext requires contiguous pages,
 	 * bigger than MAX_ORDER unless SPARSEMEM.
@@ -968,9 +972,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
 	boot_cpu_hotplug_init();
 
-	build_all_zonelists(NULL);
-	page_alloc_init_cpuhp();
-
 	pr_notice("Kernel command line: %s\n", saved_command_line);
 	/* parameters may set static keys */
 	jump_label_init();
-- 
2.35.1

