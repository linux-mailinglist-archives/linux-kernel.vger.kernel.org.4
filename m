Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64CB622AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiKILvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiKILvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:17 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D073120B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:10 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g62so16446193pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx/j6NFsqMiBfWUe9MAE1kY4nyT9uBWrAowemE/mjWM=;
        b=PRtW06hqJjnQd/kkrH5EdBvx+MeI+nT/zaRSXLQ34yFFZSjedoVDMt0ITBHY9lEJZL
         zv+rYGTJbr/jbll1pBLICDHoduO6RLnRUwbZgzJ4UPSTNt9sozFtY/xW98UZAXvjbMTU
         R6GqKRwlu/wYEXfZCbhs9SLFZ3xhLlXZm6oO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx/j6NFsqMiBfWUe9MAE1kY4nyT9uBWrAowemE/mjWM=;
        b=UF20SpYEhxMp7TEtADMjmrMrgPjyGXR1iqxPosJzZd2hWdolmiDp59JH0BHhlf5+FL
         q9dlYy4fP8/yNyMVguhNvN+O7beXyJIDahA16l6cl391WlTMN8UCefS/FRc4Oc+nmjjA
         8OnqR1LzpDoPmL3vk09c0p/icOUK4SW8Gc13RDT1K0IzbJNy/8g0ITOvJ/rX85AAyZ74
         b1CP/5SabSjSq40u1jqYTSnG8whfG3IpKIJwjAosCYRvZh16FqmRTXNmy+ee0GNm4BFV
         2J2fPDhLemiD8ed1LRpX0dBtOiXwl8nFKBhB8BRI9XSzud/EgFD3MHC5p7nahRJ0wO3M
         2UxA==
X-Gm-Message-State: ACrzQf0igTZYUfnhlDVsrxDvT9pkvI/HDadfAdbRKlYKGkrTBxBwg1br
        hl8CCvC9wpFPhQEPlMslCGi2x7FxON+OGg==
X-Google-Smtp-Source: AMsMyM4QC8IeHoMzd41nyT4jdl6i2t22PgNfGcqVzLXa+joYnG9IWHujjdaIiEn2O1jPLNxZ/+ziUQ==
X-Received: by 2002:a63:f755:0:b0:44b:e438:ef2f with SMTP id f21-20020a63f755000000b0044be438ef2fmr52609729pgk.314.1667994670169;
        Wed, 09 Nov 2022 03:51:10 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:51:09 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 06/13] zram: Clarify writeback_store() comment
Date:   Wed,  9 Nov 2022 20:50:40 +0900
Message-Id: <20221109115047.2921851-7-senozhatsky@chromium.org>
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

Re-phrase writeback BIO error comment.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 560e2932021e..a5d2ce0bcd5d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -772,8 +772,12 @@ static ssize_t writeback_store(struct device *dev,
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			zram_slot_unlock(zram, index);
 			/*
-			 * Return last IO error unless every IO were
-			 * not suceeded.
+			 * BIO errors are not fatal, we continue and simply
+			 * attempt to writeback the remaining objects (pages).
+			 * At the same time we need to signal user-space that
+			 * some writes (at least one, but also could be all of
+			 * them) were not successful and we do so by returning
+			 * the most recent BIO error.
 			 */
 			ret = err;
 			continue;
-- 
2.38.1.431.g37b22c650d-goog

