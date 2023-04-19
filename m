Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA28B6E84DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjDSW1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjDSW0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:26:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE3AD05
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:25:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a6f0d8cdfeso4530655ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681943052; x=1684535052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E81F/sZHqFlmC4PTTDxmyvFtDAnkdcxCBJVjUmPx/Qw=;
        b=h8qvhmk4lDaY4kQIaAqeKrnT156suhglOdhOFhlubu1kF8monJSVNUgUE+j1dG31u3
         2u4SpVYqZ4tfegebKpsL38KKycJWXvEDDTgK8UNr6JRmWeQLZM10VY51+CKxQiNgddvl
         jVlFZj35wrKDUORGT0J+qOCCKpjlGHzbKe/sGfoeSgQinTk47q9jptfvuPOOM2rG+CYr
         zwGu3oFCrdRFjF7E7+wb2JbG1bH3s5tlAZXNHsT/M1j9N2DMFEV+pbXVFPMwgsNs8Fq+
         +9F3bZPSaGt+4fI+77DT77iqb04ZT/uOhlexxfDhgZPl/024tDlCe5TFxeig37XFSsp8
         WtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943052; x=1684535052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E81F/sZHqFlmC4PTTDxmyvFtDAnkdcxCBJVjUmPx/Qw=;
        b=Sme54IQGJLggHlHTzHh+EgKj2if5uYH+tMt/XmkUfoLOiElRO16dzGugw1z4x8Wtyt
         vbksSIZ2zsVeqk+b8NqbwF16jtY5a4GpV+/0df+OW2TwIL3YiHUItyv2WeDUvWLVWEBP
         lPAtZTx3zDmcJHtJQeq/GRTGbT+ZuaYw2RYOO6wm8c4jbUgFCmyEwMeVmog3j9owhPM6
         6aqB85hcLaBAv+SbCSNYFIQhhti4LGrWly9vuj0Pxt5Tqqo95KDiUpLCdnsy7+cYZ4uu
         P6hIJPVcWiIzDUGBAV2OkI7nYaly9kg5HrUGTdCw+iy2CL/S78Cvdym6o5/EL/bUnkil
         gNsw==
X-Gm-Message-State: AAQBX9daIKY+b78Nn2biQaJr+8FF4NCVpuJcFVGmBm9zNOqkn5hGI48L
        nbFtXYpITRwFOpYgOr/jxyAjdbuOanB/YkUWne4=
X-Google-Smtp-Source: AKy350ZDizFV7lhpli0WrCYYrT6iDsFp55kYpsDPb3wO0+TsDTvsM5wAJ/jQ030A1Tz0V9swMbp+9w==
X-Received: by 2002:a17:902:da8a:b0:1a6:97fd:29e7 with SMTP id j10-20020a170902da8a00b001a697fd29e7mr8449012plx.27.1681943051998;
        Wed, 19 Apr 2023 15:24:11 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001a681fb3e77sm11867810plt.44.2023.04.19.15.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:24:11 -0700 (PDT)
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
Subject: [RFC kvmtool 05/10] riscv: Do not create APLIC for TVMs
Date:   Wed, 19 Apr 2023 15:23:45 -0700
Message-Id: <20230419222350.3604274-6-atishp@rivosinc.com>
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

The CoVE VMs do not support wired interrupts. Thus no need of APLIC at
this point.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 riscv/aia.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/riscv/aia.c b/riscv/aia.c
index 8c85b3f..a3b8618 100644
--- a/riscv/aia.c
+++ b/riscv/aia.c
@@ -143,6 +143,11 @@ static int aia__init(struct kvm *kvm)
 		.attr	= KVM_DEV_RISCV_AIA_CTRL_INIT,
 	};
 
+
+	/* CoVE VM only supports hardware with physical guest interrupt file */
+	if (kvm->cfg.arch.cove_vm)
+		aia_mode = KVM_DEV_RISCV_AIA_MODE_HWACCEL;
+
 	/* Setup global device attribute variables */
 	aia_mode_attr.addr = (u64)(unsigned long)&aia_mode;
 	aia_nr_ids_attr.addr = (u64)(unsigned long)&aia_nr_ids;
@@ -160,10 +165,7 @@ static int aia__init(struct kvm *kvm)
 	ret = ioctl(aia_fd, KVM_GET_DEVICE_ATTR, &aia_nr_ids_attr);
 	if (ret)
 		return ret;
-	aia_nr_sources = irq__get_nr_allocated_lines();
-	ret = ioctl(aia_fd, KVM_SET_DEVICE_ATTR, &aia_nr_sources_attr);
-	if (ret)
-		return ret;
+
 	aia_hart_bits = fls_long(kvm->nrcpus);
 	ret = ioctl(aia_fd, KVM_SET_DEVICE_ATTR, &aia_hart_bits_attr);
 	if (ret)
@@ -172,12 +174,21 @@ static int aia__init(struct kvm *kvm)
 	/* Save number of HARTs for FDT generation */
 	aia_nr_harts = kvm->nrcpus;
 
-	/* Set AIA device addresses */
-	aia_addr = AIA_APLIC_ADDR(aia_nr_harts);
-	aia_addr_attr.attr = KVM_DEV_RISCV_AIA_ADDR_APLIC;
-	ret = ioctl(aia_fd, KVM_SET_DEVICE_ATTR, &aia_addr_attr);
-	if (ret)
-		return ret;
+	/* CoVE VMs do not support APLIC yet */
+	if (!kvm->cfg.arch.cove_vm) {
+		aia_nr_sources = irq__get_nr_allocated_lines();
+		ret = ioctl(aia_fd, KVM_SET_DEVICE_ATTR, &aia_nr_sources_attr);
+		if (ret)
+			return ret;
+
+		/* Set AIA device addresses */
+		aia_addr = AIA_APLIC_ADDR(aia_nr_harts);
+		aia_addr_attr.attr = KVM_DEV_RISCV_AIA_ADDR_APLIC;
+		ret = ioctl(aia_fd, KVM_SET_DEVICE_ATTR, &aia_addr_attr);
+		if (ret)
+			return ret;
+	}
+
 	for (i = 0; i < kvm->nrcpus; i++) {
 		aia_addr = AIA_IMSIC_ADDR(i);
 		aia_addr_attr.attr = KVM_DEV_RISCV_AIA_ADDR_IMSIC(i);
-- 
2.25.1

