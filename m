Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F3470636E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjEQI73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjEQI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:59:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880F3588
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6436e075166so357214b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313929; x=1686905929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHQ/4wRfx8YGBT0TyL6p3b/Q07WGij+qVhIqIOji5co=;
        b=QkYpZT6JTZgFCW8g+gHwlD3usHqZW7OZl7/3oBK6EGsOSrFnjcS/IsoCdmA13UbZeg
         EODYTAlK0P20L372ioqTr4+YuTOAr7N9aj7tscBr5rWLf0oHxfBOH7sqej8hccrOpEaq
         GzVu2hXKgmar5SOACGxyML1twxQVjxzY9EV/y9pT+8ToUqs7vIzbk7yu9KRqwACOMP92
         U6P8OWr4V6wAeSEzkzL1zMhergOyQFTCkUCmJaedD2y5sfSLKFOPC4qm317hWlCuNQAy
         cXRnFGH7Mk0l/7roCte8CKvnYjrTWFs1OgO1YEP9J9n9Iz2LcGFgqRtukM2Rg3YWhnqz
         qTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313929; x=1686905929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHQ/4wRfx8YGBT0TyL6p3b/Q07WGij+qVhIqIOji5co=;
        b=a7edJyos/y88ljiU0zWehXeBvxF2IeW4b6oikfHV/Tn8dQYC19IGVvfv0fPFTlDP7K
         BXlRfeDRUuiHzCYpO41gKggGSz0fGrRxOuQHLC1f4O7AnjKSb4xstvU4bJUnJSSB6R0V
         ooHDr6Q1/5Cul0vvtFmfmMFjfeOgpiqWq+fpetTNkSrGKTufRjx2mvpdwrQCHsPKY6TA
         FRx2zkDpSzvgCa0NMqygmBxYGo7nbgYbCD7feNT3ETXBuBL3jfpwYEU+0YKGqgxC8Vok
         4X+Wp4hp4Faa7NPdRRxxyRI13xh3TScO4tx5/W85XXmpleD3VmvFusTctYBvHB09vsBd
         0ZCA==
X-Gm-Message-State: AC+VfDyBgdceZvK8/DL08qA8yAG2xsjHoT14rdgTMWH2UVQO2GEIJVtG
        FhHStdO30tlWtRYhfqVv87yF6w==
X-Google-Smtp-Source: ACHHUZ4MiIkSySgrbyPd4kQP2+fHUmdRgaMwGI51gtxUWgKJCZMlbz0NTwGpf9b8KfQuim4wUi1hug==
X-Received: by 2002:a05:6a20:1587:b0:101:5171:c880 with SMTP id h7-20020a056a20158700b001015171c880mr35122952pzj.62.1684313929300;
        Wed, 17 May 2023 01:58:49 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.58.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:58:49 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 01/10] maple_tree: Rework mtree_alloc_{range,rrange}()
Date:   Wed, 17 May 2023 16:58:00 +0800
Message-Id: <20230517085809.86522-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mas_empty_area{_rev}() to refactor mtree_alloc_{range,rrange}()

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 63 ++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4eb220008f72..e1820e90f167 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6493,32 +6493,31 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, min);
+	MA_STATE(mas, mt, 0, 0);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mt_is_reserved(entry)))
 		return -EINVAL;
 
-	if (min > max)
-		return -EINVAL;
-
-	if (max < size)
-		return -EINVAL;
-
-	if (!size)
-		return -EINVAL;
-
 	mtree_lock(mt);
 retry:
-	mas.offset = 0;
-	mas.index = min;
-	mas.last = max - size + 1;
-	ret = mas_alloc(&mas, entry, size, startp);
-	if (mas_nomem(&mas, gfp))
-		goto retry;
-
+	ret = mas_empty_area(&mas, min, max, size);
+	if (!ret) {
+		mas_insert(&mas, entry);
+		/*
+		 * mas_nomem() may release the lock, causing the allocated area
+		 * to be unavailable, so try to allocate a free area again.
+		 */
+		if (mas_nomem(&mas, gfp))
+			goto retry;
+	}
 	mtree_unlock(mt);
+	if (!ret) {
+		if (mas_is_err(&mas))
+			return xa_err(mas.node);
+		*startp = mas.index;
+	}
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_range);
@@ -6529,29 +6528,31 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size + 1);
+	MA_STATE(mas, mt, 0, 0);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mt_is_reserved(entry)))
 		return -EINVAL;
 
-	if (min > max)
-		return -EINVAL;
-
-	if (max < size - 1)
-		return -EINVAL;
-
-	if (!size)
-		return -EINVAL;
-
 	mtree_lock(mt);
 retry:
-	ret = mas_rev_alloc(&mas, min, max, entry, size, startp);
-	if (mas_nomem(&mas, gfp))
-		goto retry;
-
+	ret = mas_empty_area_rev(&mas, min, max, size);
+	if (!ret) {
+		mas_insert(&mas, entry);
+		/*
+		 * mas_nomem() may release the lock, causing the allocated area
+		 * to be unavailable, so try to allocate a free area again.
+		 */
+		if (mas_nomem(&mas, gfp))
+			goto retry;
+	}
 	mtree_unlock(mt);
+	if (!ret) {
+		if (mas_is_err(&mas))
+			return xa_err(mas.node);
+		*startp = mas.index;
+	}
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_rrange);
-- 
2.20.1

