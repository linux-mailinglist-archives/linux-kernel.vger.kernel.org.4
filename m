Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA8A66AB87
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjANN0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjANN03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:26:29 -0500
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7097059F5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 05:26:25 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GgY7pvKxtsfAHGgY7pSjYQ; Sat, 14 Jan 2023 14:26:23 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Jan 2023 14:26:23 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2] KVM: arm64: vgic-v3: Use kstrtobool() instead of strtobool()
Date:   Sat, 14 Jan 2023 14:26:15 +0100
Message-Id: <f546e636c6d2bbcc0d8c4191ab98ce892fce4584.1673702763.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch was already sent as a part of a serie ([1]) that axed all usages
of strtobool().
Most of the patches have been merged in -next.

I synch'ed with latest -next and re-send the remaining ones as individual
patches.

Changes in v2:
  - now compile tested with make.cross, ARCH=arm64 and compiler from
    https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 arch/arm64/kvm/vgic/vgic-v3.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 2074521d4a8c..9d63149d9e53 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -3,6 +3,7 @@
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/kstrtox.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <kvm/arm_vgic.h>
@@ -587,25 +588,25 @@ DEFINE_STATIC_KEY_FALSE(vgic_v3_cpuif_trap);
 
 static int __init early_group0_trap_cfg(char *buf)
 {
-	return strtobool(buf, &group0_trap);
+	return kstrtobool(buf, &group0_trap);
 }
 early_param("kvm-arm.vgic_v3_group0_trap", early_group0_trap_cfg);
 
 static int __init early_group1_trap_cfg(char *buf)
 {
-	return strtobool(buf, &group1_trap);
+	return kstrtobool(buf, &group1_trap);
 }
 early_param("kvm-arm.vgic_v3_group1_trap", early_group1_trap_cfg);
 
 static int __init early_common_trap_cfg(char *buf)
 {
-	return strtobool(buf, &common_trap);
+	return kstrtobool(buf, &common_trap);
 }
 early_param("kvm-arm.vgic_v3_common_trap", early_common_trap_cfg);
 
 static int __init early_gicv4_enable(char *buf)
 {
-	return strtobool(buf, &gicv4_enable);
+	return kstrtobool(buf, &gicv4_enable);
 }
 early_param("kvm-arm.vgic_v4_enable", early_gicv4_enable);
 
-- 
2.34.1

