Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AAD6E496E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjDQNK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjDQNKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:10:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3DB764
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:09:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s23-20020a17090aba1700b00247a8f0dd50so1548004pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681736954; x=1684328954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfaXwaejuaPvLs95PjZjRu0vpfMClPgPR+OjlDZfyVE=;
        b=ShgiHOX6JkpqzZi8O5nlTxhmRvwWybYlaXi2igdR5Y3NZNatwOGe8jXljS3oIP/Fvz
         THjRGdX1kL+JEtotMNez8DCpGTlwQZC0opRxzAPMXCA8ZdBYnQSdiQQhunusx1w+ZSJh
         bedAaNbGOf72kSW+byknzdekQiiut2/LN+LUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681736954; x=1684328954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfaXwaejuaPvLs95PjZjRu0vpfMClPgPR+OjlDZfyVE=;
        b=MOuphi8rQ/6OEBLFjwHz/jdbgJCUCY/YJv51K43ptz151GpJLtIPLfPDkP9uMh/IR9
         4lEL+w3sBBuj9NTLRFPKYqDakBgeHsZXK/jLDsVgbQKSmEx5nHyKTdSfLZigMPVopmSj
         9SM7MJ4uqogxH/jPRhB7Ok4+TZfAdNL1W8iGblbiQx5wNwyV6SO4gAf//QX9jCllNf1L
         KPdYTC8OLHPeYuJ0XJBQOWfzCbwpuQTCrgT/3ZoMY56gkzfXKwRLj0ynnxFrMjjg/oCu
         AH+pV2z3Ls5wyiwWuFgBQanSSDpLfXNKQ2HLbgojsDSqhTfYl3YhQn7bslZhaeEezDm6
         j6uQ==
X-Gm-Message-State: AAQBX9eAdel+24AH0eWoae98N8QUWBlnMHGr8mchL2HTL6WUIULTtb70
        YcVgyvho9MMXsBaa7k0MtaoL3w==
X-Google-Smtp-Source: AKy350akZuhaLdEgU1D3dzx3asXf9NiaaCLcNTa9ASBt7lR290Uc9SPQjCqznmsxLIHGsavpxD6H+w==
X-Received: by 2002:a17:90b:390d:b0:247:65cc:c2cf with SMTP id ob13-20020a17090b390d00b0024765ccc2cfmr6720162pjb.19.1681736954247;
        Mon, 17 Apr 2023 06:09:14 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:97ac:e7c:d412:5251])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b001a0428bd8c4sm7571744pln.289.2023.04.17.06.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:09:13 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zsmalloc: reset compaction source zspage pointer after putback_zspage()
Date:   Mon, 17 Apr 2023 22:08:50 +0900
Message-ID: <20230417130850.1784777-1-senozhatsky@chromium.org>
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

The current implementation of the compaction loop fails to set
the source zspage pointer to NULL in all cases, leading to a
potential issue where __zs_compact() could use a stale zspage
pointer. This pointer could even point to a previously freed
zspage, causing unexpected behavior in the putback_zspage()
and migrate_write_unlock() functions after returning from the
compaction loop.

Address the issue by ensuring that the source zspage pointer is
always set to NULL when it should be.

Fixes: 5a845e9f2d66 ("zsmalloc: rework compaction algorithm")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Yu Zhao <yuzhao@google.com>
Tested-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
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

