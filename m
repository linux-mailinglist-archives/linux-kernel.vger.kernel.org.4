Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD8362245A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiKIHE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKIHEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:04:25 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3E11DDFF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:04:22 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id j12so16276345plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 23:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zSRw6nfdCPaMCQzx3jE+HEvjxFnji+/pTOoyXTdquzQ=;
        b=K1QccXq8zGYDQPCT01fpavRZS+3GR2LdhwmxeSruUTnDnGDZJVASHd65B4QgmtE0aF
         4giOK3TrfRJWZTQRYUpBAqE3zxCJj1t45z5MDUvPYFY+GJGY/qOvlnwo4sByTsSaqIMk
         E+1wQYCdJm1XCWoA7I/VtEs1Nvv7XKuj6lgdxQoLTq7d2COGG9+Z4aIKwpSmb/kbJ8im
         HfejMODT3G4QL2GWSCFSWYvkPqDetayUE9cca77CR8PMz9JeREcBM/6lvsfNV4LznYsV
         XnQXD4zPWtYkF37R4NYV0CY6xYh/sZNDMGRQ+7HtLQxqliQIDlpOgzBpXyProExchux+
         F48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSRw6nfdCPaMCQzx3jE+HEvjxFnji+/pTOoyXTdquzQ=;
        b=Vod1EZ6jmY5QSITJdvlBH/ilNu3tu5WZEBEnuCxZOVMYQmrtTZZs78miWxTm2sBkrN
         KWn8RfKKY58TXwp9bCRoWrXvUGW68Hug+KSYFwyksbpryHT91yStwxcTkyMUz2cIdNd0
         aM/3GQqdvqwGwmCAB09nZAIpdnpSNfLbSCl1d8+Ky4R1KkDfdfBGeK5LwddS7ZE1sFer
         ULJK3Jymp14jGjypgA9tFeRB/6g+2SUePel0UUSHxppmqFD5TSKBgav+6Ht17iTm4J/X
         tzW834iNMSBPqyvGRF2dvyESevFo5aKGYmHAhMBPTZZ4hMCwnbgE+zVmrtVFM+XRAuGg
         t/og==
X-Gm-Message-State: ACrzQf0qbLj1I/KegIrkWxX5jNO0vWvJoe+QEUdKiQUL8d53EzVSsSix
        TUzA7FFZhyJYie/w3FBNxoNnleROe8lUPxD3
X-Google-Smtp-Source: AMsMyM4himXTZ1Oet6yD4mIg1+GbxpQRrGdlz9D2+SGVHbyEDjyVUAA42XAzqGBUnhGiWspjN1323w==
X-Received: by 2002:a17:902:db12:b0:187:4736:f780 with SMTP id m18-20020a170902db1200b001874736f780mr37864396plx.145.1667977461892;
        Tue, 08 Nov 2022 23:04:21 -0800 (PST)
Received: from xuchao.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7940b000000b0056bf29c9ba3sm7788696pfo.146.2022.11.08.23.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 23:04:21 -0800 (PST)
From:   Chao Xu <amos.xuchao@gmail.com>
X-Google-Original-From: Chao Xu <Chao.Xu9@zeekrlife.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chao Xu <Chao.Xu9@zeekrlife.com>
Subject: [PATCH] mm/vmscan: simplify the nr assignment logic for pages to scan
Date:   Wed,  9 Nov 2022 15:04:16 +0800
Message-Id: <20221109070416.620887-1-Chao.Xu9@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
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

By default the assignment logic of anonymouns or file inactive
pages and active pages to scan using the same duplicated code
snippet. To simplify the logic, merge the same part.

Signed-off-by: Chao Xu <Chao.Xu9@zeekrlife.com>
---
 mm/vmscan.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88e5216..df3c0cbe381f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5932,14 +5932,11 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		 * scan target and the percentage scanning already complete
 		 */
 		lru = (lru == LRU_FILE) ? LRU_BASE : LRU_FILE;
-		nr_scanned = targets[lru] - nr[lru];
-		nr[lru] = targets[lru] * (100 - percentage) / 100;
-		nr[lru] -= min(nr[lru], nr_scanned);
-
-		lru += LRU_ACTIVE;
-		nr_scanned = targets[lru] - nr[lru];
-		nr[lru] = targets[lru] * (100 - percentage) / 100;
-		nr[lru] -= min(nr[lru], nr_scanned);
+		for ( ; lru <= lru + LRU_ACTIVE; lru++) {
+			nr_scanned = targets[lru] - nr[lru];
+			nr[lru] = targets[lru] * (100 - percentage) / 100;
+			nr[lru] -= min(nr[lru], nr_scanned);
+		}
 
 		scan_adjusted = true;
 	}
-- 
2.34.1

