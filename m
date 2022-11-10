Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B229B624468
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiKJOel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKJOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:34:39 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF5FCC6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:34:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o7so1676154pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4naR2xBcDe88j8RrDO7aS/st7Z9xD3TqZu4x6dohykE=;
        b=F0UMYn5USPzsikDqy/bJvgjGt7aKcJjJ2LtVWwGGQCzs4g1wcqpVTvDf/UJs3CernC
         dK4b+fU7C/FenkqEvXqNiKo+CQ5C4gXBLc0jSlCKj97DhN0O+Xj0WK4ZfLlbV3CONKhl
         c5hnJ6RQ0FutnInUqXLYQBN0ANb4cEMbFVkus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4naR2xBcDe88j8RrDO7aS/st7Z9xD3TqZu4x6dohykE=;
        b=MYAOZkuf2N8PTGP8/LAaDa64SJInCS7KqbkRrmY37lpqM8LDV9ClK61oclQ6gN1uKo
         43vrQiWTVHCDXGQg4TdXf2MFteb2DNir3wDQbrWHbUXbuTaUHau/jNWT8wNTO8lrYBH/
         La9SZ5eW50+jOTSAQVMOJ8JfXG3mipN0UISH24jyYauFTol7AOYNA2VfD4dWB9+VRcA0
         PoXgqnyTA+niAE9TghkcuX6cg0YPC+ilTI4Jz6CsuRmXreOpDfA+E98EnGfVEGGUxx35
         /n12m0DUnqck83NmZu0QOaZNP0xI+fXC5Z0fekK4bLHnD9X6qdnHcN/m8I5mfBkqG3h2
         tcFA==
X-Gm-Message-State: ACrzQf04g+Ym6U49tUvwbCHvYzfXdnPhWzVIHaql0ApXOrK5OTh24/Rd
        8DpdEMqbT1/rX2EKE2R7vMr20w==
X-Google-Smtp-Source: AMsMyM4q3FQariaZiCL4NdNu4LaNek6ASbXwbHj0w2pktetZMHoN12rDx3FnR1VA3Mu6E6NsSjdBkQ==
X-Received: by 2002:a17:90a:c984:b0:20a:ac88:d39d with SMTP id w4-20020a17090ac98400b0020aac88d39dmr81779176pjt.13.1668090878111;
        Thu, 10 Nov 2022 06:34:38 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6ff1:37e4:b5b3:487e])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b00186a6b63525sm11234655plb.120.2022.11.10.06.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:34:37 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] zram: we should always zero out err variable in recompress loop
Date:   Thu, 10 Nov 2022 23:34:23 +0900
Message-Id: <20221110143423.3250790-1-senozhatsky@chromium.org>
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

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 171eccc2249d..9d33801e8ba8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1891,7 +1891,7 @@ static ssize_t recompress_store(struct device *dev,
 
 	ret = len;
 	for (index = 0; index < nr_pages; index++) {
-		int err;
+		int err = 0;
 
 		zram_slot_lock(zram, index);
 
-- 
2.38.1.431.g37b22c650d-goog

