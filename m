Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5276818FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbjA3S0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbjA3SZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:25:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B544708F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:24:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d3so12512330plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oZQ53k8sDIi9jBLs3iLBCqJLG9S0A73uETYb1fJYlI=;
        b=RORdYgIqpJhiT2xO57x39JpRwK2+L1YP/j8KtHmtUDhwVGOrsKIXsmHiJaCq2vsK7S
         Ma5JepDyFdyQh5oTKjKKlD2acJeJBcX2qUr3Vq5PyGBgmPi21mpCYwdgJD6T8LMrBURs
         Svuobo44XBMVzKF75A/b7L+pBRHseeTYQkNrXfauxnDQ/8FP56BcIB6AhsncH2NEAv/A
         cSpICfZhxgL/74xGDxqe/H2GAftpoPX5+9CG+6XCY9rNzu3P88VjuGKbVg4bETIITD+G
         LQd3QGvZmt6k07JYum1fb52IRLn7lnOdhszfFh87aXmh6rmq5TNFz/wFMOAPpPtM0fwg
         RQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oZQ53k8sDIi9jBLs3iLBCqJLG9S0A73uETYb1fJYlI=;
        b=nws7bTdBsxYKJ265yy4VTWhANpe0ImRcWoTWQ10JWX1aNOt9hweOXxdUIwFcPcwfF7
         1+mMwaohnQ6ZGQqbhbewqMFN3baZHwSRg6WMRbpNludM0WCDF6HkQi/GBpr964lyCNDG
         T2tChFtx4e6GtmEcB/tPer4HDWc2TkyF90wQXCEdvkKMisxViPDF6q/kDXCKq/uEzcCI
         rsnK6hoYMX43RCXsUc1Dyd3M3JcSBcJDY6DBMDPzVY3D8vYngDZDVS+4Bu13glymVVGQ
         /tsMdCaS7DI8uWaV1s+Kjr6MVSc2AyLW9sEcXorafmqaloOZKMVtsewf8gNhFMRvy4Fn
         O49w==
X-Gm-Message-State: AO0yUKXC0Z+1yV+bIX1LAXJ+xr+0NAYDoX1kB9d1QDU9dRyzyWbKHgWb
        XiBo5+tXvgIAFRocsZQAoCmOMw==
X-Google-Smtp-Source: AK7set9y+8gc1j7btVH3pLsk5baTgirNZhG6cKTLz7X/bnmrD8N8A0A22p9fmsha2Zc63KuBgHho2Q==
X-Received: by 2002:a05:6a20:d49b:b0:bc:c663:41b6 with SMTP id im27-20020a056a20d49b00b000bcc66341b6mr7187379pzb.28.1675103050552;
        Mon, 30 Jan 2023 10:24:10 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:24:10 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 21/24] RISC-V: ACPI: Add ACPI initialization in setup_arch()
Date:   Mon, 30 Jan 2023 23:52:22 +0530
Message-Id: <20230130182225.2471414-22-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
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

Initialize ACPI tables for RISC-V during boot.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/kernel/setup.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 4335f08ffaf2..5b4ad1baf664 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -8,6 +8,7 @@
  *  Nick Kossifidis <mick@ics.forth.gr>
  */
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
@@ -276,14 +277,22 @@ void __init setup_arch(char **cmdline_p)
 
 	efi_init();
 	paging_init();
+
+	/* Parse the ACPI tables for possible boot-time configuration */
+	acpi_boot_table_init();
+	if (acpi_disabled) {
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
-	unflatten_and_copy_device_tree();
+		unflatten_and_copy_device_tree();
 #else
-	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
-		unflatten_device_tree();
-	else
-		pr_err("No DTB found in kernel mappings\n");
+		if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
+			unflatten_device_tree();
+		else
+			pr_err("No DTB found in kernel mappings\n");
 #endif
+	} else {
+		early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)));
+	}
+
 	early_init_fdt_scan_reserved_mem();
 	misc_mem_init();
 
-- 
2.38.0

