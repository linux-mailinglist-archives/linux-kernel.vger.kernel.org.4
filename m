Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104275EBC04
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiI0HxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiI0HxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:53:17 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABAFAB42A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:53:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664265192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QARHQJJqXFRMVlOzDzMQADfn54pG19eVVGeo/uHoR54=;
        b=mwS5stQ5zKqAEvrTnAEnNq2aehk18zEWWgwhz4mJvHGsxxyN7AQuOyAIBbQYedA19wZOFl
        WotowCGn46UDCjOZj8wXkdxxX+xhMBo3WImju8ItTznhseB0gKLqmlv3IR+06f6JnVAc+f
        ueOL+nTj+IXmt0Bfu+aQ9wyLmLi3pMk=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/early_ioremap: Combine two loops to improve performance
Date:   Tue, 27 Sep 2022 15:52:39 +0800
Message-Id: <20220927075239.270583-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first loop will waring once if prev_map is init, we can add a
boolean variable to do that. So those two loops can be combined to
improve performance.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/early_ioremap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c
index 9bc12e526ed0..3076fb47c685 100644
--- a/mm/early_ioremap.c
+++ b/mm/early_ioremap.c
@@ -70,14 +70,15 @@ static unsigned long slot_virt[FIX_BTMAPS_SLOTS] __initdata;
 
 void __init early_ioremap_setup(void)
 {
+	bool init_prev_map = false;
 	int i;
 
-	for (i = 0; i < FIX_BTMAPS_SLOTS; i++)
-		if (WARN_ON(prev_map[i]))
-			break;
+	for (i = 0; i < FIX_BTMAPS_SLOTS; i++) {
+		if (!init_prev_map && WARN_ON(prev_map[i]))
+			init_prev_map = true;
 
-	for (i = 0; i < FIX_BTMAPS_SLOTS; i++)
 		slot_virt[i] = __fix_to_virt(FIX_BTMAP_BEGIN - NR_FIX_BTMAPS*i);
+	}
 }
 
 static int __init check_early_ioremap_leak(void)
-- 
2.25.1

