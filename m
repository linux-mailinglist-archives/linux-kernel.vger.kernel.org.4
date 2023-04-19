Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B81B6E8504
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjDSWd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjDSWdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:33:54 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF4F6A42
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:33:28 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-77858d8dcb5so169222241.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681943532; x=1684535532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecSGlantlLzvA0G9VPQY9TXgG8EZEn7xksLEzRIVmIY=;
        b=nVCe2AAfzZXe6JIhHVsKNh6KA28/pjNf8Z3SAz1dBHAaxZ39iY1Ye6QRA12TkcozeF
         EDBvrNGkvB8B7Dy7KbVh/GZGxwAafszOX3YUqMjp95og7XPvVSTe46oDhJhagCjU5jaW
         1NsLWRK5F/OBW/nu3ywg+pcJs2MM07FLtUjKOKusVQM5CiqYbtFyMOIYDrkYMjr9D3U5
         PD7AWIVs4EiYNc3WLM7OwqfjNbCv6LcKM/rNgRSh9VjaxWvmfa2GlemZLcwmonamBnhF
         9+jt1Fl/8FqhCxKcAX4PtIm/MWATiKOM81gk+CCgl9h9jp05N1Vrdia9WPK/wBHpXNTK
         Ypiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943532; x=1684535532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecSGlantlLzvA0G9VPQY9TXgG8EZEn7xksLEzRIVmIY=;
        b=ODi/Yxq+QOfv/PsmwHP3sUzJ9YQI4nK/LADS4Fj5jXKVpkqqXyRAat2YfLgrtMqjYF
         OD8u2m5l5JNmM3z9vZ5khSCkWqYEOicowcrfs47wqOAhtKsldeCT04t5In0RZQ3LEQmI
         kKhMez8M9Zu9qQrYHQO/teQZKMK4dESgnqfErBr8QEf37M2iZHLnA4ujhHKh8NOruP1f
         5HBHsaOTENx7Z+EpFIkz7K2TX9o1ONZL4mGcYGqdaQmGUjub39p9rL2UYu4RaLRyr/f0
         Hq9rIkoGIcEPVPsMdbGIbD6cnBtEbojgA9fvlGvaXPLnuW9NzTqMH5+MTvyUPLsBdmej
         jSig==
X-Gm-Message-State: AAQBX9fBxXtZEOMtYqVE80cYZibtsFk2xVE/duFX2WzJ9ZCikSn1TslL
        TcQ0gkUMYh59qVHCBCH+YaNOYuXySfuCsQY+b8g=
X-Google-Smtp-Source: AKy350YKfPHbIymM6qmHQFNTIkUnRhQSV2hEDBlfRu6z0TKA3ibQ947LdlZE55huq5S43nAipp/NMA==
X-Received: by 2002:a17:903:22c7:b0:1a6:3737:750c with SMTP id y7-20020a17090322c700b001a63737750cmr4095049plg.21.1681942751934;
        Wed, 19 Apr 2023 15:19:11 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:19:11 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-coco@lists.linux.dev, Dylan Reid <dylan@rivosinc.com>,
        abrestic@rivosinc.com, Samuel Ortiz <sameo@rivosinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC 46/48] riscv/virtio: Have CoVE guests enforce restricted virtio memory access.
Date:   Wed, 19 Apr 2023 15:17:14 -0700
Message-Id: <20230419221716.3603068-47-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419221716.3603068-1-atishp@rivosinc.com>
References: <20230419221716.3603068-1-atishp@rivosinc.com>
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

CoVE guest requires that virtio devices use the DMA API to allow the
hypervisor to successfully access guest memory as needed.

The VIRTIO_F_VERSION_1 and VIRTIO_F_ACCESS_PLATFORM features tell virtio
to use the DMA API. Force to check for these features to fail the device
probe if these features have not been set when running as an TEE guest.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 arch/riscv/mm/mem_encrypt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/mm/mem_encrypt.c b/arch/riscv/mm/mem_encrypt.c
index 8207a5c..8523c50 100644
--- a/arch/riscv/mm/mem_encrypt.c
+++ b/arch/riscv/mm/mem_encrypt.c
@@ -10,6 +10,7 @@
 #include <linux/swiotlb.h>
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
+#include <linux/virtio_anchor.h>
 #include <asm/covg_sbi.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
@@ -54,4 +55,7 @@ void __init mem_encrypt_init(void)
 
 	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
 	swiotlb_update_mem_attributes();
+
+	/* Set restricted memory access for virtio. */
+	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 }
-- 
2.25.1

