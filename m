Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94656162D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiKBMkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiKBMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:40:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6A29C96;
        Wed,  2 Nov 2022 05:40:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e129so16123308pgc.9;
        Wed, 02 Nov 2022 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed7Wml//j7Y9RMu6dwoeo3Qg5iNedwfaG5B6AyQm750=;
        b=gAanQ/I5GZWf/GD2GgUisok3GodxFb+eps6OU6Z/4JyUQaaYCuWdK6WEsDbnBOLtkD
         vDGapcAhYw+6EoKuyzJYmbtSpHdV8MCPUKPATDWF3ilMXEwPDMfl5KiO+wy05QMrxkpl
         4L+HVD5kYAJXYcRVhkrowzyvjIwNT5PtJqrMwCHgWy6WBniWMum5yF7pBtleVo7ZdGcg
         9+p0p5HB1zc2ZD3Babl5Zpz1001sAAJMTEuwHSNQhHZpygOHGb2LmmDoWPnGYTVzVGtI
         icU5SKNrrQNAWxUQJLpHwMAkO0TVef1lrm72o8++DYCWataDe11wi/z70n9ajbdPReq8
         6fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed7Wml//j7Y9RMu6dwoeo3Qg5iNedwfaG5B6AyQm750=;
        b=Td5NTDVhZ5OvjBv67oz0df95ZRsHqks9Lvb+NmIBQ7f8rKAGEM05DQWuRorCVgYAaJ
         lqlAfF+WAC9UR7AnUXiOqfeeXpg3u3xmaHAMfIEGqcOBCQwMslM51Vyu4wcl/cT+aHd+
         PLdW0hEB/pJCyF1oY1793EIJCbkFjgVzZevxNShBg58LlX3UXkDSkOJPzTaxveeNSuPz
         JK1eJ9PTNBWK57IUDOnQr0s61LnxPvWkcrOGHR79QI1b6ZBhP4S/hj9k4NqNyHXCAvoI
         xbJMUZKYGH8baVwg7ZUX/vNUDw+AsTmvXxkpzGQT8+nFMPvKDpeRWUZ8LwgdYM6jSGNq
         Sl0g==
X-Gm-Message-State: ACrzQf1+Cw1pNfhf9iClOa2+Zv+UvBuxM8j6TyLlDAzSG0QdYiCdJnRL
        TrZAazHFbBg+krmqn9K0HKM=
X-Google-Smtp-Source: AMsMyM5iOWdV2pPfyqmRrmntgtuRBc+0iKBhJE/t8V/GOwvmmrjb57B92hIyvaFthfSLBoCHCs48iQ==
X-Received: by 2002:a63:da4f:0:b0:43f:6af:74ed with SMTP id l15-20020a63da4f000000b0043f06af74edmr22039169pgj.290.1667392815462;
        Wed, 02 Nov 2022 05:40:15 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id f19-20020aa79693000000b0056c003f9169sm8339360pfk.196.2022.11.02.05.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:40:15 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: [PATCH 2/5] block, bfq: do bfq_set_next_ioprio_data() after setting sync mode and pid
Date:   Wed,  2 Nov 2022 20:39:53 +0800
Message-Id: <20221102123956.230-3-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
References: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do bfq_set_next_ioprio_data() after setting sync mode and pid for bfqq
in bfq_init_bfqq(), which can print real pid and sync info for
bfq_log_bfqq log in bfq_set_next_ioprio_data().

such as,
before: "bfq0A new_ioprio 4 new_weight 40"
after: "bfq203S new_ioprio 4 new_weight 40"

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7a15b2689cb8..e00c67a01b09 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5509,9 +5509,6 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	bfqq->ref = 0;
 	bfqq->bfqd = bfqd;
 
-	if (bic)
-		bfq_set_next_ioprio_data(bfqq, bic);
-
 	if (is_sync) {
 		/*
 		 * No need to mark as has_short_ttime if in
@@ -5537,6 +5534,9 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfqq->pid = pid;
 
+	if (bic)
+		bfq_set_next_ioprio_data(bfqq, bic);
+
 	/* Tentative initial value to trade off between thr and lat */
 	bfqq->max_budget = (2 * bfq_max_budget(bfqd)) / 3;
 	bfqq->budget_timeout = bfq_smallest_from_now();
-- 
2.34.1

