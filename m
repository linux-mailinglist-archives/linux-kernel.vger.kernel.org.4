Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D945A70E4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbjEWShk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbjEWShb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:37:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408818F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313F5635B7
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA98C433A1;
        Tue, 23 May 2023 18:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684867037;
        bh=Dx+cWy0dcqpkMVnXLdbKAeKzPOC7O9mGntVnbrrmpd4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Yld0PyatutKZheV5HR/xOZVi3li7NRfOrOSw1EC1fuKElOQVSGmPonvZ4Yc78dxfO
         CkCAU/ygvsSbTPUxqOsRIXMwtEPA7zXwCSJ3jd2TqfvpR8JlznJjZvIq68MBvn20+f
         zGPMdesQrxK+VPAAWEqZwBeNECQgRhyUqjp471m0ktDer0NMx9LZUHcwUGQyKNPIzc
         NJf1PU5XDxtoGQSXxYlANmFjd5JCe5kxxSMopCG80lowoScR2f6PR0XBkPhY41k/7r
         3yHv9qdXwi/KCCKfTy3ox40/XcmkLNT5WJlsDVjGGVHbU8kZCkcrQxzgpSpR0nVdxH
         tGFCPKh54Iz2Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 19:37:00 +0100
Subject: [PATCH v2 2/7] arm64/sysreg: Convert MDSCR_EL1 to automatic
 register generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v2-2-4c6add1f6257@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Dx+cWy0dcqpkMVnXLdbKAeKzPOC7O9mGntVnbrrmpd4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbQfQEOsIM7sSRKGUU9M0sMYE/zC2hQ8ElSX0dynF
 BkK5NNWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG0H0AAKCRAk1otyXVSH0KrFB/
 9KVYryXKJ0Q9v9gHbJocpaeLjfSllAbDBNZN7H/2WcAncEaUYEbYJUNwtDbdKXx6IUAHKhzj+2IT7L
 E/bee4jUOy9lWi1e0iqSViHoIROUk8cOrjvcEwkDFmpLxpU9mG/nC2FPDjX4kjkTY6U2MPLLTLa9Sw
 /Zlef1nSW9RLbxItSc5fVBH9mDjKdnXFd6ByIR2J7NSzMfik3cOX04a9nk60pMtQqWLl622mI9d7H8
 /Y+SI6MVRIMzist2gaDZ9xoAhfKA2bdLGveYBecR1VYj74C7RLNqIKE/EHgGjSLFTLfTm/jTXGWlM0
 cn3TdCw/j5OwSpdKi7+yk+pZkxTetM
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

