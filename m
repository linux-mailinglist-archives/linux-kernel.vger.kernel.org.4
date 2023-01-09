Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDDE661CC3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjAIDji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjAIDjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:39:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDA4FD01
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:39:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y1so8183720plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 19:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEbqzpe3o1M34E1TK5SG9WYfEV64gTPdXoQ0O7E/LWQ=;
        b=WQwcvUaQg4HJvYV5wdvB976BQcDb2ieJxDOiGtrty58I7ls1CoGJAe+vD3cCTZp0mS
         MPzdxEZgAGUlrS6cKJYGVF2aAESwfwE6LZMlPD5NWQcc0HUDKXcHX6v7+prbsOpr1QtL
         IYdJ1jZd59PF3ZX5SIaIzmqcHL1J296Zz2HzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEbqzpe3o1M34E1TK5SG9WYfEV64gTPdXoQ0O7E/LWQ=;
        b=g/w+uPJPU64XeOP6NcEbzJv96avH5TYV2K9OFaD4mGvbFfsFYdePfOG/KaeS80wXVR
         xUYRWQiYAEJYp1uEc4uNRPEAz58ceDQpB0kjvgLjKlJL3nlg44lgk/YGYNnnn8Qdi4Rw
         1JXD3qx9aF5RZEXxHez17uT4zm/gUds0YQTgqx2UVEsH4Xo2t1IgXwQ7KNzRmL+8qOep
         ccWtyISgWWp7V/Fm8RstfnpB6UPwnuvwQ4bKWpKjamEc0CSEmUpo+xDGhazx/nXThk/T
         nMUejbAgqfoXXfOaQ34dhprP+D2manQcfniJo7k7HGKAHuWi8Q8AM5GwKafEht+H/mZN
         EPLg==
X-Gm-Message-State: AFqh2krhIROuWkfUUs9QUoMsaWwRBc20r8gNh8kV/Wr6HslfpPO/+oME
        y9XgpjumkIiCOn2+oKMPLJuPOw==
X-Google-Smtp-Source: AMrXdXuHYjjQwDymUilhCJ/UhceAK/SDhGEV9/RSE9nacPsscyxB7o9e8XDsnKmXaH8nblH8oShCVQ==
X-Received: by 2002:a17:903:ca:b0:192:9fda:7665 with SMTP id x10-20020a17090300ca00b001929fda7665mr33824571plc.53.1673235553783;
        Sun, 08 Jan 2023 19:39:13 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5ec1:f8d2:ce47:7ddc])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00189529ed580sm4896685plg.60.2023.01.08.19.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:39:13 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 2/4] zsmalloc: skip chain size calculation for pow_of_2 classes
Date:   Mon,  9 Jan 2023 12:38:36 +0900
Message-Id: <20230109033838.2779902-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109033838.2779902-1-senozhatsky@chromium.org>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
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

