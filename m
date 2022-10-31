Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2F9612FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJaFlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJaFll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:41:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8E4AE6F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p3so9828968pld.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz2a6Gnxa0VzNk+aaf7V7ldsdawrXx9L2Y2yVCyV3wk=;
        b=hpb9n1tc4pH+/W4WEarHdEJTdKB8Ai2ziveapp1wFdmhGqQdaw2eIO47MVgU9X5z/x
         ksPR6wC6yaqkhc/7Gjw5j1+OxfdJ2fX7sdKnVGFSvnb2tH2Ewj3HO0DYDPUMqb3x5NBE
         XbPIXzjLvbXmstz37m4M+DFTtqlVUc/uSW7QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xz2a6Gnxa0VzNk+aaf7V7ldsdawrXx9L2Y2yVCyV3wk=;
        b=ja5oo2UU877c+SUUtahOvfrx8R5J0jyrCBytNFpE4xTpM4QZo7I8mGvtOq0eDVAyY2
         LcxOHuNNxwQl0WH2nmFMiS/12XlwIbKumZHYeyXlf5efiCX9WoB1PufGRDHqniBaQa6N
         qal9y/y4UleI8mhWQwnR+s0deZfmaNTj3vwVhsuARlnu+D+YMlCEDJUMF/qqTB1h4UdU
         6JJAoHnJQ5tUDqOhWYljHZhidhXvMdKo0eD7y04OozJwFuWDKcpt+1oatpxfnlVCxku/
         5ZOcU2gPLKkldD0leN8rRWpWq7SbJbabX3iueOKtMW28rOua1J8atqonk/gyCKd3MiEu
         mMzg==
X-Gm-Message-State: ACrzQf3mX4jcQ5uHaKsI+Wy0lj0ftldWAfvjuv5SpbpwCR8aXaNCSRUd
        j/EF5w3w/xBbUvHvNLygvk8K2XO7l/zTKQ==
X-Google-Smtp-Source: AMsMyM45I96pdiy6HLkp/Z+GW+ilK0vuA9XKCeCbpdBf2Nywu1yDwQlomYdS/WX51GnDSZg3i4eLcA==
X-Received: by 2002:a17:903:1211:b0:178:9353:9e42 with SMTP id l17-20020a170903121100b0017893539e42mr12657945plh.45.1667194887696;
        Sun, 30 Oct 2022 22:41:27 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7616:afe0:ba6c:96f4])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b0056befcd7958sm3573308pfj.84.2022.10.30.22.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:41:27 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 4/9] zsmalloc: make huge class watermark zs_pool member
Date:   Mon, 31 Oct 2022 14:41:03 +0900
Message-Id: <20221031054108.541190-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221031054108.541190-1-senozhatsky@chromium.org>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will permit per-pool configuration of pages per-zspage value,
which changes characteristics of the classes and moves around
huge class size watermark. Thus huge class size needs to be
a per-pool variable.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5f79223e7bfe..d329bd673baa 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -178,7 +178,6 @@ static struct dentry *zs_stat_root;
  * (see: fix_fullness_group())
  */
 static const int fullness_threshold_frac = 4;
-static size_t huge_class_size;
 
 struct size_class {
 	spinlock_t lock;
@@ -227,6 +226,7 @@ struct zs_pool {
 
 	u32 num_size_classes;
 	u32 min_alloc_size;
+	size_t huge_class_size;
 
 	struct zs_pool_stats stats;
 
@@ -1350,7 +1350,7 @@ EXPORT_SYMBOL_GPL(zs_unmap_object);
  */
 size_t zs_huge_class_size(struct zs_pool *pool)
 {
-	return huge_class_size;
+	return pool->huge_class_size;
 }
 EXPORT_SYMBOL_GPL(zs_huge_class_size);
 
@@ -2262,8 +2262,8 @@ struct zs_pool *zs_create_pool(const char *name)
 		 * endup in the huge class.
 		 */
 		if (pages_per_zspage != 1 && objs_per_zspage != 1 &&
-				!huge_class_size) {
-			huge_class_size = size;
+				!pool->huge_class_size) {
+			pool->huge_class_size = size;
 			/*
 			 * The object uses ZS_HANDLE_SIZE bytes to store the
 			 * handle. We need to subtract it, because zs_malloc()
@@ -2273,7 +2273,7 @@ struct zs_pool *zs_create_pool(const char *name)
 			 * class because it grows by ZS_HANDLE_SIZE extra bytes
 			 * right before class lookup.
 			 */
-			huge_class_size -= (ZS_HANDLE_SIZE - 1);
+			pool->huge_class_size -= (ZS_HANDLE_SIZE - 1);
 		}
 
 		/*
-- 
2.38.1.273.g43a17bfeac-goog

