Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040DB63AA38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiK1N5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiK1N4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:56:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEE84209B1;
        Mon, 28 Nov 2022 05:56:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50B84D6E;
        Mon, 28 Nov 2022 05:56:49 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.44.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A4433F73D;
        Mon, 28 Nov 2022 05:56:39 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, maz@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: Replace PMU version number '0' with ID_AA64DFR0_EL1_PMUVer_NI
Date:   Mon, 28 Nov 2022 19:26:29 +0530
Message-Id: <20221128135629.118346-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_host_pmu_init() returns when detected PMU is either not implemented, or
implementation defined. kvm_pmu_probe_armpmu() also has a similar situation
Extracted ID_AA64DFR0_EL1_PMUVer value, when PMU is not implemented is '0',
which can be replaced with ID_AA64DFR0_EL1_PMUVer_NI defined as '0b0000'.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.1-rc6

 arch/arm64/kvm/pmu-emul.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 0003c7d37533..089a0b4c561b 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -774,7 +774,8 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
 {
 	struct arm_pmu_entry *entry;
 
-	if (pmu->pmuver == 0 || pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
+	if (pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_NI ||
+	    pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
 		return;
 
 	mutex_lock(&arm_pmus_lock);
@@ -827,7 +828,7 @@ static struct arm_pmu *kvm_pmu_probe_armpmu(void)
 
 	if (event->pmu) {
 		pmu = to_arm_pmu(event->pmu);
-		if (pmu->pmuver == 0 ||
+		if (pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_NI ||
 		    pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
 			pmu = NULL;
 	}
-- 
2.25.1

