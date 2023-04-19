Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C576E783F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjDSLL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjDSLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A45A13F9C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a80d827179so10132295ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902623; x=1684494623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eblfm/T6iTpx+B5jQxcafLiaSwdeB6MwJNMx1053fIM=;
        b=DeZfx01ZX7Sehx3CCekOj5Wmh5/0E6L27Vt1u0RCG6Af7W4Ww6d99E98VCdUMc5ILQ
         ppeTAQ4ynNy3TiNv6XuWSxIGB7HqcDqzwIX1tzEXE/xJHgae/7yiQ786zEhoR6k3gOvX
         L8RXwIuD/Bcpb+fx+/tEgYMPtOMn/5RGiZHZQSsVTwbwnESwjJZgQKjJgS+CYdiWmv/X
         sTlTz+tcJxIHBX9j344JEvQHen6NftYor8JECB66GT3RicUQttnGHRgNi5k9OBP15w4r
         +bm2YkMfwA9+FPgWxfcfMf6baW+J4rq9LuYDUDbRWAWXCt8WxTxt6hmZHGKv+vMZxzEt
         z6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902623; x=1684494623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eblfm/T6iTpx+B5jQxcafLiaSwdeB6MwJNMx1053fIM=;
        b=XdFMMr2YsKNNzYQHqbxeYASfGeAwxhvJn9goi5e8jGYw/uRvUJ07CtBryCh1wKnU6z
         7NrwQf/dr3XkkV8M1n9LNU2aBWdgz6VXi5W+YH9DGv7LdTYmRvwCx/7AWthR8SyF7vLq
         vtS7AhrP2OcJCf73HLak15pV7FAA/TdnpCg+/+1V04sTrOQ41IHvQ55WLh/wG2uoFHq5
         ctDsN/UwfM1Ddygs9BX/P88ziy4Gwua5X6E0AE0vYI0SLWO+VPANnwUtoVE8XSQ1ryio
         ysVIBWLIubW7CZS/rOu6JuYB3frAm8fG/DzaQnvDJaeXVjl8/csObE+g8SvXQfUdXe51
         1L9g==
X-Gm-Message-State: AAQBX9dss5o5dCndAvwPBhTKEqKj46AImUER6KGjlqOVEPAinSqM94kE
        hEUlLQdoDWwP8b0/oapC+Ib8Zo4PQd+ASze/z5Y=
X-Google-Smtp-Source: AKy350bJa8ymH8vz3WwMTgd0nDwI9tA5BpeE2IV7rV3XHn6aSE8c09ru5XOxb+Nqph2c5N8uPATfhA==
X-Received: by 2002:a17:902:ab81:b0:1a6:4e7b:7037 with SMTP id f1-20020a170902ab8100b001a64e7b7037mr4418984plr.69.1681902623318;
        Wed, 19 Apr 2023 04:10:23 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:22 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ved Shanbhogue <ved@rivosinc.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Peter Newman <peternewman@google.com>, x86@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 09/21] RISC-V: QoS: add late_initcall to setup resctrl interface
Date:   Wed, 19 Apr 2023 04:10:59 -0700
Message-Id: <20230419111111.477118-10-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419111111.477118-1-dfustini@baylibre.com>
References: <20230419111111.477118-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add late_initcall which checks if the Ssqosid extension is present, and
if so, calls resctrl setup and sets cpu hotplug state to "qos:online".

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/kernel/qos/qos.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 arch/riscv/kernel/qos/qos.c

diff --git a/arch/riscv/kernel/qos/qos.c b/arch/riscv/kernel/qos/qos.c
new file mode 100644
index 000000000000..0b5fde06cbe1
--- /dev/null
+++ b/arch/riscv/kernel/qos/qos.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2023 Rivos Inc.
+
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/riscv_qos.h>
+
+#include <asm/csr.h>
+#include <asm/qos.h>
+
+#include "internal.h"
+
+static int __init qos_arch_late_init(void)
+{
+	int err;
+
+	if (!riscv_isa_extension_available(NULL, SSQOSID))
+		return -ENODEV;
+
+	err = qos_resctrl_setup();
+	if (err != 0)
+		return err;
+
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "qos:online", qos_resctrl_online_cpu,
+			  qos_resctrl_offline_cpu);
+
+	return err;
+}
+late_initcall(qos_arch_late_init);
-- 
2.34.1

