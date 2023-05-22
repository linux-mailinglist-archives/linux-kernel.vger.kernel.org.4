Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93370BBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjEVLYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjEVLY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:24:27 -0400
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E161F1FDC
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:21:12 -0700 (PDT)
Received: by mail-il1-x149.google.com with SMTP id e9e14a558f8ab-3381796d685so93611615ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684754472; x=1687346472;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tjbotIl6dteDpFw7M2HIwfdcqW8YhSXjziuk6U7H4Oo=;
        b=chESpP8RhTjBYYVdguowYuRgIznzG4M2UF9I7tFZtlG8zb2E0krTaM/+YPGrU8lWr7
         l/ys2WLnJQP7hnutQyiv7RNRbbcPcCKWKSYiG5hc0J0QT7WfehDUyCSIFZbvY6XzplnK
         kxMCdv2IBYm4MP4HlRbMs9m1RwRcMyy2i5IrR8FpwbTiEGvFv5gb7Jr4uzHdURDpMXPq
         lPDRcdGUF3kRVoBf/nZGEJdAB+wBQltqNBDiTKDRwz1tJqIrABPqDnDY4h9pUGo4VXHw
         ZqM5JpkVP0R1tDNbnzeIIV3YCvOaNhpBgQTK6mvck7LioQUhlY6FyFvE5tc/7k6XnuKM
         JDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684754472; x=1687346472;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjbotIl6dteDpFw7M2HIwfdcqW8YhSXjziuk6U7H4Oo=;
        b=Q9e12nwxrXzRHs9ZGXzI7VTZdl+P3R8vpEcymuEy4tJ1U9NHfRq3DYR0lRxAbRN4dy
         E7KHB0rsUDNJm3H+/RhexDE22uThfBr2Y3ACrbxtb0EVDw79wlvCOpoH+nKBM47JqBPR
         6VE9gec2zwQ5Vnd5zuSZVbshWAtO5Vc40HIEWDXsraagi6cpg56ECvV9P1tXlhvAjIw5
         pYpXqL4NjHdGW7Q9X3YqmFRnKjpSKsolHRYgoQlJrJgP0GgdzIMa0yxjSXNIKH9WLO5O
         B6u7xYBBU03wn3cfGpoWZJZjSG6FryQppTWVHdwWmSQySZWVH1WtqWzTJh4SHjVR45B/
         LbpQ==
X-Gm-Message-State: AC+VfDzWeUX1ZUyD1V1mwxJuwGeTTNHC6EKuFKenpOzyVecAuWjBnBf2
        v7dlvHGVwFgetEybNYc+5JI77/8lIF1oNA==
X-Google-Smtp-Source: ACHHUZ7UWSQwQGsHd72I/yejf19ofrwyt2xX81bG/zc8LpBQfPH0BVPAIm5/Niti+tcKANdc8o7V/lNN1cV5bA==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a92:cb44:0:b0:335:479a:8eaa with SMTP id
 f4-20020a92cb44000000b00335479a8eaamr6111039ilq.6.1684754471949; Mon, 22 May
 2023 04:21:11 -0700 (PDT)
Date:   Mon, 22 May 2023 11:20:55 +0000
Mime-Version: 1.0
Message-ID: <20230522112058.2965866-1-talumbau@google.com>
Subject: [PATCH mm-unstable 1/4] mm: multi-gen LRU: use macro for bitmap
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DECLARE_BITMAP macro when possible.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4637f6462e9c..cf18873a36b9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4144,7 +4144,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 	unsigned long next;
 	unsigned long addr;
 	struct vm_area_struct *vma;
-	unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)];
+	DECLARE_BITMAP(bitmap, MIN_LRU_BATCH);
 	unsigned long first = -1;
 	struct lru_gen_mm_walk *walk = args->private;
 
-- 
2.40.1.698.g37aff9b760-goog

