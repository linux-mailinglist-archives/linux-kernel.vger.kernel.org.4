Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8276C5B539B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiILFiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiILFiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:38:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD011B782
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:38:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t6-20020a17090a950600b0020063f8f964so3565579pjo.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FCDrifC5IjqijXV6e18komh4Y6rdr6j1i7EyaPa4Jrk=;
        b=bVjPF3LkmzOlL6cee9+hacmXazQaezgxu5kP6ipASsZxIcTk0xHjXhEMuNcEfCGVLn
         vr5sqviyzogt6mDgzl2GyKRn4JAHUGz3gGg7emJm4+FDPF3EMDrNeJ04WrY2kAjVoDe0
         /CzDjEVEknJKMb5w058tO0x6UCfS4kkaCoFTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FCDrifC5IjqijXV6e18komh4Y6rdr6j1i7EyaPa4Jrk=;
        b=3TxkLs9r/Yzpz6R6XMNukEjI6+usGnOc3A4jXrhVqZkgBB+D3tj+v8VOPQ1N/2O3Re
         ePYOlFG3cP/M2TuPNTtXeE/8NPF3hnQlZoQPNqOi0PP+3FCns+zOAeWPkGoK0DLDAWp5
         n/r5FjdGnVNU9s8Q6mlKqGH6NKqWDlMCeYSt1smIgRpRQhxXxNfndZm3TbYdN8SvxZ0Y
         ihqSFzgH82TeKItWU0GZMzpHw7y4KtP1AUUbcyphFQGnuEDbG5NL8dJ6WLROqDv/MR0+
         DrErDlIivK3HAIpjTbmCQx0wJKEgmgFjtE2U8aBQ6aooGehNEFpZfb8WL/BBlGlpubyH
         MWSg==
X-Gm-Message-State: ACgBeo30P2TK69lpDST/5yXxVaDHFVN0QrTxGuNOBJIrbEbTSaU5Rhut
        SbybG4FCb5zIGLAVwccoy4ZyiE8dkKPhAw==
X-Google-Smtp-Source: AA6agR6kCZz836/np5BmThAQGn+2hUV3IT18WiK+bG3WNotRd8Vby6m/1DW7ToKivzMFGNKo3p6duA==
X-Received: by 2002:a17:902:f211:b0:178:723:35bb with SMTP id m17-20020a170902f21100b00178072335bbmr14646123plc.43.1662961087539;
        Sun, 11 Sep 2022 22:38:07 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:e064:d5ac:4dae:9920])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902ca0400b00176c0e055f8sm4924431pld.64.2022.09.11.22.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:38:06 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: do not waste zram_table_entry flags bits
Date:   Mon, 12 Sep 2022 14:37:55 +0900
Message-Id: <20220912053755.156704-1-senozhatsky@chromium.org>
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

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index b4eecef2a11f..138be8326866 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -30,16 +30,13 @@
 
 
 /*
- * The lower ZRAM_FLAG_SHIFT bits of table.flags is for
- * object size (excluding header), the higher bits is for
- * zram_pageflags.
- *
- * zram is mainly used for memory efficiency so we want to keep memory
- * footprint small so we can squeeze size and flags into a field.
+ * ZRAM is mainly used for memory efficiency so we want to keep memory
+ * footprint small and thus squeeze size and flags into a flags member.
  * The lower ZRAM_FLAG_SHIFT bits is for object size (excluding header),
- * the higher bits is for zram_pageflags.
+ * which cannot be larger than PAGE_SIZE (requiring PAGE_SHIFT bits),
+ * the higher bits are for zram_pageflags.
  */
-#define ZRAM_FLAG_SHIFT 24
+#define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
 
 /* Flags for zram pages (table[page_no].flags) */
 enum zram_pageflags {
-- 
2.37.2.789.g6183377224-goog

