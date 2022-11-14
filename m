Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB016278AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiKNJHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiKNJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:07:24 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7941D0E0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:06:07 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-13bd19c3b68so11822386fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuilwbSjTkXNw6j4kYlnUJ0pwJrZlWFK5/+cTZqJbNQ=;
        b=dQRXwhn6GU2oVP9rmiDV3LUCEuVG7c7xXVfDgz5AhmWkHM8hafgbZ/QHBKe+g4lGKW
         QR5nRzGhcT8FM66NbfL8s176tW+pVjyTNeKuEKWYJnDSt0jZ51P0A+v8UPHkMAAXw29f
         jJM2IB/NM2lasvFAhF0rYCg4NIIbvCUh+vJnYoiaoorf1I2Q9m6ZHXcQSVuGCw6Zzc4q
         zVvCH4Gpl0o/QBnZnvrl3VrC3NcG9cg8LNxiH505rLVesy3Zj3oGEiVtT6JhlHOQGQ2f
         7N9/bjufSTQquYrJJf8+R5BvxCpVJIGRpWTzkxYZF6zYe7UkkMrjbCJBs+yty/MqIynj
         OEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuilwbSjTkXNw6j4kYlnUJ0pwJrZlWFK5/+cTZqJbNQ=;
        b=MFEHdQTODE863t1JilbZVih7OvxtRRZDZA0ro/6ntn9X9MSUi4ab2gqzMtRT0kOmmt
         C5mcDvyrlTajyL4LYFEfA6uMX4rmJaC+wxOYNZrXeIWwLUATNxEEXFm26Vp+xJyBoEPD
         Kq9XQcPcwFuIXn8iIdEE7I9WLKEItQfFc0dST98+6svDYpUV5KtxB00QzDrkKyYfBZUF
         VejKu1r0lWUUjBCSvcmPwF2ZiSYgspE1tBVL9GBFnk8Rwd+l+ivg2FvCGZnazfwwk+zQ
         MDhDXZOTdczlfvP1S4N+c2c2iQwvTdY8kx+xFelCe+pqFItKcgwIilalJLTJcn9f3Cp3
         /pfQ==
X-Gm-Message-State: ANoB5pmyMC6APyy5OMzdpSkimN0PdfOBTRm4E33VTCzQ/89fK999Bc+D
        zbpfkEulJN7mVvVysUg6wErx9Q==
X-Google-Smtp-Source: AA0mqf7B5kjNytx8G6jhKFnk9HRp3NbSU55I/62IjswwphuZUNYZsUlMNIY/ARMiNb+zq4pMcv229w==
X-Received: by 2002:a05:6871:4192:b0:13b:6d76:8bcb with SMTP id lc18-20020a056871419200b0013b6d768bcbmr6016240oab.281.1668416767176;
        Mon, 14 Nov 2022 01:06:07 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020aca2402000000b00354948e04e4sm3432939oic.2.2022.11.14.01.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:06:06 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v6 1/3] RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
Date:   Mon, 14 Nov 2022 14:35:34 +0530
Message-Id: <20221114090536.1662624-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090536.1662624-1-apatel@ventanamicro.com>
References: <20221114090536.1662624-1-apatel@ventanamicro.com>
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

Currently, the memremap() called with MEMREMAP_WB maps memory using
the generic ioremap() function which breaks on system with Svpbmt
because memory mapped using _PAGE_IOREMAP page attributes is treated
as strongly-ordered non-cacheable IO memory.

To address this, we implement RISC-V specific arch_memremap_wb()
which maps memory using _PAGE_KERNEL page attributes resulting in
write-back cacheable mapping on systems with Svpbmt.

Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/io.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 92080a227937..42497d487a17 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -135,4 +135,9 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 
 #include <asm-generic/io.h>
 
+#ifdef CONFIG_MMU
+#define arch_memremap_wb(addr, size)	\
+	((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
+#endif
+
 #endif /* _ASM_RISCV_IO_H */
-- 
2.34.1

