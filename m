Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D216DA60A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbjDFW7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239373AbjDFW7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:59:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C0B10A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3402660FE1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 22:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3064BC433EF;
        Thu,  6 Apr 2023 22:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680821983;
        bh=BA9uyCRuGDhWfqTYWFl4323a8bevZwArJSIk38QUvQY=;
        h=From:Date:Subject:To:Cc:From;
        b=QDSoxNzaZq2q5+vl2m3/1DjmStksFlOW4uWiCB0wxMXn0X1N5PGWTHx5N0LsN0Qk7
         lklvNmF0DD+h0I9gWuDJ40ApiQyKTfFPztL9cwx5yv23kjFrbi4RFiKHAcdy34KMrr
         1KM+IaUsJ7JTkdZO3bsVUz09tG0edpqOGDvwn7R99X0Gkb0p/HJDx8HGYsD3eEkkAP
         QZhDEp/b/fKbEYNF18iaPyBiiCRQtCvxuKXtvEgIX+oeSeRlCUdI/qCpEKjj9iQtSZ
         xN/Lzt/QCl76IpRhyv5tFCaX3jTtAZOo2IyxbeB0lk7DzOgI8q/CiTxAtnqA7MEBlv
         RBqFUKfkREGQQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 06 Apr 2023 23:59:25 +0100
Subject: [PATCH v4] arm64/sysreg: Convert HFGITR_EL2 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230306-arm64-fgt-reg-gen-v4-1-d587297520d5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMxOL2QC/4WNywqDMBREf0Wy7i0x8YFd9T9KF0m8iaE1yo1Ii
 /jvje5KoW4GzsCcWVhE8hjZJVsY4eyjH0KC4pQx06ngEHybmAkuJJe8AkV9VYB1ExA6cBhAW1H
 LEq0qWsvSTquIoEkF023LqR+3diS0/rU/3e6JOx+ngd778Zxv7b+POYccmlIbbpraWGyvD6SAz
 /NAjm26WRwqRFLUmFeVKbXUhfhRyEOFBA4tGq0amULpL8W6rh+/f8FpTwEAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BA9uyCRuGDhWfqTYWFl4323a8bevZwArJSIk38QUvQY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkL07djzOklFXRQlnEjfBM3fmzruAejaDHenqoeEXj
 e8CFuQmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZC9O3QAKCRAk1otyXVSH0I6WB/
 96f7Z6kC2GyYBlaRWoBQ1rXsiWPk8KYsUW/l+8jX+nLochnpNlNuwvXwAcdhf2i+YpxWx6kya8r9AD
 YXZnbaKl/RvEgjpPH76SmVZ0abKcGgd6uny7yOkyFQG43+ujuzcDdJybM43L2A5/eE1lPbWURwN7pB
 1jn7wAsDiIOHw/dAyEWtMC2VGb8k4CFDOwqPOP0c1RbIxwJYn+PJ5QBCGCQasuxeEw+9Q+mzR1kkcQ
 aD8uWbosGYsBNZR9GdQveHSFeRfcXivnwsvdSpCrXueakEJa+5+bI1eAcLQeuK/uYJPveAn4DiXKTE
 OLhBeheUj/7+vcu3dgDtBqIRKyFxVi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Automatically generate the Hypervisor Fine-Grained Instruction Trap
Register as per DDI0601 2022-12, currently we only have a definition for
the register name not any of the contents.  No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
index 2af92b4f4fe4..b76569b29561 100644
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
+Field	34	TLBIRAALE1IS
+Field	33	TLBIVAALE1IS
+Field	32	TLBIVALE1IS
+Field	31	TLBIVAAE1IS
+Field	30	TLBIASIDE1IS
+Field	29	TLBIVAE1IS
+Field	28	TLBIVVMALLE1IS
+Field	27	TLBIRVAALE1OS
+Field	26	TLBIRVALE1OS
+Field	25	TLBIRVAAE1OS
+Field	24	TLBIRVAE1OS
+Field	23	TLBIVAALE1OS
+Field	22	TLBIVALE1OS
+Field	21	TLBIVAAE1OS
+Field	20	TLVIASIDE1OS
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

