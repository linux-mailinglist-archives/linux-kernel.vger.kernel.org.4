Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4953774FCCC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGLBoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLBoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:44:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570B01712;
        Tue, 11 Jul 2023 18:44:10 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R10rP6Hspz1JC9d;
        Wed, 12 Jul 2023 09:43:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 09:44:07 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next] modpost: move some defines to the file head
Date:   Wed, 12 Jul 2023 09:57:47 +0800
Message-ID: <20230712015747.77263-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

with "module: Ignore RISC-V mapping symbols too", build error occurs,

scripts/mod/modpost.c: In function ‘is_valid_name’:
scripts/mod/modpost.c:1055:57: error: ‘EM_RISCV’ undeclared (first use in this function)
  return !is_mapping_symbol(name, elf->hdr->e_machine == EM_RISCV);

Fix it by moving the EM_RISCV to the file head, also some other
defines in case of similar problem in the future.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 scripts/mod/modpost.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7c71429d6502..885cca272eb8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -60,6 +60,22 @@ static unsigned int nr_unresolved;
 
 #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
 
+#ifndef EM_RISCV
+#define EM_RISCV		243
+#endif
+
+#ifndef R_RISCV_SUB32
+#define R_RISCV_SUB32		39
+#endif
+
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH		258
+#endif
+
+#ifndef R_LARCH_SUB32
+#define R_LARCH_SUB32		55
+#endif
+
 void __attribute__((format(printf, 2, 3)))
 modpost_log(enum loglevel loglevel, const char *fmt, ...)
 {
@@ -1428,22 +1444,6 @@ static int addend_mips_rel(uint32_t *location, Elf_Rela *r)
 	return 0;
 }
 
-#ifndef EM_RISCV
-#define EM_RISCV		243
-#endif
-
-#ifndef R_RISCV_SUB32
-#define R_RISCV_SUB32		39
-#endif
-
-#ifndef EM_LOONGARCH
-#define EM_LOONGARCH		258
-#endif
-
-#ifndef R_LARCH_SUB32
-#define R_LARCH_SUB32		55
-#endif
-
 static void section_rela(struct module *mod, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
-- 
2.41.0

