Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2E070E4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbjEWShu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbjEWShj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:37:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698E31AD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00AE862DA4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D185C433EF;
        Tue, 23 May 2023 18:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684867047;
        bh=WK7ajXHkshIT2cOizJwNF0MX+jkQcIMOaAmOWZ9YM08=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=X0J0hoAOI+mQtU86NdXRvyVCrQz5lDUXLN1KillYIPUJpl15lrRHZXlwW3zYwNShP
         vcN4ZXrJ652h+T0jpTUSW++qfMMdp70WE0eP3LjNcGZX4I/RyTbVUho/0NFThWEmjJ
         m9k7KAWggZ5kUQDTsNwBBscqKdkiRYRzUWV2n0zH1l0WyAQaku3/sZjttnyHLPMa8M
         R1Y9x/jH6cwPgBOw/X3ln73/7aqzBZFDZGVKXz7xIDasNluOA8KP8t2MnDMr659NIP
         NWBWOkCv83TSf0KUE3lL+a6k5voBiJOFJ8VfGqhr10JUrwyCHwA5AULVyKlIU1XxQI
         KG+dAzxGbIpSw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 19:37:04 +0100
Subject: [PATCH v2 6/7] arm64/sysreg: Convert OSDTRTX_EL1 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v2-6-4c6add1f6257@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WK7ajXHkshIT2cOizJwNF0MX+jkQcIMOaAmOWZ9YM08=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbQfUYotb+cQ5vS7NvwCSEEnSIHrRSOWrQhBBCd70
 VTDcRXeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG0H1AAKCRAk1otyXVSH0P4pB/
 4+zPNevkMYJ8xrH7uzKGC7X671Y3/qsTMh5asBKrJ03vJEaNoYW2rnXy+TnmbZmyja+LINaIMP/pTJ
 secNe84xPmwDF/EjY8V5gR2zcouUyJdg7wLrmXnUh1dfaYatasSjsl8sEKix42x3xXkfcDS+Vf/ydZ
 uNYNIDi0GqTgn5G/C9CmNfnMRnGz7Fgwett1IQN4hhS5q+HPzEWsKclsehhQ152YAjpFssLm7ImSQI
 9yj9Am2E45X6J5PTh3UV2c+5sgGyN4cvv5jpv9IvGOSMae8QSIVc6D/qiJjkW/4080lwAyuF0gbD01
 yDiqzkOUEEGxC/uVFnty7KwOj3ry87
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

Convert OSDTRTX_EL1 to automatic generation as per DDI0601 2023-03. No
functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 1 -
 arch/arm64/tools/sysreg         | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index da954a6eba24..d9711f1e47b2 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -134,7 +134,6 @@
 #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
 #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
 
-#define SYS_OSDTRTX_EL1			sys_reg(2, 0, 0, 3, 2)
 #define SYS_OSECCR_EL1			sys_reg(2, 0, 0, 6, 2)
 #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
 #define SYS_DBGBCRn_EL1(n)		sys_reg(2, 0, 0, n, 5)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index e4653248dcac..e18ae1df41f4 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -88,6 +88,11 @@ Res0	5:1
 Field	0	SS
 EndSysreg
 
+Sysreg	OSDTRTX_EL1	2	0	0	3	2
+Res0	63:32
+Field	31:0	DTRTX
+EndSysreg
+
 Sysreg	OSLAR_EL1	2	0	1	0	4
 Res0	63:1
 Field	0	OSLK

-- 
2.30.2

