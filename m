Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8138A70E4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbjEWSgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbjEWSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:36:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D72D11D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1279F619F9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394BAC4339C;
        Tue, 23 May 2023 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684866986;
        bh=Dx+cWy0dcqpkMVnXLdbKAeKzPOC7O9mGntVnbrrmpd4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GwtUKcLsV2PLBiXOp/GUzbMERQK58RTA0sYaMFO0GOOaJqDFnYGJw6u0e2L5S6rFc
         O4CW7iW0SWxotlf/d4s543sumF257NOpUq1C9ntxTcGxy0SBK3oUG3roO+NrZ121uz
         mQQuha5tYrUtdgjMV13Ck5lEsFeR9M3oabwAPTgbJe4BnQTfOpCMUYEJDB5FuSph3B
         JyTu7T4qB7FRn9Uj3s4sQ74XG4zPsbJ7GpWkc00uOTJIyeTtf/N1SFwOuxev5E+DGm
         HEvBzHSOPKr9AmTk5cBehyp14wtIZw8faMCM7F2a5E/XUmIN7rB10KBY5HvtV/t4Hw
         imVPxyUiYgnEg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 19:35:59 +0100
Subject: [PATCH v2 2/7] arm64/sysreg: Convert MDSCR_EL1 to automatic
 register generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v2-2-e0064336e2dd@kernel.org>
References: <20230419-arm64-syreg-gen-v2-0-e0064336e2dd@kernel.org>
In-Reply-To: <20230419-arm64-syreg-gen-v2-0-e0064336e2dd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Shaoqin Huang <shahuang@redhat.com>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Dx+cWy0dcqpkMVnXLdbKAeKzPOC7O9mGntVnbrrmpd4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbQedL1ucn3fvpkib4oCilUGYKem9UUroIbYvCS8O
 g1IK8yyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG0HnQAKCRAk1otyXVSH0OXMB/
 9iYlgr1hOmpq/gcm4VFQJPbyMYzmtuVvhN9LGrafQBKGmFWuNL9U8vlQtzscMkrXBczHJJL3hvv/yC
 Fn+76uc7Ye6Ab5htVthE6I0UMJtRf7KtUIUfrVKYGY3DJeTGeviRk0tSx9AJ0vd2xIZw3edmC4YIbm
 fxikSqDmeczL3NFZwopSOABYgaeWatku2rX5EWH1xNelMpKtpyAHLkl0LjjimJ7gaWO+uOK/QdVoYT
 Oq8ZwyIPfnqNC5IYB3u5SCou1EXsydzf1CTzz/2WNyM/SBN0V+vSsjCa6V/LZWUm4FCPbOamyAnFWo
 IsgZUlZRch+a9aZ4cLfS0fw48x3rNp
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

Convert MDSCR_EL1 to automatic register generation as per DDI0616 2023-03.
No functional change.

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h |  1 -
 arch/arm64/tools/sysreg         | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 3d69bda0e608..95de1aaee0e9 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -135,7 +135,6 @@
 #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
 
 #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
-#define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
 #define SYS_OSDTRTX_EL1			sys_reg(2, 0, 0, 3, 2)
 #define SYS_OSECCR_EL1			sys_reg(2, 0, 0, 6, 2)
 #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index df7a7ba97b43..601cc8024734 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -55,6 +55,34 @@ Field	29	TX
 Res0	28:0
 EndSysreg
 
+Sysreg	MDSCR_EL1	2	0	0	2	2
+Res0	63:36
+Field	35	EHBWE
+Field	34	EnSPM
+Field	33	TTA
+Field	32	EMBWE
+Field	31	TFO
+Field	30	RXfull
+Field	29	TXfull
+Res0	28
+Field	27	RXO
+Field	26	TXU
+Res0	25:24
+Field	23:22	INTdis
+Field	21	TDA
+Res0	20
+Field	19	SC2
+Res0	18:16
+Field	15	MDE
+Field	14	HDE
+Field	13	KDE
+Field	12	TDCC
+Res0	11:7
+Field	6	ERR
+Res0	5:1
+Field	0	SS
+EndSysreg
+
 Sysreg ID_PFR0_EL1	3	0	0	1	0
 Res0	63:32
 UnsignedEnum	31:28	RAS

-- 
2.30.2

