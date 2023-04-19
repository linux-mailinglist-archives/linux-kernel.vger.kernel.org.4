Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20986E84DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjDSW1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjDSW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:26:49 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76231718
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:25:22 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517c840f181so185723a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681943044; x=1684535044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXsqDGUR1sIAzl083YrDdeF8Dcz5MG5TcoJ+FCFYQPE=;
        b=ohOEHO7BV/FHEqjDiY6pG/sbPPkvlHxUUXDxUV7dZqgZIIWVcpKe0qvs+coh7D9ZRh
         B9hkxCLFKh8o9nAC2rlRn7bMm1mBtWYtjnNK9pkEtJDD583cXnspj2Ze6kFtPx4sD05T
         M0i9ezLAErgLCl4r/YZAwl7ub1kBW72A2bCM2VN+GllxhNlhbw4174U5Fs0Rqs8lwuLx
         6dFmv6DPhfk7Q0h+47Fu4cY06lgOcb8Yfc8WZoxCPJavUfQg727zdhXtl53U+ZG5ga3H
         Ua4k+o9Cp2yjV6jziSpH7zmCITKPG2JXN/AwelqUy5IqPzKZ18t594Y0qlAjZCJGwgwu
         OUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943044; x=1684535044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXsqDGUR1sIAzl083YrDdeF8Dcz5MG5TcoJ+FCFYQPE=;
        b=XLChwmomSLWahv32gZ9DP2qrZ/dG6goJJoGYSzi87VQZZI4ZO++CBz5x8xHW4tz3WF
         5LAKW4NX0jUEt26FDWEwWMeVBvbAs4SH87Wup+6HmfJ/8sTTL1kPYXzNUoKKq9FLWNHx
         TRKRjYHgGPsmRj/9jvGMyHMyROp3HNmTf48/N1XIlQk+dot8+n0ErybwGD4rvMkhxEQu
         pm4m5kJrxvH/uQ7QyX48IfuUEdyjIVbeW0/1tCBMfED4IjMpD6x4fGMMX7tMqkCnople
         Nki7NvSkcwkTyAvyGGdCFZRs2BNiuZRd9Zz2PZUKszKZs5975PWq4tdn4X1VbVOXQXAk
         z9aA==
X-Gm-Message-State: AAQBX9dvX68oOdiYksM5Oa0+8VUGMi8XcaWQ7U9te9DfPXSxdDhfOwHi
        +qDcZ8zj3U3Ez9p8av4V1box6wMwQZApmcqof44=
X-Google-Smtp-Source: AKy350ZHJJEltFWMtiEqeoirE/coBcaQIIAAD+T2dcklEUVhjT2GbyU5FBvkRUpdkDap1R/DwivJLA==
X-Received: by 2002:a17:90a:be01:b0:247:1e30:5880 with SMTP id a1-20020a17090abe0100b002471e305880mr3727645pjs.38.1681943044256;
        Wed, 19 Apr 2023 15:24:04 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001a681fb3e77sm11867810plt.44.2023.04.19.15.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:24:04 -0700 (PDT)
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
Subject: [RFC kvmtool 01/10] riscv: Add a CoVE VM type.
Date:   Wed, 19 Apr 2023 15:23:41 -0700
Message-Id: <20230419222350.3604274-2-atishp@rivosinc.com>
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

The KVM needs to distinguish if an user wants to create a CoVE VM instead
of a traditional VM. Define a RISC-V specific CoVE VM type that can be
passed as a VM type.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 include/linux/kvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index ba4c4b0..000d2b9 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -911,6 +911,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
 #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
 	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
+
+#define KVM_VM_TYPE_RISCV_COVE  (1UL << 9)
 /*
  * ioctls for /dev/kvm fds:
  */
-- 
2.25.1

