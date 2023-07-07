Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E348E74AE8D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjGGKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjGGKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:11:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FB5210B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:11:24 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55ae2075990so995637a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688724684; x=1691316684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE13/bSU+7HEsPPuu+3SI81hgRU4W8DBIsnfpeEf3iw=;
        b=QfdtXzibF52G1Tv3CudmdGlATyS59CcgsOu6Yx2koGrpC74+8yd+xWT7sFR6R2XDrO
         gLuqLE0iQGKZdOWHpMCvXK6wF3hpQJ2EHnzTEB5S7e3pI8W8gv7WPZ8DUDfaaqwZCOuH
         F4h98U2DmLpnD0IvL2M9FbjL0G77/y888wjKbLXS79WcMX/Ga6KUkSkLCB+PHy7ZStcX
         bK+SrmMCjPox6KOZsAiGtXVXBFtJq1xqS4MTotYtaou3nIWhmDuwlDa0Aphz8y+ii/Rn
         dJ+t5kSMAr2Ep6yUvfN2iaHaXG3bEUMxRZPcbMo8BDViD3Yv/fGmVaamFhCuCeZcJ1Tm
         CXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724684; x=1691316684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE13/bSU+7HEsPPuu+3SI81hgRU4W8DBIsnfpeEf3iw=;
        b=XrO4HB1p5KMmZO59n+Mu/K4INJ5Z5sxOMoOM60+2uHtveiueI9djFr1Ltyqjf2nooy
         c4a7i0sa24Sc0u76u5+IA70pGB7Dy5c6TJo5joQAOTd1EliVO9qbhhvWE7HfsHNStn2x
         knBN5P9crDNS9Bvh71nhpjcZjqnPs/XjWPIATn4/XHlb95xGueU81kirnYUc5CcY2Xg9
         GUyM3EDpO7p7US37S6VHvhFw1YJolZ3YOsBciG5wDAynaxnFi8Zgx8AvqijfmHfaD2on
         qfg7Kj9Z6R9ZS6ocOz+zujte8cbwQbo0pcEesxV617ydobF/V2gwy/ZYvwF2LjUkvj4z
         XdWw==
X-Gm-Message-State: ABy/qLbUoZNwA07et1DxZhUE2luAKb2P4roy8gMePJTA0Kz330zgwzge
        zfoaWoFvPwiU2nRVoB/wd/FrrQ==
X-Google-Smtp-Source: APBJJlHLtVaSHtwyC+RDJwQld7xxpdLz2jT4V8stnsV2QVLZYFcHbHnSXhSnU0cJ6Mez8qp0sxmKeA==
X-Received: by 2002:a05:6a20:3d8b:b0:12f:952:11fb with SMTP id s11-20020a056a203d8b00b0012f095211fbmr4370514pzi.52.1688724683859;
        Fri, 07 Jul 2023 03:11:23 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b0068288aaf23esm2602549pfv.100.2023.07.07.03.11.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jul 2023 03:11:23 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RESEND PATCH 4/8] maple_tree: fix mas_validate_child_slot() to check last missed slot
Date:   Fri,  7 Jul 2023 18:10:53 +0800
Message-Id: <20230707101057.29326-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
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

Don't break the loop before checking the last slot. Also here check if
non-leaf nodes are missing children.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1fe8b6a787dd..88d6373f37b0 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7111,11 +7111,12 @@ static void mas_validate_child_slot(struct ma_state *mas)
 
 	for (i = 0; i < mt_slots[type]; i++) {
 		child = mas_slot(mas, slots, i);
-		if (!pivots[i] || pivots[i] == mas->max)
-			break;
 
-		if (!child)
-			break;
+		if (!child) {
+			pr_err("Non-leaf node lacks child at %p[%u]\n",
+			       mas_mn(mas), i);
+			MT_BUG_ON(mas->tree, 1);
+		}
 
 		if (mte_parent_slot(child) != i) {
 			pr_err("Slot error at %p[%u]: child %p has pslot %u\n",
@@ -7130,6 +7131,9 @@ static void mas_validate_child_slot(struct ma_state *mas)
 			       mte_to_node(mas->node));
 			MT_BUG_ON(mas->tree, 1);
 		}
+
+		if (i < mt_pivots[type] && pivots[i] == mas->max)
+			break;
 	}
 }
 
-- 
2.20.1

