Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C545627475
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiKNCOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbiKNCOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:14:35 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911FAF037
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 18:14:34 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y13so9757633pfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 18:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwe/CGewB3ONcgBOsjiiofH3aqvCPDJMHiAaI9g1bPo=;
        b=QfydQIAZ7OUfGESB844uyKVezkoPzk9pGxEJSJeEcF8MzBqpkORyurGqSnjKDgGloJ
         8acIS/W4obb/bmXsTuOdcBsJkfSES3o5VE8dBxYme+m3Ec18b6rW+1z+jmfemrfPC6NG
         g3VDmOxpG83xrOI5cot7fgFOFlAtcg1wEl06M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wwe/CGewB3ONcgBOsjiiofH3aqvCPDJMHiAaI9g1bPo=;
        b=DSiCSA0BVOukP2Wua+nSVdw6NevclBCI822Aztnr9gap425voTKc1YAULoweCkrrfZ
         B86GWwkCL1t3Iai+D+W0KbNKZ1xVCTojyWwmp3wyKB1VKnPiGVoalgi/Z2ly5PAapLJD
         ZL6prAMyAXfAbFUlr2zHABh3+lexh97J7TUKSoZ1KaMWgINe5ywCP4Y44GO8WT5rz1zS
         EH8vQ7J3hY3KlZkjEWkXLXDBd+yGUtxPPXj9CNcCwYx0kM9OhUK+EO49bi7OGSfYuyZV
         ExBRGn5k6SzKma5m07/x6wvN6cP4iYEniiL8ymhNEGzxLgDqCXGg2ffJIsGEaemPGh4U
         R/gQ==
X-Gm-Message-State: ANoB5plV8dwei4kqzgkvxJIoNq0Kzy0al88wC1jQ474ELVbHgMmU517X
        peokrBmbFJKko9ROkajiY56LSw==
X-Google-Smtp-Source: AA0mqf7AbZHqarqTcstWVSy2kvTab7yPcO0uhz/YyOOrJfvuuk4D/Hz987snCA+m7ZxIXS6VIDXjnA==
X-Received: by 2002:a05:6a00:10c8:b0:562:3acc:7a63 with SMTP id d8-20020a056a0010c800b005623acc7a63mr11978799pfu.51.1668392074077;
        Sun, 13 Nov 2022 18:14:34 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:add6:3280:f7d1:25fc])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b0017f592a7eccsm5868740pls.298.2022.11.13.18.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 18:14:33 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: [PATCH] zram: explicitly limit prio_max for static analyzers
Date:   Mon, 14 Nov 2022 11:14:20 +0900
Message-Id: <20221114021420.4060601-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109115047.2921851-5-senozhatsky@chromium.org>
References: <20221109115047.2921851-5-senozhatsky@chromium.org>
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

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9d33801e8ba8..e67a124f2e88 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1706,6 +1706,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	 * Iterate the secondary comp algorithms list (in order of priority)
 	 * and try to recompress the page.
 	 */
+	prio_max = min(prio_max, ZRAM_MAX_COMPS);
 	for (; prio < prio_max; prio++) {
 		if (!zram->comps[prio])
 			continue;
-- 
2.38.1.431.g37b22c650d-goog

