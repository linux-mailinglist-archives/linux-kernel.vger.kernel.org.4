Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9037E731996
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245438AbjFONKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245732AbjFONKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:10:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E08B270A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b3c578c602so33358115ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686834629; x=1689426629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8uMjI1Tkwt5zl80wRd5zFszf8LWrgvycYShg8nZg9U=;
        b=l1V7kQJL3oyDCiUF/OX7fjrtf7DZRR7RI2GYk9oEhjuwS5LI2YqP0f4o3ddXjCWQWS
         xXdKgruRFLIYy+1PhD7MZSSVXOb6BErBtCQdSZQMObTLlY0qM+CKupkWJNruRGfSEmfc
         oW41beRbt3HRy9w2l2O1DcWBYDVPZiSG2DRRkkjsbHsDACrSHKZOVAp8ZqhW1aIdEUbH
         Au/zWMZPo2SzO8wN9yNtmxVPcruM3FvQe3k5BqqCXDFBmNRDX1koxSPrzHPpuCff26iy
         h7xcxA0B3BRnkC6K8fQClPedS2wE6D3qIGnyt/NxBtZZFqlppa+0JXPsytq4Fu6UJTAy
         HIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834629; x=1689426629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8uMjI1Tkwt5zl80wRd5zFszf8LWrgvycYShg8nZg9U=;
        b=PLgyLAUmFImtLKtIwn38q17KfDTPb2HlwFEbaA+ORjqtmhM+7sQv8VF1zxvomf8J45
         fIBcGeNCnHzHZXKPSuDoS1uPLPbvcCOM5r5lJPgZ8uhBkwhnNbNrdZ3neA+pdgj34ayV
         cZVAD1++TdxIdC5P7oqu1lbdqSYRrAGtvVrNkKJ/jCGzbLpwZ6Qs0/ghjBNrLW1HSEVH
         qPhiXiYGxNkPKuM/XLQBdTiqNBwq/yhi0Di8mz76SS3lAzGmFFzHroFRX2LEJz4H2eLr
         58dJhOK90/0ZO9QPUbKbD1nb5EWwsYBnI/jgNS2W/rwXA3hGzLDgNbAtfMcvvc0vz3ie
         C8Hg==
X-Gm-Message-State: AC+VfDzDg44Y1QaJjL/vJmxudUNS8j6fgthik5usRnf6BZvVi6fD7FCB
        zf+c6nh7yMV/SAuia2aFIvlqXw==
X-Google-Smtp-Source: ACHHUZ5rliJjSYTDmlWHluKhK3fS/k6VkVj5cW2hkY6zYL+BLggnSeHKeKWIJy07Iu0sbBZ66yxn1A==
X-Received: by 2002:a17:903:41ce:b0:1ac:8837:df8 with SMTP id u14-20020a17090341ce00b001ac88370df8mr17054187ple.6.1686834629690;
        Thu, 15 Jun 2023 06:10:29 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001a804b16e38sm14036019plr.150.2023.06.15.06.10.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 06:10:28 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 1/8] maple_tree: set the node limit when creating a new root node
Date:   Thu, 15 Jun 2023 21:08:52 +0800
Message-Id: <20230615130859.21858-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
References: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the node limit of the root node so that the last pivot of all nodes
is the node limit (if the node is not full).

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 279b871f21a6..23202edb9f1e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3692,7 +3692,8 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 	mas->offset = slot;
 	pivots[slot] = mas->last;
 	if (mas->last != ULONG_MAX)
-		slot++;
+		pivots[++slot] = ULONG_MAX;
+
 	mas->depth = 1;
 	mas_set_height(mas);
 	ma_set_meta(node, maple_leaf_64, 0, slot);
-- 
2.20.1

