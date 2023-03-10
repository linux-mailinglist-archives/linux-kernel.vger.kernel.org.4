Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7076B432B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjCJOLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjCJOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:10:30 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE581AB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:09:37 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id a2so5664614plm.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678457376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjLkk2c7qkyw5y4hjkb7TF+50UyVGFsleuClk20l+mY=;
        b=WphEF2oxgLVej3eE274fGsflhyHMgJ2dTa8s8OAIbv9LOvuOXfdF5Wd1/NaUe575sO
         jjgnHjjrsT0jG6nkB6+v3mF6Cr3KhiaHv6c32jK1u5+vbv0c5CRt2ZF0+PVT6Cbh4HTH
         MbTFqJrcrn9Gkh6LznsP0LnemRqAd0jDgk17BUrm8jORI2Z6HACdab9cSSXcHLhfmvI1
         xh1BNcKau3ckNIcS2HIQZc9DrtBF1jIOIXioVCYTSReGIrRus1A7fySebJgKB4nf68ku
         I+9kznE7YYXqfpkGLKgIi/gzoqg00fpJ4qB1FyA7HcnqhHZOJqUFQ8om/zSdXIm75gBT
         DotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678457376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjLkk2c7qkyw5y4hjkb7TF+50UyVGFsleuClk20l+mY=;
        b=nSr0OCIP9Hyu+VIBPdPI+mEEYbd21oIcvQPmuyyBFVitz1hV9GdvS+RppG4S+UJs4P
         fRcDskc+TI8T62XYmjkS4CfnZnBowSYgiq62X2cstLmrIxZuaVEi6WEChTO+c1YkUe+H
         UhZ8rl7HPrLrEI31au5tuuwvRNnms6LM58YyyOqkqKK5LZAIBh3pX2dytNNHH8JnGkHS
         Ud5HCJcA/7PV7Tebm4V9eQ5A3ObxwEy376jNRdLB7aRCk7NqfCwV2wLY9gIz8Fa7EQhT
         yKN7096kJDscrs7OSaS/4gV1Iu9coprrrLLckWpewytKK6MvL7FidQP67Ja5lsxhBbDx
         awmw==
X-Gm-Message-State: AO0yUKWQPwylwrb73PvhZIandh6GBfI5EHuU6Akn04pmSFHm6s4luJ2W
        Puygk7lE7PbDqZNwjK4VJm3ahQ==
X-Google-Smtp-Source: AK7set+QrOEa9fTlDbVV5pXLDfDbkYu/K29dJO9b63aMffjgrG9OR8N6Nz38PCDjMG+CznXz5kGPHw==
X-Received: by 2002:a17:90b:4a4c:b0:237:9cc7:28a4 with SMTP id lb12-20020a17090b4a4c00b002379cc728a4mr27301326pjb.14.1678457376680;
        Fri, 10 Mar 2023 06:09:36 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id fu11-20020a17090ad18b00b002375c356b0csm6753pjb.19.2023.03.10.06.09.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Mar 2023 06:09:36 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 1/4] maple_tree: Fix get wrong data_end in mtree_lookup_walk()
Date:   Fri, 10 Mar 2023 22:08:44 +0800
Message-Id: <20230310140848.94485-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if (likely(offset > end))
	max = pivots[offset];

The above code should be changed to if (likely(offset < end)), which is
correct. This affects the correctness of ma_data_end(). Now it seems
that the final result will not be wrong, but it is best to change it.
This patch does not change the code as above, because it simplifies the
code by the way.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 646297cae5d1..b3164266cfde 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3875,18 +3875,13 @@ static inline void *mtree_lookup_walk(struct ma_state *mas)
 		end = ma_data_end(node, type, pivots, max);
 		if (unlikely(ma_dead_node(node)))
 			goto dead_node;
-
-		if (pivots[offset] >= mas->index)
-			goto next;
-
 		do {
-			offset++;
-		} while ((offset < end) && (pivots[offset] < mas->index));
-
-		if (likely(offset > end))
-			max = pivots[offset];
+			if (pivots[offset] >= mas->index) {
+				max = pivots[offset];
+				break;
+			}
+		} while (++offset < end);
 
-next:
 		slots = ma_slots(node, type);
 		next = mt_slot(mas->tree, slots, offset);
 		if (unlikely(ma_dead_node(node)))
-- 
2.20.1

