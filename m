Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9FB719957
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjFAKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjFAKSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:18:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15100E6B;
        Thu,  1 Jun 2023 03:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A08FC6431E;
        Thu,  1 Jun 2023 10:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2E8C433A0;
        Thu,  1 Jun 2023 10:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685614487;
        bh=Hrx9VtVZyq4uWMBfRCekQXUO/IA4A1XOafQormtZTuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpP21c/RwAJYJm+U25a1tWi/38F4mEWtcst293zmlG6D0PKkBX6d3h9ATwIa7uumf
         xA2hJJdQXNiMtmOQ7k+n+4Eh/tb5q0l+ZhSYKzMYnVQJJBECXK0Boas7FeJCclB+qU
         YcYICH1vai6DP7rq0TDqg3DTbnaTA2lnglkoOvwlhDm1fQ7nyhjt7rdP88kQv/EuQI
         aAPjl78FETn69M4Prx6Edwv1H7cz2NpKwM5xe4vWf7aC2SYCcxtbSZA9vK0QR4+ALQ
         VYyMUVtF0JdrmF3hiV5k4Z6ygm8TjniyOkfbF+4LCBKjd7eHTl1itn2XLvK6KpbTcp
         yOKt8OfWFYJOQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH 10/13] modules, jitalloc: prepare to allocate executable memory as ROX
Date:   Thu,  1 Jun 2023 13:12:54 +0300
Message-Id: <20230601101257.530867-11-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230601101257.530867-1-rppt@kernel.org>
References: <20230601101257.530867-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

When executable memory will be allocated as ROX it won't be possible to
update it using memset() and memcpy().

Introduce jit_update_copy() and jit_update_set() APIs and use them in
modules loading code instead of memcpy() and memset().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/jitalloc.h |  2 ++
 kernel/module/main.c     | 19 ++++++++++++++-----
 mm/jitalloc.c            | 20 ++++++++++++++++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/linux/jitalloc.h b/include/linux/jitalloc.h
index 7f8cafb3cfe9..0ba5ef785a85 100644
--- a/include/linux/jitalloc.h
+++ b/include/linux/jitalloc.h
@@ -55,6 +55,8 @@ struct jit_alloc_params *jit_alloc_arch_params(void);
 void jit_free(void *buf);
 void *jit_text_alloc(size_t len);
 void *jit_data_alloc(size_t len);
+void jit_update_copy(void *buf, void *new_buf, size_t len);
+void jit_update_set(void *buf, int c, size_t len);
 
 #ifdef CONFIG_JIT_ALLOC
 void jit_alloc_init(void);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 91477aa5f671..9f0711c42aa2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1197,9 +1197,19 @@ void __weak module_arch_freeing_init(struct module *mod)
 
 static void *module_memory_alloc(unsigned int size, enum mod_mem_type type)
 {
-	if (mod_mem_type_is_data(type))
-		return jit_data_alloc(size);
-	return jit_text_alloc(size);
+	void *p;
+
+	if (mod_mem_type_is_data(type)) {
+		p = jit_data_alloc(size);
+		if (p)
+			memset(p, 0, size);
+	} else {
+		p = jit_text_alloc(size);
+		if (p)
+			jit_update_set(p, 0, size);
+	}
+
+	return p;
 }
 
 static void module_memory_free(void *ptr, enum mod_mem_type type)
@@ -2223,7 +2233,6 @@ static int move_module(struct module *mod, struct load_info *info)
 			t = type;
 			goto out_enomem;
 		}
-		memset(ptr, 0, mod->mem[type].size);
 		mod->mem[type].base = ptr;
 	}
 
@@ -2251,7 +2260,7 @@ static int move_module(struct module *mod, struct load_info *info)
 				ret = -ENOEXEC;
 				goto out_enomem;
 			}
-			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
+			jit_update_copy(dest, (void *)shdr->sh_addr, shdr->sh_size);
 		}
 		/*
 		 * Update the userspace copy's ELF section address to point to
diff --git a/mm/jitalloc.c b/mm/jitalloc.c
index 16fd715d501a..a8ae64364d56 100644
--- a/mm/jitalloc.c
+++ b/mm/jitalloc.c
@@ -7,6 +7,16 @@
 
 static struct jit_alloc_params jit_alloc_params;
 
+static inline void jit_text_poke_copy(void *dst, const void *src, size_t len)
+{
+	memcpy(dst, src, len);
+}
+
+static inline void jit_text_poke_set(void *addr, int c, size_t len)
+{
+	memset(addr, c, len);
+}
+
 static void *jit_alloc(size_t len, unsigned int alignment, pgprot_t pgprot,
 		       unsigned long start, unsigned long end,
 		       unsigned long fallback_start, unsigned long fallback_end,
@@ -86,6 +96,16 @@ void *jit_data_alloc(size_t len)
 			 fallback_start, fallback_end, kasan);
 }
 
+void jit_update_copy(void *buf, void *new_buf, size_t len)
+{
+	jit_text_poke_copy(buf, new_buf, len);
+}
+
+void jit_update_set(void *addr, int c, size_t len)
+{
+	jit_text_poke_set(addr, c, len);
+}
+
 struct jit_alloc_params * __weak jit_alloc_arch_params(void)
 {
 	return NULL;
-- 
2.35.1

