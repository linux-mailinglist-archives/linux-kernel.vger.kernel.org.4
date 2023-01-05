Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0BD65E524
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjAEFfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjAEFfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:35:38 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA6C5132D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 21:35:38 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a184so13786447pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 21:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvvS87mfgDK3AanjNOiSdWY479pGlUeMdWmydMONAbM=;
        b=ZOigF9gP3ox2wQ1zSpV804cSF8sMjwowDtxNQg8uNjyVvXHeLqggLSqwx1tRbjrl9B
         bnJrcbil85V6vAirx2XZPoC0C8R/EU2ZbD+54woGiRCo9GR8JP4hAMJkbFPpQyAk6EhY
         U7FslFAbJPenKL019W92H94OSDxTBVtGcc3wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvvS87mfgDK3AanjNOiSdWY479pGlUeMdWmydMONAbM=;
        b=P4HT3Ih5sLVbh0c104uhJe1Ohv4oQ7SZ9gzC2SlYdmiWe4EsM56d+W4zKWLXG3fdNj
         dmFWe8/EDKSr/Tw6sIghq99nK6SX1YqUfxe7rMPvNUTsR/cY6cS9wOx1yx8OIwcy+omh
         AwVeyYKjtNhxB98iYZAgP6cqcYBLph68w7eI7uVgteDn9OZCyFUork8ZGa4ZV+98y+ir
         qkvVaw8EAO4gLwWkzCUs5bycsN+ChCk5gL3a4Vn+oXhMMuHp0M27JDO061mvMFODLbEJ
         ERWbazj1BybsXHh1cVB5GUIP7j51TpO4ZUNn4tPHGxL3rM0LfrGPyQJaZjQx0cuLo9H0
         RBCQ==
X-Gm-Message-State: AFqh2krySk0jj7j/JzFOp2O6GoqDSSwN9r1CEt62acEprbOQqAXjzutE
        4Yb/iG4ZCyFC4Ke3ZkQF5imlRQ==
X-Google-Smtp-Source: AMrXdXs7ikuwn0bVOye9xIcYyunW3Of68phhtfVO0eCIT+czMyzUJEhFuS9IQZf97Bw1n6CWls1t3g==
X-Received: by 2002:a62:d45e:0:b0:56e:dca8:ba71 with SMTP id u30-20020a62d45e000000b0056edca8ba71mr43482025pfl.32.1672896937609;
        Wed, 04 Jan 2023 21:35:37 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:da84:4bce:bb29:7dea])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b00577c5915138sm2036855pfi.128.2023.01.04.21.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 21:35:37 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/4] zsmalloc: skip chain size calculation for pow_of_2 classes
Date:   Thu,  5 Jan 2023 14:35:08 +0900
Message-Id: <20230105053510.1819862-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230105053510.1819862-1-senozhatsky@chromium.org>
References: <20230105053510.1819862-1-senozhatsky@chromium.org>
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
---
 mm/zsmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 959126e708a3..9a0f1963b803 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2290,6 +2290,9 @@ static int calculate_zspage_chain_size(int class_size)
 	int i, min_waste = INT_MAX;
 	int chain_size = 1;
 
+	if (is_power_of_2(class_size))
+		return chain_size;
+
 	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
 		int waste;
 
-- 
2.39.0.314.g84b9a713c41-goog

