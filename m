Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9E969613D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBNKpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjBNKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:44:46 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CBF86AE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:44:00 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lf10so7091435ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XqS5XS9K0gVFKIqlVQ1fvlwwhKgBIsbsx/lxGSO4I14=;
        b=wZeIsjeB/Zo2j6NDzZYavDee4rG/0MNaS+S9sQ5sz3es7byC3q3/CGB+7Y2zZNlEnv
         3I3hrZE4drN47D0K2TnrLZhUkaECrKnxG7yK0Kvjpa0JoO15OzjdO1xwQhppm3YOmAtQ
         2sAAHoYigNpPXi/RMobt5MUC+KGbVXLsc+4+S4gaVelGK4667CRCzpOUad1lUj7ZFi1W
         OM8pE0LqrTgGDWrOHR25XJOjciu1A+IMC/oSWbV8Y/0lqPGgM0iuXOTTp84+YKR838E/
         GMyBKknGwtIWn03f4zVmPg3Ad3ZZzBwbcwtOAfrxFSq4Hkt/c6G9wB5fvw/9sQW5bmHh
         3HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqS5XS9K0gVFKIqlVQ1fvlwwhKgBIsbsx/lxGSO4I14=;
        b=dwMrMjg/s7TdyRSFW2fq18JobTWl+KUK+5e1nQIg+3pviEe0iBVKyljLK78Nbb4Jsq
         o5Xu+hEO23WBlUhYOIg25HTe3EeJEqHmCU4Tj61sWsVedx3Xi6B23onrg8ZYgPI40CJn
         1NOyE7awy0ufJynMSU9qbHBd916lFJsGRFcBfDrGedwEphCbxGXbWQHrWAy3xb9BIXXd
         Apjio+r3QZifrnbuGE9ezQlMjm0ZLUhl+yWiPoOPJ0HV9gdQU76YDg4CyAYb3J8dvpMY
         rnpkopkSooNaL+OcopawTvi50ZucTkRkXHX1imo11FR68wWZ9yIN8dAaK02LvYtlLHIs
         495Q==
X-Gm-Message-State: AO0yUKUYMnPceBr7G68gkOSs+oUsotaKbGZBr9qnl3HxOpboIRKyMkVN
        ii2wRdXfJGYnXB8/vW8LtWtb/g==
X-Google-Smtp-Source: AK7set9OiDXfQDSSzlTWpcz2XQVHKpCFrrP+/YlN9PhndGSMRAPD7uYo3yXcPA9h3GuLrxzFG/v/AQ==
X-Received: by 2002:a17:906:f913:b0:87b:d60a:fcbb with SMTP id lc19-20020a170906f91300b0087bd60afcbbmr2135967ejb.47.1676371414259;
        Tue, 14 Feb 2023 02:43:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:85f:fc9d:e4b5:af84:8794:2f3f:88f1])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709063e8f00b0084cb4d37b8csm8184654ejj.141.2023.02.14.02.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:43:33 -0800 (PST)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     netdev@vger.kernel.org
Cc:     alexander.duyck@gmail.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] page_pool: add a comment explaining the fragment counter usage
Date:   Tue, 14 Feb 2023 12:43:16 +0200
Message-Id: <20230214104316.2254814-1-ilias.apalodimas@linaro.org>
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

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- Update the comment withe the correct description for pp_frag_count
 include/net/page_pool.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 34bf531ffc8d..277e215cfb58 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -277,6 +277,16 @@ void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
 				  unsigned int dma_sync_size,
 				  bool allow_direct);

+/* pp_frag_count represents the number of writers who can update the page
+ * either by updating skb->data or via DMA mappings for the device.
+ * We can't rely on the page refcnt, as we don't know who might be
+ * holding page references and we can't reliably destroy or sync DMA mappings
+ * of the fragments.
+ *
+ * When pp_frag_count reaches 0 we can either recycle the page, if the page
+ * refcnt is 1, or return it back to the memory allocator and destroy any
+ * mappings we have.
+ */
 static inline void page_pool_fragment_page(struct page *page, long nr)
 {
 	atomic_long_set(&page->pp_frag_count, nr);
--
2.38.1

