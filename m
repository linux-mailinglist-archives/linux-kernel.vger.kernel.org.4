Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879D35B2E6E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiIIGE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIIGE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:04:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8633A1E;
        Thu,  8 Sep 2022 23:04:55 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MP54w5xqYzHnVL;
        Fri,  9 Sep 2022 14:02:56 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:04:53 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <dhowells@redhat.com>, <jarkko@kernel.org>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] security/keys: remove request_key_conswq and keyring_search_instkey() declarations
Date:   Fri, 9 Sep 2022 14:04:52 +0800
Message-ID: <20220909060452.1121620-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_key_conswq has been removed since
commit 76181c134f87 ("KEYS: Make request_key() and co fundamentally
asynchronous").

keyring_search_instkey() has been removed since
commit b5f545c880a2 ("[PATCH] keys: Permit running process to
instantiate keys").

so remove the declare for them from header file.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/keys/internal.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9b9cf3b6fcbb..6a2fb45c22f8 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -86,7 +86,6 @@ extern struct kmem_cache *key_jar;
 extern struct rb_root key_serial_tree;
 extern spinlock_t key_serial_lock;
 extern struct mutex key_construction_mutex;
-extern wait_queue_head_t request_key_conswq;
 
 extern void key_set_index_key(struct keyring_index_key *index_key);
 extern struct key_type *key_type_lookup(const char *type);
@@ -109,9 +108,6 @@ extern void __key_link_end(struct key *keyring,
 extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
 				    const struct keyring_index_key *index_key);
 
-extern struct key *keyring_search_instkey(struct key *keyring,
-					  key_serial_t target_id);
-
 extern int iterate_over_keyring(const struct key *keyring,
 				int (*func)(const struct key *key, void *data),
 				void *data);
-- 
2.25.1

