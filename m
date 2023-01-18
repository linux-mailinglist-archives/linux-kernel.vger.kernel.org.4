Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE09670F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjARBDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjARBCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:02:11 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFB53E63
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:52:28 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jl3so233535plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlEuvLJ1OIwhsVr6jP4j+nVp1P/tzWBP4lAYnG/eYgY=;
        b=TLu9c0Cj9B2z19rRraJKbiywIrmYs/BVdE12dMxlvW8Y149yooSO39yxohc5u8cq2d
         iUC1z81ahFo78NQK8aD1I9A9YnnL2f69pBet4g2EhZAiqQHWUM3UP/Cm/nQMw5XYJU1D
         himUcbF+wJEhI9kS2XeqnPuGlUxxUFPHNZCXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlEuvLJ1OIwhsVr6jP4j+nVp1P/tzWBP4lAYnG/eYgY=;
        b=cHVPa+DUHoTThxVUqPSes177OJAelT2UzQ5+qOqEpDpAVmTpTnonIfmqtFG27E+z5s
         IYXgkAALEYHMUa5t1xgQNegCgoDlijdgrXk9ssp4TCR3ZLnT2Poylazg4WqHqWeUrjEe
         uGBZ1dIXiS5XEhnn5TGLi9TzTgyaISPRWmf0bBSvHSvsLtoepXldYspNyltL2lfcSIhQ
         7aQTFYGxZSEiiFxPfQyN5AShpECIik5E4j6BY0jB7MC6n2WeiOOPuynh8fZSfIHygLEJ
         cxe8D9c5xV/8JA9BCgIB9VQ4MWcWe6Z07XyQ+sdHnC0jUkziA7y2qnaWsxqDZCdBcUSF
         yDEw==
X-Gm-Message-State: AFqh2koiKouAwK9zod40noTQ22SiOJkXDPVAINOP7t5ciAslptT4Syvl
        EOhcA8rJGeIpnz19l2dXUAHrXw==
X-Google-Smtp-Source: AMrXdXvg3Wmcxlr+zxIzbctf0szk1Alr8VFtzl74qmArJYWCAlwZt9atsHWVsv5Y4QATS8R33CZw/w==
X-Received: by 2002:a17:902:8d94:b0:192:d9dd:167d with SMTP id v20-20020a1709028d9400b00192d9dd167dmr4633379plo.43.1674003146107;
        Tue, 17 Jan 2023 16:52:26 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:10f3:73a5:7e44:adbf])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b00192f4fbdeb5sm8351461ple.102.2023.01.17.16.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:52:25 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 2/4] zsmalloc: skip chain size calculation for pow_of_2 classes
Date:   Wed, 18 Jan 2023 09:52:08 +0900
Message-Id: <20230118005210.2814763-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230118005210.2814763-1-senozhatsky@chromium.org>
References: <20230118005210.2814763-1-senozhatsky@chromium.org>
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

If a class size is power of 2 then it wastes no memory
and the best configuration is 1 physical page per-zspage.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index effe10fe76e9..ee8431784998 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2287,6 +2287,9 @@ static int calculate_zspage_chain_size(int class_size)
 	int i, min_waste = INT_MAX;
 	int chain_size = 1;
 
+	if (is_power_of_2(class_size))
+		return chain_size;
+
 	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
 		int waste;
 
-- 
2.39.0.314.g84b9a713c41-goog

