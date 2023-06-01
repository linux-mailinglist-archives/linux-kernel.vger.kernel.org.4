Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A9B719353
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjFAGgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjFAGf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:35:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C5F98
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:35:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d24136685so435423b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1685601356; x=1688193356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2GsxwgwUEfdpBblJK65XRtMqtTO1KwkNNcF5ULWqv0=;
        b=UZr+uxSUntQeNPbeNZbmzl34Y+FnDg4DPXipdcXF4PcD90hfjjNzJ/6V7Vp9cYGipY
         2W0ei1M6WvTloAQtU9yu8SZ69B7fxrjAw3+xeVYxd5sd0LRQu+gYfHBB58DcU9o+wgFU
         vev+QO7dYDXu6xG3q+ZuzcUx77CEPFtWX61CPzfGsF5TUa9W3dm2pH+Qy24MDzeeD9S5
         ov/lWxDZPFVczrJ/JclgpmAzY1RDeu666qgYyOH8Fvk7D0t9PkSEab5u8/5vw5fsFCPR
         M+u49hPUaLofqYGBUgOdRrllA7qwcvw/xWiMN93jUJW0lguhrwdE29GxezX14R1YrAbW
         m9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685601356; x=1688193356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2GsxwgwUEfdpBblJK65XRtMqtTO1KwkNNcF5ULWqv0=;
        b=gMDJ/zOX/yyaC2QyL/y1onWDj3f1C1wFECO03HCMk407iz02SSzIQN4XgyoC+vvhPc
         YIujzJ1oiNqS1VLl0M+gjvCnJGw3nhbfcioITja11kPPNtoc2blsMNgsSAvV+N3aKK+P
         abWbe//G2i4I/pprX49MmNYBHZPnP7DORgSb3NvSVDrN/qsLU/Oa7Gw6McOzwcZYrsM2
         ZXXY2YB9ZKk0AOjIBe2WS24RqobFTxtwJ/OfzBccM/RLEVmOpRGv6oGKjxw+m7XzaRml
         DHuZ/I183sybPwn5EQmclC6tR5Ln1Wa0lPipeGY7CxCmSrlYOd5thEDEDbLIGP8vCRUm
         susg==
X-Gm-Message-State: AC+VfDzXqAJ4zMwie//apQdI2al0QoiGnLXw7ReoWt+taMjLkHwCtAgz
        mIhQYA6fmcqUGD4LNCqhzEJkxQ==
X-Google-Smtp-Source: ACHHUZ7IDWn4Cvtit1m6gAQx0PvKlwHOXdroztxTwv74kJze1S5PM7Odo3XGRTfbsZYT1Pctrk6OIw==
X-Received: by 2002:a05:6a00:1f96:b0:64d:2a87:2596 with SMTP id bg22-20020a056a001f9600b0064d2a872596mr720870pfb.10.1685601356269;
        Wed, 31 May 2023 23:35:56 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id x25-20020a62fb19000000b0062e0c39977csm4302233pfm.139.2023.05.31.23.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 23:35:56 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     rppt@kernel.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/2] mm/mm_init.c: do not calculate memmap and reserved pages for empty zone
Date:   Thu,  1 Jun 2023 06:35:36 +0000
Message-Id: <20230601063536.26882-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For empty zone, it's unnecessary to account for pages used by memmap.
Also, the pages reserved in dma zone can be ignored.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/mm_init.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 232efac9a929..b82718d596c3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1543,6 +1543,13 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		size = zone->spanned_pages;
 		freesize = zone->present_pages;
 
+		if (!size) {
+			nr_kernel_pages += 0;
+			nr_all_pages += 0;
+			zone_init_internals(zone, j, nid, 0);
+			continue;
+		}
+
 		/*
 		 * Adjust freesize so that it accounts for how much memory
 		 * is used by this zone for memmap. This affects the watermark
@@ -1579,10 +1586,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		 * And all highmem pages will be managed by the buddy system.
 		 */
 		zone_init_internals(zone, j, nid, freesize);
-
-		if (!size)
-			continue;
-
 		setup_usemap(zone);
 		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
 	}
-- 
2.25.1

