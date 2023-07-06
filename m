Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDAF74A414
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjGFTDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjGFTDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F721BFF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688670147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xrVOfhoIMemGGmfQntaPU0HXJfwvQLEazh/5eyulSkk=;
        b=hmQ3XMdhaWWftg8yPQU+ffe46w61wnxOGOyXnH4y/HuIBATfUtJmeY7Fa83B0XttydLVEz
        1GokC2yZYjPvk16JzcIkEE8lQnuVg4eBqDkOPFy8lEKR8MCDHLXiU5TE5dPQhOWJQ2GGKc
        OwY3rhFHuHrKK7boqUcST5EGWPTvce0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-8siB-6IjN5arBNq_acKDHA-1; Thu, 06 Jul 2023 15:02:23 -0400
X-MC-Unique: 8siB-6IjN5arBNq_acKDHA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C35F238008A2;
        Thu,  6 Jul 2023 19:02:22 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D27DA492B01;
        Thu,  6 Jul 2023 19:02:19 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Remove the arch_calc_vm_prot_bits() macro from the uapi
Date:   Thu,  6 Jul 2023 21:02:17 +0200
Message-Id: <20230706190217.371721-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch_calc_vm_prot_bits() macro uses VM_PKEY_BIT0 etc. which are
not part of the uapi, so the macro is completely useless for userspace.
It is also hidden behind the CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
config switch which we shouldn't expose to userspace. Thus let's move
this macro into a new internal header instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/x86/include/asm/mman.h      | 15 +++++++++++++++
 arch/x86/include/uapi/asm/mman.h |  8 --------
 scripts/headers_install.sh       |  1 -
 3 files changed, 15 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/include/asm/mman.h

diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
new file mode 100644
index 0000000000000..12b820259b9f3
--- /dev/null
+++ b/arch/x86/include/asm/mman.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+#define arch_calc_vm_prot_bits(prot, key) (		\
+		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
+		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
+		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
+		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
+#endif
+
+#include <uapi/asm/mman.h>
+
+#endif /* __ASM_MMAN_H__ */
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 775dbd3aff736..a72e4f3e13b17 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -4,14 +4,6 @@
 
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-#define arch_calc_vm_prot_bits(prot, key) (		\
-		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
-		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
-		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
-		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
-#endif
-
 #include <asm-generic/mman.h>
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index afdddc82f02b3..56d3c338d91d7 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -81,7 +81,6 @@ arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_IA32_EMULATION
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_X86_64
-arch/x86/include/uapi/asm/mman.h:CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 "
 
 for c in $configs
-- 
2.39.3

