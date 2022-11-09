Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2498622AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiKILvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiKILvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9A2EF1D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:18 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so1595125pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTJSMGQnVr536MHmH+z5uAcQ4mxEF9ubNphP3SWXc38=;
        b=JugrdxVHc3EVPtfDqUoNOLZ1kNs5JPOJ8YZcAaOous+St7ne5PyANDUJXAtNY2rhEi
         n//X6QGWh/U5eKuz/qRvjJjhPJDLKEKXuOXggdKo3dJVy++tIRmqYSSouzcUMrqrK99F
         y82p7gDbtsucgtq6MfVMebxhThBUzWo1dXpBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTJSMGQnVr536MHmH+z5uAcQ4mxEF9ubNphP3SWXc38=;
        b=K3eqDXZnaxhZXypgrFMc/YNJjthtzFFlgJAiWUxeKqBZXwYGU7VmF+3u8r+GukkZB/
         biqogo5sRyrX1VC7yJVSfuo0IwATZU9I94HVhoTzxDRfmvwkanwOYfw48aRnncg3XtJM
         iAs6/dDlBML96QIamDG306evqtCHYNmJ3cpUpGl4BY/PwbfOlRp3C0XI7RGCKb3Aj+Xe
         g6x5mdAiIF+KTTWLwZiY2lhGiKhDUJDDvRX782l4l1hkrFYUr/Ttx/ieOUgBHkieL+7y
         L7xN33zhaAy6BNpS7B8an47BB8kEy2meJCXl8kx7kLON+2k8G5EQCG67mcNDjRt1QEEr
         pi9Q==
X-Gm-Message-State: ACrzQf2wcrNi/lPHPUVwSuS/m1woDZn8fMdaV0sZ1ArR5qTRvHvB+5HJ
        POKb1N/3LyqhC18tPkQwVs25+g==
X-Google-Smtp-Source: AMsMyM7MLI40Iy3R2HZvtqnUxgbgUMiou0kBc/wNNyE+pA7d0aC//esy4rrsRm2ejyOyrIpOAHrfIA==
X-Received: by 2002:a17:90a:f414:b0:212:cacf:42c3 with SMTP id ch20-20020a17090af41400b00212cacf42c3mr79536832pjb.198.1667994677913;
        Wed, 09 Nov 2022 03:51:17 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:51:17 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 09/13] zram: remove redundant checks from zram_recompress()
Date:   Wed,  9 Nov 2022 20:50:43 +0900
Message-Id: <20221109115047.2921851-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109115047.2921851-1-senozhatsky@chromium.org>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
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

Size class index comparison is powerful enough so we can
remove object size comparisons.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 383d967ef4c7..67b58f2255db 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1725,9 +1725,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 							comp_len_new);
 
 		/* Continue until we make progress */
-		if (comp_len_new >= huge_class_size ||
-		    comp_len_new >= comp_len_old ||
-		    class_index_new >= class_index_old ||
+		if (class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
 			zcomp_stream_put(zram->comps[prio]);
 			continue;
@@ -1750,9 +1748,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	 * that would save memory, mark the object as incompressible so that
 	 * we will not try to compress it again.
 	 */
-	if (comp_len_new >= huge_class_size ||
-	    comp_len_new >= comp_len_old ||
-	    class_index_new >= class_index_old) {
+	if (class_index_new >= class_index_old) {
 		zram_set_flag(zram, index, ZRAM_INCOMPRESSIBLE);
 		return 0;
 	}
-- 
2.38.1.431.g37b22c650d-goog

