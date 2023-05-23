Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A5170E4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbjEWShp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjEWShh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF1819D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47B636307F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94914C4339B;
        Tue, 23 May 2023 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684867042;
        bh=1trlKZwAecGTqrKD0iQKq5crYO5E8+VYUNMVFUR5Ei0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ym0dc8yUIAwLtVciJM2MzxVMG0yzR/5UPKUTB1zWXIsKeHiFpV3C7HrrKOLBG4yuK
         VHQ6pKC0q1COD6oRYRuauXEQmW52k8e9GKNunRPlvnm8kfaEcsyeebNGDEr9Za35BI
         uYpJT2zMx6sVIQAhK4zYtO95c7PhpsXc1hRcINuWSdIFI9AAFhvOxPiIC24OFQv1rY
         cXSECHIMatt44kr+Naf08sa2xfP2Ulx4gaXpAvjOl0PYWQINChFDoGfYLsCrECYE6t
         Hr3uEQsXneRxKHT48V3R9Nh5xUUvHBf23HnqMvSwtbWEmwetRAW7LBZqNQYIn2+hMB
         ojWE4na+wQHTA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 19:37:02 +0100
Subject: [PATCH v2 4/7] arm64/sysreg: Convert OSLAR_EL1 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v2-4-4c6add1f6257@kernel.org>
References: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
In-Reply-To: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Shaoqin Huang <shahuang@redhat.com>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1trlKZwAecGTqrKD0iQKq5crYO5E8+VYUNMVFUR5Ei0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbQfS5ksRXV7nYrRmjLnuyk3eVXlUsp5+ShKKTNMV
 ylPvfsqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG0H0gAKCRAk1otyXVSH0HuIB/
 sF4syN3KUBqKtlaK7e0YFcn7RqUfrMctSb2rSPXQhpqid8LkyQqHnfkf7yXW8V7/PoGAYW8rwHDcpt
 XjkuGxswb9Ywc3tMw8cGdVkXuw0HCAp4c6GQTREEOC7Gg58+IUUG8RRKF3BIjkPJEK01zrbPxgbd8q
 Eh804cru5Mtmub53E0F8Gxile9nWd1zyhMk37KgOSm6elVlc1XsgKCMsVKfLqm3E7n+ZzPCKyx2gdV
 cW4GNN8XewJXIXeWia2wqRkmokk3NRQh0+mrMQSJVFm4kKtQWQO4YYqrFd8q5+ZoHL85hZZDNNyuXi
 I17E0E6yImQDJadcEaj+P4A5Uda6+7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert OSLAR_EL1 to automatic generation as per DDI0601 2023-03. No
functional change.

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 3 ---
 arch/arm64/tools/sysreg         | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 979975c8be2c..1901b676d7c6 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -143,9 +143,6 @@
 #define SYS_DBGWCRn_EL1(n)		sys_reg(2, 0, 0, n, 7)
 #define SYS_MDRAR_EL1			sys_reg(2, 0, 1, 0, 0)
 
-#define SYS_OSLAR_EL1			sys_reg(2, 0, 1, 0, 4)
-#define OSLAR_EL1_OSLK			BIT(0)
-
 #define SYS_OSLSR_EL1			sys_reg(2, 0, 1, 1, 4)
 #define OSLSR_EL1_OSLM_MASK		(BIT(3) | BIT(0))
 #define OSLSR_EL1_OSLM_NI		0
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 601cc8024734..b0aefdf9ed34 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -83,6 +83,11 @@ Res0	5:1
 Field	0	SS
 EndSysreg
 
+Sysreg	OSLAR_EL1	2	0	1	0	4
+Res0	63:1
+Field	0	OSLK
+EndSysreg
+
 Sysreg ID_PFR0_EL1	3	0	0	1	0
 Res0	63:32
 UnsignedEnum	31:28	RAS

-- 
2.30.2

