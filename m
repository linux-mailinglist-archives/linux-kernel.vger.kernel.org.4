Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF006EE0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjDYLGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjDYLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:06:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064B12CA4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b50a02bffso4706316b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682420754; x=1685012754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdvAl/rsZlyn6jAT/y3p3/RJdLkd5U9SZ/gjDoLgWfw=;
        b=WZB2irIoBxS6GfGWbmO853Yh/UPd4puaaWuwwy6+RSHHRD9B00WbRPCkiKPVrIbRII
         1pcfPq9bubluGJJeyOkwLw/XxAmdroXH+PyguDhLNWvGNXvKzmSCKSKO6fYtvqXgbO04
         iz99DVGSY1h2LtWFUVD+x7fZ0tz+TLSL781orthWvsF2rwarXtXFcU4IV/V5a7zQRQq8
         wuPrNWCDq6Ow9r9Vn27Ha/PmX//TkDUedK1Mow/rbV9iqKf015dWHpqGcO+uuA500v//
         WqsfSrj40q7HE8zDHZhcIzZCKsjjFNTglOGyr4KegnKNRbr3XDs9pNjqWtA0TXgPVef1
         xngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420754; x=1685012754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdvAl/rsZlyn6jAT/y3p3/RJdLkd5U9SZ/gjDoLgWfw=;
        b=XIcupWrDYFCFTEM4Ww3q/sQNKQgMbDwP1oPqpxtfzzIaH1nibyNudh4KFuM5TbYMFl
         0P93kPteUSyjnoUY2fcC6qIsbaNl0xLEMtrvfTqevRYEVBoHaJxCGicjnck/F/jLvKZ1
         cn1QMg2lckkM/qVG1TtZOvDH4w1bfjlYAYYNoxg8zoG12mtDEWFb+gOECYhPmsulTE25
         M7HeyftagLJ5JLAXI9lDGwLmpqnSI30I9MRu58T4AH9Xmu93w0eGve1ztXOyFBhEAxP7
         buC+0irYkJDB/dKp8xk1rPp96NZ3R4p9fuUaMmRmzMkONbYW4HU3eCo5BKnzIY9ZyAoT
         wqsA==
X-Gm-Message-State: AAQBX9d36nlaaWn1kDmwsF5LKENUrkfoi6bPPXdEp5+8G1EZ3FrWclRe
        FUtAA0Kd1nXi+Etco449F9QWaA==
X-Google-Smtp-Source: AKy350YosWlGcJzLz6lD6ztODg+LACdFQKhZ99bcfSueMS7rUjCsz9/sQVqQTb0SfTKSFkZeLRnrXg==
X-Received: by 2002:a05:6a21:1014:b0:ec:86a7:4fa5 with SMTP id nk20-20020a056a21101400b000ec86a74fa5mr19512176pzb.30.1682420753957;
        Tue, 25 Apr 2023 04:05:53 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm4422169pfk.79.2023.04.25.04.05.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 04:05:53 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 9/9] maple_tree: Move declaration of mas_empty_area_rev() to a better place
Date:   Tue, 25 Apr 2023 19:05:11 +0800
Message-Id: <20230425110511.11680-10-zhangpeng.00@bytedance.com>
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

mas_empty_area() and mas_empty_area_rev() are a pair, move
mas_empty_area_rev() so that their declarations are together.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/maple_tree.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 1fadb5f5978b6..3130c1f822ddf 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -470,6 +470,12 @@ void *mas_next(struct ma_state *mas, unsigned long max);
 
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
@@ -493,12 +499,6 @@ static inline bool mas_is_paused(struct ma_state *mas)
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

