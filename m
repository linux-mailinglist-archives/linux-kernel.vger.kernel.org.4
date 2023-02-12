Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4327C6936F7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 12:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBLLLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 06:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLLLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 06:11:02 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FED113DF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 03:10:36 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b5so10901901plz.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 03:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vj3CqwZGdEJq6TnmgvklBeQzIVsiCyTs4essffNxDE=;
        b=IUs1HJ9v6ffF7K4bizanUhy7IgWUOu+k0/TnIYSfm0HHZ3Y16O7Oj0M/+0JkuUhnX8
         GNWebkZi3J+OTBGGmz+GLUIuRCYiJA5qTrmK5vtenvY1qW7NPhO/ea2Bh06wQ3eUiO5+
         b9UqsnKqgEI/ZeMC7MMkUxzcpWZGIpU6wlrYXBpxbqRx9WYRsxaRB4AmbvBcvwYhpxAo
         Vw8jyecrrfSRRin5qx3oJmR4tFkcizkNiQ48q54iCH40XaDe0g7kjJ8I9OjwWYITc9im
         nthjOMXCP1SEnFyQK4vkywxSYyKf8JlW6rKchc4VlNsnXSj09ZARZzYirBcGrujqc/b8
         yE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vj3CqwZGdEJq6TnmgvklBeQzIVsiCyTs4essffNxDE=;
        b=zFTJ6pQ/djIGa0l6bEBlvNha5W36sgJfYxv9bf/IEm9FH9Df6DEgQc6P8Gqdq+6bQk
         Hq07lubOEIRDqVog7xSwjZlp89br0+G8Qx8kQOgy5aFOieLzpeKVKeKdDtJxjp+lm469
         84sgyqUBiPETltjo3wx+hdQVo0WCmA9il7RPUqynLfVVjdaas0Jbueu5NYPQvQzJTHUs
         syYAJz7E54qAV/kYTUqfORriasl8QajgwSNdm7eaz7PU5QCE+ELqoQu4FMRxxcJgyT8D
         /zRPSIPknHN89H2dUlk15IztmklEO6vYO/rMGsHfsa0JcKQKs6l4UDW0BvQU9tc5FjZB
         EE/w==
X-Gm-Message-State: AO0yUKV8oJX0+MZ3pMAzu5A1QBdNvzkSz3XAd/zABaTewegktnQhLzwB
        isNxNIlQdmRp6zcv07on4j9ecc9FZ0N/WyDz
X-Google-Smtp-Source: AK7set+dHFF9S/w3YsET49Y1KoeTltxtxQaWBkNADqQ3MGjiIclWKiGrmt7CReklJY5yOgN7aywZHA==
X-Received: by 2002:a05:6a20:9388:b0:c3:6ce:ac40 with SMTP id x8-20020a056a20938800b000c306ceac40mr19114795pzh.4.1676200235586;
        Sun, 12 Feb 2023 03:10:35 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x21-20020aa784d5000000b005a8ab25ab0csm912150pfn.87.2023.02.12.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 03:10:35 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: page_alloc: call panic() when memoryless node allocation fails
Date:   Sun, 12 Feb 2023 19:10:27 +0800
Message-Id: <20230212111027.95520-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In free_area_init(), we will continue to run after pgdat of memoryless
node allocation fails. However, in the subsequent process (such as when
initializing zonelist), the case that NODE_DATA(nid) is NULL is not
handled, which will cause panic. Instead of this, it's better to call
panic() directly when the memory allocation fails during system boot.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/page_alloc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..588555754601 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8360,11 +8360,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 
 			/* Allocator not initialized yet */
 			pgdat = arch_alloc_nodedata(nid);
-			if (!pgdat) {
-				pr_err("Cannot allocate %zuB for node %d.\n",
-						sizeof(*pgdat), nid);
-				continue;
-			}
+			if (!pgdat)
+				panic("Cannot allocate %zuB for node %d.\n",
+				       sizeof(*pgdat), nid);
 			arch_refresh_nodedata(nid, pgdat);
 			free_area_init_memoryless_node(nid);
 
-- 
2.20.1

