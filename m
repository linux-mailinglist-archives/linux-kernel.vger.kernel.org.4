Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41B69B56D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBQWVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBQWVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:21:46 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CEF65366
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:21:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bt27so2059955wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YBPuaolOMt6OUwxf3LGCole4vSrBOMWaEwSldzEt85A=;
        b=gH8CbD9JRITx2jfZaLd2BzsUUQ0cV0s+Tztdu8ess3WsqryNTHUzqfXlsfqEzM6zZ0
         AFF3WfqmvvenYni6219FVh0DdOSEJfq/AodHT05PrpRBj60aseO2ZzZkMDsUQy7P+UzM
         gU3GOuuIedlJ997uisbHgRCPeN3bevoxqGFVoEnudxveWz+LnxNs0N6QvOviutea3fOD
         MWUpTHPzXHNUnqKKAl33Vhash4EHyikExjN+bD/yVRWHFlqLMPny6PxNqYCozG4UYTYc
         tZ6nc0lhtVWX8/bgqiidjKDHt8CLA+R3Hkwa/AWjL60jqOLKmCQb0ELoyqWUSClWtIrj
         rsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBPuaolOMt6OUwxf3LGCole4vSrBOMWaEwSldzEt85A=;
        b=nqLBCptLzRljJdFNtzhPbthGtIYiEhWQNZv/eroI6GUdKTKkIqiLYwiHQtp2Zu42a7
         PlUtf+cFAZqPgcp8vudOhgjbq7L9ZCL7WRBFokxdForl3zq61e7glhuHUBS+1L/uW4t5
         cCjgBhL8K4dktV7eKWK26OV+Pr3MGVQxYqmzA9C6Nk0ovDKWj7Ho5b6G7W4pi3KKivoW
         pNzVp0LHug3eLg2peRBI0R9uQ+vJMXPyWrhWmFKBOpEp/cppUD5p2HtkJrFQvHUoZG09
         h7m65GK8IkMXckpQGmsNszVJJt/vwxhqXZiu9l9Jxq+PaduoA9fEByg/PZpkqgzLc9S1
         fUpw==
X-Gm-Message-State: AO0yUKWsMOaWhniko+Tt6DLgv4EGC06pTNnGgU9jOAHu92U8DZdiKlAM
        bzKle2f1W801iEqJpQb2UX/HeA==
X-Google-Smtp-Source: AK7set9LvgG2GZ83xT0nIImG5DLyxRhXdfbeXEYV4e8Y8OeEsm+81p0BgeZrfOg09sATWmOWnOsjpA==
X-Received: by 2002:a5d:6e5d:0:b0:2c5:54a7:363c with SMTP id j29-20020a5d6e5d000000b002c554a7363cmr1408888wrz.23.1676672501403;
        Fri, 17 Feb 2023 14:21:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:85f:fc09:d5bf:b3bb:da70:27f6:b05a])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b002c5503a8d21sm5300136wrv.70.2023.02.17.14.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 14:21:40 -0800 (PST)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     netdev@vger.kernel.org
Cc:     alexander.duyck@gmail.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] page_pool: add a comment explaining the fragment counter usage
Date:   Sat, 18 Feb 2023 00:21:30 +0200
Message-Id: <20230217222130.85205-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the page_pool code the first impression is that keeping
two separate counters, one being the page refcnt and the other being
fragment pp_frag_count, is counter-intuitive.

However without that fragment counter we don't know when to reliably
destroy or sync the outstanding DMA mappings.  So let's add a comment
explaining this part.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v2:
 - Removed a uneeded commas on the comment
Changes since v1:
 - Update the comment withe the correct description for pp_frag_count
 include/net/page_pool.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 34bf531ffc8d..ddfa0b328677 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -277,6 +277,16 @@ void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
 				  unsigned int dma_sync_size,
 				  bool allow_direct);

+/* pp_frag_count represents the number of writers who can update the page
+ * either by updating skb->data or via DMA mappings for the device.
+ * We can't rely on the page refcnt for that as we don't know who might be
+ * holding page references and we can't reliably destroy or sync DMA mappings
+ * of the fragments.
+ *
+ * When pp_frag_count reaches 0 we can either recycle the page if the page
+ * refcnt is 1 or return it back to the memory allocator and destroy any
+ * mappings we have.
+ */
 static inline void page_pool_fragment_page(struct page *page, long nr)
 {
 	atomic_long_set(&page->pp_frag_count, nr);
--
2.38.1

