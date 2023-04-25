Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0AF6EE0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjDYLFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYLFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:05:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4E05FDD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso4532384b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682420732; x=1685012732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3gtz2twduYMn314aWKPdPXlwzAEr/ThikDxq/EAqMc=;
        b=QmK+bpu3OrfPdSwq5btASAzKm3wgRczj/+suiuqNcMy2NwVbP4ROvdfevWx4rQNazE
         z51Uz+aGBN2J44RqQUvlScXgks+MkypgIVZPjhcPt8g1vNU6HSKACdUnLJH86h3Trf5x
         29A4FD1yH8yNeYxbdMGM1UejkWDX+SNrdDJtE8vfWm8swblZ77+lqF7zKpuickVwqdC4
         oAnQBvIRl6pV+0feNB+9re2SLlggZIRIT1Z67T0xC9ipIzv87BVHDvgkdSQ1gdFZnefA
         DXoZ2TKFJCZFzR8vjJJb5NhBPKZIus1BetzLfmTTHhYzAZW9qSZtdi+W+BOt1gqG8q5m
         iEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420732; x=1685012732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3gtz2twduYMn314aWKPdPXlwzAEr/ThikDxq/EAqMc=;
        b=V/0cHUk/NP1HzrTZzlK4rLuKt+/ddwWS3W+/A6HwDSbtzycw0rqZMc/yqydoZwTBnO
         IVbAkk2MaYTwK68PPrg8EljtZYGIAtJKCir5zJTkKcRNcIhxLB38bWAQ/7cOQLORyIeV
         56oV8Gsh9DpZgLcw29snB4ulS7GJfIcBPH4sCexM/iVMf5KB0qoNyo6JymSQP4pDeV3z
         P7KuriAGRE9XnApXAcRtX4yyJJmMsNQHm98LcoTQluuvCiXnJ2eEq3DuNxbsp5euIcsB
         eviLVMTCsx2uXH1oM4tYLFiIVfqU/YQAVPamwJ5mtXO1tN591aVmRpSWruqRMdhx4E3K
         afPA==
X-Gm-Message-State: AAQBX9fJ9EfzbdC2Fw/tc31QX6+NkaIFHzRrHwLkUzSHGlmDQQ/TpWn5
        oMVzefIEn9S94TjvoZqebwuykw==
X-Google-Smtp-Source: AKy350a6riQre9kg4t0NqG+0JOJCUjRgULCxd3ko2U+yTXTnw2AYPmRvhUw2mqlYxBxuXlVpDaZ1AQ==
X-Received: by 2002:aa7:8884:0:b0:63d:2c2f:e3a2 with SMTP id z4-20020aa78884000000b0063d2c2fe3a2mr23868065pfe.18.1682420731840;
        Tue, 25 Apr 2023 04:05:31 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm4422169pfk.79.2023.04.25.04.05.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 04:05:31 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 2/9] maple_tree: Make maple state reusable after mas_empty_area()
Date:   Tue, 25 Apr 2023 19:05:04 +0800
Message-Id: <20230425110511.11680-3-zhangpeng.00@bytedance.com>
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

Make mas->min and mas->max point to a node range instead of a leaf entry
range. This allows mas to still be usable after mas_empty_area() returns.
This currently has no user impact because no one use mas after
mas_empty_area() now.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 72099b4b32169..aa55c914818a0 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5320,14 +5320,7 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 
 	mt = mte_node_type(mas->node);
 	pivots = ma_pivots(mas_mn(mas), mt);
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
-
-	if (offset < mt_pivots[mt])
-		mas->max = pivots[offset];
-
-	if (mas->index < mas->min)
-		mas->index = mas->min;
+	mas->index = max(mas->index, mas_safe_min(mas, pivots, offset));
 
 	mas->last = mas->index + size - 1;
 	return 0;
-- 
2.20.1

