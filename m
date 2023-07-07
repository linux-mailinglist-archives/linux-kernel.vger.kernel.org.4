Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7649474AE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjGGKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjGGKLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:11:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7611CAF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:11:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666eb03457cso1060254b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688724675; x=1691316675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obQkYhgKS4HY8GCkScMSh7+VaHIuzmq4BqEaENwQoNQ=;
        b=ahfJjKcjkN3t/H/Kibyt7ZUmq5o9Qf9MqO0YUCMAE1gwMas3raqn7C91lMkIMWWa+T
         IJpR/S9MoSPTB0GA9vEeaHbA3kmXN2W7SWysLZhJs6HexLH13doyrOLey8REwDAcdRPN
         fP8HOY0sup0QDoYEw9uvVF3G2q+51TJo0nXFR7bTMRyT5OacgzLxQE9frW/AKpX+AWNR
         /D2sk7Q+gPL7mw1O1vqKgXJGKmWY5ytglXmVVnGG1IqqW4I012Ywz9z/LyJ6/oJGZlRb
         r8NHFBGoZggHXSbLeAun3FT8PlbYYDJt1ZBk1/8+08pOsZ9cvnyjpIIiC2BX2Ly1YlQ6
         H0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724675; x=1691316675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obQkYhgKS4HY8GCkScMSh7+VaHIuzmq4BqEaENwQoNQ=;
        b=PqpNxHZ7zdGwT3NKZFMpIxBkIzXRi2tVuMGPcFAZU/hvIoefnd7LkBLu3vFUTQISUE
         oHZlZDJbdWs4J6P4J02Qc/fTC7pWvA9rbaXw5ZHES5RCbydShiEZ6chnJgfO9CcWZSQ6
         GtJ7yd5jchl9IJKBs4HFKiZzf8AudlZLxpdbEjVGIpreqeL49OSYrjYdmJyWoU17hWhg
         uJpd29wX7cDqtwofZ4G6qQUAF8nIFjrHyfKjtklG+XavaNbiUTKEpxxooVFfTgYpEjEi
         4AP2TsAV3lSerD47dxhnXuoAZ6EZjBQUS3HlhUwpTMZ0DyISMnAozGECJw02X+6b3Ssz
         k7wQ==
X-Gm-Message-State: ABy/qLY0/uzKgeO2kqjSbS8m/OxA1CWVaXI+uF12A97DKmrElwjTYH53
        qac5qfp06m/5I194/CLBNbZ/UQ==
X-Google-Smtp-Source: APBJJlHDXMs7auQxKm6lk5bZ49tnnErX5Li8AtE/l8/sNkUBvdMUGaUh5L2J1GdM5UfG+EeVA+sVlg==
X-Received: by 2002:a05:6a00:1593:b0:65e:ec60:b019 with SMTP id u19-20020a056a00159300b0065eec60b019mr4460571pfk.25.1688724674907;
        Fri, 07 Jul 2023 03:11:14 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b0068288aaf23esm2602549pfv.100.2023.07.07.03.11.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jul 2023 03:11:14 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RESEND PATCH 1/8] maple_tree: set the node limit when creating a new root node
Date:   Fri,  7 Jul 2023 18:10:50 +0800
Message-Id: <20230707101057.29326-2-zhangpeng.00@bytedance.com>
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

Set the node limit of the root node so that the last pivot of all nodes
is the node limit (if the node is not full).

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d3072858c280..f55e59bd9122 100644
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

