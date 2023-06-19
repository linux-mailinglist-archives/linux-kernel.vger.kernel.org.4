Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6AB734E04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFSIfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFSIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:33:19 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CEAD1AD;
        Mon, 19 Jun 2023 01:33:17 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8CxvOrGEpBkEswGAA--.14017S3;
        Mon, 19 Jun 2023 16:33:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxC8q3EpBkAgsgAA--.15169S23;
        Mon, 19 Jun 2023 16:33:09 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn,
        tangyouling@loongson.cn
Subject: [PATCH v14 21/30] LoongArch: KVM: Implement handle iocsr exception
Date:   Mon, 19 Jun 2023 16:32:46 +0800
Message-Id: <20230619083255.3841777-22-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230619083255.3841777-1-zhaotianrui@loongson.cn>
References: <20230619083255.3841777-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxC8q3EpBkAgsgAA--.15169S23
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement kvm handle vcpu iocsr exception, setting the iocsr info into
vcpu_run and return to user space to handle it.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/include/asm/inst.h | 16 ++++++
 arch/loongarch/kvm/exit.c         | 92 +++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index b09887ffcd15..db5857796432 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -56,6 +56,14 @@ enum reg2_op {
 	revbd_op	= 0x0f,
 	revh2w_op	= 0x10,
 	revhd_op	= 0x11,
+	iocsrrdb_op     = 0x19200,
+	iocsrrdh_op     = 0x19201,
+	iocsrrdw_op     = 0x19202,
+	iocsrrdd_op     = 0x19203,
+	iocsrwrb_op     = 0x19204,
+	iocsrwrh_op     = 0x19205,
+	iocsrwrw_op     = 0x19206,
+	iocsrwrd_op     = 0x19207,
 };
 
 enum reg2i5_op {
@@ -298,6 +306,13 @@ struct reg3sa2_format {
 	unsigned int opcode : 15;
 };
 
+struct reg2csr_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int csr : 14;
+	unsigned int opcode : 8;
+};
+
 union loongarch_instruction {
 	unsigned int word;
 	struct reg0i15_format	reg0i15_format;
@@ -313,6 +328,7 @@ union loongarch_instruction {
 	struct reg2bstrd_format	reg2bstrd_format;
 	struct reg3_format	reg3_format;
 	struct reg3sa2_format	reg3sa2_format;
+	struct reg2csr_format   reg2csr_format;
 };
 
 #define LOONGARCH_INSN_SIZE	sizeof(union loongarch_instruction)
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index 18635333fc9a..32edd915ebcb 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -96,3 +96,95 @@ static int _kvm_handle_csr(struct kvm_vcpu *vcpu, larch_inst inst)
 
 	return EMULATE_DONE;
 }
+
+int _kvm_emu_iocsr(larch_inst inst, struct kvm_run *run, struct kvm_vcpu *vcpu)
+{
+	u32 rd, rj, opcode;
+	u32 addr;
+	unsigned long val;
+	int ret;
+
+	/*
+	 * Each IOCSR with different opcode
+	 */
+	rd = inst.reg2_format.rd;
+	rj = inst.reg2_format.rj;
+	opcode = inst.reg2_format.opcode;
+	addr = vcpu->arch.gprs[rj];
+	ret = EMULATE_DO_IOCSR;
+	run->iocsr_io.phys_addr = addr;
+	run->iocsr_io.is_write = 0;
+
+	/* LoongArch is Little endian */
+	switch (opcode) {
+	case iocsrrdb_op:
+		run->iocsr_io.len = 1;
+		break;
+	case iocsrrdh_op:
+		run->iocsr_io.len = 2;
+		break;
+	case iocsrrdw_op:
+		run->iocsr_io.len = 4;
+		break;
+	case iocsrrdd_op:
+		run->iocsr_io.len = 8;
+		break;
+	case iocsrwrb_op:
+		run->iocsr_io.len = 1;
+		run->iocsr_io.is_write = 1;
+		break;
+	case iocsrwrh_op:
+		run->iocsr_io.len = 2;
+		run->iocsr_io.is_write = 1;
+		break;
+	case iocsrwrw_op:
+		run->iocsr_io.len = 4;
+		run->iocsr_io.is_write = 1;
+		break;
+	case iocsrwrd_op:
+		run->iocsr_io.len = 8;
+		run->iocsr_io.is_write = 1;
+		break;
+	default:
+		ret = EMULATE_FAIL;
+		break;
+	}
+
+	if (ret == EMULATE_DO_IOCSR) {
+		if (run->iocsr_io.is_write) {
+			val = vcpu->arch.gprs[rd];
+			memcpy(run->iocsr_io.data, &val, run->iocsr_io.len);
+		}
+		vcpu->arch.io_gpr = rd;
+	}
+
+	return ret;
+}
+
+int _kvm_complete_iocsr_read(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	unsigned long *gpr = &vcpu->arch.gprs[vcpu->arch.io_gpr];
+	enum emulation_result er = EMULATE_DONE;
+
+	switch (run->iocsr_io.len) {
+	case 8:
+		*gpr = *(s64 *)run->iocsr_io.data;
+		break;
+	case 4:
+		*gpr = *(int *)run->iocsr_io.data;
+		break;
+	case 2:
+		*gpr = *(short *)run->iocsr_io.data;
+		break;
+	case 1:
+		*gpr = *(char *) run->iocsr_io.data;
+		break;
+	default:
+		kvm_err("Bad IOCSR length: %d,addr is 0x%lx",
+				run->iocsr_io.len, vcpu->arch.badv);
+		er = EMULATE_FAIL;
+		break;
+	}
+
+	return er;
+}
-- 
2.39.1

