Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA5F70B459
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjEVFIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjEVFIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:08:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E551129
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso2299179b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732068; x=1687324068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yOLk/7tHD7/ODqSb7roZU5d9FbnbbLKf36QePLl4Fs=;
        b=AzHzNd0mvm+jLZUdv/e7B4MQC3FEjUAXCF3VVAaoRyZSNx71MXEV51MxVvMQPGTRnL
         beZ/HAieLZVm6erPnazYr8lxJ/KMnHLGwVLS9rpwqD4TZwtSOLNIx2ilFdPluS8Fo5wH
         aulAdvKjGbORvC5pYRoimAsxCsbmmub7MiwaCjUVNgDxrPoNguk1B2QxFs2f/4u0BDxC
         ghdjhr9rKY4kS7OZrxzDsus7afl7TirEZO6XG2XE9PaDtCnJIS3J6uHgXmphvXYrsd64
         V0VVSCQSKamOqt+7V9vZLiSj9VDqYA4y4mi6VfOkA+OqJDHu8LZDsc5yOBZRw9CnQDtp
         /E8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732068; x=1687324068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yOLk/7tHD7/ODqSb7roZU5d9FbnbbLKf36QePLl4Fs=;
        b=WnSaeAIFmoE/m2FY+BtcXD2W1LoABJuUPgL9tyw/mh0hKJ9U5noLlmHlDXVuTrFeHg
         39yhXHAP6bJP7OmGyTQttoZB0fGcEDfHiBEIyzAac7JZUEuFNf6aIcSR7x5qslRW9uQp
         v06y/9KIVLOw4uKI3htAfVHgT7tu2TRXjYtGEwC1e3toV+yjn0nE/sGMdwRXxPSmhGmn
         b2JZniDDbhzg51iyEUl5HUTaLyfbqQmch8pP6OjTSfVrmjNLtJ5atlAgQKbkrUtuzZpC
         lJm2pKUNbC/pMggJKNL/rK23fZ0jhXE7+URypIJDLOiS98WPUZ12fQN0fyIAeWhGawXa
         7OrA==
X-Gm-Message-State: AC+VfDw3YGC4kcpSHg7qzsidFWJXxMaSr4j1ZztI12qNb1sdhUI5QzvI
        0jNXg/TgSFciFbxm2KSNeH043A==
X-Google-Smtp-Source: ACHHUZ4VTPblQwvMklYDFzU1McTkdLu8cOzHgLuHXQ1smW7pdssNegVfLfyh8uucTfzZ0+l2hFIQ4w==
X-Received: by 2002:a05:6a00:c8d:b0:644:c365:50d5 with SMTP id a13-20020a056a000c8d00b00644c36550d5mr11924837pfv.6.1684732067735;
        Sun, 21 May 2023 22:07:47 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:47 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 10/10] maple_tree: Relocate the declaration of mas_empty_area_rev().
Date:   Mon, 22 May 2023 13:06:56 +0800
Message-Id: <20230522050656.96215-11-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
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

