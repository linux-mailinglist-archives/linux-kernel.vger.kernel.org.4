Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957A15B5D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiILP32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiILP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:29:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0524BDD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:29:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso8510315pjm.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=CPqjDBRnfd3YUUYjuwzH1YFz7BdjyfL6bOnI/3LB5Bk=;
        b=hIYiAqgrhPuKXd5jVuPdYSi5Zizxj4WGgX6YJ2Oh96Mtz4pq2+QH5so6OLdi/7M2Bn
         3UG82Fno3pnL7Pkj6jWxE2NNfpvvGrTA2oHiKOd2jgC0YmcPxysBoYBI/QbllbhMceAS
         Yq4gYXpNdceW218uHLM738DLTZg5il7HIaNDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CPqjDBRnfd3YUUYjuwzH1YFz7BdjyfL6bOnI/3LB5Bk=;
        b=2U0l8V0Of6GfBuX7bhDltZGkfLVoo5Ro6PJqZBi8ynz2Okm/bcSAWN/JTwK6qF7ACB
         2SLY1vt6EpCE/FudVCLVljiZ2WoEQiDNZ1216fSeR22C7uk7gnSUCL4DZt5erXBWzscz
         q1WPH0+6Og4EJX4jqUXSgLYFO+kI9YhpPPoTOF7a+7ojASigRT9VpwFGWgnXKVIZqiWq
         wQ+/aHHsP06H/qW8ZNO+GCgvRGEXUPgxfNGtZJh/c1mNmeDAnpZFRlecsqPC8fodEzKK
         2+XEkNw056HLtavDN8C3VFt5cexXyCLpZs139PH8k6G7jkg9PHXmDLTKqZv8QJlkPI61
         Fcnw==
X-Gm-Message-State: ACgBeo1PsD9RKfcBuUR87lGxYopyUg5kyBiCxyAu9lx2UeB0TL44tRVC
        q5vO2nRUBIiinN/Bii12aNU1VKiU/XBbDA==
X-Google-Smtp-Source: AA6agR70svDQ1mN9/etbL0P8c90uZL97hW9UfLOcxZ4CDtx4b4tpOYbVDQK88XcBUyKNyaJUG3vHXw==
X-Received: by 2002:a17:902:e947:b0:170:d739:8cbe with SMTP id b7-20020a170902e94700b00170d7398cbemr27884626pll.141.1662996563948;
        Mon, 12 Sep 2022 08:29:23 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:e064:d5ac:4dae:9920])
        by smtp.gmail.com with ESMTPSA id l72-20020a63914b000000b00419ab8f8d2csm5748847pge.20.2022.09.12.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:29:23 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] zram: do not waste zram_table_entry flags bits
Date:   Tue, 13 Sep 2022 00:27:44 +0900
Message-Id: <20220912152744.527438-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zram_table_entry::flags stores object size in the lower bits and
zram pageflags in the upper bits. However, for some reason, we
use 24 lower bits, while maximum zram object size is PAGE_SIZE,
which requires PAGE_SHIFT bits (up to 16 on arm64). This wastes
24 - PAGE_SHIFT bits that we can use for additional zram pageflags
instead.

Also add a BUILD_BUG_ON() to alert us should we run out of bits
in zram_table_entry::flags.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c |  2 ++
 drivers/block/zram/zram_drv.h | 15 +++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f3948abce2f7..07913bcdb5c2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2449,6 +2449,8 @@ static int __init zram_init(void)
 {
 	int ret;
 
+	BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > BITS_PER_LONG);
+
 	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
 				      zcomp_cpu_up_prepare, zcomp_cpu_dead);
 	if (ret < 0)
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index b4eecef2a11f..2b50f0521bd3 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -30,16 +30,15 @@
 
 
 /*
- * The lower ZRAM_FLAG_SHIFT bits of table.flags is for
- * object size (excluding header), the higher bits is for
- * zram_pageflags.
+ * ZRAM is mainly used for memory efficiency so we want to keep memory
+ * footprint small and thus squeeze size and zram pageflags into a flags
+ * member. The lower ZRAM_FLAG_SHIFT bits is for object size (excluding
+ * header), which cannot be larger than PAGE_SIZE (requiring PAGE_SHIFT
+ * bits), the higher bits are for zram_pageflags.
  *
- * zram is mainly used for memory efficiency so we want to keep memory
- * footprint small so we can squeeze size and flags into a field.
- * The lower ZRAM_FLAG_SHIFT bits is for object size (excluding header),
- * the higher bits is for zram_pageflags.
+ * We use BUILD_BUG_ON() to make sure that zram pageflags don't overflow.
  */
-#define ZRAM_FLAG_SHIFT 24
+#define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
 
 /* Flags for zram pages (table[page_no].flags) */
 enum zram_pageflags {
-- 
2.37.2.789.g6183377224-goog

