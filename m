Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF7A70E4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbjEWSgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbjEWSgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AD186
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37F0363088
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CEFC4339C;
        Tue, 23 May 2023 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684866991;
        bh=1trlKZwAecGTqrKD0iQKq5crYO5E8+VYUNMVFUR5Ei0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BD2vp1wpRNzi10+ritEJUUw3B+MKSXAXhTdKM1A/URGx2Ikv2sSbeKBny1JRahGM3
         tU71pyFygfCS89Zi4HVFHQL92Dx1sfMFQ3YhitUgPOCeslXryQyL0oXNj/Ao4+qcBI
         vf1OA2JibVLM1l5A2T2eznGiyHjBpoCuQRjbgzbTrfd20SL0CSO2k9M3xBfoH/b8b6
         iUfcncJyJpiA4Oxa4roH4jef/neoKd6XPPhrB5Xc1SJcg+JPdwIhLjK7OLhLKZVy90
         Lv1U4GiOxxjuyNs33ciwWRPfwXdWKU+NzWIBXghdKT4KgDX5XVDNb/+Z8QAe/xDMOY
         5SEolKQ1MVFSw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 19:36:01 +0100
Subject: [PATCH v2 4/7] arm64/sysreg: Convert OSLAR_EL1 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v2-4-e0064336e2dd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1trlKZwAecGTqrKD0iQKq5crYO5E8+VYUNMVFUR5Ei0=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhpRc9vm52/QENbWsT+teDHgcH5yw7JS5itZaRkW/yJDmNbyZ
 V151MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQAT8ehm/++UZqi5OF45yC/7qmC0y8
 8pa7dbNkdZLF+QMbHoWZ2AwTZ/A6dnrcodD302P3P+9jeyIfDSzPxwJQferZlmF7zOv551ZrnoJTeG
 S5IN/lueFqR31kdVKqZt+iS/bll6vmjSx8fJtVGX/ac59zpdv+L6lzebudL5jfGUL6wCHczRrEu/d7
 m/WhPS9NtypVD40RWvrmuJ2xnkXihLMRM4t74t2HE5X3rYC6G5qyZ1OYptP1DIscRIW+tR36SeVTNL
 dXfxl055/+ibTKJMp3DBn1+NFVuqb16r5zm2Kzww99nvqccv3pdh6+CrquGcnn2wYhLr640elTw+4q
 nzK9/I1TE3n/4jKWz3MPDJwTtxAA==
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

