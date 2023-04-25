Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EDC6EE0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjDYLGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjDYLF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:05:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10EB558F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso7413575b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682420728; x=1685012728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adf/xVVZ+zD1y6dwSMZy7eTiJ3ZJr+5S82v3Bo6axPQ=;
        b=Qg/Eb8jh+M7A1BjNkJA0ETdhpSJNmHPQqY7kHY12vMVLnl1kdHdvkXB4if/LEJNcQ5
         /1LNuehfPKitPB3/5yv9OLAuhw799I6ciManueoWOAOynBw1CWPSJwwq7GxIxWdDsCzN
         naRUqvc2fV0nM8rhoZ1l1nNrYS66KlT/jRC4W1CsIMeKe0PoIvySiXB8XjS+DHlft/NM
         fZHyu90UDLxs+cplyvIGFAikzgye2S15dQ1zbi/9kb+dH6OV4iV+CspPnU1KIUXqBT7J
         qA2QnXHcRQ4FVt6MfpPeeOr+TBMq90cvSRy6vcvX4sHyef0DMH8MM3BjdFREbtnczCbm
         zWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420728; x=1685012728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adf/xVVZ+zD1y6dwSMZy7eTiJ3ZJr+5S82v3Bo6axPQ=;
        b=XatKBQa+VQCbnJ+5B1G6RiHmTaPKv4Wn35eV/XswKo7m2GNxovGk1V5F8AwyNNLYbK
         FQSv0+0ehjB0LcMVvpmJVnToHlT5nrWUz21QHkWVY3cTShkhcyVDvi4fTI+1kXRD63Tk
         iR6cGU6ihW8GZB4Dumm4+l/gMxY92miyKA400vSmwOofLNZE0VSqmF0wxk86B4rYc4ug
         pNOpziRn2XZ3bc68hJE1i0L9ZaVh8kF+kl8rhX02T1dKkTBjXYhh8Ix02tZ0WVOlkIqG
         uDyJmh7w3pc2A8HGEyVdkPaq+NbAMHfWfS7c/yp/xSUO+0cPeIP66ByOZDq2lY1LpCfR
         l98A==
X-Gm-Message-State: AAQBX9fh0W2CQpgmU7qoCvDA/LbasetkQrGzhQoxHa5l4ckDkLAqnB+3
        N550hoD3NBrc3r+B8uirbeqTjxFpWULzylzHfB8=
X-Google-Smtp-Source: AKy350bOoFyRIN0M8N28n3KXREP3tLoV3nfJ0YqTMfCWgc6sCikZeNaFUfG2ms1pU+I3yUk9dO7Khw==
X-Received: by 2002:a05:6a00:1516:b0:640:dbe5:e2ee with SMTP id q22-20020a056a00151600b00640dbe5e2eemr7068367pfu.10.1682420728409;
        Tue, 25 Apr 2023 04:05:28 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm4422169pfk.79.2023.04.25.04.05.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 04:05:28 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 1/9] maple_tree: Fix allocation when min is equal to max in mas_empty_area/_area_rev()
Date:   Tue, 25 Apr 2023 19:05:03 +0800
Message-Id: <20230425110511.11680-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
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

Make the allocation valid when min is equal to max in mas_empty_area()
and mas_empty_area_rev(). As Liam R. Howlett said, VMA doesn't make this
allocation, so now this bug won't trigger.

Also add some checks for invalid parameters.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 110a36479dced..72099b4b32169 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5289,7 +5289,10 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	unsigned long *pivots;
 	enum maple_type mt;
 
-	if (min >= max)
+	if (unlikely(min > max))
+		return -EINVAL;
+
+	if (unlikely(size == 0) || unlikely(max - min < size - 1))
 		return -EINVAL;
 
 	if (mas_is_start(mas))
@@ -5344,7 +5347,10 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 {
 	struct maple_enode *last = mas->node;
 
-	if (min >= max)
+	if (unlikely(min > max))
+		return -EINVAL;
+
+	if (unlikely(size == 0) || unlikely(max - min < size - 1))
 		return -EINVAL;
 
 	if (mas_is_start(mas)) {
@@ -5380,7 +5386,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 		return -EBUSY;
 
 	/* Trim the upper limit to the max. */
-	if (max <= mas->last)
+	if (max < mas->last)
 		mas->last = max;
 
 	mas->index = mas->last - size + 1;
-- 
2.20.1

