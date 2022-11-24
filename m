Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF09C6372F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKXHjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKXHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:39:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4A8F3D5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:39:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so912297pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UA260AehhLAfEdYE8BrfOKBXPadjTQ0oWHspkp4L4Pc=;
        b=THuBqC89Jfusdgra3SZeu6/RBNnEtIs/tTKvTH8yxdB18c9vUDS+zRq6xrOyWqh4hS
         xGE4Z1fM91uGAk3sufgV/Q9eUlIm8FIfA/Rflnldf2N4xF23JrUfcoVEMeGS/8kY+d5O
         lrJCf3pvvFPqEiz2WWTCZu1wS1IeVOgasgx0LGdw5+osuoqdusRDC566uvIu16h+VEZp
         649/HfnJLyJkpFKwysz9c7sBh94ZMe7XSvN25TVrYTrSTDmKQHbYkDOCJ6IGvOMIH2SS
         ZauloVy1YaoQIMYT4GklJ+lb4Vp3I/92qvaHBLiX1hDKpQ35LxBFe92kuYTdNhWknTzI
         /iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UA260AehhLAfEdYE8BrfOKBXPadjTQ0oWHspkp4L4Pc=;
        b=sC4xzL0iRw8rx2UrjXgc2kf6q8gZ6R5swFuLkACK4CHFJh8AdVDuiZTgELGgTa/xI8
         Lfz3Xw8GMxmDgT6/8NJyaYBxpF2cfvh6AayZ4MHBxFU2ji0mh8LoHLLx7NKdl5OU5mFa
         e8KeQP/lSQDO3LTdMx6BxJY4p+2rDRFA3yQlkBrCczfFlGTYca8n8F0B91yf6NAXJ/my
         +krVHyTjfeGuMCbiTBZiWJtKbemA0SJ+Yl4VMp0aMB3G5o4qEU4qVzM2su0Qqgk7VIZV
         7U0dRHd0K/NVpFn8xvb4L1KbmEJ7GvRkPXvVWHTpuXVKBSKIL+9i1Ntx6dkCY6gCWPCA
         46zw==
X-Gm-Message-State: ANoB5pm+18UV7cCd76CbrWS40epH46p/vMfBIcT1/h41/HPdboH1udb8
        rAQbMmOmesI+zTMcxqOMzDlm1A==
X-Google-Smtp-Source: AA0mqf6LieQTxv4TzvKYyWHggvMNThPG0+krCHoy6rIfYkaS2QNm19YP/LmtqfBerLYrAL7swFXDfQ==
X-Received: by 2002:a17:90a:db52:b0:212:d2c2:8e1a with SMTP id u18-20020a17090adb5200b00212d2c28e1amr40767868pjx.54.1669275558683;
        Wed, 23 Nov 2022 23:39:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b0018862b7f8besm503510plx.160.2022.11.23.23.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 23:39:18 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     dan.j.williams@intel.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH linux-next] mm: memremap: delete static key devmap_managed_key
Date:   Thu, 24 Nov 2022 15:39:09 +0800
Message-Id: <20221124073909.15489-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static key devmap_managed_key has no users since we
deleted put_devmap_managed_page_refs(). So delete it too.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memremap.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 0d714adadbfb..67749f74be4e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -38,30 +38,6 @@ unsigned long memremap_compat_align(void)
 EXPORT_SYMBOL_GPL(memremap_compat_align);
 #endif
 
-#ifdef CONFIG_FS_DAX
-DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
-EXPORT_SYMBOL(devmap_managed_key);
-
-static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
-{
-	if (pgmap->type == MEMORY_DEVICE_FS_DAX)
-		static_branch_dec(&devmap_managed_key);
-}
-
-static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
-{
-	if (pgmap->type == MEMORY_DEVICE_FS_DAX)
-		static_branch_inc(&devmap_managed_key);
-}
-#else
-static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
-{
-}
-static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
-{
-}
-#endif /* CONFIG_FS_DAX */
-
 static void pgmap_array_delete(struct range *range)
 {
 	xa_store_range(&pgmap_array, PHYS_PFN(range->start), PHYS_PFN(range->end),
@@ -133,7 +109,6 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 	percpu_ref_exit(&pgmap->ref);
 
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
-	devmap_managed_enable_put(pgmap);
 }
 EXPORT_SYMBOL_GPL(memunmap_pages);
 
@@ -333,8 +308,6 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	if (error)
 		return ERR_PTR(error);
 
-	devmap_managed_enable_get(pgmap);
-
 	/*
 	 * Clear the pgmap nr_range as it will be incremented for each
 	 * successfully processed range. This communicates how many
-- 
2.20.1

