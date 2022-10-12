Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3C65FC433
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJLLNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJLLNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:13:08 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAEFC2C96
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1665573181; bh=jQXI5aEReKrw+ZRZjXWpuy3D8HVFbu5pIl125t8w5MA=;
        h=From:To:Cc:Subject:Date:From;
        b=YInqk2tXDllQoaKT8SucQez+0E2IhD+nG3xXtlMN3R1btmb5/JqcpxxxIK//2m/ib
         INpXBiREeIuwhCsrF1PyMWMFcLviOZxsoscEoMPhulmLn4rdSrsit+2KSF8Vhdz2nC
         YoxTD/DCAKibg5q494Tnp0z2P7dnez0l05hUsIVE=
Received: from ld50.lan (unknown [101.88.135.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 334E1600CF;
        Wed, 12 Oct 2022 19:12:59 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Expose LBT features in cpuinfo and ELF HWCAP
Date:   Wed, 12 Oct 2022 19:12:54 +0800
Message-Id: <20221012111254.3194431-1-kernel@xen0n.name>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Although proper context switching support for LBT is not present yet,
this fixes an apparent oversight where other similarly not-yet-supported
features e.g. LSX, LASX, Crypto, or LVZ are being reported but the LBT
ones are not.

Fixes: 628c3bb40e9a ("LoongArch: Add boot and setup routines")
Signed-off-by: WANG Xuerui <git@xen0n.name>
Cc: loongarch@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
---
 arch/loongarch/kernel/cpu-probe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 529ab8f44ec6..82de5264d2c9 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -123,6 +123,18 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		c->options |= LOONGARCH_CPU_LVZ;
 		elf_hwcap |= HWCAP_LOONGARCH_LVZ;
 	}
+	if (config & CPUCFG2_X86BT) {
+		c->options |= LOONGARCH_CPU_LBT_X86;
+		elf_hwcap |= HWCAP_LOONGARCH_LBT_X86;
+	}
+	if (config & CPUCFG2_ARMBT) {
+		c->options |= LOONGARCH_CPU_LBT_ARM;
+		elf_hwcap |= HWCAP_LOONGARCH_LBT_ARM;
+	}
+	if (config & CPUCFG2_MIPSBT) {
+		c->options |= LOONGARCH_CPU_LBT_MIPS;
+		elf_hwcap |= HWCAP_LOONGARCH_LBT_MIPS;
+	}
 
 	config = read_cpucfg(LOONGARCH_CPUCFG6);
 	if (config & CPUCFG6_PMP)
-- 
2.38.0

