Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E59B70EBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbjEXDOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjEXDN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:13:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621921A6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae3ed1b08eso4757405ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684898022; x=1687490022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV+E10z6xFr5GObbzUS/AcEhnoCetH+fwSlbsSYX4vY=;
        b=UEqQJrMOHnp7tNX7Xow0fq26n4UkOiUISE4M7Opa3LuKIvoS3dhJJ0pqVVo2SLlHs8
         6Qqpy3Eu1Kk08CjhUGgaFUpgTvqwnToIT35Fuppg5a6SaiPtz0c9rGgD9iaXf7kGpKLf
         rS9jqrOV2UtKcs1SiOtf56rgGQlYwIsWsBR4Xu4CfUbv+ajxw8ISYMIaxeaBTW2NfEzq
         lJuSO+qkX1c3cciGzclkIICDlZENpzNmPSqJg/s1ju/BkYi7dKl6yvDfpV6sTU3bXc9x
         lKEvIzWQPS7ntNGuM+n1OvdBANoB8EPXON4tpuiZV7OO1lTc1VkCZZYlWibCcyZ+H9Vb
         9dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684898022; x=1687490022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RV+E10z6xFr5GObbzUS/AcEhnoCetH+fwSlbsSYX4vY=;
        b=D0JyPYWID3h92F0X/2hJCx2NIAvnhyD/QnjtCWJxTgS7FbBFiKuZV4XpxdiyY7Wlbo
         3h/STdmLCv3rSOBIPXx7VUTLz9/EouHp3CGAg3059pN2NMEzamMu3NNSMrZJyO+DJrFW
         lpgkk/nkJPik3Vn8mG586BedCc/1vU/uHsUu0TSNxzqGbpok588ZnbjFWcf4X6kod8tZ
         l+DU5QGP0k+SInLs5gDiIWJicAzKbtm/Aga+fdYhGcaXNxQ2jXJLbr7nebJqgmzmZqX+
         OJwV+JdUyH7N6iOKk39OT9xH4GSzB5w1pnsH7AoTh7lIfRyGRmflffQxbD5OGfP7vm+f
         DCag==
X-Gm-Message-State: AC+VfDwQ1wuVN1qWJPJK32CkzOy3MB+8DnGXOZhgYlxw9GZgAIv/XhKc
        EgWC7Kc34WVVyZt3WDpTvBnJjA==
X-Google-Smtp-Source: ACHHUZ7T4GM4OuK5QysFeJ/gTT+sQ/FKJvyX7/w982xaAUIoPuxcFTqCTQN0bfu0nq33cYFYgWIVvw==
X-Received: by 2002:a17:902:c412:b0:1af:d00c:7f04 with SMTP id k18-20020a170902c41200b001afd00c7f04mr5042927plk.12.1684898021782;
        Tue, 23 May 2023 20:13:41 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001ab061e352bsm7480769plr.195.2023.05.23.20.13.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 May 2023 20:13:41 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 10/10] maple_tree: Relocate the declaration of mas_empty_area_rev().
Date:   Wed, 24 May 2023 11:12:47 +0800
Message-Id: <20230524031247.65949-11-zhangpeng.00@bytedance.com>
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

Relocate the declaration of mas_empty_area_rev() so that
mas_empty_area() and mas_empty_area_rev() are together.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 541675229568..295548cca8b3 100644
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

