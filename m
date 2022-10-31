Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526B26132C8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJaJeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJaJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:34:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD52FB;
        Mon, 31 Oct 2022 02:34:16 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N17C42K5RzVjKr;
        Mon, 31 Oct 2022 17:29:20 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 17:34:14 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 17:34:14 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <acme@redhat.com>, <tadeusz.struk@linaro.org>,
        <keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
        <pf@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] tools headers UAPI: Sync linux/stddef.h with the kernel sources
Date:   Mon, 31 Oct 2022 17:30:57 +0800
Message-ID: <20221031093057.29050-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 036b8f5b8970 ("tools headers uapi: Update linux/in.h copy") modify
tools/include/uapi/linux/in.h, and __DECLARE_FLEX_ARRAY is introduced.
Macro is not defined in tools/include, compilation fails:

    CLNG-BPF [test_maps] bind4_prog.bpf.o
  In file included from progs/bind4_prog.c:7:
  /root/linux-mainline-new/linux/tools/include/uapi/linux/in.h:199:3: error: type name requires a specifier or qualifier
                  __DECLARE_FLEX_ARRAY(__be32, imsf_slist_flex);
                  ^
  /root/linux-mainline-new/linux/tools/include/uapi/linux/in.h:199:32: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
                  __DECLARE_FLEX_ARRAY(__be32, imsf_slist_flex);
                                               ^
  2 errors generated.

Synchronize include/uapi/linux/stddef.h to tools headers directory,
and delete the line "#include <linux/compiler_types.h>":

  # cp ./include/uapi/linux/stddef.h tools/include/uapi/linux/stddef.h
  # sed -i '/#include <linux\/compiler_types.h>/,+1d' tools/include/uapi/linux/stddef.h

And add missed <linux/stddef.h> header in tools/include/uapi/linux/in.h.

Fixes: 036b8f5b8970 (tools headers uapi: Update linux/in.h copy)
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/include/uapi/linux/in.h     |  1 +
 tools/include/uapi/linux/stddef.h | 45 +++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 tools/include/uapi/linux/stddef.h

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index f243ce665f74..79015665daf1 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 #include <linux/libc-compat.h>
 #include <linux/socket.h>
+#include <linux/stddef.h>
 
 #if __UAPI_DEF_IN_IPPROTO
 /* Standard well-defined IP protocols.  */
diff --git a/tools/include/uapi/linux/stddef.h b/tools/include/uapi/linux/stddef.h
new file mode 100644
index 000000000000..72bcdf96999f
--- /dev/null
+++ b/tools/include/uapi/linux/stddef.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_STDDEF_H
+#define _UAPI_LINUX_STDDEF_H
+
+#ifndef __always_inline
+#define __always_inline inline
+#endif
+
+/**
+ * __struct_group() - Create a mirrored named and anonyomous struct
+ *
+ * @TAG: The tag name for the named sub-struct (usually empty)
+ * @NAME: The identifier name of the mirrored sub-struct
+ * @ATTRS: Any struct attributes (usually empty)
+ * @MEMBERS: The member declarations for the mirrored structs
+ *
+ * Used to create an anonymous union of two structs with identical layout
+ * and size: one anonymous and one named. The former's members can be used
+ * normally without sub-struct naming, and the latter can be used to
+ * reason about the start, end, and size of the group of struct members.
+ * The named struct can also be explicitly tagged for layer reuse, as well
+ * as both having struct attributes appended.
+ */
+#define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
+	union { \
+		struct { MEMBERS } ATTRS; \
+		struct TAG { MEMBERS } ATTRS NAME; \
+	}
+
+/**
+ * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ *
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
+	struct { \
+		struct { } __empty_ ## NAME; \
+		TYPE NAME[]; \
+	}
+#endif
-- 
2.30.GIT

