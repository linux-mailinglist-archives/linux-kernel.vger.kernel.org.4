Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B39706376
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjEQJAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjEQI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:59:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7185B82
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-643a1fed360so330454b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313954; x=1686905954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yOLk/7tHD7/ODqSb7roZU5d9FbnbbLKf36QePLl4Fs=;
        b=Q7oXeL4sctdcQKhumFBqJRf42lgk2FNTENFZu9Qkrb6TOXTEIcxw3K5SI70QmVnuHX
         2OCeSnCqCeKxNz0bWKvL1ZvkX9V5aKtUkcZDe+E7XLyPfqXLnSp98eUqDOeL9woLgcpY
         si1rd8DLRkRyXptPznV12FXg8kcZDXpdfWShJ5yy2oKxn37RsKt+8+Va4+GLTaD/2yqk
         hyBRT5SBkbQNtwyol39lNKPfWRPA2+YT9s8nqCvwpbEzQi+urdyy27mjKENKLNgztn2B
         p2kqsdiNl/iwhz4U774B51iyoC0dqLHrV3i4E3vAN1Fi/ZG+zKqZEwvC6eXEiuqoFYD/
         6gQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313954; x=1686905954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yOLk/7tHD7/ODqSb7roZU5d9FbnbbLKf36QePLl4Fs=;
        b=Kjv34F9DRdDI1QrxqhAaAwVPKujopucCU2EgUm4d393/w+iWAwtFhVGnvhV2J2INSe
         WdIFBL0HtsbWCD0zRDsiSwXBhpdEADD9N6UuBO4OZxNjNBQdfogYLQmhUF6YSv2BiMbF
         pXp5u3XjKp3xj1ZvnmdtTyrrgxE7aZdAVGRmF4I+LIhzvO3V3kJdvR0xwiutxzXjrEzy
         kI0qq3UNB8FnakuPm2oZzIhbE+J90aGZPU1suLKLnpuVpV4XB7FZ4KRzsSC3rw0tiUfX
         Yl2TmwsmqvjnX2AlljSHj2SWOB6JIVS1hTQax/F2znwiK8VkEVMiMwm+4HzXrJg3NQ5T
         aO5Q==
X-Gm-Message-State: AC+VfDz2aBGE3dDOCmGfNePXunZRFRL/zO3ZtMmnXWesbvCpAirEWNPr
        zJMLhFDYnoPfUgOsfkA4PanwsA==
X-Google-Smtp-Source: ACHHUZ4H+myF7IIjsdfH08K6wJiNewZT9TZjcR0vwBuPvaaRoKaGKaynz0WzQUoHt0UQoLpwbdi5NQ==
X-Received: by 2002:a05:6a00:2d12:b0:644:ad29:fd37 with SMTP id fa18-20020a056a002d1200b00644ad29fd37mr14335pfb.28.1684313954312;
        Wed, 17 May 2023 01:59:14 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.59.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:59:14 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 10/10] maple_tree: Relocate the declaration of mas_empty_area_rev().
Date:   Wed, 17 May 2023 16:58:09 +0800
Message-Id: <20230517085809.86522-11-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
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

Relocate the declaration of mas_empty_area_rev() so that
mas_empty_area() and mas_empty_area_rev() are together.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/maple_tree.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 85559a34a098..c4681cb8414f 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -474,6 +474,12 @@ void *mas_next_range(struct ma_state *mas, unsigned long max);
 
 int mas_empty_area(struct ma_state *mas, unsigned long min, unsigned long max,
 		   unsigned long size);
+/*
+ * This finds an empty area from the highest address to the lowest.
+ * AKA "Topdown" version,
+ */
+int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
+		       unsigned long max, unsigned long size);
 
 static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
 			    unsigned long addr)
@@ -497,12 +503,6 @@ static inline bool mas_is_paused(const struct ma_state *mas)
 	return mas->node == MAS_PAUSE;
 }
 
-/*
- * This finds an empty area from the highest address to the lowest.
- * AKA "Topdown" version,
- */
-int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
-		       unsigned long max, unsigned long size);
 /**
  * mas_reset() - Reset a Maple Tree operation state.
  * @mas: Maple Tree operation state.
-- 
2.20.1

