Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17766CBBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjC1J7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjC1J7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:59:00 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC43619C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:38 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bn14so6829310pgb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679997517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBD4yaWYkYDbLkNhZA944C9ObF80BX09B3zGBKkIydI=;
        b=HhbQB+dgFelVX19imcjsNLuo23G94LeWSU/HGZgUiVNfjyKVW+HiToJUnagtKSthBY
         5kq+NvO/ctnPo47Twm8reDS0d5f0bC6BH3c9qB+Q9Gjw3RaCZ+yyNCqRN0jzkzO4hh9Z
         MgZCQ7XZwY1fjVVJrlrFKYiY+51dScHVJrHlEvymXRrBLu2hClZ3UbSwxLjhj/YFxX64
         vMWId0i1jE82E/qg7Sr38pLdxec55XLsUoXO4nMH1EQgjTwoGGcRX4UGDsco7eCfVB8d
         cLv4R1G7yh9yGkneEds787t4phoeg1nJ0GlxivunqwTSMcQ5LysGeIuwdCvjaRqL97IT
         maTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBD4yaWYkYDbLkNhZA944C9ObF80BX09B3zGBKkIydI=;
        b=Hm0Lg7nL5s8KVSe9btAyxYS7QNtKUo9fHS+9GM5L7WEhtO5rO4qS/nsIw4cNNkgGnu
         Lms4VFj/VPYaI4McW/LWUo/WKH6hLv8ZlwZ2/QRg6BIguQ3oFyrqvvfMJFDk/OcsazTX
         ndR/TbXldBLHbk7WJYMuZUDE1aCVX8ozHl+fUHgOOfpl8K4H2OFpm76h6p51QIDB0qkU
         SERsnHxjJlPDTIPthzHn1i1sDVFQ+DNH43zhdqkQoFMfz9B6G0xuBTumzSAJOx3WaCb0
         1KJgNG9BU9TiL1XbJ4Os5A7E7+reRS4y4/JoUCesHfz023aIxTIjS/tiXJ4/bxIqJ92Y
         t0ig==
X-Gm-Message-State: AAQBX9cqP1Obqxo2ePSomfPkXOtEnuTMTSlSmNsoZVejZswGozIlBfdu
        z36vkEep4bb0otgmZzTl5Uoj9w==
X-Google-Smtp-Source: AKy350aBkCEiteWTRB8arAPPUAGcyuriJ2lhLAbvPCn/eGNEdVUaJTvoxyZvHgGLTc4pYAyj0IqVBw==
X-Received: by 2002:a62:1dca:0:b0:627:de2e:f1a5 with SMTP id d193-20020a621dca000000b00627de2ef1a5mr13507673pfd.4.1679997517751;
        Tue, 28 Mar 2023 02:58:37 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b005a8a5be96b2sm17207556pfa.104.2023.03.28.02.58.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Mar 2023 02:58:37 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, jannh@google.com, sjpark@amazon.de,
        muchun.song@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/6] mm: kfence: check kfence pool size at building time
Date:   Tue, 28 Mar 2023 17:58:03 +0800
Message-Id: <20230328095807.7014-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230328095807.7014-1-songmuchun@bytedance.com>
References: <20230328095807.7014-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check kfence pool size at building time to expose problem ASAP.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/kfence/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index de62a84d4830..6781af1dfa66 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -841,10 +841,9 @@ static int kfence_init_late(void)
 		return -ENOMEM;
 	__kfence_pool = page_to_virt(pages);
 #else
-	if (nr_pages > MAX_ORDER_NR_PAGES) {
-		pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");
-		return -EINVAL;
-	}
+	BUILD_BUG_ON_MSG(get_order(KFENCE_POOL_SIZE) > MAX_ORDER,
+			 "CONFIG_KFENCE_NUM_OBJECTS is too large for buddy allocator");
+
 	__kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL);
 	if (!__kfence_pool)
 		return -ENOMEM;
-- 
2.11.0

