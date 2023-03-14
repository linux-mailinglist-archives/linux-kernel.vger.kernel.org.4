Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2657E6B9433
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCNMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjCNMnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:43:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87879A189C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:42:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cn6so2661857pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678797738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3vWZFEyoFMtyU6NTTWlVAUK8MBUwQjg+G+jzZCDuAk=;
        b=Q0EWqbllJxrbZyB/Dz9VLiyjmY6OKzQ9ODkPXCtv1PHZFxEXHWUGy9j8P3QCubHPW6
         laPUIMP5ae5R8SQ31VbcE0PP2Qxc0ZRZeq9ial6QzAMDElJuHuLPmKq8qz8iadur2NK2
         Qc6llIatsVC/fIYVCuEaCkKpavYWo5xV0MCwYao4CrA7z5VX0new9FRvp3QEbxYXkyiI
         SLS6EiaBUB2md6d10HaQRcz8rW8OxSMc7iQFehdRbjLPyp5kXZppj44STkAZGKtyjsmc
         olYO/uynIoSxt0B+X/x9asOLPNhgHb9CaVT7qrMmAGPN7MuDUu025M1syzM8Q6iWO8yG
         UYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678797738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3vWZFEyoFMtyU6NTTWlVAUK8MBUwQjg+G+jzZCDuAk=;
        b=C4ql3GXnIg8h0FzsI4z6zAv6a3hDFjLx/jEGfcpURks8dxGJPaeiSLnacmH0MtOdVP
         hgygV1PbOTw0CRrlr3xi0GzqiqUEn/edWZMbGHyyX/q77FNsO7Vv3A5VFarau9nMuYaz
         l002ro7RzuF2ZXQUtFrxho1B1WvxKsSuoZT1N2BwR3TXuJyxw+IM4rRZB7fabZGWAV3q
         sHmP+AGK7M+0LtNKbn7bNoA6baYwpMqmkQ+iPq1b+aWWn62BDtfogccL6RikgM+fEA+u
         bvThKQJi1y8TQrxh4acwdqkxg1QQpZQiMSI/2YA2rjjhuNuTip6aA1ZeH/0QdqNeTQmr
         wo1A==
X-Gm-Message-State: AO0yUKWmNVr5uKJ1vZ2RzM9WkY1yDd4Cv+stJcQ9CZ4IGxd6dpT6eejY
        OJ8MCyjdmnvB3Bf6kGB7oF5hXQ==
X-Google-Smtp-Source: AK7set9Ud5nZcxsuvhOGQRUujTT++2XEg590TsbcJ3Ds1UZrcs20nPDnaJZcfAnEuMlVPZqCfqCn0A==
X-Received: by 2002:a05:6a20:bc97:b0:d5:74f:37a1 with SMTP id fx23-20020a056a20bc9700b000d5074f37a1mr3510720pzb.27.1678797738697;
        Tue, 14 Mar 2023 05:42:18 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7828b000000b005ded5d2d571sm1509385pfm.185.2023.03.14.05.42.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Mar 2023 05:42:18 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 1/3] maple_tree: Fix get wrong data_end in mtree_lookup_walk()
Date:   Tue, 14 Mar 2023 20:42:01 +0800
Message-Id: <20230314124203.91572-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
References: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
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

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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

