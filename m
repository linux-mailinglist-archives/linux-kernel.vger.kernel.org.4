Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A9E5EEC64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiI2DXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2DW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:22:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F16127541;
        Wed, 28 Sep 2022 20:22:56 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MdJTV64vQzHtmG;
        Thu, 29 Sep 2022 11:18:06 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 11:22:44 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 11:22:44 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
        <llvm@lists.linux.dev>, <linux-mm@kvack.org>
CC:     <keescook@chromium.org>, <vbabka@suse.cz>
Subject: [PATCH -next] compiler.h: fix compile error with gcc-8 or lower version
Date:   Thu, 29 Sep 2022 11:38:45 +0800
Message-ID: <20220929033845.485728-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got the follow compile error in latest linux-next kernel with gcc-8.4:

  In file included from <command-line>:
  ./include/linux/percpu.h: In function ‘__alloc_reserved_percpu’:
  ././include/linux/compiler_types.h:279:30: error: expected declaration specifiers before ‘__alloc_size__’
   #define __alloc_size(x, ...) __alloc_size__(x, ## __VA_ARGS__) __malloc
                                ^~~~~~~~~~~~~~
  ./include/linux/percpu.h:120:74: note: in expansion of macro ‘__alloc_size’
   extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align) __alloc_size(1);

__alloc_size is not defined in gcc-8 or lower version, so add back the
conditional test for __alloc_size__ to fix it.

Fixes: 63caa04ec605 ("slab: Remove __malloc attribute from realloc functions")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 include/linux/compiler_types.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index aa81da7a28eb..aae8852ccbdc 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -276,8 +276,13 @@ struct ftrace_likely_data {
  * be performing a _reallocation_, as that may alias the existing pointer.
  * For these, use __realloc_size().
  */
+#ifdef __alloc_size__
 #define __alloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__) __malloc
-#define __realloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__)
+#define __realloc_size(x, ...) __alloc_size__(x, ## __VA_ARGS__)
+#else
+#define __alloc_size(x, ...)	__malloc
+#define __realloc_size(x, ...) __malloc
+#endif
 
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
-- 
2.25.1

