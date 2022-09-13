Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFCF5B6B10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiIMJpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiIMJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:44:59 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E4AFD36;
        Tue, 13 Sep 2022 02:44:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663062297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJL3FbXBtTzcHZgAPzygmcYC5SSDDT0fz6jIg7iwh8E=;
        b=FrJd1G5+j1a5oQ71ei6kWlHkZcy0v1sSIGfgMBAN3Bn9YgCR0bXWaz9vCpghiBUZaCLQal
        u7HBZdR7RJmhH8796y6ArVo/S2mGrX7Xf2szQbTLSGvryXXwbG+UiiYPYcrseKZI5xwA8G
        cDxlkhEQJyw1gNsOEDHNWENPIcV/kcA=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Reiji Watanabe <reijiw@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] KVM: arm64: Remove internal accessor helpers for id regs
Date:   Tue, 13 Sep 2022 09:44:35 +0000
Message-Id: <20220913094441.3957645-3-oliver.upton@linux.dev>
In-Reply-To: <20220913094441.3957645-1-oliver.upton@linux.dev>
References: <20220913094441.3957645-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal accessors are only ever called once. Dump out their
contents in the caller.

No functional change intended.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/sys_regs.c | 46 ++++++++++-----------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e18efb9211f0..26210f3a0b27 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1153,25 +1153,17 @@ static unsigned int raz_visibility(const struct kvm_vcpu *vcpu,
 
 /* cpufeature ID register access trap handlers */
 
-static bool __access_id_reg(struct kvm_vcpu *vcpu,
-			    struct sys_reg_params *p,
-			    const struct sys_reg_desc *r,
-			    bool raz)
-{
-	if (p->is_write)
-		return write_to_read_only(vcpu, p, r);
-
-	p->regval = read_id_reg(vcpu, r, raz);
-	return true;
-}
-
 static bool access_id_reg(struct kvm_vcpu *vcpu,
 			  struct sys_reg_params *p,
 			  const struct sys_reg_desc *r)
 {
 	bool raz = sysreg_visible_as_raz(vcpu, r);
 
-	return __access_id_reg(vcpu, p, r, raz);
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	p->regval = read_id_reg(vcpu, r, raz);
+	return true;
 }
 
 /* Visibility overrides for SVE-specific control registers */
@@ -1226,31 +1218,13 @@ static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
  * are stored, and for set_id_reg() we don't allow the effective value
  * to be changed.
  */
-static int __get_id_reg(const struct kvm_vcpu *vcpu,
-			const struct sys_reg_desc *rd, u64 *val,
-			bool raz)
-{
-	*val = read_id_reg(vcpu, rd, raz);
-	return 0;
-}
-
-static int __set_id_reg(const struct kvm_vcpu *vcpu,
-			const struct sys_reg_desc *rd, u64 val,
-			bool raz)
-{
-	/* This is what we mean by invariant: you can't change it. */
-	if (val != read_id_reg(vcpu, rd, raz))
-		return -EINVAL;
-
-	return 0;
-}
-
 static int get_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		      u64 *val)
 {
 	bool raz = sysreg_visible_as_raz(vcpu, rd);
 
-	return __get_id_reg(vcpu, rd, val, raz);
+	*val = read_id_reg(vcpu, rd, raz);
+	return 0;
 }
 
 static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
@@ -1258,7 +1232,11 @@ static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 {
 	bool raz = sysreg_visible_as_raz(vcpu, rd);
 
-	return __set_id_reg(vcpu, rd, val, raz);
+	/* This is what we mean by invariant: you can't change it. */
+	if (val != read_id_reg(vcpu, rd, raz))
+		return -EINVAL;
+
+	return 0;
 }
 
 static int get_raz_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-- 
2.37.2.789.g6183377224-goog

