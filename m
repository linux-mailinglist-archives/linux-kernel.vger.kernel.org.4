Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE26E853E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjDSWwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDSWv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:51:59 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B2B1701
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:51:57 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-187e041b08aso219060fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681944716; x=1684536716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fg2apWNkO7XMTsfLYU3rTZlWorsx4wHesUuN9ZGrN4=;
        b=WUbj02UeMcy41XsHfO98vaNJDQDNXOQqCfRLlmEVm+ZZFRt6mhnFrbDdTfkc/I1z79
         unuw4UFr4ejB6HTO31GuZYdxMlyioQUJLEEV7XA1gad9fEVKDdcEASFYXDTKgEMBlPP4
         S4XhPju/QU8A7ExikNsYonS/aqhxnqeM8OUdNDEOlE8VJN4NPf5s/b1nAEXe7872N6Tk
         88iAlzzgE9pw87Adp8YHXdgS7/5WUMtESFJXxZJEi+XklFQPr7GwS/3TrawtWlZnDc+6
         zauOLx4Uku9QIWyggawkI82lC1+om8T/kjgLhnbllz6HB6vRk3t3L6/x6h9Wf2FM0xB7
         EfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681944716; x=1684536716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fg2apWNkO7XMTsfLYU3rTZlWorsx4wHesUuN9ZGrN4=;
        b=lzYa2F6UGmC6dCuIBblK5pqMbQHO6DCeTMDhn3id7wTfz9LAbMidGb8SSptjMcx5Vr
         AYQmLR+MH6YKnMKx8qWfPG9B/3aHpdWHFYZYOann+Dk8+dMDiPhxZ7Jsobjc+ZMKXOIK
         cfNFPAcSPATnRUwZfO5Bxo4urDeVMtIqjwr3gUH98A7HtfNNMvFct/yYtbIzw1T0BXdS
         0ZvyKGTWM6g8+bf2vykopsz1PoLBENjXMX53RfPO9hSdOUdORM/fuaEL9qFnMS90R8DM
         O8WgXQWtklDzfTSaQbihgv4VQeGDceqJ2LdnwlQJ6Z5ZVBNyLCYqUuUZtkXYw6Yd4ILw
         G3rg==
X-Gm-Message-State: AAQBX9dGTs0rv/57933lWuTtTdiWXCdjxri5kfjf7b9vNAQnktjIJm5Q
        m6PU6hzRdW4RMnWiToitXjngahaHA27n0tmRy5w=
X-Google-Smtp-Source: AKy350bcbgE/EJ3Ej08OUUDHS562dStL1nY59dRLyQva3UBkO8qD2X/slMFNk57ZH7aSQKcUf51qPw==
X-Received: by 2002:a17:902:a504:b0:1a1:be45:9857 with SMTP id s4-20020a170902a50400b001a1be459857mr6646673plq.1.1681942754165;
        Wed, 19 Apr 2023 15:19:14 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:19:13 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-coco@lists.linux.dev, Dylan Reid <dylan@rivosinc.com>,
        abrestic@rivosinc.com, Samuel Ortiz <sameo@rivosinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC 47/48] RISC-V: Add shared bounce buffer to support DBCN for CoVE Guest.
Date:   Wed, 19 Apr 2023 15:17:15 -0700
Message-Id: <20230419221716.3603068-48-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419221716.3603068-1-atishp@rivosinc.com>
References: <20230419221716.3603068-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

Early console buffer needs to be shared with the host for CoVE Guest.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/tty/serial/earlycon-riscv-sbi.c | 51 ++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
index 311a4f8..9033cca 100644
--- a/drivers/tty/serial/earlycon-riscv-sbi.c
+++ b/drivers/tty/serial/earlycon-riscv-sbi.c
@@ -9,6 +9,14 @@
 #include <linux/init.h>
 #include <linux/serial_core.h>
 #include <asm/sbi.h>
+#include <asm/cove.h>
+#include <asm/covg_sbi.h>
+#include <linux/memblock.h>
+
+#ifdef CONFIG_RISCV_COVE_GUEST
+#define DBCN_BOUNCE_BUF_SIZE (PAGE_SIZE)
+static char dbcn_buf[DBCN_BOUNCE_BUF_SIZE] __aligned(PAGE_SIZE);
+#endif
 
 #ifdef CONFIG_RISCV_SBI_V01
 static void sbi_putc(struct uart_port *port, unsigned char c)
@@ -24,6 +32,33 @@ static void sbi_0_1_console_write(struct console *con,
 }
 #endif
 
+#ifdef CONFIG_RISCV_COVE_GUEST
+static void sbi_dbcn_console_write_cove(struct console *con, const char *s,
+					unsigned int n)
+{
+	phys_addr_t pa = __pa(dbcn_buf);
+	unsigned int off = 0;
+
+	while (off < n) {
+		const unsigned int rem = n - off;
+		const unsigned int size =
+			rem > DBCN_BOUNCE_BUF_SIZE ? DBCN_BOUNCE_BUF_SIZE : rem;
+
+		memcpy(dbcn_buf, &s[off], size);
+
+		sbi_ecall(SBI_EXT_DBCN, SBI_EXT_DBCN_CONSOLE_WRITE,
+#ifdef CONFIG_32BIT
+			  size, pa, (u64)pa >> 32,
+#else
+			  size, pa, 0,
+#endif
+			  0, 0, 0);
+
+		off += size;
+	}
+}
+#endif
+
 static void sbi_dbcn_console_write(struct console *con,
 				   const char *s, unsigned n)
 {
@@ -45,14 +80,26 @@ static int __init early_sbi_setup(struct earlycon_device *device,
 
 	/* TODO: Check for SBI debug console (DBCN) extension */
 	if ((sbi_spec_version >= sbi_mk_version(1, 0)) &&
-	    (sbi_probe_extension(SBI_EXT_DBCN) > 0))
+	    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
+#ifdef CONFIG_RISCV_COVE_GUEST
+		if (is_cove_guest()) {
+			ret = sbi_covg_share_memory(__pa(dbcn_buf),
+						    DBCN_BOUNCE_BUF_SIZE);
+			if (ret)
+				return ret;
+
+			device->con->write = sbi_dbcn_console_write_cove;
+			return 0;
+		}
+#endif
 		device->con->write = sbi_dbcn_console_write;
-	else
+	} else {
 #ifdef CONFIG_RISCV_SBI_V01
 		device->con->write = sbi_0_1_console_write;
 #else
 		ret = -ENODEV;
 #endif
+	}
 
 	return ret;
 }
-- 
2.25.1

