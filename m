Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DDD611B24
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJ1TsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJ1TsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:48:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C6A24419D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=w2TcGA3omIeq3yxp81jgH+z11BiFQX/+KG2uxbRcnKg=; b=ks+sTiRY6cSm9Wr/5Ajk0dRWgD
        8FOEc3MhC69/nxeFJfF4MsM5p2kWKC0wMsBYpMgeuLjF4ynIO07RIqoFH10m/rbeHWi7aAjPcH4XL
        BL93ujKDf988/1YnHhVgktI3/a9FCh3gG44Sp2dT6uAXcGTfGB0X7JnbFnwtbMPXUnVHzi5hmXtjd
        iqLtkIK/EC2vzuPd3jlzDWNKIXLHwAqwxyGEx4o2T/I6hFbLiWgvf7q6KMMYp/eW0aF5Bvx+PJjO3
        +eUjCJW1JFrIw8bbpdV88/LkK9ictwhcmKs/wwt4bIH9/j4C3Pkv0L8PFQlX6SMutqrEXhwsr7+3+
        j/QVtvRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooVKR-007ARB-1D; Fri, 28 Oct 2022 19:47:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B57CC300322;
        Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 980AB2C6B7F85; Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Message-ID: <20221028194453.330970755@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Oct 2022 21:40:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        djwong@kernel.org, yujie.liu@intel.com, tglx@linutronix.de,
        jpoimboe@kernel.org, joao.moreira@intel.com,
        samitolvanen@google.com
Subject: [PATCH 1/5] kallsyms: Revert "Take callthunks into account"
References: <20221028194022.388521751@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Link: https://lore.kernel.org/r/202210241614.2ae4c1f5-yujie.liu@intel.com
---
 kernel/kallsyms.c |   45 +++++----------------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -293,12 +293,6 @@ static unsigned long get_symbol_pos(unsi
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
@@ -306,25 +300,13 @@ int kallsyms_lookup_size_offset(unsigned
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
+		return 1;
 	}
-
-	ret = !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf);
-	if (!ret) {
-		ret = !!__bpf_address_lookup(addr, symbolsize,
-					     offset, namebuf);
-	}
-found:
-	if (ret && offset)
-		*offset -= PADDING_BYTES;
-	return ret;
+	return !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf) ||
+	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
 
 static const char *kallsyms_lookup_buildid(unsigned long addr,
@@ -337,8 +319,6 @@ static const char *kallsyms_lookup_build
 	namebuf[KSYM_NAME_LEN - 1] = 0;
 	namebuf[0] = 0;
 
-	addr += PADDING_BYTES;
-
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -368,8 +348,6 @@ static const char *kallsyms_lookup_build
 
 found:
 	cleanup_symbol_name(namebuf);
-	if (ret && offset)
-		*offset -= PADDING_BYTES;
 	return ret;
 }
 
@@ -396,8 +374,6 @@ int lookup_symbol_name(unsigned long add
 	symname[0] = '\0';
 	symname[KSYM_NAME_LEN - 1] = '\0';
 
-	addr += PADDING_BYTES;
-
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -425,8 +401,6 @@ int lookup_symbol_attrs(unsigned long ad
 	name[0] = '\0';
 	name[KSYM_NAME_LEN - 1] = '\0';
 
-	addr += PADDING_BYTES;
-
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -443,8 +417,6 @@ int lookup_symbol_attrs(unsigned long ad
 		return res;
 
 found:
-	if (offset)
-		*offset -= PADDING_BYTES;
 	cleanup_symbol_name(name);
 	return 0;
 }
@@ -470,15 +442,8 @@ static int __sprint_symbol(char *buffer,
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


