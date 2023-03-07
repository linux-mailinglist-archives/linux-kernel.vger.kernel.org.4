Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73546ADBCE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCGKZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjCGKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:25:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D567E5FF5;
        Tue,  7 Mar 2023 02:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678184725; x=1709720725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qWB3e5tgDGUKCOsNQtNNw5AKYgfS2AJpadcC4RT6yqQ=;
  b=YWQES2dcbwVTCkleictX1E3V0UhpGGRfL/a0obG27EQyA1hDrcsxLXl2
   FwcB+v9gys8cNnSTx3Wh6AUmNb7TUg+9IzoC+hAQrzPHNZJpnvghWCLp7
   3mfgj1nn4PFxY0zlnOwmWVvP/71wmHzxkPzYLILb+LwU5SUaA4fXYfdFO
   EXfj/uMQ2jOewabptYdHL2Hwk0lpktOJj0JWzWRjHDTPdLBFdm89N4Xrx
   GRCizSYaKOtiYrYt6zYkIp3WIRsNyQeXrvCtTlqbjziyvfLc0+ZOtOhz4
   +19rYCfKeblqP/illwnK+1uXVIkacxvAexKO9I96CG1IzZk48oTC8/SYc
   A==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673938800"; 
   d="scan'208";a="204052299"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2023 03:25:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Mar 2023 03:25:22 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Tue, 7 Mar 2023 03:25:19 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-riscv@lists.infradead.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <rust-for-linux@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: [PATCH v1 2/2] RISC-V: enable building 64-bit kernels with rust support
Date:   Tue, 7 Mar 2023 10:24:41 +0000
Message-ID: <20230307102441.94417-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307102441.94417-1-conor.dooley@microchip.com>
References: <20230307102441.94417-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889; i=conor.dooley@microchip.com; h=from:subject; bh=yBD6MNol++6y2HAWMBBaDRLPC5EtLmNC6wyDPXZv0s4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsAs+aOuwTWjpufIiaM2fzp6LVux5wqT1WnRVxQM+mrf5w VINVRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACZyoI3hf4iJso1T2ZFneoqdb/5bWv Tebv2x8NxSR/1oV4uw6NaiVkaGdwZ6t/Wjz29b8GVH9OWbU7YeKJ5+V+Fi3plvhnYXf5s1sAAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <ojeda@kernel.org>

The rust modules work on 64-bit RISC-V, with no twiddling required.
Select HAVE_RUST and provide the required flags to kbuild so that the
modules can be used. The Makefile and Kconfig changes are lifted from
work done by Miguel in the Rust-for-Linux tree, hence his authorship.
Following the rabbit hole, the Makefile changes originated in a script,
created based on config files originally added by Gary, hence his
co-authorship.

32-bit is broken in core rust code, so support is limited to 64-bit:
ld.lld: error: undefined symbol: __udivdi3

As 64-bit RISC-V is now supported, add it to the arch support table,
taking the opportunity to sort the table in alphabetical order.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
While adding RISC-V to the table, I took the chance to re-sort it
alphabetically. I didn't think that warranted co-authorship, but given
we had an authorship conversation already I am happy to provide one for
that...
---
 Documentation/rust/arch-support.rst | 3 ++-
 arch/riscv/Kconfig                  | 1 +
 arch/riscv/Makefile                 | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index ed7f4f5b3cf15..77765ffd5af41 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -15,7 +15,8 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
 ============  ================  ==============================================
 Architecture  Level of support  Constraints
 ============  ================  ==============================================
-``x86``       Maintained        ``x86_64`` only.
+``riscv``     Maintained        ``riscv64`` only.
 ``um``        Maintained        ``x86_64`` only.
+``x86``       Maintained        ``x86_64`` only.
 ============  ================  ==============================================
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5e42cc376048..c3179b139361f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -114,6 +114,7 @@ config RISCV
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
+	select HAVE_RUST if 64BIT
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6203c33789228..950612bf193cf 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -31,6 +31,8 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
 	KBUILD_AFLAGS += -mabi=lp64
 
 	KBUILD_LDFLAGS += -melf64lriscv
+
+	KBUILD_RUSTFLAGS += -Ctarget-cpu=generic-rv64
 else
 	BITS := 32
 	UTS_MACHINE := riscv32
-- 
2.39.2

