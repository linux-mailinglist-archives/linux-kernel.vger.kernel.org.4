Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1061E74F03C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjGKNeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjGKNeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:34:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A8110C7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:34:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e46e83d7fso4728009a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689082447; x=1691674447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEE57oj+GdsJXanw66t6tys98dAd0Zr2j6aIYgyrMwY=;
        b=g/WuLHQmL7CPdZ+Ok7EIf7d1Xu/fG+L/P6L7zVdUBdCdF3Ez6u2boNDYnk61d0rIwj
         CMhftbvXawRc4ut4OCxgXIiUPgbP/rsImTOz2B8HxmeRaq9eF6BKXeU0OJDsQt/9fq4b
         Omv7FpHIZKArHhSa7+IyI4hQwJ3p5iJHaq3UHvNC2phwTCWfaEMyiofpiQ6MctE1k0/r
         O8P6NU63aexh8ylJO9t0TTSgQDsNUhjUAKDpP8Cr1C0QRUBHHVSDQ2hL1x8j9PzOh30Z
         rAe63UFW8+oZbcuikCVhHBL6m6zB9HM0St0jXu6KU6VY74MNzuetN4VKurTuF6z6CUsW
         0GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689082447; x=1691674447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEE57oj+GdsJXanw66t6tys98dAd0Zr2j6aIYgyrMwY=;
        b=NmcVs6x27TUslyTu8DlRSvRk1EK4Q7zZv3EH8OdQv3IO47bTio8FLSzVCBe3fEEY/E
         2pRegmQtcMPs73WnKoDYbWeDmq0fLMsg2MChDsRsQYfhjTV0xzThl+AdTnC18ZE9Zf0r
         eOMKZQkACqSZA+o/r7emeiy/Fzoc7yV2TICx4Dxqqiy0ipYQOQY5weOkxr2ItKVE7mho
         hE0ieA/qwR87pwibb3D5gRBjUHCfUDLgLsdGLjFIixnYZINvKePfVRMahE7ckf1uQQZL
         SQzw2lB8LPjgL5iDg65VhhEvF9Db40RNeIPzzvtCGENKAF1ZegEMhjM3mSHwva3z9+eQ
         F0ZQ==
X-Gm-Message-State: ABy/qLYKNg8m/mPhJcQO+NJIBB3fOO5C8DxAH8Xv4hKdgFVIZB4t7/nu
        JkieyDIyhjO/PGU7G40huYw=
X-Google-Smtp-Source: APBJJlECFO/61hgLZW4KZGoE5ATuuGswvkOlnPXeP+0NaXUEhKoKs3y0HJMojjzcdAiRR0YaNxWizw==
X-Received: by 2002:a05:6402:6cf:b0:51e:fa7:a292 with SMTP id n15-20020a05640206cf00b0051e0fa7a292mr14655910edy.12.1689082446838;
        Tue, 11 Jul 2023 06:34:06 -0700 (PDT)
Received: from andrea.ba.rivosinc.com ([2.199.74.220])
        by smtp.gmail.com with ESMTPSA id v15-20020a056402184f00b0051df6c2bb7asm1276862edy.38.2023.07.11.06.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:34:06 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 1/2] riscv,mmio: Fix readX()-to-delay() ordering
Date:   Tue, 11 Jul 2023 15:33:47 +0200
Message-Id: <20230711133348.151383-2-parri.andrea@gmail.com>
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

Section 2.1 of the Platform Specification [1] states:

  Unless otherwise specified by a given I/O device, I/O devices are on
  ordering channel 0 (i.e., they are point-to-point strongly ordered).

which is not sufficient to guarantee that a readX() by a hart completes
before a subsequent delay() on the same hart (cf. memory-barriers.txt,
"Kernel I/O barrier effects").

Set the I(nput) bit in __io_ar() to restore the ordering, align inline
comments.

[1] https://github.com/riscv/riscv-platform-specs

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/mmio.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
index aff6c33ab0c08..4c58ee7f95ecf 100644
--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -101,9 +101,9 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * Relaxed I/O memory access primitives. These follow the Device memory
  * ordering rules but do not guarantee any ordering relative to Normal memory
  * accesses.  These are defined to order the indicated access (either a read or
- * write) with all other I/O memory accesses. Since the platform specification
- * defines that all I/O regions are strongly ordered on channel 2, no explicit
- * fences are required to enforce this ordering.
+ * write) with all other I/O memory accesses to the same peripheral. Since the
+ * platform specification defines that all I/O regions are strongly ordered on
+ * channel 0, no explicit fences are required to enforce this ordering.
  */
 /* FIXME: These are now the same as asm-generic */
 #define __io_rbr()		do {} while (0)
@@ -125,14 +125,14 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #endif
 
 /*
- * I/O memory access primitives. Reads are ordered relative to any
- * following Normal memory access. Writes are ordered relative to any prior
- * Normal memory access.  The memory barriers here are necessary as RISC-V
+ * I/O memory access primitives.  Reads are ordered relative to any following
+ * Normal memory read and delay() loop.  Writes are ordered relative to any
+ * prior Normal memory write.  The memory barriers here are necessary as RISC-V
  * doesn't define any ordering between the memory space and the I/O space.
  */
 #define __io_br()	do {} while (0)
-#define __io_ar(v)	__asm__ __volatile__ ("fence i,r" : : : "memory")
-#define __io_bw()	__asm__ __volatile__ ("fence w,o" : : : "memory")
+#define __io_ar(v)	({ __asm__ __volatile__ ("fence i,ir" : : : "memory"); })
+#define __io_bw()	({ __asm__ __volatile__ ("fence w,o" : : : "memory"); })
 #define __io_aw()	mmiowb_set_pending()
 
 #define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
-- 
2.34.1

