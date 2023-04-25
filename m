Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F271F6EE0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjDYLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjDYLF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:05:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFD87ABF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:51 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso4700984b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682420751; x=1685012751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5HiaDQy1gV5OijIvJDqywUjC7+FvWItMLIDy/cp2lo=;
        b=Jmn8+k2SfFfgMhLQds+Cr0nlYahkoptl1RwDbzAx8AZV4daLWkUna/d9KpjCx2Rfy9
         rmCt9o71sj3yTlbe6K2B/hk/W22x/AoY5gUneeoO2WZBUgG67nocT5AJKOv91QCs4JN+
         DZCnL7fxyHriXlCninrD3Zk7URi4nUfnyi5EmbP/3Gha1H6bcYRPYa70gVOJDs6+9d0S
         qnpA6xJhk/rQJkofq1EEOa8tqw8D0zjeLVXFud06M0NuAFQZVoamUgVTSmw9Qqf/CECK
         aW9WKvh1ndvQxmuIyREMN2Zd+vYx5GuyPdQSabCRBc2itdPqh0hvHYca5F8MEElf7xn+
         3LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420751; x=1685012751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5HiaDQy1gV5OijIvJDqywUjC7+FvWItMLIDy/cp2lo=;
        b=JImxG/15/ZMWVbuUB4mDZm9pAsS8pR01sCQWrZ4vZvEW50TRZH9Is8AjlWZmqdLl1v
         0yHE+OUc2/2/oHOfI5VV29iExnbugnmCtn/IcUY65dv/VRJwhCZ+W5uGZkSTGdPKG7AC
         N/dEUMeiIGHob3hPdSnxk7lxrVaiBwxTJXaB6uzpzLukWFNzTH9CDdgAgjyY+m8enkjY
         bwBeT+OlDZkucKUj2Wak0RyOe7QJ7mq9+YdRdQogfKWyosj3NlEmspYBpigr0ti4Eb2h
         TjHuzbSSUPNbWJ4uUO6PpPg+20SwEX2PnbOEQpUyY1XhznAopZB/dOCAfkfo9TQMNK9m
         qvBg==
X-Gm-Message-State: AAQBX9eRenNvFqdlSv9aZwAPCxpPk9xCj4yv2wJmESS9W+SrUE3z5Evy
        rxUqf+B7os9FHefnMZKvOnxJ4Gu00uDaZlyYkes=
X-Google-Smtp-Source: AKy350ZfhQmTsVjWSSkNdrmfeWoP+w6CU2sdxSf+zlZBnBd3DIyE6NNnISJz8v358g87ZS2LcR27eQ==
X-Received: by 2002:a05:6a00:2d20:b0:634:7ba3:d142 with SMTP id fa32-20020a056a002d2000b006347ba3d142mr24767709pfb.10.1682420750817;
        Tue, 25 Apr 2023 04:05:50 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm4422169pfk.79.2023.04.25.04.05.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 04:05:50 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 8/9] maple_tree: Remove the redundant check of mas->offset in mas_empty_area/area_rev()
Date:   Tue, 25 Apr 2023 19:05:10 +0800
Message-Id: <20230425110511.11680-9-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
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

In mas_empty_area(), after mas_awalk() returns, if EBUSY is not set,
then mas->offset must be valid, no need to check. Same in
mas_empty_area_rev(), so delete it.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8bfa837b7b752..964214de2ed18 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5305,13 +5305,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 		return xa_err(mas->node);
 
 	offset = mas->offset;
-	if (unlikely(offset == MAPLE_NODE_SLOTS))
-		return -EBUSY;
-
 	mt = mte_node_type(mas->node);
 	pivots = ma_pivots(mas_mn(mas), mt);
 	mas->index = max(mas->index, mas_safe_min(mas, pivots, offset));
-
 	mas->last = mas->index + size - 1;
 	return 0;
 }
@@ -5365,9 +5361,6 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 	if (mas_is_err(mas))
 		return xa_err(mas->node);
 
-	if (unlikely(mas->offset == MAPLE_NODE_SLOTS))
-		return -EBUSY;
-
 	/* Trim the upper limit to the max. */
 	if (max < mas->last)
 		mas->last = max;
-- 
2.20.1

