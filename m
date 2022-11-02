Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0D0615F93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiKBJXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiKBJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8AC65F6;
        Wed,  2 Nov 2022 02:20:10 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:20:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1hOlCFXWXbokLJXphBjWmebB9fCZGdGULZTZDJxqFc=;
        b=z/CI8IXsGrWbYOfyuQaLZ0SDqpZT8T2riOAxz7x/Uf7Ja+hjb3vTBzJ3le4f/ROdIKMl38
        z4j3w93nCo90korkUyUntWoGEm150XDjow2+pq+fnWXvuwyhwVelUytroTin66oeza0WUc
        5rwXKQf7iwLwymElnRGoxWWWOkxeIZaQKqo8yt+qdPJaR2xwI59A7rlf0Nkv6Y0y0w/5T4
        1J3V1mBnbgfbC7dHNiTtcAXcdEmcv+QNFwzSf11IXS5bZHcXPSNGRW1HDmpDunIiiIn+Xh
        JmYhx/AyuooS6z7Igegh9+zovMbtzgHz1ZG6iz7anY1GyQcchA7iCIa0EMKb8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1hOlCFXWXbokLJXphBjWmebB9fCZGdGULZTZDJxqFc=;
        b=7WtS51dSoXz5BrMbzaVUMtZ/dgdHKJZUdlV02iuVcR4uLXhy6xvBxoDxUeB3ZtO6n+eWya
        +BVfXsNNwgBndaBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] kallsyms: Revert "Take callthunks into account"
Cc:     "Reported-by: kernel test robot" <yujie.liu@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202210241614.2ae4c1f5-yujie.liu@intel.com>
References: <202210241614.2ae4c1f5-yujie.liu@intel.com>
MIME-Version: 1.0
Message-ID: <166738080795.7716.3207497322812603185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5ebddd7c4951c50142bcb239d4c6a82eff15759e
Gitweb:        https://git.kernel.org/tip/5ebddd7c4951c50142bcb239d4c6a82eff15759e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 28 Oct 2022 15:26:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:08 +01:00

kallsyms: Revert "Take callthunks into account"

This is a full revert of commit:

  f1389181622a ("kallsyms: Take callthunks into account")

The commit assumes a number of things that are not quite right.
Notably it assumes every symbol has PADDING_BYTES in front of it that
are not claimed by another symbol.

This is not true; even when compiled with:

  -fpatchable-function-entry=${PADDING_BYTES},${PADDING_BYTES}

Notably things like .cold subfunctions do not need to adhere to this
change in ABI. It it also not true when build with CFI_CLANG, which
claims these PADDING_BYTES in the __cfi_##name symbol.

Once the prefix bytes are not consistent and or otherwise claimed the
approach this patch takes goes out the window and kallsym resolution
will report invalid symbol names.

Therefore revert this to make room for another approach.

Reported-by: Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Link: https://lore.kernel.org/r/202210241614.2ae4c1f5-yujie.liu@intel.com
Link: https://lkml.kernel.org/r/20221028194453.330970755@infradead.org
---
 kernel/kallsyms.c | 45 +++++----------------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index cc244c0..60c20f3 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -293,12 +293,6 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	return low;
 }
 
-#ifdef CONFIG_FUNCTION_PADDING_BYTES
-#define PADDING_BYTES	CONFIG_FUNCTION_PADDING_BYTES
-#else
-#define PADDING_BYTES	0
-#endif
-
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -306,25 +300,13 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 				unsigned long *offset)
 {
 	char namebuf[KSYM_NAME_LEN];
-	int ret;
-
-	addr += PADDING_BYTES;
 
 	if (is_ksym_addr(addr)) {
 		get_symbol_pos(addr, symbolsize, offset);
-		ret = 1;
-		goto found;
-	}
-
-	ret = !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf);
-	if (!ret) {
-		ret = !!__bpf_address_lookup(addr, symbolsize,
-					     offset, namebuf);
+		return 1;
 	}
-found:
-	if (ret && offset)
-		*offset -= PADDING_BYTES;
-	return ret;
+	return !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf) ||
+	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
 
 static const char *kallsyms_lookup_buildid(unsigned long addr,
@@ -337,8 +319,6 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 	namebuf[KSYM_NAME_LEN - 1] = 0;
 	namebuf[0] = 0;
 
-	addr += PADDING_BYTES;
-
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -368,8 +348,6 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 
 found:
 	cleanup_symbol_name(namebuf);
-	if (ret && offset)
-		*offset -= PADDING_BYTES;
 	return ret;
 }
 
@@ -396,8 +374,6 @@ int lookup_symbol_name(unsigned long addr, char *symname)
 	symname[0] = '\0';
 	symname[KSYM_NAME_LEN - 1] = '\0';
 
-	addr += PADDING_BYTES;
-
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -425,8 +401,6 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 	name[0] = '\0';
 	name[KSYM_NAME_LEN - 1] = '\0';
 
-	addr += PADDING_BYTES;
-
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -443,8 +417,6 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 		return res;
 
 found:
-	if (offset)
-		*offset -= PADDING_BYTES;
 	cleanup_symbol_name(name);
 	return 0;
 }
@@ -470,15 +442,8 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	len = strlen(buffer);
 	offset -= symbol_offset;
 
-	if (add_offset) {
-		char s = '+';
-
-		if ((long)offset < 0) {
-			s = '-';
-			offset = 0UL - offset;
-		}
-		len += sprintf(buffer + len, "%c%#lx/%#lx", s, offset, size);
-	}
+	if (add_offset)
+		len += sprintf(buffer + len, "+%#lx/%#lx", offset, size);
 
 	if (modname) {
 		len += sprintf(buffer + len, " [%s", modname);
