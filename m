Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994B76E84E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjDSW1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjDSW1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:27:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA18AF33
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:25:39 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51efefe7814so276569a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681943048; x=1684535048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sx5yCGWct6pM6GpC/mvdByE459bnHS7kFRJEEmvmIAE=;
        b=3p9iTgdU1fM6SCFnmbdU2SRrkZIz70XAXwuZckkQOMwQBsxli9xyQOj3eelNgilUbh
         Ys8/7Ew5TPJfNpxVGDr0CtIGeK0FA4rEB+OIcbXgq5wyTLnVYPvSZ8aMalLarGl9SYQB
         5RACL91+xtTKghPY756sehNtiuCKsCnVWuoe+lw1F03ENQxtWOfB9WS65O7GV37PILFO
         Dk35L2JW1UKZe1fvGcD1U01nAz5TPWWbGAHGpwD1ZT3uAJFTUyTj5jlwZGRm00f0H14O
         tl+5fi2Hb+F0OmZuIVTWcPUeShVBuC5Hht10Q7j0AV8S9TF+U8wIpbjtIc2XL8zQkszI
         EVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943048; x=1684535048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sx5yCGWct6pM6GpC/mvdByE459bnHS7kFRJEEmvmIAE=;
        b=bP+OVmy4eXmp6kn3kuFC5kl176yP7bARpQw/2fVSTIQcTMbQMnUhtfNfRboXbVkwGt
         dL0Cw2yGddY1QrSdxvQfyE0zS7aJUqTmGTjy1MIzL3RPgro6Owb6NtHHHNR+rUKYiLfc
         po/fq6IGpi1GjOhvLOz33Lvf35Ti16yKiQ4EnZVv22oU/2ZiPt7H/5eUsTWRmSCOWnBb
         KBm/DPIy1lPuv8hSz1heccB6XrdaHdnC2TqjRA3c1Yh05JiHAOxfjEcMxMzA0wfoI5Tw
         mHejY3doTfXh1ZpY7GKTzozmvESBbYVFEQTyTblCxfsAet7bgFqvlf8n8sY8zVG56TDK
         GafA==
X-Gm-Message-State: AAQBX9cgfzVgYAgAWl3ADOHcldbWryts1OBAyYdKZTYS5O454sfk+pUh
        TCoq4WYi/hTp96glbAWSFlMArYsKV5rw82XlYrA=
X-Google-Smtp-Source: AKy350YPzGRajmyQ2O5tL/h5sOqIMWA3WFpT3qCLbVNDZ6itlq+/cjeCHlrQkCoL9IBGQLSaGxxwuA==
X-Received: by 2002:a17:903:2905:b0:19a:b869:f2f8 with SMTP id lh5-20020a170903290500b0019ab869f2f8mr5951568plb.21.1681943047880;
        Wed, 19 Apr 2023 15:24:07 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001a681fb3e77sm11867810plt.44.2023.04.19.15.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:24:07 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-coco@lists.linux.dev, Dylan Reid <dylan@rivosinc.com>,
        abrestic@rivosinc.com, Samuel Ortiz <sameo@rivosinc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC kvmtool 03/10] riscv: Define a measure region IOCTL
Date:   Wed, 19 Apr 2023 15:23:43 -0700
Message-Id: <20230419222350.3604274-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419222350.3604274-1-atishp@rivosinc.com>
References: <20230419222350.3604274-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoVE VM images needs to be measured by the TSM. The VMM updates
the host about these images via a new IOCTL. The host makes appropriate
ecalls for TSM to perform the measurement.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 include/linux/kvm.h          |  2 ++
 riscv/include/asm/kvm.h      |  6 ++++++
 riscv/include/kvm/kvm-arch.h |  2 ++
 riscv/kvm.c                  | 21 +++++++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 000d2b9..d4969a0 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -1547,6 +1547,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_SVM_OFF		  _IO(KVMIO,  0xb3)
 #define KVM_ARM_MTE_COPY_TAGS	  _IOR(KVMIO,  0xb4, struct kvm_arm_copy_mte_tags)
 
+#define KVM_RISCV_COVE_MEASURE_REGION _IOR(KVMIO, 0xb5, struct kvm_riscv_cove_measure_region)
+
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
 
diff --git a/riscv/include/asm/kvm.h b/riscv/include/asm/kvm.h
index 1dce9a4..2bacc38 100644
--- a/riscv/include/asm/kvm.h
+++ b/riscv/include/asm/kvm.h
@@ -98,6 +98,12 @@ struct kvm_riscv_timer {
 	__u64 state;
 };
 
+struct kvm_riscv_cove_measure_region {
+	unsigned long user_addr;
+	unsigned long gpa;
+	unsigned long size;
+};
+
 /*
  * ISA extension IDs specific to KVM. This is not the same as the host ISA
  * extension IDs as that is internal to the host and should not be exposed
diff --git a/riscv/include/kvm/kvm-arch.h b/riscv/include/kvm/kvm-arch.h
index 9f2159f..08ac54a 100644
--- a/riscv/include/kvm/kvm-arch.h
+++ b/riscv/include/kvm/kvm-arch.h
@@ -120,4 +120,6 @@ void riscv__generate_irq_prop(void *fdt, u8 irq, enum irq_type irq_type);
 
 void riscv__irqchip_create(struct kvm *kvm);
 
+void kvm_cove_measure_region(struct kvm *kvm, unsigned long uaddr,
+			      unsigned long gpa, unsigned long rsize);
 #endif /* KVM__KVM_ARCH_H */
diff --git a/riscv/kvm.c b/riscv/kvm.c
index a9ade1f..99b253e 100644
--- a/riscv/kvm.c
+++ b/riscv/kvm.c
@@ -13,6 +13,27 @@ struct kvm_ext kvm_req_ext[] = {
 	{ 0, 0 },
 };
 
+void kvm_cove_measure_region(struct kvm *kvm, unsigned long uaddr,
+			      unsigned long gpa, unsigned long rsize)
+{
+	int ret;
+
+	if (!kvm->cfg.arch.cove_vm)
+		return;
+
+	struct kvm_riscv_cove_measure_region mr = {
+		.user_addr = uaddr,
+		.gpa = gpa,
+		.size = rsize,
+	};
+
+	ret = ioctl(kvm->vm_fd, KVM_RISCV_COVE_MEASURE_REGION, &mr);
+	if (ret < 0) {
+		ret = -errno;
+		die("Setting measure region failed for CoVE VM\n");
+	}
+}
+
 u64 kvm__arch_default_ram_address(void)
 {
 	return RISCV_RAM;
-- 
2.25.1

