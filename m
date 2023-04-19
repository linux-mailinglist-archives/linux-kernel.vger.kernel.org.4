Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16EE6E783D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjDSLLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjDSLLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:11:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1507213C3F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a68f2345c5so21727755ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681902626; x=1684494626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F7zU+i+fgt15KwVVGwxKhOm7NGAJEpboJ7iHtKcEtA=;
        b=aV4uFLLXRbU0iBRIE297Q6EuQGVnLdUjGgZomWyhtilxlo1Xq5JPOtPmXFKRcqinT0
         ofpucAcyCK12hWD3OSGm2ZBa8cCd7SRz725V46cfkz9Mc3how+qc46mk/Pv1Iir4XwH3
         I+W9X2ydKb5X5SejIFVpYeCGYnMLe84eo3oyFXWBojouGseR4qBtPkM36th81qqCXb6S
         xugkArjRhlFMZwiJYvBNhF+f6h98sog5nw474YuDtsxZCN2cq0gloi3bUk3KqowxoeZk
         zrdDTH+1ANXXhbvzhlyXrcyTllVHQhr4OuyPAT2dipwlDOYDrEYiFYl4VgX1JrWJnY+3
         NgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902626; x=1684494626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1F7zU+i+fgt15KwVVGwxKhOm7NGAJEpboJ7iHtKcEtA=;
        b=PyzghGBNOe4w6Kc/J6hVTngTfAB7wYiMC/SRFPQZ5VW0rKAR34meIx7sjl5Y39fDLX
         2cj9ilYP1/M+4QYuMrf8ChW5aa/9bpS6ZNMlwHuoTwgLkbTJ9U73Ij0lPvQQMYtgW6yu
         lJT1ogmpv+qcbqBwGsmKnuHn4BeoY8IU7pO4ty2kSKMKz9pXUt3HR/r1RGJGYca3QYQq
         M3EXxS3I7yYjdBPoH7i4r2cMGdNz3PnkH8dMLVyQx18B3f2JcImUIyVhuEo/jr8ojv7I
         Ob96JT84SM4B+ErjGaorvbG/qAB9jJ3eHYtEMfkqx4UFfw47I3/1N2YDMmC49UPaKN3A
         0BvQ==
X-Gm-Message-State: AAQBX9dppBYdi9AUJRSOYuHo7+bNSySgs+GCciDXZs2KGSaYX2Azuf7R
        aA/oH80HeBE8yLSxfteWg7L+qQ==
X-Google-Smtp-Source: AKy350aB3waRCVBrNPWUpTvTFh7Oe7hWlqGLAXwcnE0SSE6o5sCO8frWgwt3jy/dLmWZ5MGyUsHLZQ==
X-Received: by 2002:a17:903:230b:b0:1a6:a6e7:8846 with SMTP id d11-20020a170903230b00b001a6a6e78846mr6108159plh.40.1681902626375;
        Wed, 19 Apr 2023 04:10:26 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:eaf2:1d7a:7338:16cb])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001a24cded097sm11180774plt.236.2023.04.19.04.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:10:25 -0700 (PDT)
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
Subject: [RFC PATCH 11/21] RISC-V: QoS: add to build when CONFIG_RISCV_ISA_SSQOSID set
Date:   Wed, 19 Apr 2023 04:11:01 -0700
Message-Id: <20230419111111.477118-12-dfustini@baylibre.com>
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

Add the sqoscfg CSR handling and the resctrl interface to the build when
CONFIG_RISCV_ISA_SSQOSID is set.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/kernel/Makefile     | 2 ++
 arch/riscv/kernel/qos/Makefile | 2 ++
 2 files changed, 4 insertions(+)
 create mode 100644 arch/riscv/kernel/qos/Makefile

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4cf303a779ab..57d57e430fb9 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -89,3 +89,5 @@ obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_vdso/
+
+obj-$(CONFIG_RISCV_ISA_SSQOSID)  += qos/
diff --git a/arch/riscv/kernel/qos/Makefile b/arch/riscv/kernel/qos/Makefile
new file mode 100644
index 000000000000..9ed0c13a854d
--- /dev/null
+++ b/arch/riscv/kernel/qos/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos.o qos_resctrl.o
-- 
2.34.1

