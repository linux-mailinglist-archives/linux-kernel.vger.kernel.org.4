Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28826F0177
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjD0HNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbjD0HLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:11:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FB984487;
        Thu, 27 Apr 2023 00:11:21 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8CxOuoYIEpkhnQBAA--.2454S3;
        Thu, 27 Apr 2023 15:11:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxtrENIEpksEA+AA--.18906S24;
        Thu, 27 Apr 2023 15:11:18 +0800 (CST)
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
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn
Subject: [PATCH v8 22/30] LoongArch: KVM: Implement handle idle exception
Date:   Thu, 27 Apr 2023 15:11:01 +0800
Message-Id: <20230427071109.3367258-23-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230427071109.3367258-1-zhaotianrui@loongson.cn>
References: <20230427071109.3367258-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxtrENIEpksEA+AA--.18906S24
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvdXoW7JrW5uFykWr43XF4UXFyUAwb_yoWkXrb_ZF
        Z7Jas5GFWrXF45Ka4Dt345Ka4Ygw4kXFWY9FW7ury3GF1qyrWUC39rWw1DZrWkKFWUZFW5
        K3ykZas7Zw12qjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        77CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
        kF7I0E14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6c
        x26rWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r12
        6r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7xRiTKZJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement kvm handle LoongArch vcpu idle exception, using kvm_vcpu_block
to emulate it.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/kvm/exit.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index bd33fe0c6424..3fdb42939a05 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -188,3 +188,23 @@ int _kvm_complete_iocsr_read(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	return er;
 }
+
+int _kvm_emu_idle(struct kvm_vcpu *vcpu)
+{
+	++vcpu->stat.idle_exits;
+	trace_kvm_exit_idle(vcpu, KVM_TRACE_EXIT_IDLE);
+
+	if (!kvm_arch_vcpu_runnable(vcpu)) {
+		/*
+		 * Switch to the software timer before halt-polling/blocking as
+		 * the guest's timer may be a break event for the vCPU, and the
+		 * hypervisor timer runs only when the CPU is in guest mode.
+		 * Switch before halt-polling so that KVM recognizes an expired
+		 * timer before blocking.
+		 */
+		kvm_save_timer(vcpu);
+		kvm_vcpu_block(vcpu);
+	}
+
+	return EMULATE_DONE;
+}
-- 
2.31.1

