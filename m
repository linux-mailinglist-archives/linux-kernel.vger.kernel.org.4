Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBB36E3EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDQFBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDQFBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:01:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBDE10D8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 22:01:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2472dc49239so700254a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 22:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681707711; x=1684299711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS4Pkg0HE5+UxYA0hiruUQ00ilsEPgdYXH5UV1O8hIk=;
        b=HzynEqYHkWXVtxmpOKeHNyA59TmKbC48BgADQgAoicyyonNQRXqBtqety7oevIB4mO
         kWKoXOGUb43q9ItRNjf2w/tVUpztvMbeF/eCrjFRlTI/ywnZR+UYUGr9q22sca3LhHsf
         ASX7P+o6OaOaL52hSvqJvffIalsVnc2QJSpW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681707711; x=1684299711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS4Pkg0HE5+UxYA0hiruUQ00ilsEPgdYXH5UV1O8hIk=;
        b=jNB17VTKbONSCQavQSxW5T8s2yp4tGcZuY2+zuXYUiz4jouGRzhlOJfUSGe4RX9g9j
         ggXLr7KWQgehK355OuZwtEYzySTCr8755TBAxecUMDajjHSw7dK1qGI0vz4grD/aTaHW
         xHB8M5+CnCsGx0fYUHdHC9wTh7QAxKZezg21PELWTh08Kp75yqX/4oKOCKcfI0SXqOoq
         7YWLISgCkR+Nd6rA8zb0eBVyn/JbkznJCFNFX8Vg2q2Mw81ogTo8Lmmfgae0o0rn20bD
         HbBW+ebEn+HWZYpXzYUdTS1/1s67acoKwyAuornnE0Edw9getk7KwKEiTq30/t6oeCko
         ACYg==
X-Gm-Message-State: AAQBX9eCrSQFDbzNShuMOEloXu66+rKVIg0ehZ2YWUM+aSnY7fZRybfp
        Xx5Zo5p2BfT5TmBkQGAHORkdgA==
X-Google-Smtp-Source: AKy350bQ2D/xaVVJ692Azw6bLaxA+WF72DQHClmy0RxhD6f3549DDpfcBdeZ78HRBvLYvTirNl7gSw==
X-Received: by 2002:a05:6a00:23c8:b0:623:e4d2:d13e with SMTP id g8-20020a056a0023c800b00623e4d2d13emr21214550pfc.34.1681707711595;
        Sun, 16 Apr 2023 22:01:51 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:97ac:e7c:d412:5251])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b005810c4286d6sm6661977pfn.0.2023.04.16.22.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 22:01:51 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zsmalloc: reset compaction source zspage pointer after putback_zspage()
Date:   Mon, 17 Apr 2023 14:01:40 +0900
Message-ID: <20230417050140.1653593-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230304034835.2082479-4-senozhatsky@chromium.org>
References: <20230304034835.2082479-4-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup.

Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index aea50e2aa350..cc81dfba05a0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2239,8 +2239,8 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		if (fg == ZS_INUSE_RATIO_0) {
 			free_zspage(pool, class, src_zspage);
 			pages_freed += class->pages_per_zspage;
-			src_zspage = NULL;
 		}
+		src_zspage = NULL;
 
 		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
 		    || spin_is_contended(&pool->lock)) {
-- 
2.40.0.634.g4ca3ef3211-goog

