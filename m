Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F4A731287
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbjFOIoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244696AbjFOInj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:43:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEFF297B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666aa1b79a3so80635b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686818598; x=1689410598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtXCNMCToSbvY4lMnhwDqjdw8KEp/J31bkp75I6UIro=;
        b=l3TDRxu1IZeyZNvWGdJOFqtHd+LYhlWJeVIRmuLAkF0iPL/Q4KJgpGWeh7yt2KT390
         KzCL+z04k59mTjKNc1qkFngmiEIN7AEVfPul0AZh9evDVDjlwvB62qsNc0qk1cODg5op
         c5ZcfjgPq4iTWVmfJGSM2rtBKFqryJoMm4+M8PPPckeA9qg2gVriJbfcAwUAQBPIeVXu
         YMm0+kwc4VoVWFYaesVj4e8F5hPwX8K5ZwSWddqC5b8kzgp76myGhJZxg9jm+Ptz3mtX
         cai+VRJ32w9/dUu3CoeZE60WbitOBrdrPjWnPzWbuqC7KE5tPbmfNbKrOtB+3Y5qgmcQ
         QROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818598; x=1689410598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtXCNMCToSbvY4lMnhwDqjdw8KEp/J31bkp75I6UIro=;
        b=fjidC0WvjVjlwAJUzUig0kyFOPEz2pucLtGXW0uQoBs9OqZd4Js+1ksMMo+TRAZqAE
         NU3VLpZ/931V0eOpQSAzimHr6eJX+I2aicsD9MTEFCBBt+24wD2jq6RrLfsXK0gjtgxX
         AGvZIHeJQBs3sA+GJdWbid0/CPDYSnHM9gwfipMUWQKlgZthNaEyw5z2eg4n6VGOAgtJ
         n9IDZjR8yWJjnO/pKjySyOysnOXqzS1TwKf5PTBygcanYBbn4E1jfmhHE+sxPCJ+A+M2
         iUzZ3fBSXGIqSNU5lJ6evQbTmgaG+1A1Zgej6tCU/1PLg12hqh4Q2J4gE0ldxXd2KaHd
         6ymA==
X-Gm-Message-State: AC+VfDyKE0QvaHTisEraSex+sKO60Kw+1HRr8fWITbzmBiHpBtwUDwvA
        BMtPCvtc4lPWn5EipVOy6pn9EA==
X-Google-Smtp-Source: ACHHUZ5q9AP+JpvTGeNeOKfaSVbGfzkXtHUw8eqE+etHTDoY4NTa38tMPtfWroY21eD2WL8zxFFROQ==
X-Received: by 2002:a05:6a00:391e:b0:643:aa8d:8cd7 with SMTP id fh30-20020a056a00391e00b00643aa8d8cd7mr4292787pfb.32.1686818598107;
        Thu, 15 Jun 2023 01:43:18 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i21-20020aa78b55000000b0064fe06fe712sm11139783pfd.129.2023.06.15.01.43.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 01:43:17 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 3/4] maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
Date:   Thu, 15 Jun 2023 16:43:00 +0800
Message-Id: <20230615084301.97701-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
References: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the new range can be completely covered by the original last range
without touching the boundaries on both sides, two new entries can be
appended to the end as a fast path. We update the original last pivot at
the end, and the newly appended two entries will not be accessed before
this, so it is also safe in RCU mode.

This is useful for sequential insertion, which is what we do in
dup_mmap(). Enabling BENCH_FORK in test_maple_tree and just running
bench_forking() gives the following time-consuming numbers:

before:               after:
17,874.83 msec        15,738.38 msec

It shows about a 12% performance improvement for duplicating VMAs.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d2799c69a669..da4af6743b30 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4202,10 +4202,10 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
  *
  * Return: True if appended, false otherwise
  */
-static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
+static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
+				 unsigned char new_end)
 {
 	unsigned char end = wr_mas->node_end;
-	unsigned char new_end = end + 1;
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char node_pivots = mt_pivots[wr_mas->type];
 
@@ -4217,16 +4217,27 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 		ma_set_meta(wr_mas->node, maple_leaf_64, 0, new_end);
 	}
 
-	if (mas->last == wr_mas->r_max) {
-		/* Append to end of range */
-		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->entry);
-		wr_mas->pivots[end] = mas->index - 1;
-		mas->offset = new_end;
+	if (new_end == wr_mas->node_end + 1) {
+		if (mas->last == wr_mas->r_max) {
+			/* Append to end of range */
+			rcu_assign_pointer(wr_mas->slots[new_end],
+					   wr_mas->entry);
+			wr_mas->pivots[end] = mas->index - 1;
+			mas->offset = new_end;
+		} else {
+			/* Append to start of range */
+			rcu_assign_pointer(wr_mas->slots[new_end],
+					   wr_mas->content);
+			wr_mas->pivots[end] = mas->last;
+			rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
+		}
 	} else {
-		/* Append to start of range */
+		/* Append to the range without touching any boundaries. */
 		rcu_assign_pointer(wr_mas->slots[new_end], wr_mas->content);
-		wr_mas->pivots[end] = mas->last;
-		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
+		wr_mas->pivots[end + 1] = mas->last;
+		rcu_assign_pointer(wr_mas->slots[end + 1], wr_mas->entry);
+		wr_mas->pivots[end] = mas->index - 1;
+		mas->offset = end + 1;
 	}
 
 	if (!wr_mas->content || !wr_mas->entry)
@@ -4273,7 +4284,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 		goto slow_path;
 
 	/* Attempt to append */
-	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
+	if (mas_wr_append(wr_mas, new_end))
 		return;
 
 	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
-- 
2.20.1

