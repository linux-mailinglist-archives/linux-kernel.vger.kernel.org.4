Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38470EBC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbjEXDO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbjEXDNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:13:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F241A8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae507af2e5so5242605ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684898004; x=1687490004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5ruzeEGnj5CNT1/L3jtI3wslKiej4m4uvmLFSF+fv0=;
        b=MAXMrwd/Xszur0x1fVAw7betXZi6Nv6iEeLRVE5rWFKAKqojhanpmq36+yY3jJQzsO
         M9EaO7RCl07OPXG4T0XWZ9VSsKYxu0A23zt5ExwuJrHR4zwdz4j0AmGa1VSOUMO6wVYw
         qbhvNZyU6dI9n7coOrUlXhim1BD85Jo0/sUOOUpXURBnyIkhz77RCwKkEwgBBXh8yi4h
         lupqDHDCc8iRhYj0YQ6830133yOLFDVOMIx7nBBQEQIABrD38VhOK6s7jpcSWBsQBTYP
         IV1HaE09ZjaHvHuTj90fgQdS2QStLY/pP/3jhoEO7eVxczLOyNTW1OWsR4ZkoGp1yHNJ
         r9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684898004; x=1687490004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5ruzeEGnj5CNT1/L3jtI3wslKiej4m4uvmLFSF+fv0=;
        b=YeVJfpPONlXVggjy3g/CYnrqSQb+3CSAVWNzRfrInqiGhzURPaPXoEvVqF0PVsEEzE
         yz2EYT1ycmvd/i+sYpDfdBAgXRt4UBw6AHDo69/2Df3ohrmuA8jtXiuztrzICdMaYg6u
         BSI7/Fq+h1/QQleGdLaxjxLRoPRYtEDH30kTvBaKRn9BN5KeIIWuXNE7orbRDo3zuqBf
         ole5ekEAMWu+iwaARNEWwNTap4klz53/kWLqFxEZ8hK5yKeP7X3du4itoGLNW0P1k+Gw
         UUtGfGUNqG6vW5VjNEnXfz3Gskot8KH6OmJl7ZaqLFjxjlxddPYllvNryTqlTKIA7lfX
         FbAA==
X-Gm-Message-State: AC+VfDxdAK16IVcw7d32HVSBYEmNtn3GGvQI0RFwDjdhLN1lxNEy1/Rz
        pAMUonppNFm6GWRPyMtuhaXscWZGIlsxmYl52aY=
X-Google-Smtp-Source: ACHHUZ6DAmE3MeGOc5YNkDegpteBBglHsp+EtBuDqz75GpGc17B78j9ExHKLk63janlv3Z40tdQw2w==
X-Received: by 2002:a17:903:8c4:b0:1ac:b03c:a58e with SMTP id lk4-20020a17090308c400b001acb03ca58emr20956735plb.25.1684898004536;
        Tue, 23 May 2023 20:13:24 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001ab061e352bsm7480769plr.195.2023.05.23.20.13.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 May 2023 20:13:24 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 04/10] maple_tree: Simplify mas_is_span_wr()
Date:   Wed, 24 May 2023 11:12:41 +0800
Message-Id: <20230524031247.65949-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
References: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
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

Make the code for detecting spanning writes more concise.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3fe6a6685384..41a105e76e22 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3728,43 +3728,31 @@ static inline void mas_store_root(struct ma_state *mas, void *entry)
  */
 static bool mas_is_span_wr(struct ma_wr_state *wr_mas)
 {
-	unsigned long max;
+	unsigned long max = wr_mas->r_max;
 	unsigned long last = wr_mas->mas->last;
-	unsigned long piv = wr_mas->r_max;
 	enum maple_type type = wr_mas->type;
 	void *entry = wr_mas->entry;
 
-	/* Contained in this pivot */
-	if (piv > last)
+	/* Contained in this pivot, fast path */
+	if (last < max)
 		return false;
 
-	max = wr_mas->mas->max;
-	if (unlikely(ma_is_leaf(type))) {
-		/* Fits in the node, but may span slots. */
+	if (ma_is_leaf(type)) {
+		max = wr_mas->mas->max;
 		if (last < max)
 			return false;
+	}
 
-		/* Writes to the end of the node but not null. */
-		if ((last == max) && entry)
-			return false;
-
+	if (last == max) {
 		/*
-		 * Writing ULONG_MAX is not a spanning write regardless of the
-		 * value being written as long as the range fits in the node.
+		 * The last entry of leaf node cannot be NULL unless it is the
+		 * rightmost node (writing ULONG_MAX), otherwise it spans slots.
 		 */
-		if ((last == ULONG_MAX) && (last == max))
-			return false;
-	} else if (piv == last) {
-		if (entry)
-			return false;
-
-		/* Detect spanning store wr walk */
-		if (last == ULONG_MAX)
+		if (entry || last == ULONG_MAX)
 			return false;
 	}
 
-	trace_ma_write(__func__, wr_mas->mas, piv, entry);
-
+	trace_ma_write(__func__, wr_mas->mas, wr_mas->r_max, entry);
 	return true;
 }
 
-- 
2.20.1

