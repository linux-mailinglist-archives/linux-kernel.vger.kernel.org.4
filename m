Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710C76FC8D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjEIOYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbjEIOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:24:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5A364EF2
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:23:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF831063;
        Tue,  9 May 2023 07:24:30 -0700 (PDT)
Received: from e126864.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3BEA3F663;
        Tue,  9 May 2023 07:23:43 -0700 (PDT)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] arm64: mops: allow disabling MOPS from the kernel command line
Date:   Tue,  9 May 2023 15:22:34 +0100
Message-Id: <20230509142235.3284028-11-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230509142235.3284028-1-kristina.martsenko@arm.com>
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to disable the MOPS extension at runtime using the
kernel command line. This can be useful for testing or working around
hardware issues. For example it could be used to test new memory copy
routines that do not use MOPS instructions (e.g. from Arm Optimized
Routines).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/idreg-override.c              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..e01fbfd78ae9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -429,6 +429,9 @@
 	arm64.nosme	[ARM64] Unconditionally disable Scalable Matrix
 			Extension support
 
+	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
+			Set instructions support
+
 	ataflop=	[HW,M68k]
 
 	atarimouse=	[HW,MOUSE] Atari Mouse
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 370ab84fd06e..8439248c21d3 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -123,6 +123,7 @@ static const struct ftr_set_desc isar2 __initconst = {
 	.fields		= {
 		FIELD("gpa3", ID_AA64ISAR2_EL1_GPA3_SHIFT, NULL),
 		FIELD("apa3", ID_AA64ISAR2_EL1_APA3_SHIFT, NULL),
+		FIELD("mops", ID_AA64ISAR2_EL1_MOPS_SHIFT, NULL),
 		{}
 	},
 };
@@ -174,6 +175,7 @@ static const struct {
 	  "id_aa64isar1.gpi=0 id_aa64isar1.gpa=0 "
 	  "id_aa64isar1.api=0 id_aa64isar1.apa=0 "
 	  "id_aa64isar2.gpa3=0 id_aa64isar2.apa3=0"	   },
+	{ "arm64.nomops",		"id_aa64isar2.mops=0" },
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"kaslr.disabled=1" },
 };
-- 
2.25.1

