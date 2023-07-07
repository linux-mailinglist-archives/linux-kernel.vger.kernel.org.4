Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F9674B4D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjGGQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjGGQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:03:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD51BF4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:03:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b7fb1a82c4so12112745ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688745782; x=1691337782;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=kF0uQEN662Ylwi2u8B6YjR1hUODDsncC9aFANUny7O8=;
        b=cYoTElhkxPgxMxbMBtiYHiY7zIG+iRfcpLBx18CvRbyyrYJav4Qlg47Aj69t/rdGZj
         UPMEVD5biF0LlK2QptEmZgbDod1gpbFgcl4UFNF7c/xXBHa3QPeLiRlLu6g77JNm7dWi
         KV34YgdDOOywcumWNpQrGsqcp/x2cTkv33JUr1OmsyW7yhaRIhpxiqI9bkUzcrc0EwU6
         Umcboojqup8T8nMnNl6M5MhaKyFDjKWiffKk8VFp6JsqIFw5zljomlNM9gU+F5yKGAoH
         Ym3KEsN0d3PF6VNryEYS1YQDXP/49075KvpKJrLQvKQZmsM8gJtC1HpkYwdUoxF35ARu
         q6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745782; x=1691337782;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kF0uQEN662Ylwi2u8B6YjR1hUODDsncC9aFANUny7O8=;
        b=Ink8HytzxViQFzkNdlRkoefsWukSpaoUQgf+rc6SVa16HfGlxS0bAEaFvDqTHR6rAt
         YllgKMamqOq+i9HLphC0lW7WfuVyNSrtfvFcwOD1K1hiU+g2ZqHRFfUlxxcWg0dPEryA
         4Lf32iFZ1/uXuqHGWpFC58Pc4NCfumSP5ZQQz+Ijnm/HL/AnvCszF/HXLYKxNALslR2i
         HHleU7jYYFeDCDQ2NePCdbja2KHuXbL2UpwwKOnBxqljuVysgn6UWCdjgn6qiug7P+KV
         nxi1m4ohJ1Ll1clIcAc9U5vLRRISS61g29T1HHVZxmg4PiT2oFXVZ6iZQBo88DfCmO+L
         6+Mg==
X-Gm-Message-State: ABy/qLbJGhgFKbjutd9b7oR8X9sPmAuoy4dO9c3AbXW/9nM45jkrRE9E
        v1vA19OlO9sTS/9GHa82nO1Pp8QvKnPSNhPtWhU=
X-Google-Smtp-Source: APBJJlGNN3z7qOn51JWWxegL0GEQ8tvT7dLoK6EFuISJia98DCx0aGARl5XCxRkkRmZuVvjqqBt/Eg==
X-Received: by 2002:a17:902:d508:b0:1b8:4ec2:5200 with SMTP id b8-20020a170902d50800b001b84ec25200mr5567552plg.2.1688745782222;
        Fri, 07 Jul 2023 09:03:02 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001b567bbe82dsm3454695plg.150.2023.07.07.09.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:03:01 -0700 (PDT)
Subject: [PATCH v2] module: Ignore RISC-V mapping symbols too
Date:   Fri,  7 Jul 2023 09:00:51 -0700
Message-ID: <20230707160051.2305-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     mcgrof@kernel.org, rdunlap@infradead.org, thomas@t-8ch.de
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V has an extended form of mapping symbols that we use to encode
the ISA when it changes in the middle of an ELF.  This trips up modpost
as a build failure, I haven't yet verified it yet but I believe the
kallsyms difference should result in stacks looking sane again.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/all/9d9e2902-5489-4bf0-d9cb-556c8e5d71c2@infradead.org/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
Changes since v1 <20230707054007.32591-1-palmer@rivosinc.com/>:

* Drop the unnecessary IS_RISCV define and just inline it.
---
 include/linux/module_symbol.h | 12 +++++++++++-
 kernel/module/kallsyms.c      |  2 +-
 scripts/mod/modpost.c         |  2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 7ace7ba30203..5b799942b243 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -3,12 +3,22 @@
 #define _LINUX_MODULE_SYMBOL_H
 
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
-static inline int is_mapping_symbol(const char *str)
+static inline int is_mapping_symbol(const char *str, int is_riscv)
 {
 	if (str[0] == '.' && str[1] == 'L')
 		return true;
 	if (str[0] == 'L' && str[1] == '0')
 		return true;
+	/*
+	 * RISC-V defines various special symbols that start with "$".  The
+	 * mapping symbols, which exist to differentiate between incompatible
+	 * instruction encodings when disassembling, show up all over the place
+	 * and are generally not meant to be treated like other symbols.  So
+	 * just ignore any of the special symbols.
+	 */
+	if (is_riscv)
+		return str[0] == '$';
+
 	return str[0] == '$' &&
 	       (str[1] == 'a' || str[1] == 'd' || str[1] == 't' || str[1] == 'x')
 	       && (str[2] == '\0' || str[2] == '.');
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index ef73ae7c8909..78a1ffc399d9 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -289,7 +289,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 		 * and inserted at a whim.
 		 */
 		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
-		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
+		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i), IS_ENABLED(CONFIG_RISCV)))
 			continue;
 
 		if (thisval <= addr && thisval > bestval) {
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b29b29707f10..7c71429d6502 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1052,7 +1052,7 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 
 	if (!name || !strlen(name))
 		return 0;
-	return !is_mapping_symbol(name);
+	return !is_mapping_symbol(name, elf->hdr->e_machine == EM_RISCV);
 }
 
 /* Look up the nearest symbol based on the section and the address */
-- 
2.41.0

