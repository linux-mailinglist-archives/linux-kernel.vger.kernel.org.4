Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B219F60457B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiJSMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiJSMh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:37:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6B1382CA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:18:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l4so17061139plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAvEVwdPVzOcq2kBtufcX9nitBNib2gQ4gtkOEEFeSI=;
        b=FXlNG2VASXiEp9WSI7gST2fu64ZG/1MiT8WEB7Uxmw/y0b7OjAUZGRDYvLNjDytDLY
         pvAzzPZJ+LmY7b0hcxlD//VXwXXsAzaQgD0+mgzzAA8fk5uNO0tA5N5ciZ3kyzQvH8Bp
         CGJcMh7Ckrw8tGK/ZJHfAaEs+aW//lEy1LnrRfWGZj2aWN3c6RCCzp75an3TiiUC3jOQ
         8BXMkRnHTUXGDtYgF4ZaHTmyt6Y8dgQ9LgpxaMpuGc5JoGiwt0363vHJr7OUktUvnxDn
         XDvjcV2FkSNyeXcazWx6OpYqRLPc24U+hEpQp8qZipU/ROs7HYq/VxgN63U2jrArJFoC
         0f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAvEVwdPVzOcq2kBtufcX9nitBNib2gQ4gtkOEEFeSI=;
        b=wLGN9OGfO8S/Q6QO1OGJuR6nQAp8FbMzwzY4wdY5QkH47SwZJNf6dEoIdHzkLh5Zjr
         gxVtoT2cc4Rcw/7Wq/cgoe/JwP2Xm0d44tEQTrm1y1WjbZlDhjSd19TbCCHTBmanLvzK
         ckv/A/cU3AVnya+IkghnXbPpm/hRclLybFvqNDUkPwmFIRNp9GzD6xnjwomm3bwV5QE6
         aKxmSjAO8LG6OoZX1BedN4wM7KZU3gKNb9Ml+1p7ZKiQlHsXBuCbCfbxqZij9oaAWTj6
         X2ozenFDzernBndPGrrz4MCHoETxNFDddjwV+JChXlViJ/4Okb7IbjyXQFKBMFNw8Jz1
         gagg==
X-Gm-Message-State: ACrzQf0UWqE0Sc+8iMh0IUBIUTPKVayaWDztb7eCGPt17Ac5Kc3uYnqi
        rKmjDTpX22tGVE51b69Ww9XOWw==
X-Google-Smtp-Source: AMsMyM4r+1sZX98RIcCz29nMUVrrLREHUkLHWWcnq3T4bJXz+0LCLIef/LZFzsKGD/QCnVFFTkgmuA==
X-Received: by 2002:a17:902:d4c5:b0:183:6e51:503 with SMTP id o5-20020a170902d4c500b001836e510503mr8105943plg.84.1666181813665;
        Wed, 19 Oct 2022 05:16:53 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.102])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0017e93c158d7sm10529824pla.214.2022.10.19.05.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 05:16:52 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v3 2/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
Date:   Wed, 19 Oct 2022 17:46:20 +0530
Message-Id: <20221019121622.179024-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019121622.179024-1-apatel@ventanamicro.com>
References: <20221019121622.179024-1-apatel@ventanamicro.com>
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

