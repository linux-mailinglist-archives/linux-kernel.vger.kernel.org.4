Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4143E6A5379
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjB1HBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjB1HBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:01:06 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86C15211CF;
        Mon, 27 Feb 2023 23:01:02 -0800 (PST)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8Dxj82tpv1jkGAGAA--.6566S3;
        Tue, 28 Feb 2023 15:01:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxc+Wppv1jPG9AAA--.15462S11;
        Tue, 28 Feb 2023 15:01:00 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v3 09/29] LoongArch: KVM: Implement vcpu get, vcpu set registers
Date:   Tue, 28 Feb 2023 15:00:36 +0800
Message-Id: <20230228070057.3687180-10-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230228070057.3687180-1-zhaotianrui@loongson.cn>
References: <20230228070057.3687180-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxc+Wppv1jPG9AAA--.15462S11
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvAXoW3CFy5ZF15Gw1rGFWrKF45Jrb_yoW8JrW8Jo
        W8tw48CrWrGw12ywsrtw12qay8JFyxu3WkZr1rAF1F9anrJF4rWr18Ca1DZry3Xr9xWryU
        Ca1jgFn7uayktFn8n29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUvj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64
        kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY
        1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2js
        IEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1s
        IEY20_WwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_
        JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4
        AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj4RKpBTUUUUU
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement loongarch vcpu get registers and set registers operations, it
is called when user space use the ioctl interface to get or set regs.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 375 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 375 insertions(+)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e16b7ca852e3..dce89ace2750 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -13,6 +13,381 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
+int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *v, int force)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+
+	GET_HW_GCSR(id, LOONGARCH_CSR_CRMD, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_PRMD, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_EUEN, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_MISC, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_ECFG, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_ESTAT, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_ERA, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_BADV, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_BADI, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_EENTRY, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBIDX, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBEHI, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBELO0, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBELO1, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_ASID, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_PGDL, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_PGDH, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_PWCTL0, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_PWCTL1, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_STLBPGSIZE, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_RVACFG, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_CPUID, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_PRCFG1, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_PRCFG2, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_PRCFG3, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_KS0, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_KS1, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_KS2, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_KS3, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_KS4, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_KS5, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_KS6, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_KS7, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TMID, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TCFG, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TVAL, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_CNTC, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_LLBCTL, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBRENTRY, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBRBADV, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBRERA, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBRSAVE, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBRELO0, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBRELO1, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBREHI, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_TLBRPRMD, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_DMWIN0, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_DMWIN1, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_DMWIN2, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_DMWIN3, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_MWPS, v);
+	GET_HW_GCSR(id, LOONGARCH_CSR_FWPS, v);
+
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_IMPCTL1, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_IMPCTL2, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRCTL, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRINFO1, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRINFO2, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRENTRY, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRERA, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRSAVE, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_CTAG, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_DEBUG, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_DERA, v);
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_DESAVE, v);
+
+	GET_SW_GCSR(csr, id, LOONGARCH_CSR_TINTCLR, v);
+
+	if (force && (id < CSR_ALL_SIZE)) {
+		*v = kvm_read_sw_gcsr(csr, id);
+		return 0;
+	}
+
+	return -1;
+}
+
+int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *v, int force)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+	int ret;
+
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_CRMD, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_PRMD, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_EUEN, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_MISC, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_ECFG, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_ERA, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_BADV, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_BADI, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_EENTRY, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBIDX, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBEHI, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBELO0, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBELO1, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_ASID, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_PGDL, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_PGDH, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_PWCTL0, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_PWCTL1, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_STLBPGSIZE, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_RVACFG, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_CPUID, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_KS0, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_KS1, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_KS2, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_KS3, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_KS4, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_KS5, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_KS6, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_KS7, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TMID, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TCFG, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TVAL, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_CNTC, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_LLBCTL, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBRENTRY, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBRBADV, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBRERA, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBRSAVE, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBRELO0, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBRELO1, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBREHI, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_TLBRPRMD, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_DMWIN0, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_DMWIN1, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_DMWIN2, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_DMWIN3, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_MWPS, v);
+	SET_HW_GCSR(csr, id, LOONGARCH_CSR_FWPS, v);
+
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_IMPCTL1, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_IMPCTL2, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRCTL, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRINFO1, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRINFO2, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRENTRY, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRERA, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_MERRSAVE, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_CTAG, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_DEBUG, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_DERA, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_DESAVE, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_PRCFG1, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_PRCFG2, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_PRCFG3, v);
+
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_PGD, v);
+	SET_SW_GCSR(csr, id, LOONGARCH_CSR_TINTCLR, v);
+
+	ret = -1;
+	switch (id) {
+	case LOONGARCH_CSR_ESTAT:
+		write_gcsr_estat(*v);
+		/* estat IP0~IP7 inject through guestexcept */
+		write_csr_gintc(((*v) >> 2)  & 0xff);
+		ret = 0;
+		break;
+	default:
+		if (force && (id < CSR_ALL_SIZE)) {
+			kvm_set_sw_gcsr(csr, id, *v);
+			ret = 0;
+		}
+		break;
+	}
+
+	return ret;
+}
+
+static int _kvm_get_one_reg(struct kvm_vcpu *vcpu,
+		const struct kvm_one_reg *reg, s64 *v)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+	int reg_idx, ret;
+
+	if ((reg->id & KVM_IOC_CSRID(0)) == KVM_IOC_CSRID(0)) {
+		reg_idx = KVM_GET_IOC_CSRIDX(reg->id);
+		ret = _kvm_getcsr(vcpu, reg_idx, v, 0);
+		if (ret == 0)
+			return ret;
+	}
+
+	switch (reg->id) {
+	case KVM_REG_LOONGARCH_COUNTER:
+		*v = drdtime() + vcpu->kvm->arch.time_offset;
+		break;
+	default:
+		if ((reg->id & KVM_REG_LOONGARCH_MASK) != KVM_REG_LOONGARCH_CSR)
+			return -EINVAL;
+
+		reg_idx = KVM_GET_IOC_CSRIDX(reg->id);
+		if (reg_idx < CSR_ALL_SIZE)
+			*v = kvm_read_sw_gcsr(csr, reg_idx);
+		else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int _kvm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	int ret;
+	s64 v;
+
+	ret = _kvm_get_one_reg(vcpu, reg, &v);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
+	if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64) {
+		u64 __user *uaddr = (u64 __user *)(long)reg->addr;
+
+		ret = put_user(v, uaddr);
+	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U32) {
+		u32 __user *uaddr = (u32 __user *)(long)reg->addr;
+		u32 v32 = (u32)v;
+
+		ret = put_user(v32, uaddr);
+	}
+
+	return ret;
+}
+
+static int _kvm_set_one_reg(struct kvm_vcpu *vcpu,
+		const struct kvm_one_reg *reg,
+		s64 v)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+	int ret = 0;
+	unsigned long flags;
+	u64 val;
+	int reg_idx;
+
+	val = v;
+	if ((reg->id & KVM_IOC_CSRID(0)) == KVM_IOC_CSRID(0)) {
+		reg_idx = KVM_GET_IOC_CSRIDX(reg->id);
+		ret = _kvm_setcsr(vcpu, reg_idx, &val, 0);
+		if (ret == 0)
+			return ret;
+	}
+
+	switch (reg->id) {
+	case KVM_REG_LOONGARCH_COUNTER:
+		local_irq_save(flags);
+		/*
+		 * gftoffset is relative with board, not vcpu
+		 * only set for the first time for smp system
+		 */
+		if (vcpu->vcpu_id == 0)
+			vcpu->kvm->arch.time_offset = (signed long)(v - drdtime());
+		write_csr_gcntc((ulong)vcpu->kvm->arch.time_offset);
+		local_irq_restore(flags);
+		break;
+	case KVM_REG_LOONGARCH_VCPU_RESET:
+		kvm_reset_timer(vcpu);
+		memset(&vcpu->arch.irq_pending, 0, sizeof(vcpu->arch.irq_pending));
+		memset(&vcpu->arch.irq_clear, 0, sizeof(vcpu->arch.irq_clear));
+		break;
+	default:
+		if ((reg->id & KVM_REG_LOONGARCH_MASK) != KVM_REG_LOONGARCH_CSR)
+			return -EINVAL;
+
+		reg_idx = KVM_GET_IOC_CSRIDX(reg->id);
+		if (reg_idx < CSR_ALL_SIZE)
+			kvm_write_sw_gcsr(csr, reg_idx, v);
+		else
+			return -EINVAL;
+	}
+	return ret;
+}
+
+static int _kvm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	s64 v;
+	int ret;
+
+	ret = -EINVAL;
+	if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64) {
+		u64 __user *uaddr;
+
+		uaddr = (u64 __user *)(long)reg->addr;
+		ret = get_user(v, uaddr);
+	} else if ((reg->id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U32) {
+		u32 __user *uaddr;
+		s32 v32;
+
+		uaddr = (u32 __user *)(long)reg->addr;
+		ret = get_user(v32, uaddr);
+		v = (s64)v32;
+	}
+
+	if (ret)
+		return -EFAULT;
+
+	return _kvm_set_one_reg(vcpu, reg, v);
+}
+
+int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
+{
+	return -ENOIOCTLCMD;
+}
+
+int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
+{
+	return -ENOIOCTLCMD;
+}
+
+int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	int i;
+
+	vcpu_load(vcpu);
+
+	for (i = 0; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
+		regs->gpr[i] = vcpu->arch.gprs[i];
+
+	regs->pc = vcpu->arch.pc;
+
+	vcpu_put(vcpu);
+	return 0;
+}
+
+int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	int i;
+
+	vcpu_load(vcpu);
+
+	for (i = 1; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
+		vcpu->arch.gprs[i] = regs->gpr[i];
+	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
+	vcpu->arch.pc = regs->pc;
+
+	vcpu_put(vcpu);
+	return 0;
+}
+
+long kvm_arch_vcpu_ioctl(struct file *filp,
+			 unsigned int ioctl, unsigned long arg)
+{
+	struct kvm_vcpu *vcpu = filp->private_data;
+	void __user *argp = (void __user *)arg;
+	long r;
+
+	vcpu_load(vcpu);
+
+	switch (ioctl) {
+	case KVM_SET_ONE_REG:
+	case KVM_GET_ONE_REG: {
+		struct kvm_one_reg reg;
+
+		r = -EFAULT;
+		if (copy_from_user(&reg, argp, sizeof(reg)))
+			break;
+		if (ioctl == KVM_SET_ONE_REG)
+			r = _kvm_set_reg(vcpu, &reg);
+		else
+			r = _kvm_get_reg(vcpu, &reg);
+		break;
+	}
+	default:
+		r = -ENOIOCTLCMD;
+		break;
+	}
+
+	vcpu_put(vcpu);
+	return r;
+}
+
 int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 {
 	return 0;
-- 
2.31.1

