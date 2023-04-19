Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D298E6E84EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjDSW2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjDSW2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:28:06 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A8BCC23
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:26:31 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1a66b9bd7dfso5258405ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681943050; x=1684535050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqxJzuQg4YHoKMLWmjQ5z9IqDd25T8M3gtHVASWlMsA=;
        b=CdFLGUbJVpNnlbN6H0RysN3QwK8Q22dGILzUyKn1eed3BCAW6+MEMsBRDq2/F3MfEN
         8F/42PROs9h1k2Q7VrH4EPO6wp5xxtsziRkW162nuTlbeuaKnWv/CAiPccnTCWWIYPQk
         oJLjTPMoTHn4eG+8ibMKGv7GyStv5zxs81LmeyyaemazO9r8w0RuVqYmdLVQ/35zsHF4
         Epuj0d4WbFCdWHPxERyyC/wFKBbzXDxx2K1QzNu3em+Y/D7eT+3ZwnJpBriORGuqa1bG
         mG11CSzZymcMK9J81Dm4lnZ1qJfC6fNYaISOIHAhx4fE/+Qh3aPrGDxSYFrQFc63TMHE
         cEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943050; x=1684535050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqxJzuQg4YHoKMLWmjQ5z9IqDd25T8M3gtHVASWlMsA=;
        b=XxT3LkhMh5joT4pqsE5N5pXV5rLC0qi18VoJxopSVtRiiASYtgCqDnsauEafjXscHU
         x+i/h/vXuRjZbOyOQZzQ9VULus4BKvgwmxtU7cUrWLTU7OiFrYBXE+sVjLRArtsGJxd/
         kfMOFz8lpzCbbzwpDE/se+aH3c3AbCjPuEyE0SmU5OqqVDr0U/5b0EfownM2GO88Sjd1
         nInvbpEcjH+ibsX6OtsIRB/qjgSckNWNPzKAqYsq4Kty96RJKAt/C1j6F0kZxy9TfuJB
         eH0QQ0NNFuYXT9cP7z2D06VuIUIO3OflOMnX/o0u1Rnn8qwYnG73jL4ZfA00JeFPWpQR
         /wkw==
X-Gm-Message-State: AAQBX9cq/1hB7wfKc18JIGQyNX41Em2GhdYs1r3GXXg/jQ8F6tF82I6h
        OrQUlNJ8WnKsha1YwRjx1vGwn81H9v28DVN/db0=
X-Google-Smtp-Source: AKy350Y1oJzpFyEWrofUoiBPrqInLwUP0IdbCjWNBlR0+a+fpEuwpi5wATQkdQOE2P7s+B2OF642XA==
X-Received: by 2002:a17:902:db08:b0:1a6:8405:f709 with SMTP id m8-20020a170902db0800b001a68405f709mr8145477plx.20.1681943049834;
        Wed, 19 Apr 2023 15:24:09 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001a681fb3e77sm11867810plt.44.2023.04.19.15.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:24:09 -0700 (PDT)
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
Subject: [RFC kvmtool 04/10] riscv: Invoke measure region for VM images
Date:   Wed, 19 Apr 2023 15:23:44 -0700
Message-Id: <20230419222350.3604274-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419222350.3604274-1-atishp@rivosinc.com>
References: <20230419222350.3604274-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT, initrd and kernel images needs to be measured before a CoVE VM
can be started to validate its authenticity.

Hookup the measure region API for these three components.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 riscv/fdt.c | 3 +++
 riscv/kvm.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/riscv/fdt.c b/riscv/fdt.c
index 61a28bb..07ec336 100644
--- a/riscv/fdt.c
+++ b/riscv/fdt.c
@@ -254,6 +254,9 @@ static int setup_fdt(struct kvm *kvm)
 
 	if (kvm->cfg.arch.dump_dtb_filename)
 		dump_fdt(kvm->cfg.arch.dump_dtb_filename, fdt_dest);
+
+	kvm_cove_measure_region(kvm, (unsigned long)fdt_dest,
+				kvm->arch.dtb_guest_start, FDT_MAX_SIZE);
 	return 0;
 }
 late_init(setup_fdt);
diff --git a/riscv/kvm.c b/riscv/kvm.c
index 99b253e..d59e8bc 100644
--- a/riscv/kvm.c
+++ b/riscv/kvm.c
@@ -148,6 +148,8 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 	pr_debug("Loaded kernel to 0x%llx (%zd bytes)",
 		 kvm->arch.kern_guest_start, file_size);
 
+	kvm_cove_measure_region(kvm, (unsigned long)pos, kvm->arch.kern_guest_start,
+			       file_size);
 	/* Place FDT just after kernel at FDT_ALIGN address */
 	pos = kernel_end + FDT_ALIGN;
 	guest_addr = ALIGN(host_to_guest_flat(kvm, pos), FDT_ALIGN);
@@ -188,6 +190,8 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 		pr_debug("Loaded initrd to 0x%llx (%llu bytes)",
 			 kvm->arch.initrd_guest_start,
 			 kvm->arch.initrd_size);
+		kvm_cove_measure_region(kvm, (unsigned long)pos, initrd_start,
+				       file_size);
 	} else {
 		kvm->arch.initrd_size = 0;
 	}
-- 
2.25.1

