Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B6A6011C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiJQOy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiJQOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31FB691AE;
        Mon, 17 Oct 2022 07:53:45 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018416;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAE92Gv2CqWdn0m33OE2fyomeYucTas60k68ZJws/sI=;
        b=zw36FngqttvDsfoiXLMGfdKUV4OGrc50S263ajOcnJOPr8Y6aUBeQ50eQRojAj19s9r3uT
        8eXGA+8CFgpRav+jH1+o8dN3aA7vMLur3eCYCsdEjb/UiuZ+6xSPiEU7w2yVG/GqyCJrRi
        fw6+5D/FfpEFrbFw7h5huYFc95bEWFvELfDDed+BQubAmHaCPBipquEOd7yCb1rhffUTIC
        dBIuKFfasulcPfTg0XUtnd+FSA49wIj9Q1vKf4JCN3JUl0QVZ8+GQgunzu+5PgG/u1PC+6
        85Fp23fY2sZrxsY5rOl0LKLSnXHswdc1FBBm9rghbuAMSzIkRb1gwThU8tFrjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018416;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAE92Gv2CqWdn0m33OE2fyomeYucTas60k68ZJws/sI=;
        b=O+27T1Ds6h/Pc/kdE33ZL3li2immt/ZBXqoj1/nzxtVUQWzhetD7U6nNtXNKw5eVmiIZuH
        QBT+il93+uQewyDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] kallsyms: Take callthunks into account
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111148.409656012@infradead.org>
References: <20220915111148.409656012@infradead.org>
MIME-Version: 1.0
Message-ID: <166601841516.401.9118798161796361063.tip-bot2@tip-bot2>
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

Commit-ID:     f1389181622a08d6f1c71407a64df36b809d632b
Gitweb:        https://git.kernel.org/tip/f1389181622a08d6f1c71407a64df36b809d632b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:17 +02:00

kallsyms: Take callthunks into account

Since the pre-symbol function padding is an integral part of the
symbol make kallsyms report it as part of the symbol by reporting it
as sym-x instead of prev_sym+y.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111148.409656012@infradead.org
---
 kernel/kallsyms.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 60c20f3..cc244c0 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -293,6 +293,12 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	return low;
 }
 
+#ifdef CONFIG_FUNCTION_PADDING_BYTES
+#define PADDING_BYTES	CONFIG_FUNCTION_PADDING_BYTES
+#else
+#define PADDING_BYTES	0
+#endif
+
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -300,13 +306,25 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 				unsigned long *offset)
 {
 	char namebuf[KSYM_NAME_LEN];
+	int ret;
+
+	addr += PADDING_BYTES;
 
 	if (is_ksym_addr(addr)) {
 		get_symbol_pos(addr, symbolsize, offset);
-		return 1;
+		ret = 1;
+		goto found;
+	}
+
+	ret = !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf);
+	if (!ret) {
+		ret = !!__bpf_address_lookup(addr, symbolsize,
+					     offset, namebuf);
 	}
-	return !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf) ||
-	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
+found:
+	if (ret && offset)
+		*offset -= PADDING_BYTES;
+	return ret;
 }
 
 static const char *kallsyms_lookup_buildid(unsigned long addr,
@@ -319,6 +337,8 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 	namebuf[KSYM_NAME_LEN - 1] = 0;
 	namebuf[0] = 0;
 
+	addr += PADDING_BYTES;
+
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -348,6 +368,8 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 
 found:
 	cleanup_symbol_name(namebuf);
+	if (ret && offset)
+		*offset -= PADDING_BYTES;
 	return ret;
 }
 
@@ -374,6 +396,8 @@ int lookup_symbol_name(unsigned long addr, char *symname)
 	symname[0] = '\0';
 	symname[KSYM_NAME_LEN - 1] = '\0';
 
+	addr += PADDING_BYTES;
+
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -401,6 +425,8 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 	name[0] = '\0';
 	name[KSYM_NAME_LEN - 1] = '\0';
 
+	addr += PADDING_BYTES;
+
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
 
@@ -417,6 +443,8 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 		return res;
 
 found:
+	if (offset)
+		*offset -= PADDING_BYTES;
 	cleanup_symbol_name(name);
 	return 0;
 }
@@ -442,8 +470,15 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	len = strlen(buffer);
 	offset -= symbol_offset;
 
-	if (add_offset)
-		len += sprintf(buffer + len, "+%#lx/%#lx", offset, size);
+	if (add_offset) {
+		char s = '+';
+
+		if ((long)offset < 0) {
+			s = '-';
+			offset = 0UL - offset;
+		}
+		len += sprintf(buffer + len, "%c%#lx/%#lx", s, offset, size);
+	}
 
 	if (modname) {
 		len += sprintf(buffer + len, " [%s", modname);
