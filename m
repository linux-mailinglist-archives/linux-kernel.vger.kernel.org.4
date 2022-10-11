Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7218A5FAA97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJKCXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKCXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:23:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804127DF54
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:23:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c24so11949269plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pA2L/FNaj7e7+kUZGmo87Y5GGtuU8PgqF9oHvyd5XJ0=;
        b=aOVAgCTFUk3B94yRy18snaZHgtEeSUJykJ0ot+Ljr1hdS5x9wwPdboGW7YMhvDAbRJ
         ZwvfxbttriYA3H2esaRMMKmVQ0oj9gP02KjMIUTv8viD6oOBtwmpwO/Zmz+LYVUu0dA9
         +sF6lCBmK1N0DRiU09vUW/bOP4i8SB9FupMR+m1BQzVXU8kxf29K79Wl1HZWJHmgeKZx
         oDZWo8snoo2zIPjyDZX96GeLSt4KLsiT/ffMlszxDQI61qJ/iHY8p1guKTIdUMpXoBJa
         XDqHWaFPlvXmZ2BxY/Iq+yDHZPbPWeLWzwuIc5DzGIUKzmMXwRSjZsNVwgxcB3f6B7Of
         YUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pA2L/FNaj7e7+kUZGmo87Y5GGtuU8PgqF9oHvyd5XJ0=;
        b=UgrHte1rqe60IVVftMGDg0u+hrDCJVJo6l5bcBePjhuP8sijcwIdrhNBMJATATjjXr
         Z4qOJpqF799tT79eg6cGoJQuof0d7MifFBzw95YGwsqaYXiMQ6UYQ05oLFY/1qIcioSm
         nVkMn7tISEYqlbxY9U7lbVHmU5pudY9ToeE3rP93+dv7CaP56zcaHpHFJ0g3jg28pZfy
         xbxAC6eMcpPGCsuO/BAK+ocURH7X29kfxW6UXXJpojofCPZqGP9juAVpoOrXfSYulxhB
         sr7XVIHfRx9vuzPHNo+1PwnLpLxJyoTJqABQWfhWeI4GWX5uOYjwp4NidBDO8A5KDnfj
         s4zw==
X-Gm-Message-State: ACrzQf1q0k1DF1mti39SLpBq6VU2YkbRVxkaq/qIWQq2qhB6X6kwVevD
        YOCz5WuXHNoRhTN8mmtw8pU=
X-Google-Smtp-Source: AMsMyM6Fv/99kgTYy5VGB7ccfHNOf0+TN7/WFuO0wEJREVgxfoyTXj54YlueWcfwwlxOs9NAHq3MQQ==
X-Received: by 2002:a17:90a:ac11:b0:20b:10d2:e837 with SMTP id o17-20020a17090aac1100b0020b10d2e837mr24508899pjq.165.1665455018060;
        Mon, 10 Oct 2022 19:23:38 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h2-20020a63f902000000b00438834b14a1sm6801151pgi.80.2022.10.10.19.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:23:37 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 5/5] ksm: add zero_pages_sharing documentation
Date:   Tue, 11 Oct 2022 02:23:32 +0000
Message-Id: <20221011022332.322435-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011022006.322158-1-xu.xin16@zte.com.cn>
References: <20221011022006.322158-1-xu.xin16@zte.com.cn>
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

From: xu xin <xu.xin16@zte.com.cn>

When enabling use_zero_pages, pages_sharing cannot represent how
much memory saved indeed. zero_pages_sharing + pages_sharing does.
add the description of zero_pages_sharing.

Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/admin-guide/mm/ksm.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index fb6ba2002a4b..484665aa7418 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -162,7 +162,7 @@ The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
 pages_shared
         how many shared pages are being used
 pages_sharing
-        how many more sites are sharing them i.e. how much saved
+        how many more sites are sharing them
 pages_unshared
         how many pages unique but repeatedly checked for merging
 pages_volatile
@@ -173,6 +173,14 @@ stable_node_chains
         the number of KSM pages that hit the ``max_page_sharing`` limit
 stable_node_dups
         number of duplicated KSM pages
+zero_pages_sharing
+        how many empty pages are sharing kernel zero page(s) instead of
+        with each other as it would happen normally. Only effective when
+        enabling ``use_zero_pages`` knob.
+
+If ``use_zero_pages`` is 0, only ``pages_sharing`` can represents how
+much saved. Otherwise, ``pages_sharing`` + ``zero_pages_sharing``
+represents how much saved actually.
 
 A high ratio of ``pages_sharing`` to ``pages_shared`` indicates good
 sharing, but a high ratio of ``pages_unshared`` to ``pages_sharing``
-- 
2.25.1

