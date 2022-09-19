Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8725BC18C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiISCu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiISCuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:50:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8129A272;
        Sun, 18 Sep 2022 19:50:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w20so14607225ply.12;
        Sun, 18 Sep 2022 19:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SYi7IojHEftdTdWXx08akJ87fP9b+6eRrKThed0efXo=;
        b=jZLuRZsOmzoK8mtzQK0fqW4XTKnXD2wxSeexLtUpGJVEzpVhct+KQIaE07uGfLUpC/
         ECxnFr4jGJJOb6poC7tIQBVcdaCWEXIeBnXLz/of67zQ9hVfCPTUiChWuROUfbDtApaE
         Vn/YftSGoOOErtz3BUkLlOf0lPXDvCVzijVGrJuUR5SfMHHJZHyqm5XVgso/Ef5xgEdi
         BrX13BVxYb1hCwgm+10636BoqL/Crb2iYcEeEGIPLJhOosdx04v8oIFmDYS1YP06sL7D
         Ql73rHUuv1PWjuv7iHQrvrSp1iLZ/NGGUNqozLa1AR41t4MPCBnQlZW1KPMNplfsQ1h3
         jcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SYi7IojHEftdTdWXx08akJ87fP9b+6eRrKThed0efXo=;
        b=8CxGQNDP+ZJEhiY7pOWP2olQLBbRiU1UrsYMP85yVuDdN5+rNVrYm0ZCNAHjrziQtK
         1VYYGO8r5XUONRTcSvAsxqaY2J3BoAB2X7WRPIxUq15e7q3uyGOJH0T9evg1Ien8/vco
         x5NBFrRtpYi34EEOQj+qAtCtP9QaWF8+qdF/pq8c707QnWG8rdRZ/yTthYKq1ge0cqyz
         CP9zvcPeVxkKKGGFNYB8O8Q7th5Bg5Uqq7ekoDDmDu04oSQdRSGKas+AlTXPcnFEC0z+
         aRdFOzsvRl44/zJm4+8+naYD3zL6/JJwST/iw6UFQl94AZG4xZuAd9GfDQkFARN8xDoL
         GT3Q==
X-Gm-Message-State: ACrzQf2vKbzvAWrv1tLeFaPBhz+Xb6msxJe6ypGa58f8AubE1EUZVyqx
        qMOiczaIc7gT+NN2VA5Yr/CuC0m9AD0=
X-Google-Smtp-Source: AMsMyM5gN2JcbwAOjMNxBDlRJPzcBMNc5GTC9EA/J/5Tb2PQsKvXZi2zgBHFsCQ8vMWyStdiB+WZ4Q==
X-Received: by 2002:a17:902:f708:b0:178:9b70:310b with SMTP id h8-20020a170902f70800b001789b70310bmr4737952plo.65.1663555819026;
        Sun, 18 Sep 2022 19:50:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a3d0900b002002fb120d7sm5549820pjc.8.2022.09.18.19.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 19:50:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     minchan@kernel.org
Cc:     ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] zram: use strscpy() is more robust and safer
Date:   Mon, 19 Sep 2022 02:50:14 +0000
Message-Id: <20220919025014.211268-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index eb021db21ddf..28b17c82c27a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -499,7 +499,7 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	strlcpy(file_name, buf, PATH_MAX);
+	strscpy(file_name, buf, PATH_MAX);
 	/* ignore trailing newline */
 	sz = strlen(file_name);
 	if (sz > 0 && file_name[sz - 1] == '\n')
@@ -1031,7 +1031,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 	char compressor[ARRAY_SIZE(zram->compressor)];
 	size_t sz;
 
-	strlcpy(compressor, buf, sizeof(compressor));
+	strscpy(compressor, buf, sizeof(compressor));
 	/* ignore trailing newline */
 	sz = strlen(compressor);
 	if (sz > 0 && compressor[sz - 1] == '\n')
@@ -1979,7 +1979,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
-	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
+	strscpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
-- 
2.25.1
