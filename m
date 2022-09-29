Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318275EEC42
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiI2DBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiI2DAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:00:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601CEE7E22
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:00:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id i6so269491pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ntOaXZWiOy5WNqk09ZQlodKiEJfpbZTIA6gGynxCZgg=;
        b=lDrpHaRe9q0Jmc73SFbCt9ppSUFzUBZQytKKBHRnGVV6W/U/oV4Z6GbzD1WrZHU3iY
         Dr9lNNGskr562NpUqNyd2bNs38c0ulNiZHQQZGKaavIWzwERXtZxC4E3uyYW1tvmXOl1
         BIJu9o9fHpLCLew11QwcghxIlKe0yu83YBxNyq6N2yTvqSVnbJ+gHBa4ri8bx0eRYZxp
         Vz2FXybaTYpHWayU4lYC2sx1qtTfJPzaskE9v7Mu63T8SFCwsaSk8vIm02cQ1iIG/d12
         at9swJiwgngFuWqopH33bZTiGhCecnkfLXOIvFBeuwP29OT+s+eNmZgyMOo1VGlczpjR
         hq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ntOaXZWiOy5WNqk09ZQlodKiEJfpbZTIA6gGynxCZgg=;
        b=ak6r06PGfZ+ZCKVQ43+GXCFCIRiwFMNwCdIX5muqzm6+OTjOEBCh9BWbb8KemQP3x3
         MxK3E7+Mm9/ZOBh9KoWFDj2HW9CM5s8tkI3AmnFV7/0AfR9iZCDLB84bXjOYlBFWbcqp
         nwgTVs91bMT4HwCUGqIZDxauOIKa0zItf30OcOojxAxTEU2NVJ+oq2SBWSY65l9k8TQz
         bMqj4z6XDMxDwa73KTgAUrLxIGLn3HWfNmaCgga8sSN267QgWVtUAqm2mxDQ6mdpu8rx
         BNKf1AzUph+wGd5Qo05QRx/QhMSFpVUNsZop3lilHSzce/0oREmXhKtSzwQ3shrsr32s
         uTew==
X-Gm-Message-State: ACrzQf2P+MgfiNRNh2DkZpGZJJ1JKVco9V4Q+fXe+hUEMcq7dJa1BerG
        nP86L6MV7fjPPRqAhdNJsfc=
X-Google-Smtp-Source: AMsMyM7X5xSmzpChrAhbu30JbqsqVY23sNZy0Ud37cuhoijBt6sOMXtCgJ0t1uML1A5taGTx4lez7A==
X-Received: by 2002:aa7:9532:0:b0:53e:7875:39e1 with SMTP id c18-20020aa79532000000b0053e787539e1mr1149275pfp.82.1664420448926;
        Wed, 28 Sep 2022 20:00:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id lb12-20020a17090b4a4c00b00205fafa6768sm1194675pjb.6.2022.09.28.20.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 20:00:48 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com,
        imbrenda@linux.vnet.ibm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        xu xin <xu.xin.sc@gmail.com>
Subject: [PATCH 3/3] ksm: add zero_pages_sharing in Documentation
Date:   Thu, 29 Sep 2022 03:00:43 +0000
Message-Id: <20220929030043.281441-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929025206.280970-1-xu.xin16@zte.com.cn>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
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

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Signed-off-by: xu xin <xu.xin.sc@gmail.com>
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
+        with each other as it would happen normally. only effective when
+        enabling ``use_zero_pages`` knob.
+
+If ``use_zero_pages`` is 0, only ``pages_sharing`` can represents how
+much saved. Otherwise, ``pages_sharing`` + ``zero_pages_sharing``
+represents how much saved actually.
 
 A high ratio of ``pages_sharing`` to ``pages_shared`` indicates good
 sharing, but a high ratio of ``pages_unshared`` to ``pages_sharing``
-- 
2.25.1

