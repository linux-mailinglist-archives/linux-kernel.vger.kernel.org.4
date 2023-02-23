Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCFF6A0163
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjBWDFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjBWDFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:05:18 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B34740C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i10so2359460plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpGG/okMdj5ni9xegYLzCx8QuNxJjUnFEqNX1SXn5aY=;
        b=eXWiDf6CYI70E3qaKKdmQKpYXcXl5mJcHwRXnE9PqLSpLMIBznVHG6rsd6Yik0X/kL
         7XBQaZKnWMaK+ZCn7rGTemi+XWQrhgo9ktJrz62HQnL1ZI8wqWskCMnCOUoRKkFs/oq2
         x5q7YV9lJ90uWhY6HMhvkqjtbT42l++wXe/Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpGG/okMdj5ni9xegYLzCx8QuNxJjUnFEqNX1SXn5aY=;
        b=K31aiZZT3KDW4nh5Yb11W7XXuBgF+3+vkIbnAz9Dx4Fxb45JIrMPSV/4C03YMaKGJj
         czrS/mEmu4ZAHuulthxubrCSB3Esnv18VYybS4DFPGETw9mAH2wyQiYvglGN1Xhowm3t
         Zm6cOpay9J1N0uWzjCSANdZCvFQwu3CpejLaUJ+uYxrwQjbh5bwKgYeRSKLLiRIXBeD2
         1YJijpnD2UJZJ7SkIm44yQ8g0sZ916+5nqfMLTSqODBL75vrd/SeweFPrBPDSrGpcrAt
         fy44QvE5NO/yQf6OZt+fwpvdA6UolxGU21f/e7TkJ8zi896HuooS6iwYLK+b8jwZ27jL
         ktbw==
X-Gm-Message-State: AO0yUKWrTDw1LVGi0XyO4woD59knjuxIBCvvmiHPr3mpLph7MEHk2l2v
        uTi3awTVq7qnk8NQ2S6S9VkNLGiwBdsnFQ7M
X-Google-Smtp-Source: AK7set+4oxGj/Ama0iVUAf/6wEdS2tLFbPW6Kq4JQCSnEY0zMYJIdlBBjbRva1S9Em30N43trG4ihA==
X-Received: by 2002:a17:902:e5c9:b0:19c:355c:6eb5 with SMTP id u9-20020a170902e5c900b0019c355c6eb5mr14014208plf.30.1677121512118;
        Wed, 22 Feb 2023 19:05:12 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6de2:9e85:b508:57b8])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b0019926c77577sm608520plb.90.2023.02.22.19.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:05:11 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 5/6] zsmalloc: extend compaction statistics
Date:   Thu, 23 Feb 2023 12:04:50 +0900
Message-Id: <20230223030451.543162-6-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230223030451.543162-1-senozhatsky@chromium.org>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend zsmalloc zs_pool_stats with a new member that
holds the number of objects pool compaction moved
between pool pages.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/zsmalloc.h | 2 ++
 mm/zsmalloc.c            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index a48cd0ffe57d..8b3fa5b4a68c 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -36,6 +36,8 @@ enum zs_mapmode {
 struct zs_pool_stats {
 	/* How many pages were migrated (freed) */
 	atomic_long_t pages_compacted;
+	/* How many objects were migrated during compaction */
+	atomic_long_t objs_moved;
 };
 
 struct zs_pool;
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index eacf9e32da5c..f7e69df48fb0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1815,6 +1815,7 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		obj_idx++;
 		record_obj(handle, free_obj);
 		obj_free(class->size, used_obj, NULL);
+		atomic_long_inc(&pool->stats.objs_moved);
 	}
 
 	/* Remember last position in this iteration */
-- 
2.39.2.637.g21b0678d19-goog

