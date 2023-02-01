Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4641A67E3AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjA0LlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjA0LlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:41:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9446B10250;
        Fri, 27 Jan 2023 03:40:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F48165C;
        Fri, 27 Jan 2023 03:40:48 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7406D3F64C;
        Fri, 27 Jan 2023 03:40:03 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc:     suzuki.poulose@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joey Gouly <Joey.Gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-coco@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC kvmtool 06/31] arm64: Check SVE capability on the VM instance
Date:   Fri, 27 Jan 2023 11:39:07 +0000
Message-Id: <20230127113932.166089-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127113932.166089-1-suzuki.poulose@arm.com>
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127113932.166089-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to PVtime, check the SVE capability on the VM instance
to account for the different VM types and the corresponding support.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arm/aarch64/kvm-cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arm/aarch64/kvm-cpu.c b/arm/aarch64/kvm-cpu.c
index c8be10b3..da809806 100644
--- a/arm/aarch64/kvm-cpu.c
+++ b/arm/aarch64/kvm-cpu.c
@@ -150,13 +150,15 @@ void kvm_cpu__select_features(struct kvm *kvm, struct kvm_vcpu_init *init)
 	}
 
 	/* Enable SVE if available */
-	if (kvm__supports_extension(kvm, KVM_CAP_ARM_SVE))
+	if (kvm__supports_vm_extension(kvm, KVM_CAP_ARM_SVE))
 		init->features[0] |= 1UL << KVM_ARM_VCPU_SVE;
 }
 
 int kvm_cpu__configure_features(struct kvm_cpu *vcpu)
 {
-	if (kvm__supports_extension(vcpu->kvm, KVM_CAP_ARM_SVE)) {
+	struct kvm *kvm = vcpu->kvm;
+
+	if (kvm__supports_vm_extension(kvm, KVM_CAP_ARM_SVE)) {
 		int feature = KVM_ARM_VCPU_SVE;
 
 		if (ioctl(vcpu->vcpu_fd, KVM_ARM_VCPU_FINALIZE, &feature)) {
-- 
2.34.1

