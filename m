Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8D6C71C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjCWUpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjCWUpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:45:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27919106
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C0F1628A0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC89C433A1;
        Thu, 23 Mar 2023 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679604335;
        bh=nWKfi1HEudmdxpdb81RertI104eji0uTemho/GX0iSU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=D1jlG8/G0083Nj0cox7djvVUCkT7HM8YbRUrXhqL6O0I2azb1GNT+hpIWIVNWdqKl
         I32apii0Qqk7UhF1ScHAPIIlX1IJ22K+hoB6zgJYZcMFuVdDcq0HS2K+OvOxI22CeE
         T8T51A4Lb5cwNlRI+divcYaJCH3RJUB+n8XJXLPp/yFU1hCxk1wjJGASF1N7PKHEuD
         1+L1VNcF1uFxtpa3pE2+Tfpl/GnH9DW8A6QwX0ETuTBW1KakrKed+/cW7dk3mMJKEr
         vKTnY+WkPgl6JgXG4GcCEvVb92izzbVfgoAZ2i7uwFBtuueyxkcr3KRqqtiyYsRG7j
         Yo2b4KBRr5lZw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Mar 2023 20:44:54 +0000
Subject: [PATCH v3 2/2] arm64/sysreg: Convert HFGITR_EL2 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230306-arm64-fgt-reg-gen-v3-2-decba93cbaab@kernel.org>
References: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
In-Reply-To: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nWKfi1HEudmdxpdb81RertI104eji0uTemho/GX0iSU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkHLpp5I05qve552Mm+inmnWBhpAdu7yoSQdMMPzF4
 X7RFVxqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZBy6aQAKCRAk1otyXVSH0KTKB/
 9QV65JfqBNLsJ9C48nRt/84ABDsys8h8KsyOr9lnkmKhTpIQwo4BfP35B5gof+xL5UgL7JCjgWTYVE
 DpnlK7GNTR15t6fkltzHQq9iXXOtELz9Yaaw8+gWqe7KmeeJXslijkmtSFW5Jn67Hu+GcoX0TcCRw6
 QI4teQprN/aVbCczRuq6JDHpWBHZGVAhFJ9+JdQ+p8ypBjW/bgpIeA5aGcW5kC0tdDQQV/LQRk2wUD
 tAJIGPxoZmJtySl4ePPZkFk5vtGrxUQiEv7iu4EijQ0f6Fmy3q6GGpnALuREKNG17p9a041z0vckP7
 +y0/LCrmvTP+S7ljMgeItEVovvaWBU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
index 60829a9409f0..c06097a8b921 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1941,6 +1941,71 @@ Sysreg HFGWTR_EL2	3	4	1	1	5
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
+Field	44	TLBSIDE1
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

-- 
2.30.2

