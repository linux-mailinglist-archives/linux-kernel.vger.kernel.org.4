Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D270E4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbjEWShs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjEWShi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E36A1A8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A042E635B8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25917C433A0;
        Tue, 23 May 2023 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684867045;
        bh=/s3OQTPaAeFaaX+KplVvFWg8KQWTQaJvzEWKqMGEZfI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lzWx708XdMcMIBFAfAjaCDpv8AXJojFYtc/b4O3Lshk9/rbPb9LRKGBuZRyT1gYjN
         cP9lfVPJhOsx5B6gGZ40qBjUA/1VbZg9UaAqVJ1h/4JMmjK1xQFreWsA72JfiPe3Sl
         74ufths48YYWtR8i3I+8zk354P9ZeHqALthxu3vHaXOQNWCBtkEjtIXXXInLlkI+Eb
         h3hddxPmN/M88lI+OHu/oEe6qxxOvvnJd7JIJmzIJXpgUAQxEguRGSgkWoK1qlvmJF
         NjrAJgjHxNvF49eymBXt4NUqhUOhjQr5s1Z0XaU1UUy7J8b25stx5IzSvh8IVIWSIW
         iIG3cexsgAs4Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 19:37:03 +0100
Subject: [PATCH v2 5/7] arm64/sysreg: Convert OSDTRRX_EL1 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v2-5-4c6add1f6257@kernel.org>
References: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
In-Reply-To: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/s3OQTPaAeFaaX+KplVvFWg8KQWTQaJvzEWKqMGEZfI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbQfTB1M/2bseR8N2orKJ9G+SAdLnH2a1tarpQwb8
 sSf36EGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG0H0wAKCRAk1otyXVSH0FPcB/
 47DuFiRTIw6y2n5Jq305ETHwbabH9R5dvMNpLkxDbppQBDP86ElXKCoXKJVoUS6GOVag1Q4ZaCD1th
 snGutLUzqDS7Bpl4/cpndLGtsL+9002ERd5t2j4D6kp9GId++aWd1VjkL//FZ4OP6FQY8z41MCN7cG
 ORPow87qGFlQxus7865kyFeVE5B6v4yuDVQs/rSYz7kwDjqz+AeTnw7q2iT2XwK0PZozSlvJ246JBX
 NufCnF1rvm2ZVsy03vegEpM+HAMwm27ifQavRe7zIqP2M1GpfXnaxo2GxI3nM1Kk9TPLHIwbQGH5+G
 uSHvuvlgLotwBIs2hDC1toUpLVdLcr
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

Convert OSDTRRX_EL1 to automatic generation as per DDI0601 2023-03, no
functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 1 -
 arch/arm64/tools/sysreg         | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1901b676d7c6..da954a6eba24 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -134,7 +134,6 @@
 #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
 #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
 
-#define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
 #define SYS_OSDTRTX_EL1			sys_reg(2, 0, 0, 3, 2)
 #define SYS_OSECCR_EL1			sys_reg(2, 0, 0, 6, 2)
 #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index b0aefdf9ed34..e4653248dcac 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -48,6 +48,11 @@
 # feature that introduces them (eg, FEAT_LS64_ACCDATA introduces enumeration
 # item ACCDATA) though it may be more taseful to do something else.
 
+Sysreg	OSDTRRX_EL1	2	0	0	0	2
+Res0	63:32
+Field	31:0	DTRRX
+EndSysreg
+
 Sysreg	MDCCINT_EL1	2	0	0	2	0
 Res0	63:31
 Field	30	RX

-- 
2.30.2

