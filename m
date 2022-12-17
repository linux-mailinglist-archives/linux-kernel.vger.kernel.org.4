Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8164F8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 12:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLQLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 06:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQLbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 06:31:33 -0500
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C3ADF90;
        Sat, 17 Dec 2022 03:31:24 -0800 (PST)
X-QQ-mid: bizesmtp76t1671276650tdrswa6d
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 17 Dec 2022 19:30:48 +0800 (CST)
X-QQ-SSF: 0140000000200090D000B00A0000000
X-QQ-FEAT: 90EFqYDyPxCkbDFXxFdW7X7FJpfnpNAakESINYCEm+gO9LHamBz3FT0QOjoMP
        f61gSQVZV/nRltLjaPQsV6lAuJxjEarMMxjqhND2SUBYnv7QXmPLQDTVmu/lOvBkhzR2VZa
        n3ZD26PN0906qrHBpYgw67c3rj2dxZv4hGoVXHj4tE/yJ0VpbqTHetayVrlSN9CMlKmHUW/
        wdj6rHm+7Md9UG0PJd27S6/r53tkh4fX+1eaPUBefAQsJ+By370HGucNGXuzil2MDjTix+Y
        RZM7jgooj1GFSE5TWHUN8tPUNpt3xBJKoVJ9WjRw14FK+dhA8Nlk9eEZ/dYNlrm5XaphabW
        tdpq6o0UHZyQDyOI7XtXbsUcQEErq7qRbORNUnXMboTrX1tZkTvyUTHsyUptCLkfTs/KoYS
        rg1pi+Edkjg=
X-QQ-GoodBg: 2
From:   gouhao@uniontech.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, mingo@elte.hu, gouhaojake@163.com,
        Gou Hao <gouhao@uniontech.com>
Subject: [PATCH] mm/slab: remove unused slab_early_init
Date:   Sat, 17 Dec 2022 19:30:45 +0800
Message-Id: <20221217113045.15997-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gou Hao <gouhao@uniontech.com>

'slab_early_init' was introduced by 'commit e0a42726794f
("[PATCH] mm/slab.c: fix early init assumption")', this
flag was used to prevented off-slab caches being created
so early during bootup.

The only user of 'slab_early_init' was removed in commit
'3217fd9bdf00 ("mm/slab: make criteria for off slab
determination robust and simple")'.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 mm/slab.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 7a269db050ee..ede1f29fd81c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -220,7 +220,6 @@ static inline void fixup_objfreelist_debug(struct kmem_cache *cachep,
 static inline void fixup_slab_list(struct kmem_cache *cachep,
 				struct kmem_cache_node *n, struct slab *slab,
 				void **list);
-static int slab_early_init = 1;
 
 #define INDEX_NODE kmalloc_index(sizeof(struct kmem_cache_node))
 
@@ -1249,8 +1248,6 @@ void __init kmem_cache_init(void)
 	slab_state = PARTIAL_NODE;
 	setup_kmalloc_cache_index_table();
 
-	slab_early_init = 0;
-
 	/* 5) Replace the bootstrap kmem_cache_node */
 	{
 		int nid;
-- 
2.20.1

