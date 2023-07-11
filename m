Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21EB74F03E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjGKNeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGKNeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:34:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3AA10E7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:34:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e57874bfdso3228037a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689082450; x=1691674450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjSbzIFEjI+X1OOQ6m2DfrSrdZF0QXWrCZ+NzN3e1QQ=;
        b=E3/CeuSOmwHqwO+eKZA0MFEDZyoi+dMeScbz3G6OYrKt8mh4aZZM7S6KymL6RNKNoD
         WHfWPkgnXI4zx5iu1orD7MaeYfxvjK9ixUXu1C7nFV/+07WQ/6hX87o+ZKBKnA8Ftz4J
         CKeFy+FPHNKj46RX9EVDvyyOurs3DAKRtNUliIbMQqDeMlJhVnf/B2NbULja41sPatlr
         NiGNh1wqSnM5Ni70yYckNFhrF/z0QkztqpHl+9cjWZA826bk9gXyO4MuOCJ6avQsUV2Q
         4b3vStTEEH8VMLEAfWa9X4EFMrqkwezg/ckw4ybLwccGyHIbHbYRQa6xkCwBaEeqTLrE
         ijgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689082450; x=1691674450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjSbzIFEjI+X1OOQ6m2DfrSrdZF0QXWrCZ+NzN3e1QQ=;
        b=cJBcHmrIYMdRY7tPEA9PCf+BU664b9CLgdQcM3UCpWDdm3OIortvSkrgpDG9pDzGAK
         mqSyLJH0EpuY1kMrrK4j9jDobfGUwt2CU2/NJ5SWtyMIQyWRTGZfBnMPkV4wLUQtFEJ+
         bH2NL2ZUJam4tWqorK6KWDuTfcFtJdYz1wwgxhIfwdBOyPJXIAae+DMEx1iGk2b83+ze
         Gx4B0eKrGKOfacLHgpzYZoCKytrj8rpaXvZFAWEd+uExPUBlhqDPLGb4DnNsI1b85/T5
         R23o7bEPW3MtbocqderbHg3/5sc/hirWrc8hZOHo/GRcZo1q3nKyj4xauBuZUVASQLz4
         OYmQ==
X-Gm-Message-State: ABy/qLaH62efRH0IC9s6+ici0qVzkQkzyzcZLssY+y7A6J3PT6MpSAqw
        fACgtDHfoNtc6m1CPtOnnJc=
X-Google-Smtp-Source: APBJJlE/81QBvB0nKkNxHUfF5FvAefEWCsBQWnxuBLjwjlyq4Q3DeQLemAoCPTEAmYt4leMJcio/QQ==
X-Received: by 2002:aa7:c442:0:b0:51e:293b:e1ce with SMTP id n2-20020aa7c442000000b0051e293be1cemr14093106edr.31.1689082450137;
        Tue, 11 Jul 2023 06:34:10 -0700 (PDT)
Received: from andrea.ba.rivosinc.com ([2.199.74.220])
        by smtp.gmail.com with ESMTPSA id v15-20020a056402184f00b0051df6c2bb7asm1276862edy.38.2023.07.11.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:34:09 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 2/2] riscv,mmio: Use the generic implementation for the I/O accesses
Date:   Tue, 11 Jul 2023 15:33:48 +0200
Message-Id: <20230711133348.151383-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711133348.151383-1-parri.andrea@gmail.com>
References: <20230711133348.151383-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of readX(), writeX() and their "relaxed"
variants, readX_relaxed() and writeX_relaxed(), matches the generic
implementation; remove the redundant code.

No functional change intended.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/mmio.h | 68 ++++-------------------------------
 1 file changed, 6 insertions(+), 62 deletions(-)

diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
index 4c58ee7f95ecf..116b898fe969d 100644
--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -80,72 +80,16 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #endif
 
 /*
- * Unordered I/O memory access primitives.  These are even more relaxed than
- * the relaxed versions, as they don't even order accesses between successive
- * operations to the I/O regions.
- */
-#define readb_cpu(c)		({ u8  __r = __raw_readb(c); __r; })
-#define readw_cpu(c)		({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
-#define readl_cpu(c)		({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
-
-#define writeb_cpu(v, c)	((void)__raw_writeb((v), (c)))
-#define writew_cpu(v, c)	((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
-#define writel_cpu(v, c)	((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
-
-#ifdef CONFIG_64BIT
-#define readq_cpu(c)		({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
-#define writeq_cpu(v, c)	((void)__raw_writeq((__force u64)cpu_to_le64(v), (c)))
-#endif
-
-/*
- * Relaxed I/O memory access primitives. These follow the Device memory
- * ordering rules but do not guarantee any ordering relative to Normal memory
- * accesses.  These are defined to order the indicated access (either a read or
- * write) with all other I/O memory accesses to the same peripheral. Since the
- * platform specification defines that all I/O regions are strongly ordered on
- * channel 0, no explicit fences are required to enforce this ordering.
- */
-/* FIXME: These are now the same as asm-generic */
-#define __io_rbr()		do {} while (0)
-#define __io_rar()		do {} while (0)
-#define __io_rbw()		do {} while (0)
-#define __io_raw()		do {} while (0)
-
-#define readb_relaxed(c)	({ u8  __v; __io_rbr(); __v = readb_cpu(c); __io_rar(); __v; })
-#define readw_relaxed(c)	({ u16 __v; __io_rbr(); __v = readw_cpu(c); __io_rar(); __v; })
-#define readl_relaxed(c)	({ u32 __v; __io_rbr(); __v = readl_cpu(c); __io_rar(); __v; })
-
-#define writeb_relaxed(v, c)	({ __io_rbw(); writeb_cpu((v), (c)); __io_raw(); })
-#define writew_relaxed(v, c)	({ __io_rbw(); writew_cpu((v), (c)); __io_raw(); })
-#define writel_relaxed(v, c)	({ __io_rbw(); writel_cpu((v), (c)); __io_raw(); })
-
-#ifdef CONFIG_64BIT
-#define readq_relaxed(c)	({ u64 __v; __io_rbr(); __v = readq_cpu(c); __io_rar(); __v; })
-#define writeq_relaxed(v, c)	({ __io_rbw(); writeq_cpu((v), (c)); __io_raw(); })
-#endif
-
-/*
- * I/O memory access primitives.  Reads are ordered relative to any following
- * Normal memory read and delay() loop.  Writes are ordered relative to any
- * prior Normal memory write.  The memory barriers here are necessary as RISC-V
- * doesn't define any ordering between the memory space and the I/O space.
+ * I/O barriers
+ *
+ * See Documentation/memory-barriers.txt, "Kernel I/O barrier effects".
+ *
+ * Assume that each I/O region is strongly ordered on channel 0, following the
+ * RISC-V Platform Specification, "OS-A Common Requirements".
  */
 #define __io_br()	do {} while (0)
 #define __io_ar(v)	({ __asm__ __volatile__ ("fence i,ir" : : : "memory"); })
 #define __io_bw()	({ __asm__ __volatile__ ("fence w,o" : : : "memory"); })
 #define __io_aw()	mmiowb_set_pending()
 
-#define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
-#define readw(c)	({ u16 __v; __io_br(); __v = readw_cpu(c); __io_ar(__v); __v; })
-#define readl(c)	({ u32 __v; __io_br(); __v = readl_cpu(c); __io_ar(__v); __v; })
-
-#define writeb(v, c)	({ __io_bw(); writeb_cpu((v), (c)); __io_aw(); })
-#define writew(v, c)	({ __io_bw(); writew_cpu((v), (c)); __io_aw(); })
-#define writel(v, c)	({ __io_bw(); writel_cpu((v), (c)); __io_aw(); })
-
-#ifdef CONFIG_64BIT
-#define readq(c)	({ u64 __v; __io_br(); __v = readq_cpu(c); __io_ar(__v); __v; })
-#define writeq(v, c)	({ __io_bw(); writeq_cpu((v), (c)); __io_aw(); })
-#endif
-
 #endif /* _ASM_RISCV_MMIO_H */
-- 
2.34.1

