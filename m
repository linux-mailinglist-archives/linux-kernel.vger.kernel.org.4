Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067F17058D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjEPU04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEPU0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67851D04B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:26:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32B14638F9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1707C433EF;
        Tue, 16 May 2023 20:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268769;
        bh=DGi4eUWzPXy8Fa8N7P2ArAP2jVc3TCXs+v8ySrraZgA=;
        h=From:To:Cc:Subject:Date:From;
        b=AEVTnF6C2ACn2TfkYqOFHyR/RMkD8WW54QwQYAlXhgQX38M7pnjLIX/9jrkXUdCOD
         A34gXpgBUrVktk6QgU80CMsNHMhyeWJ6MTXRlmrg/I9T+Q4GjRtnI6d5qGbd39ZaC3
         csFj+bqmSM9h2MJvJi5uaW5mrZDNxYwK580vUWQC1mfyKXeih+dokFpfIMcqz3ch6A
         erBTAAp/fEvMygNth8dp4XK2h36r5rMB6jflB50joDra/mwKOsCJYPya5NXDVE+bXS
         qK/CwbUPXzeEFErZyy7z3oeTD4KwIWxJ6ey6e1oNSau/sVc/VnSwKLafo0n96sQ8g9
         4NTXKHhuwDqHQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        Adrien Thierry <athierry@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq_arm: mark vchiq_platform_init() static
Date:   Tue, 16 May 2023 22:25:55 +0200
Message-Id: <20230516202603.560554-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function has no callers from other files, and the declaration
was removed a while ago, causing a W=1 warning:

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:465:5: error: no previous prototype for 'vchiq_platform_init'

Marking it static solves this problem but introduces a new warning
since gcc determines that 'g_fragments_base' is never initialized
in some kernel configurations:

In file included from include/linux/string.h:254,
                 from include/linux/bitmap.h:11,
                 from include/linux/cpumask.h:12,
                 from include/linux/mm_types_task.h:14,
                 from include/linux/mm_types.h:5,
                 from include/linux/buildid.h:5,
                 from include/linux/module.h:14,
                 from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
In function 'memcpy_to_page',
    inlined from 'free_pagelist' at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:433:4:
include/linux/fortify-string.h:57:33: error: argument 2 null where non-null expected [-Werror=nonnull]
include/linux/highmem.h:427:9: note: in expansion of macro 'memcpy'
  427 |         memcpy(to + offset, from, len);
      |         ^~~~~~

Add a NULL pointer check for this in addition to the static annotation
to avoid both.

Fixes: 89cc4218f640 ("staging: vchiq_arm: drop unnecessary declarations")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 90a3958d1f29..aa2313f3bcab 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -415,7 +415,7 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
 	pagelistinfo->scatterlist_mapped = 0;
 
 	/* Deal with any partial cache lines (fragments) */
-	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS) {
+	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS && g_fragments_base) {
 		char *fragments = g_fragments_base +
 			(pagelist->type - PAGELIST_READ_WITH_FRAGMENTS) *
 			g_fragments_size;
@@ -462,7 +462,7 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
 	cleanup_pagelistinfo(instance, pagelistinfo);
 }
 
-int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
+static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 {
 	struct device *dev = &pdev->dev;
 	struct vchiq_drvdata *drvdata = platform_get_drvdata(pdev);
-- 
2.39.2

