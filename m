Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB36C37C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCURGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjCURGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:06:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA5532BF;
        Tue, 21 Mar 2023 10:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B44AB818B9;
        Tue, 21 Mar 2023 17:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5914C433EF;
        Tue, 21 Mar 2023 17:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418352;
        bh=PM92BQVLa2WxBbnDUdLvSknVaFsEpK5ocCyJK48uW0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VV0W2zZWcfrS0Pnp7+uSdWblosvpxij7nM1hHcrlG6KllIxLpgkWjfxg6L8pJn6fS
         BuLcNFnrrsqJZ2HjcQZgwa16TIsHGm+PlSEnS618ROJunWIwJUgEEKS9BmC8kn9mtZ
         +a/7bhMFsF80Ers2bOuy4wk2Hv6uXB6fN16IauXtYO3TdhOGMD2w+MVQYE18Gy8lNX
         I0UmErrOkPo74b4zSg9+e3g/fu3Q03+8nBlqGdPNQDWEi47Z/ABd4ZcARfsXP8gp/4
         en9kBBqp2MCxbotDylFJMqcRb66FWu2xCKl7T8IUAf9yteeqDDhCD3NcqHA5r7EPKp
         9OrwGIUQYSbLQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 06/14] init: fold build_all_zonelists() and page_alloc_init_cpuhp() to mm_init()
Date:   Tue, 21 Mar 2023 19:05:05 +0200
Message-Id: <20230321170513.2401534-7-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230321170513.2401534-1-rppt@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Both build_all_zonelists() and page_alloc_init_cpuhp() must be called
after SMP setup is complete but before the page allocator is set up.

Still, they both are a part of memory management initialization, so move
them to mm_init().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
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

