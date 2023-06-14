Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B6073016B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245462AbjFNONv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjFNONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:13:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB271715
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:13:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3d29cfb17so27169695ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686752027; x=1689344027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=atkhLsJk4kYIR051jZUJsqhyVSqD17cKG1dfd3E+c04=;
        b=QtPPdAz8+r7dt+3azArNI+jobqYcT5F/K5n1989N0B9h/dF9O0THNdPrbOgk401sv3
         5J4d7liK3gdJtZ9cdamd5TvGz8tspTsfmQzlUei3suVhQyLyrh3DkFHy4rVZlSHdPsr5
         YEErmKXQc4bgS24oNRScFjmmHUyABKOtOISkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752027; x=1689344027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atkhLsJk4kYIR051jZUJsqhyVSqD17cKG1dfd3E+c04=;
        b=XG6KApn9iuyd6vjR8SCYSO+ngjfV4HfjXILsPiZRzBfIDg4QJhgaz+8aRyZDELd1Me
         A9EQ8/3eRZaqA+yhE5N2KOPfd6LsRxr/6Xc3+Eizm71tjztwrQigH4IS2KW8UFpajIj1
         8DVNBwrQqIn8FEcAGXkNMO4Bv9aAM9yJl33wwA8MMrXDtq0EXNyU2EmLzoPsIFaN4byA
         Ry5KEae3Il6cH9p+eG+sRyBLUB3W0SVCZGL9DgFmGv0crgFGt7hc1Q2CwNQ4mCj3PzSO
         kAzTEwoezYXPVKZqdz7GkOdbbwULd9MD2hVsrZAmnlzu92O1dw0uVtGHTiA7m2PNNVGL
         s+KA==
X-Gm-Message-State: AC+VfDwOtC7PiRMG8ZwD15c4eaXFNH5WEZ8VwcumO0zlM7fUchKe1JJJ
        EEXy34FBlCF20tA+whrJO4K2tg==
X-Google-Smtp-Source: ACHHUZ7c5hnOfemkMscvWj+eorrnWGExlzE2F7LXwlInsGAGaYBz8d88ceGN6cOoTGXRuvmWq7tQGg==
X-Received: by 2002:a17:903:124d:b0:1ac:aba5:7885 with SMTP id u13-20020a170903124d00b001acaba57885mr14900116plh.47.1686752027301;
        Wed, 14 Jun 2023 07:13:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:e1a3:812:fed0:eeab])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f55200b001b042c0939fsm12226648plf.99.2023.06.14.07.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:13:46 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brian Geffon <bgeffon@google.com>
Subject: [PATCH] zram: further limit recompression threshold
Date:   Wed, 14 Jun 2023 23:13:12 +0900
Message-ID: <20230614141338.3480029-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recompression threshold should be below huge-size-class
watermark.

Suggested-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1867f378b319..5676e6dd5b16 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1753,7 +1753,7 @@ static ssize_t recompress_store(struct device *dev,
 		}
 	}
 
-	if (threshold >= PAGE_SIZE)
+	if (threshold >= huge_class_size)
 		return -EINVAL;
 
 	down_read(&zram->init_lock);
-- 
2.41.0.162.gfafddb0af9-goog

