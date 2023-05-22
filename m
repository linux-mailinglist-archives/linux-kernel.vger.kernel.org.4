Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7B470C332
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjEVQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjEVQW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC68F1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4355760C67
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEACC433EF;
        Mon, 22 May 2023 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684772574;
        bh=G/fe6roSUXDmM2/KNg6p2UkocZaL5qbzAOdEZ818tv0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qKM79+nZdmX7gHlPPtIfSPENp3MVLRrLVU0VHDxtxdnnzTYDSNY1rtyL1w9es3oF2
         5+sNrvULuU2S5n/rXS8al1M2hRKCMF56QE51q+toooVFjAhYl6R6g9qrGXZw/Lz1oF
         LSN54S71OVuK3rjsILEPVI1mrMbAgO0F4ITHMqUMWeQz+yaMr+AoHRJKJYXMfWd52O
         Zuqiv2K4MWmQ3aH9LjE8pxd3DNET5YVWZHoErU5/murnd50g9GybMi+eRWAK4ePa2A
         Xul1nlgcMiRmBgR6JOBRw1ilKTDQz0/pjyGu2Pp1+iluW2MrTSCWcbGyPuWT2HMze3
         H5+mwEVZxuXsQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 22 May 2023 17:22:41 +0100
Subject: [PATCH 2/5] arm64/sysreg: Convert MDCCINT_EL1 to automatic
 register generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v1-2-936cd769cb9e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G/fe6roSUXDmM2/KNg6p2UkocZaL5qbzAOdEZ818tv0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBka5bUO+I3Gj34AOYEKcMicgGKQTnFUZWH7GfRFe+U
 UjbRnwWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZGuW1AAKCRAk1otyXVSH0AiYB/
 0TrUSU8JZfIsTuOruidRVPHGcPEuHeophKStHYETANcwfKYqxw19PiYdFbWpIy1FMx78ezCXSZjhzh
 ucOKh/QkmTRpdbV9pJo5ruJEzrvoBwPEzsLWEq1G+Fc6wkBbtHGGIM9dsOMIZ1Ry9Ql6oC9UmvKaAK
 UPSwJ4hYZ7bRbkWFbQtDp6GPqJ913SPR8Nei1sAZ50dpSyZ+JtV3l/KdJujWInQTtyaII54GQeNd6b
 ZHmevprX3hbgv5z9q/dDVkHpNA6xK1TaogrTyeK78LdkXBgcnInqtY7IYVy+6mYDk9eeyStmm3Bzl/
 JhoAHv8rPDhz472V6SwUB+/BnCXt2P
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

Convert MDCCINT_EL1 to automatic register generation as per DDI0616
2023-03. No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 1 -
 arch/arm64/tools/sysreg         | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6505665624d4..4e48bb4dca6a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -134,7 +134,6 @@
 #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
 #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
 
-#define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
 #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
 #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
 #define SYS_DBGBCRn_EL1(n)		sys_reg(2, 0, 0, n, 5)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index dd5a9c7e310f..1699e87bc0b4 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -48,6 +48,13 @@
 # feature that introduces them (eg, FEAT_LS64_ACCDATA introduces enumeration
 # item ACCDATA) though it may be more taseful to do something else.
 
+Sysreg	MDCCINT_EL1	2	0	0	2	0
+Res0	63:31
+Field	30	RX
+Field	29	TX
+Res0	28:0
+EndSysreg
+
 Sysreg ID_PFR0_EL1	3	0	0	1	0
 Res0	63:32
 UnsignedEnum	31:28	RAS

-- 
2.30.2

