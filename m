Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998170BB54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjEVLOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjEVLN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:13:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FA19BF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96fffe11714so96048966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753733; x=1687345733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3POfPMkD0T4i+gkKz2qkPU4t7/WZTiyT2qCdNLU280=;
        b=VBUTLfKbApHu6QZhrVrOCB3BjALZb8HbF0H20xKFhc6s2ddiN7suwTGMU0bL+g+sYn
         RmbQ1cww5mUZenVFKfKM0obeU2G6DDRfd8SBMnH9fmFpOyakPo9ae6ksAd2XakoCBv0E
         7Ov6b3cng1MnPemi03HJHLAXu9L7D+fD1mqdF1IW9NYQd6lcGKgDypewZcwaRLFcrhmr
         yjR9yAKjvtwtrmWZi3nCGabZYIW/EQNSzPSvJbp0e3+m5rd5yon1lw8lX3KGm/ik7TPO
         pykNacp5zTZge80vp2rYbryAhbquVFUZS46oKag6NjrQQcMLsIE3M8wIwP5IFy1Gt0Ul
         IcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753733; x=1687345733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3POfPMkD0T4i+gkKz2qkPU4t7/WZTiyT2qCdNLU280=;
        b=DWtQWnPxDRa1HKXMy1KSj82cHj8PG0ivfj7kHpBRqlKmAq1c9cwWNx7JuqjB/uyLhd
         724tTd3H7bcTKZKiaqW/lsoucF1kp4pp6jRKBGJ49vQ9IWvKvThWQRjPtam1hSyMh5VW
         KHYlnSUu5y0BnF2MtjX7LRPnLOfrNayGgIgw3g9pBsBv/2GPt5kpS/6Z6HTxKvzbc+Ll
         kA9gihmshuOG0bMac15MuCSINPSwO0Ulw0XNX0aXjrvgHML0lz3PKclmA/PTkEXX9Hw0
         uRQLvshb0HDNwJWdDjCBESsR6legxTOnMkWOYVRdw+ZimhAqrmBfhf/7i3+5G/ZlrDnK
         28rQ==
X-Gm-Message-State: AC+VfDwcV5lPdrlOBNl+U6j9o7Tbtx+Gp8YlQE3vEnVamPEefOLFT3sL
        AASTmX4gz81/Qzk/w2IkyPE=
X-Google-Smtp-Source: ACHHUZ7sSj0PR0+CyXEW2CQQzfPJq5rycOMctGBSYZ5gIV+Lpig9VckuJmCX23ieD4b+A7HcD+ROww==
X-Received: by 2002:a17:907:1c8b:b0:94e:48ac:9a51 with SMTP id nb11-20020a1709071c8b00b0094e48ac9a51mr11815922ejc.4.1684753732807;
        Mon, 22 May 2023 04:08:52 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2949453ejb.220.2023.05.22.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:08:52 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/9] mm: vmalloc: Add va_alloc() helper
Date:   Mon, 22 May 2023 13:08:41 +0200
Message-Id: <20230522110849.2921-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522110849.2921-1-urezki@gmail.com>
References: <20230522110849.2921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __alloc_vmap_area() function contains an open codded
logic that finds and adjusts a VA based on allocation request.

Introduce a va_alloc() helper that adjusts found VA only. It
will be used later at least in two places.

There is no a functional change as a result of this patch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 31ff782d368b..409285b68a67 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1482,6 +1482,32 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
 	return 0;
 }
 
+static unsigned long
+va_alloc(struct vmap_area *va,
+	struct rb_root *root, struct list_head *head,
+	unsigned long size, unsigned long align,
+	unsigned long vstart, unsigned long vend)
+{
+	unsigned long nva_start_addr;
+	int ret;
+
+	if (va->va_start > vstart)
+		nva_start_addr = ALIGN(va->va_start, align);
+	else
+		nva_start_addr = ALIGN(vstart, align);
+
+	/* Check the "vend" restriction. */
+	if (nva_start_addr + size > vend)
+		return vend;
+
+	/* Update the free vmap_area. */
+	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
+	if (WARN_ON_ONCE(ret))
+		return vend;
+
+	return nva_start_addr;
+}
+
 /*
  * Returns a start address of the newly allocated area, if success.
  * Otherwise a vend is returned that indicates failure.
@@ -1494,7 +1520,6 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
 	bool adjust_search_size = true;
 	unsigned long nva_start_addr;
 	struct vmap_area *va;
-	int ret;
 
 	/*
 	 * Do not adjust when:
@@ -1512,18 +1537,8 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
 	if (unlikely(!va))
 		return vend;
 
-	if (va->va_start > vstart)
-		nva_start_addr = ALIGN(va->va_start, align);
-	else
-		nva_start_addr = ALIGN(vstart, align);
-
-	/* Check the "vend" restriction. */
-	if (nva_start_addr + size > vend)
-		return vend;
-
-	/* Update the free vmap_area. */
-	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
-	if (WARN_ON_ONCE(ret))
+	nva_start_addr = va_alloc(va, root, head, size, align, vstart, vend);
+	if (nva_start_addr == vend)
 		return vend;
 
 #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
-- 
2.30.2

