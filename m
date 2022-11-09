Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56300622AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiKILvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiKILvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:21 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65181317C2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:13 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f63so16030088pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtxYsj6E0bxgea4oeDPQD6uPBfUoT8WqWkKOxHgnlE8=;
        b=BhhFMs1ML3PGfZKVrN186Q97ul+1G9ZHCoV+RVoLQr8lz4T5uyEB8FVWXqOd2MPEJV
         WXRNdPNw5zFbek9OBqFeG95mqUcpvBVSA9OgxkLNbzSfXs/gtXDE0iZciXnFTnO7xbEx
         VVL2cpPMLshWAYupNPDK+0SFTzwaSKVuxvrqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtxYsj6E0bxgea4oeDPQD6uPBfUoT8WqWkKOxHgnlE8=;
        b=GvhpGOkqJVb5zpkVOWB+sa/330gwKTAJPQAcKLaUZtqsRZBlJlK3P7uB1L/xWy61pR
         GB3v6UfuUC5e2R2i2YVYEg5dSrMG416aqG98xscP3VXqxCjb37017buvomnTFwyF3m6i
         /CdjNDTehCyVkUKUPkOuRtYJMELE1sOSlJ7FLxinY6I6h6x54I05fzKzrwd9Hd+jM/by
         nsCqt16PlPN65emMfEPTsG6ervuILv8xlBj3ajRZPB9T6ItRLEyW2Xuz37eg/oVhvTTA
         zKGt5daWjsy2W7D9CPZtwAGx5XQjFQVTmlPwKYF3fjxr5GVfdDnGob5wtzNMZqzZAJzJ
         T6Ag==
X-Gm-Message-State: ANoB5pnfjd9atNGcfnf4cqMNh/OlG52wboi3/ezlK3qlemGgGnp7irPI
        saUeum7FiYhNznQdATiyrlUtrg==
X-Google-Smtp-Source: AA0mqf5O4dQwnhqX2UIonKGx0YaOrk9LZS0ppNcJn3lPaVyD2Siq7naWMzUGxAKXAAnyXSHio9Vedw==
X-Received: by 2002:a65:6846:0:b0:470:8e8f:fe89 with SMTP id q6-20020a656846000000b004708e8ffe89mr5699996pgt.172.1667994672770;
        Wed, 09 Nov 2022 03:51:12 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:51:12 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 07/13] zram: Use IS_ERR_VALUE() to check for zs_malloc() errors
Date:   Wed,  9 Nov 2022 20:50:41 +0900
Message-Id: <20221109115047.2921851-8-senozhatsky@chromium.org>
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

Avoid type casts that are needed for IS_ERR() and use
IS_ERR_VALUE() instead.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a5d2ce0bcd5d..9561569273fe 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1545,19 +1545,19 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	 * if we have a 'non-null' handle here then we are coming
 	 * from the slow path and handle has already been allocated.
 	 */
-	if (IS_ERR((void *)handle))
+	if (IS_ERR_VALUE(handle))
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				__GFP_KSWAPD_RECLAIM |
 				__GFP_NOWARN |
 				__GFP_HIGHMEM |
 				__GFP_MOVABLE);
-	if (IS_ERR((void *)handle)) {
+	if (IS_ERR_VALUE(handle)) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				GFP_NOIO | __GFP_HIGHMEM |
 				__GFP_MOVABLE);
-		if (IS_ERR((void *)handle))
+		if (IS_ERR_VALUE(handle))
 			return PTR_ERR((void *)handle);
 
 		if (comp_len != PAGE_SIZE)
-- 
2.38.1.431.g37b22c650d-goog

