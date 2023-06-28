Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4C740AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjF1ISY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjF1INo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:13:44 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3490F4239
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:09:38 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a36803f667so126541b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687939777; x=1690531777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE5S+xEF8iVKqL+efUmsUqFQSIecG35V/4BhhPZycNg=;
        b=AilhbHK0aM+A5BB8Z1rmPO4N+MsUR/2+LQgiCZJWFN2R11wFXOUolRw8hL8L8T4mof
         y5mtG8fPoQ/kIFKblMt5ceUIVNhur2Qn+h/0TBSRxWK5PIcMoDxtA/7e9HFQF8tA/TLP
         PoELeW1aYNmSReh/flMgBDZsXlw7UF79s0r+tfstLyIVfOMsrYZlkU/8ffNjc3MKkCPY
         x6A4cQN7bNxLQfVluDsG+qqxCWwJfiGmSpJF22bhYclYAJfE57DK3Kj4nFy6DwtKa0d5
         1S00BaWFyUECXKoYNsz46o2qtcBolWgd7GAVfl9Pi5CnmqWO25huNDpK8CqmbKaZqya7
         0BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939777; x=1690531777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE5S+xEF8iVKqL+efUmsUqFQSIecG35V/4BhhPZycNg=;
        b=CiOzveHJ3KhZQ9SM/PKs2CUZlLc2EKLiFz9Z+R27Yuyp3RNATTBR6AnKsaYNcQP4hM
         BpP/c9a24TlZg7LALX53f6zt0JRSCJbYBwtxAlP7VHfOsG6oDslIlB4k/CyEk/Br1iUR
         BofecG64oh535rrTFtd+hBwqN3wx5CDBfyZuvlA3dHfzEk45CUXjPrU2G7z84C7t/F5c
         btwN3vmN+3O9AdV0u8hJcNRYxyhkOs80OJUbXwqJnjolrDxTJ2tbr09OUo1/LF9WO2v4
         x4JrMtCIoKilH8I+zFH4/riFq7bnRdPUJ2i2rqJ75clNotqNkgql+74W3DuvV4lEA+H/
         +h3g==
X-Gm-Message-State: AC+VfDzeP38btlKaKCyrX8h3ewXmMMJlJEVLQuTAdZ/nQxmlzj6u8650
        6HEgloAm28se4SCa10ePOaSbqQeBXI2wGjs7uCQmaw==
X-Google-Smtp-Source: ACHHUZ7wsIFlFgorUeOyA8dts5//X0YcNBChMuP62NzBrpOOf8zMBBIOHsejV1gjrmGlqvrF9RiRhQ==
X-Received: by 2002:a17:902:ecc3:b0:1b3:c62d:71b7 with SMTP id a3-20020a170902ecc300b001b3c62d71b7mr992905plh.18.1687937837922;
        Wed, 28 Jun 2023 00:37:17 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001b8021fbcd2sm4836988plb.280.2023.06.28.00.37.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Jun 2023 00:37:17 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 3/4] maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
Date:   Wed, 28 Jun 2023 15:36:56 +0800
Message-Id: <20230628073657.75314-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230628073657.75314-1-zhangpeng.00@bytedance.com>
References: <20230628073657.75314-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index bfffbb7cab26..56b9b5be28c8 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4266,10 +4266,10 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
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
 
@@ -4281,16 +4281,27 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
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
@@ -4337,7 +4348,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 		goto slow_path;
 
 	/* Attempt to append */
-	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
+	if (mas_wr_append(wr_mas, new_end))
 		return;
 
 	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
-- 
2.20.1

