Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5782C604706
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiJSN1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiJSN0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:26:45 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A01DC80F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:13:08 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x188so19186821oig.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAvEVwdPVzOcq2kBtufcX9nitBNib2gQ4gtkOEEFeSI=;
        b=lxyzgM77oVhyr2xYFxJj6wgQvry6rw4Y/+zIvaG6JfmYtSzQ+X/1aPsePwBNrnegwI
         UrY3/A1/YLrrc1SIB0jp8+zD7aA98y9QtCArUpqYXnMw5Dl6VWnG3iDZuyf1BgGGohqT
         1l9CyxXHnpqjwurbYuT9nD7l0kpliUcju0mwn+yFEAvwgXbH6lu8+EDbPW1ou1EWw4d0
         i8arRfQLRw/k0jmr0IQml/LWHNUCdyXuEptr8wqAxovxLLP0t6dVC1zBEVwFmRU6HrPR
         foFXA9X8UDYRdXrxUc+XpDAQmh4P+zLMHzd7Q4Ct6xrxImFMYovLYXg9s6KdCxtlBdrg
         3gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAvEVwdPVzOcq2kBtufcX9nitBNib2gQ4gtkOEEFeSI=;
        b=vjuYNauTUwzvhyf5vtFOPGDYvN6XWyYkh64tDz9iAL0KTcDB2P9cdFTpbWyLd4rB9a
         j908noITuEmRd5RCKNaeQKYMeCnGfBX5mNAGAlkxVHvX22mAejIzqZRLkFccLb4xI+mF
         2IDrM+nxTfBBhBnlAzhIlJKrKHVrasT3a1HAdFc04h7mt/JVGws0WqeDAbY5TPplE3lO
         zXcfa0DGtBn0h34hY+CdDqsgQ32mCaP5J6oLttI35WkpnlWABRs1tE3RM9meVbs1qiZQ
         IUNXXKbSXSZ4CAO2DOympHRKZD/9hFDSNZSRFPPkO41Hj48tKLHHTp+1JkBh/jAQTY2h
         jnNg==
X-Gm-Message-State: ACrzQf2cWQzrpesvBmYog8hgw1D3ayZ2DRs43PvVeuDiJjsvCwlLiDtH
        QvgmbdThcapYqDcY8cHErFQJF+SXtI871g==
X-Google-Smtp-Source: AMsMyM6ea6y78yP7zvn7fmEDAEjq1F7za/6iBEos6YJxPN0ITU1VfQyHOKcpYsTQpoGZjSvFb+JmVQ==
X-Received: by 2002:a17:90b:4c52:b0:20d:7917:4cb3 with SMTP id np18-20020a17090b4c5200b0020d79174cb3mr45614039pjb.6.1666185105397;
        Wed, 19 Oct 2022 06:11:45 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.102])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b00172897952a0sm10934478plc.283.2022.10.19.06.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 06:11:44 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v4 2/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
Date:   Wed, 19 Oct 2022 18:41:26 +0530
Message-Id: <20221019131128.237026-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019131128.237026-1-apatel@ventanamicro.com>
References: <20221019131128.237026-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all flavors of ioremap_xyz() function maps to the generic
ioremap() which means any ioremap_xyz() call will always map the
target memory as IO using _PAGE_IOREMAP page attributes. This breaks
ioremap_cache() and ioremap_wc() on systems with Svpbmt because memory
remapped using ioremap_cache() and ioremap_wc() will use _PAGE_IOREMAP
page attributes.

To address above (just like other architectures), we implement RISC-V
specific ioremap_cache() and ioremap_wc() which maps memory using page
attributes as defined by the Svpbmt specification.

Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/io.h      | 10 ++++++++++
 arch/riscv/include/asm/pgtable.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 92080a227937..92a31e543388 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -133,6 +133,16 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, count)
 #endif
 
+#ifdef CONFIG_MMU
+#define ioremap_wc(addr, size)		\
+	ioremap_prot((addr), (size), _PAGE_IOREMAP_WC)
+#endif
+
 #include <asm-generic/io.h>
 
+#ifdef CONFIG_MMU
+#define ioremap_cache(addr, size)	\
+	ioremap_prot((addr), (size), _PAGE_KERNEL)
+#endif
+
 #endif /* _ASM_RISCV_IO_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7ec936910a96..346b7c1a3eeb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -182,6 +182,8 @@ extern struct pt_alloc_ops pt_ops __initdata;
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
 #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
+#define _PAGE_IOREMAP_WC	((_PAGE_KERNEL & ~_PAGE_MTMASK) | \
+				 _PAGE_NOCACHE)
 #define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
 
 extern pgd_t swapper_pg_dir[];
-- 
2.34.1

