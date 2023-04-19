Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C456E8509
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjDSWf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjDSWfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:35:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236131FF0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:35:23 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-74db3642400so4729885a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681943660; x=1684535660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv3jO/UplLaGK+gTx4v9j9xexh60oYjru3uhX3LfGtA=;
        b=1vPSyerqCt0Qvmv8hwWhHs7+2v7XZAr0KTtgrWL8gjgqfbN4dFPAoAdZKUnWg12ZG3
         /YHqSNVuzXAc9b2HHwGH9LBzvgZToUvEu35LDcgR6A9q+XF7KMusQr66TDyHOeFfFrqL
         dYumZcibZ88UIV3XDd3fu8JgdSeCCADimOXm4NTSmIIENw4jPwsywDQ3Dvfh8vZnU/VF
         2cQlWu4iJNzDcz9iAaE1D4BTPYin8nFfRQVUj76zTk1WFPDT9V13d7wvFhn1zjsBbPJz
         TBf25knHEobu9uNSG14nviJCdobDDbdi9UhzhOzvayqzCnYVdfHDjyFSJBIaB5RURPTv
         KQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943660; x=1684535660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iv3jO/UplLaGK+gTx4v9j9xexh60oYjru3uhX3LfGtA=;
        b=L4w2dO7/4ZuIxP1G0+Wn9kt8CVgDVUi/gI0hkk8ojWwr6XeZzZv69dZYxSdLyq5qjG
         sBp6nF81qeei3SiuatExzpb+ZAjC/ig82w07KHTvwi5UELsuX1T/KL1ts/yCJSgdydK3
         571fJAvscfbynHsIliNcEiMlkEhMzNpZXhGLGSNhfCJDG441qCCfZIFYI2394AN83yYR
         w8OsPRJ6cHGtGRqzY4U3eEFjDHi8/H2TdNB4myW962lpg8eP69MgrnNcMFDYIN+Be8Y0
         VnJ64yJYj3jDuefIQIld0Ma64n3EJoiGgZ8+MgjmVpjFQ4Hzt7tbgMkyykEY8AuJmpU9
         61Lg==
X-Gm-Message-State: AAQBX9ccwH5NOh1fT91hVPy/TBb/yQydAVlP7gSQ2kWKzmSmWAoD8kkc
        +nYv2euUigyKNFoAH3GJQtVCTglKd2sdXD+kyjY=
X-Google-Smtp-Source: AKy350YmjLuFNHpdbGKVUxtLnNGDTOqZujizSNNxdVNVjL7P36ZiZ6Z6Phv1PaiPaoxLg0i7OBeTQw==
X-Received: by 2002:a17:902:d505:b0:19d:778:ff5 with SMTP id b5-20020a170902d50500b0019d07780ff5mr7467330plg.15.1681943057246;
        Wed, 19 Apr 2023 15:24:17 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001a681fb3e77sm11867810plt.44.2023.04.19.15.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:24:17 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
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
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC kvmtool 08/10] riscv: virtio: Enforce VIRTIO_F_ACCESS_PLATFORM feature flag.
Date:   Wed, 19 Apr 2023 15:23:48 -0700
Message-Id: <20230419222350.3604274-9-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419222350.3604274-1-atishp@rivosinc.com>
References: <20230419222350.3604274-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

VIRTIO_F_ACCESS_PLATFORM feature tells the guest that device will
be using DMA for transfers. This forces the guest to use DMA API
to allow the host to successfully access guest memory as needed.

This is needed for CoVE VMs.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 riscv/kvm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/riscv/kvm.c b/riscv/kvm.c
index e728790..aebb6bd 100644
--- a/riscv/kvm.c
+++ b/riscv/kvm.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/kvm.h>
 #include <linux/sizes.h>
+#include <linux/virtio_config.h>
 
 struct kvm_ext kvm_req_ext[] = {
 	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
@@ -224,5 +225,14 @@ int kvm__arch_setup_firmware(struct kvm *kvm)
 
 u64 kvm__arch_get_virtio_host_features(struct kvm *kvm)
 {
-	return 0;
+	u64 features = 0;
+
+	/* CoVE VMs mandate VIRTIO_F_ACCESS_PLATFORM feature to force use of
+	 * SWIOTLB bounce buffers through DMA API. Without this device probe
+	 * will fail for CoVE VMs.
+	 */
+	if (kvm->cfg.arch.cove_vm)
+		features |= (1ULL << VIRTIO_F_ACCESS_PLATFORM);
+
+	return features;
 }
-- 
2.25.1

