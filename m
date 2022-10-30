Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68F612947
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ3JPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3JPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:15:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEDD105
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eZHBFKGdlyvjUyOtZTxUlT0c0Nkd2MWDN13FYETBKps=; b=jzcCgFmGAhpsVf9TpFX3FZBzO8
        lLgOTW76i26CufAPzWCOPbQWf5ypSRHq3QbqB4jy9wM5J/BU4MqMQe2/2sP+hH9GVvKlN9qHfkqtT
        OhG+dGiAgGAQ95f9yUWuuPfvz1Mr9Y0PVGlnf8TGrsTgxv1BU/asarXwK7gbDvl5BY62b7jAhXKwR
        zxCLNfznPMq93S1MTex+h1oIygdkeAPwpwxHt/j6pD8JkLsPXsPTninPK20vmgrcRMtjkU62So/Tn
        1nDyCw9X+OZ6t1G15GA9e0CyyB1kTXb3W4vQMZwxjZle0oOfym+mtfK5TThpnNBlo6hLCBhmkDLuZ
        JIXF2jiQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op4Ph-002mWJ-95; Sun, 30 Oct 2022 09:15:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E659D30017F;
        Sun, 30 Oct 2022 10:15:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAE9D203DCBE0; Sun, 30 Oct 2022 10:15:22 +0100 (CET)
Date:   Sun, 30 Oct 2022 10:15:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, djwong@kernel.org,
        yujie.liu@intel.com, tglx@linutronix.de, jpoimboe@kernel.org,
        joao.moreira@intel.com, samitolvanen@google.com
Subject: Re: [PATCH 0/5] x86/kallsyms: Fix the call-thunk kallsyms fail
Message-ID: <Y15AqvPo/JqjVjTx@hirez.programming.kicks-ass.net>
References: <20221028194022.388521751@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028194022.388521751@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:40:22PM +0200, Peter Zijlstra wrote:
> Hi all,
> 
> As reported here:
> 
>   https://lkml.kernel.org/r/202210241614.2ae4c1f5-yujie.liu@intel.com
> 
> The kallsyms change for call-thunks doesn't really work out as expected. These
> patches revert that change and propose an alternative.

Robot found it needed the below; have folded back and pushed out again.

---
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cf743520a786..55066c493570 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3479,7 +3479,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
-			if (!strncmp(func->name, "__cfi_", 6))
+			if (!strncmp(func->name, "__cfi_", 6) ||
+			    !strncmp(func->name, "__pfx_", 6))
 				return 0;
 
 			WARN("%s() falls through to next function %s()",
@@ -4042,6 +4043,7 @@ static int add_prefix_symbol(struct objtool_file *file, struct symbol *func,
 
 	for (;;) {
 		struct instruction *prev = list_prev_entry(insn, list);
+		u64 offset;
 
 		if (&prev->list == &file->insn_list)
 			break;
@@ -4049,11 +4051,13 @@ static int add_prefix_symbol(struct objtool_file *file, struct symbol *func,
 		if (prev->type != INSN_NOP)
 			break;
 
-		insn = prev;
-		if (func->offset - prev->offset == opts.prefix) {
-			elf_create_prefix_symbol(file->elf, func, -opts.prefix);
+		offset = func->offset - prev->offset;
+		if (offset >= opts.prefix) {
+			if (offset == opts.prefix)
+				elf_create_prefix_symbol(file->elf, func, opts.prefix);
 			break;
 		}
+		insn = prev;
 	}
 
 	return 0;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 9fbdad7a565d..3d636d12d679 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -822,7 +822,7 @@ elf_create_section_symbol(struct elf *elf, struct section *sec)
 static int elf_add_string(struct elf *elf, struct section *strtab, char *str);
 
 struct symbol *
-elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long addend)
+elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size)
 {
 	struct symbol *sym = calloc(1, sizeof(*sym));
 	size_t namelen = strlen(orig->name) + sizeof("__pfx_");
@@ -840,7 +840,8 @@ elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long addend)
 
 	sym->sym.st_name = elf_add_string(elf, NULL, name);
 	sym->sym.st_info = orig->sym.st_info;
-	sym->sym.st_value = orig->sym.st_value + addend;
+	sym->sym.st_value = orig->sym.st_value - size;
+	sym->sym.st_size = size;
 
 	sym = __elf_create_symbol(elf, sym);
 	if (sym)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 9e3bd4717a11..b6974e3173aa 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -146,7 +146,7 @@ static inline bool has_multiple_files(struct elf *elf)
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
-struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long addend);
+struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 		  unsigned int type, struct symbol *sym, s64 addend);
