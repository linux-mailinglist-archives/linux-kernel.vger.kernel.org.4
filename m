Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A29572B7C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjFLFmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjFLFlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:41:06 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0410171E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:40:30 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-19674cab442so2467924fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686548422; x=1689140422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItzAMJwJhGybL3SYe9JMZRDA2+kADGrO7c+R89TrEXg=;
        b=OT9IxQEs+I6Su7qVZ5TcolzkjpjLjlWzXIX+T7pvI6Fh6rgAlNqs8KIyei4b5QP86d
         r1zKI2PR8AhmgDPNIwFTm111Bk8JK5slsrNqm4KGql5G9ah/nhmqwXvWVRwDxXVD7JCb
         T4lTH4HNgLBlVxs+0YkUZjwGR05msR2WiSMy6BQ8c0rnjRW/0u6bbsxPBbof4TqSk511
         2hC41M3t1qd+waAZL8SFeIdT7EIAFj8DCFzNspop6SC21erHx+o3hg6ltN4zOCd9bmNq
         vWj6jjIrdHjcJJ8gjp3r/2LJG5u4XlSRASKRbqJKW7BczcomMAL/RDdu7L8a0/tdAdaF
         m7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548422; x=1689140422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItzAMJwJhGybL3SYe9JMZRDA2+kADGrO7c+R89TrEXg=;
        b=VGqAMDo8JUNcMLXbtPLgoJqPGjE0Cr4XqVG+DRaT0tVJlanpDH/z8pdVOzFlhfzJt8
         CJWXHaIvXrPMURN865hvI2XfGCE9QsKYavIUlrhkabLQxtusQgt9q6kAMSKJw6Go9izs
         OLd/KkjvEMBl1dmNnIrvhbUUPOYMq6CUy8RZSHUQoUTxCUXBoSFCuMIqtezC04S61TDN
         Ayo4l1kn89m2wzAXHKSjxa/rc7Q4G5CrBKAakNWNEJ/uRDmjP8vZrdyzlwqOZyfyo/Ic
         Y3oXKqN/o1ePbN8CNLKREz02A1wJVZcKMNwGsKRrddKZQBJzlsdewArmuGzbdIAvVHMk
         Mq8A==
X-Gm-Message-State: AC+VfDy+E/XyAFWpIeQBO0kPSl1NKEGUwtI/Da252AQ3ZvNJgyRnutOn
        GoExiGUZJnXxCWY8pS6DlKm2hw==
X-Google-Smtp-Source: ACHHUZ5VhbemlNMa/C96OS5oJq3Hn9nOsmVawnbnBv7JIlC+o7QQG/ol/I8MeD/nz4QiewgDdVf6TQ==
X-Received: by 2002:a05:6870:8645:b0:1a6:4c71:8dd with SMTP id i5-20020a056870864500b001a64c7108ddmr3753337oal.37.1686548422284;
        Sun, 11 Jun 2023 22:40:22 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id lv19-20020a056871439300b001a30d846520sm5534869oab.7.2023.06.11.22.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:40:21 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 08/10] RISC-V: KVM: Expose APLIC registers as attributes of AIA irqchip
Date:   Mon, 12 Jun 2023 11:09:30 +0530
Message-Id: <20230612053932.58604-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612053932.58604-1-apatel@ventanamicro.com>
References: <20230612053932.58604-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expose APLIC registers as KVM device attributes of the in-kernel
AIA irqchip device. This will allow KVM user-space to save/restore
APLIC state using KVM device ioctls().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_aia.h  |  3 +++
 arch/riscv/include/uapi/asm/kvm.h |  6 +++++
 arch/riscv/kvm/aia_aplic.c        | 43 +++++++++++++++++++++++++++++++
 arch/riscv/kvm/aia_device.c       | 25 ++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index f6bd8523395f..ba939c0054aa 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -129,6 +129,9 @@ static inline void kvm_riscv_vcpu_aia_imsic_cleanup(struct kvm_vcpu *vcpu)
 {
 }
 
+int kvm_riscv_aia_aplic_set_attr(struct kvm *kvm, unsigned long type, u32 v);
+int kvm_riscv_aia_aplic_get_attr(struct kvm *kvm, unsigned long type, u32 *v);
+int kvm_riscv_aia_aplic_has_attr(struct kvm *kvm, unsigned long type);
 int kvm_riscv_aia_aplic_inject(struct kvm *kvm, u32 source, bool level);
 int kvm_riscv_aia_aplic_init(struct kvm *kvm);
 void kvm_riscv_aia_aplic_cleanup(struct kvm *kvm);
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 047c8fc5bd71..9ed822fc5589 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -249,6 +249,12 @@ enum KVM_RISCV_SBI_EXT_ID {
 #define KVM_DEV_RISCV_AIA_GRP_CTRL		2
 #define KVM_DEV_RISCV_AIA_CTRL_INIT		0
 
+/*
+ * The device attribute type contains the memory mapped offset of the
+ * APLIC register (range 0x0000-0x3FFF) and it must be 4-byte aligned.
+ */
+#define KVM_DEV_RISCV_AIA_GRP_APLIC		3
+
 /* One single KVM irqchip, ie. the AIA */
 #define KVM_NR_IRQCHIPS			1
 
diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
index 1b0a4df64815..ed9102dfba77 100644
--- a/arch/riscv/kvm/aia_aplic.c
+++ b/arch/riscv/kvm/aia_aplic.c
@@ -499,6 +499,49 @@ static struct kvm_io_device_ops aplic_iodoev_ops = {
 	.write = aplic_mmio_write,
 };
 
+int kvm_riscv_aia_aplic_set_attr(struct kvm *kvm, unsigned long type, u32 v)
+{
+	int rc;
+
+	if (!kvm->arch.aia.aplic_state)
+		return -ENODEV;
+
+	rc = aplic_mmio_write_offset(kvm, type, v);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+int kvm_riscv_aia_aplic_get_attr(struct kvm *kvm, unsigned long type, u32 *v)
+{
+	int rc;
+
+	if (!kvm->arch.aia.aplic_state)
+		return -ENODEV;
+
+	rc = aplic_mmio_read_offset(kvm, type, v);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+int kvm_riscv_aia_aplic_has_attr(struct kvm *kvm, unsigned long type)
+{
+	int rc;
+	u32 val;
+
+	if (!kvm->arch.aia.aplic_state)
+		return -ENODEV;
+
+	rc = aplic_mmio_read_offset(kvm, type, &val);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 int kvm_riscv_aia_aplic_init(struct kvm *kvm)
 {
 	int i, ret = 0;
diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index a151fb357887..17dba92a90e1 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -364,6 +364,15 @@ static int aia_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 			break;
 		}
 
+		break;
+	case KVM_DEV_RISCV_AIA_GRP_APLIC:
+		if (copy_from_user(&nr, uaddr, sizeof(nr)))
+			return -EFAULT;
+
+		mutex_lock(&dev->kvm->lock);
+		r = kvm_riscv_aia_aplic_set_attr(dev->kvm, type, nr);
+		mutex_unlock(&dev->kvm->lock);
+
 		break;
 	}
 
@@ -411,6 +420,20 @@ static int aia_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		if (copy_to_user(uaddr, &addr, sizeof(addr)))
 			return -EFAULT;
 
+		break;
+	case KVM_DEV_RISCV_AIA_GRP_APLIC:
+		if (copy_from_user(&nr, uaddr, sizeof(nr)))
+			return -EFAULT;
+
+		mutex_lock(&dev->kvm->lock);
+		r = kvm_riscv_aia_aplic_get_attr(dev->kvm, type, &nr);
+		mutex_unlock(&dev->kvm->lock);
+		if (r)
+			return r;
+
+		if (copy_to_user(uaddr, &nr, sizeof(nr)))
+			return -EFAULT;
+
 		break;
 	}
 
@@ -447,6 +470,8 @@ static int aia_has_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 			return 0;
 		}
 		break;
+	case KVM_DEV_RISCV_AIA_GRP_APLIC:
+		return kvm_riscv_aia_aplic_has_attr(dev->kvm, attr->attr);
 	}
 
 	return -ENXIO;
-- 
2.34.1

