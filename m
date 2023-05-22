Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9939870C336
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjEVQXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjEVQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3CE9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B51E60C67
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2F3C4339B;
        Mon, 22 May 2023 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684772581;
        bh=8nGdHG41Sq+2pYzY75ll3lCjhbxICW46NC3itOTILLg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=R7TlZ/swN6n9ZdujR7/eUkEGWnPXfR/m/fUSJnjfMkjNX/d3U8JJpVB3QG9UQ+18b
         3ChwfHMDcb8My8rVJ8qPc540VZ5I6CluEX2qZY7i7YDRZWdpP9BCHG9aEysn2br4W0
         pNQbXsJgg65YokDFndYFNZWBtcVaQd6suT2aqrHroiLUfFclM6JYPd/QMuIbff8/UD
         u5li13IJZknuBpczlaQBQUT+h5ubO2XVRZhU/ZzFDxtpw2OPLBnzGiN0jXqYVMjuS1
         MBB7WM/MQvIrIxRKWLjTHF0q6Ovt8lLWjeUsN0qvDHW/JsKuLDv4biFXOT/VC5rEwH
         HoH5B+n7e7M5Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 22 May 2023 17:22:44 +0100
Subject: [PATCH 5/5] arm64/sysreg: Convert OSLAR_EL1 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v1-5-936cd769cb9e@kernel.org>
References: <20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org>
In-Reply-To: <20230419-arm64-syreg-gen-v1-0-936cd769cb9e@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8nGdHG41Sq+2pYzY75ll3lCjhbxICW46NC3itOTILLg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBka5bWlBIlzvv8r7RXpM0eD5xKcfN7tXnKCuoI4k4T
 HPI1ahOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZGuW1gAKCRAk1otyXVSH0NhaB/
 9bdRaqARex0WH59AXvDsCZC9s+erjBaqknoy800EVrUq6jyDkxJnG8NPir0O99TAJk7pXmDX/sjD73
 tQ7eOF0pbUEWTlS/qnLeOXqvoOOpAb1aWnDACpAIujz+TDao8NnngqH5qgyPm1Xv7uBKGJ7+3hEoid
 /uCgcmtDO1KXNWH9hx2gb3nlEppBon/Fq321i9iU5xQicecw1a8yC5VyIKC+gprcPPH512TYXTM2wO
 6vajE1NAtcvXxkyUwIAnPAaRxsQxuq2EMNuIucHwI0HzN6hIWTOJo/sTe5Cfu1G0ATadTMiNSrNwbf
 3Qk0aJDyBXy27TnWbPPeJdbyIl9w7V
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert OSLAR_EL1 to automatic generation as per DDI0601 2023-03. No
functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 3 ---
 arch/arm64/tools/sysreg         | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 09de958e79ed..3b51e532caa9 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -140,9 +140,6 @@
 #define SYS_DBGWCRn_EL1(n)		sys_reg(2, 0, 0, n, 7)
 #define SYS_MDRAR_EL1			sys_reg(2, 0, 1, 0, 0)
 
-#define SYS_OSLAR_EL1			sys_reg(2, 0, 1, 0, 4)
-#define OSLAR_EL1_OSLK			BIT(0)
-
 #define SYS_OSLSR_EL1			sys_reg(2, 0, 1, 1, 4)
 #define OSLSR_EL1_OSLM_MASK		(BIT(3) | BIT(0))
 #define OSLSR_EL1_OSLM_NI		0
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a5ae0e19fc9f..84df0b7feb45 100644
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

