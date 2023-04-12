Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F66C6DFB63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDLQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDLQaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF86E98
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A93363593
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82905C433EF;
        Wed, 12 Apr 2023 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317036;
        bh=1FntlvoLLLm+fNRRQfBl1PQXxDYBMudmnPCr9j3Tp0c=;
        h=From:Date:Subject:To:Cc:From;
        b=gSYonxfX0GDpZH2JT3b9YsSk7vG4FPsaa+8agh/ZjaUQaSBzvvVl6+G6U5pqLqp7X
         l7xM56J0HT9nfpCmOH3116EviV7n+ORfV87BP2v42Ez/CcgekN6t0KosLkUrUZl7DN
         bRb1ST33GMUH0oWxXY6WFEGpWynhmwg8egU1GJJs2QyqGDS8lYtyhQdangPVPjUTzw
         O+cUePVeCwArv7bzr9noFi3El4N1WjVsLDBvQF3OcQHXBzcQa4e6qzKh4n9tL0it7B
         9+yMGTyZ+uHTh8EkZwu32ES1kZHSGSrl10E68lM/HZ35SV+jJQDrApUghgZ9APlp0k
         mW6/n+EHLveGQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Apr 2023 17:26:43 +0100
Subject: [PATCH v5] arm64/sysreg: Convert HFGITR_EL2 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230306-arm64-fgt-reg-gen-v5-1-516a89cb50f6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMLbNmQC/4XOy2rDMBAF0F8JWneCrIcVd9X/KFnoMZJFGjmMj
 GkI/vfK2ZVAvBm4A3PuPFhFyljZ5+HBCJdc81Ra0B8H5kdbEkIOLTPBheSS92Dp2iuIaQbCBAk
 LuCiM1BitCpG1O2crgiNb/Lhdztfbtr0Rxvz7bPo+tzzmOk90fxYv3bZ917F00MGgned+MD5i+
 LogFfw5TpTYxi1ilxCNMNj1vddOOiVeCLlLSOAQ0Ds7yDaseyHULqHaF0GfjBiMFjzof8S6rn+
 BgIi3kgEAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1FntlvoLLLm+fNRRQfBl1PQXxDYBMudmnPCr9j3Tp0c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkNtypdMxZT/q+/JhJHC8dqo9EfuqW2JorBlDOgrN/
 w7KmyW2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZDbcqQAKCRAk1otyXVSH0KxfB/
 9dZ5iVhk1Jm/9J2J6eSgIKPQKFWxYyoihO9WR4NQaQVfHps5ixHw2yilJ3IR0+n+Ki/K5IumucAWSn
 UlYZnAtKo2bvN0zTgX/vCBIS5vk2tBzjmQAH/b13YbkszJrMoQtEdgiOBXKd/QWtQW5IZwjpjGjkFR
 ictxsbU6l0Cfw2LZBlKfortApovHsSzp/Ml4kmfrGTzTnZwRZAojv/ATYV5Nhh2yK/ebezLOiJKu/1
 ewWU8Z3pc3CCNb7sAXw+rC7CDFHwX9cYOSbKssM7Ow29JhFfJ/Q2ywyT9wtKzJsbY87tSxmxkkvJaI
 8aKUwvODTu3Hra71/FUk6HuCETTOPF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Automatically generate the Hypervisor Fine-Grained Instruction Trap
Register as per DDI0601 2023-03, currently we only have a definition for
the register name not any of the contents.  No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v5:
- Update changelog to say this reflects 2023-03 (no code changes).
- Corrected definitions of TLBIRVAE1IS, TLBIVMALLE1IS and TLBIASIDE1OS.
- Link to v4: https://lore.kernel.org/r/20230306-arm64-fgt-reg-gen-v4-1-d587297520d5@kernel.org
Changes in v4:
- Rebase onto applied HFG[RW]TR_EL2 patch.
- Correct naming of HFGITR_EL2.TLBIASIDE1.
- Link to v3: https://lore.kernel.org/r/20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org
Changes in v3:
- Add HFGITR_EL2.
Changes in v2:
- Correct naming of nPIRE0_EL1.
- Link to v1: https://lore.kernel.org/r/20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org
---
 arch/arm64/include/asm/sysreg.h |  1 -
 arch/arm64/tools/sysreg         | 65 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e5ca9ece1606..c48b41c9b0cc 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -419,7 +419,6 @@
 #define SYS_MDCR_EL2			sys_reg(3, 4, 1, 1, 1)
 #define SYS_CPTR_EL2			sys_reg(3, 4, 1, 1, 2)
 #define SYS_HSTR_EL2			sys_reg(3, 4, 1, 1, 3)
-#define SYS_HFGITR_EL2			sys_reg(3, 4, 1, 1, 6)
 #define SYS_HACR_EL2			sys_reg(3, 4, 1, 1, 7)
 
 #define SYS_TTBR0_EL2			sys_reg(3, 4, 2, 0, 0)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 2af92b4f4fe4..77edce16f4f9 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1964,6 +1964,71 @@ Sysreg HFGWTR_EL2	3	4	1	1	5
 Fields	HFGxTR_EL2
 EndSysreg
 
+Sysreg HFGITR_EL2	3	4	1	1	6
+Res0	63:61
+Field	60	COSPRCTX
+Field	59	nGCSEPP
+Field	58	nGCSSTR_EL1
+Field	57	nGCSPUSHM_EL1
+Field	56	nBRBIALL
+Field	55	nBRBINJ
+Field	54	DCCVAC
+Field	53	SVC_EL1
+Field	52	SVC_EL0
+Field	51	ERET
+Field	50	CPPRCTX
+Field	49	DVPRCTX
+Field	48	CFPRCTX
+Field	47	TLBIVAALE1
+Field	46	TLBIVALE1
+Field	45	TLBIVAAE1
+Field	44	TLBIASIDE1
+Field	43	TLBIVAE1
+Field	42	TLBIVMALLE1
+Field	41	TLBIRVAALE1
+Field	40	TLBIRVALE1
+Field	39	TLBIRVAAE1
+Field	38	TLBIRVAE1
+Field	37	TLBIRVAALE1IS
+Field	36	TLBIRVALE1IS
+Field	35	TLBIRVAAE1IS
+Field	34	TLBIRVAE1IS
+Field	33	TLBIVAALE1IS
+Field	32	TLBIVALE1IS
+Field	31	TLBIVAAE1IS
+Field	30	TLBIASIDE1IS
+Field	29	TLBIVAE1IS
+Field	28	TLBIVMALLE1IS
+Field	27	TLBIRVAALE1OS
+Field	26	TLBIRVALE1OS
+Field	25	TLBIRVAAE1OS
+Field	24	TLBIRVAE1OS
+Field	23	TLBIVAALE1OS
+Field	22	TLBIVALE1OS
+Field	21	TLBIVAAE1OS
+Field	20	TLBIASIDE1OS
+Field	19	TLBIVAE1OS
+Field	18	TLBIVMALLE1OS
+Field	17	ATS1E1WP
+Field	16	ATS1E1RP
+Field	15	ATS1E0W
+Field	14	ATS1E0R
+Field	13	ATS1E1W
+Field	12	ATS1E1R
+Field	11	DCZVA
+Field	10	DCCIVAC
+Field	9	DCCVADP
+Field	8	DCCVAP
+Field	7	DCCVAU
+Field	6	DCCISW
+Field	5	DCCSW
+Field	4	DCISW
+Field	3	DCIVAC
+Field	2	ICIVAU
+Field	1	ICIALLU
+Field	0	ICIALLUIS
+EndSysreg
+
 Sysreg	ZCR_EL2	3	4	1	2	0
 Fields	ZCR_ELx
 EndSysreg

---
base-commit: 79260355593f96a7580a1995f07a9662c0d5a9ae
change-id: 20230306-arm64-fgt-reg-gen-bf2735efa4df

Best regards,
-- 
Mark Brown <broonie@kernel.org>

