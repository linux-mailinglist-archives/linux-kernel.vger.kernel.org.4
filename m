Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA85720818
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbjFBRDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbjFBRCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:02:54 -0400
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDD01A4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:02:53 -0700 (PDT)
Received: by mail-il1-x149.google.com with SMTP id e9e14a558f8ab-33b59d59193so20406405ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685725372; x=1688317372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jc0HXGzYvsWKFFqMwew1siGd4KbapSh3HWhZ39XsN18=;
        b=j+tKfi2kSo+PoSM8bzNfiRyUHJOyeGZ8cXfsmhGYboQIkXNZcgKm7MC/cWX/C6ZkqG
         60f7UABnT6ErAicHdSv8GNsaMsxzvOwv4YmniUVjWIoOAFBY8RnuSFSvJlf10WPLD0Pl
         04johD9tWvxiLCZi1WR0w+oOd0+AB/CP+2jYhm7evUJn7pTqemwzVAxdP+R68pydUGOA
         HIqJ0F9ltOSTrTcu2f3O/9bIynM8h5wdOVo4MLk5r9Ic6t6CxEi8rZbTDEZoGZX1Jbzt
         PmrdFFznsQ54/dOus3KfJ9Qig75zKJPzP+rVna7qVoudLzvULSQv2dyT4F4wCWi6idZ2
         o0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685725372; x=1688317372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jc0HXGzYvsWKFFqMwew1siGd4KbapSh3HWhZ39XsN18=;
        b=kIhogpxT4Igs7VFT8cgtWASPTzdWghgqaEKGD+O+ig2SdspjQLLKN8oYxKYKgYV2fw
         dalAgGargmbmom1VzAsLEUMAPP72jZY7lS3E9btzmzD2+3g870PZL5p9/LW34qyndyKq
         U/9j8rWOjyQfVPzb7XiecKMoEPHGAFFdLqGSCsCHqCVyFEVabTZA/y1xM+PxOZ6Gi+jh
         MqyhDvl9LRS/rPBsbsbebWCNisyhqmwN+Ws5RLYuHliLg/zSJGxkOgslsQ2rp4/SOiud
         HmnzuJ9EYTH7qlkkY3btYDL0Z7viQ5OIMeT1PMFvF+VHdkiJ7AZhzBJDISpPY3QZLnrL
         w9Og==
X-Gm-Message-State: AC+VfDz3Q/KyZQtLTRMt/azIV6brjus5AifjLTu7gseFjhLTetOnfxV9
        +079IpkWns/wpwuV3DiyJ9p0xPDR/SBQeXgQ+w==
X-Google-Smtp-Source: ACHHUZ7+edDLEpgV1IGnbtuAGa0C22RGdZstxlqcJBRqQ5INrzQuoJ8ypYZbCeOZkcJOp1lxWUSrEVByOHlYXL/q9g==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a92:db52:0:b0:335:908b:8f9 with SMTP
 id w18-20020a92db52000000b00335908b08f9mr4386617ilq.1.1685725372593; Fri, 02
 Jun 2023 10:02:52 -0700 (PDT)
Date:   Fri,  2 Jun 2023 17:01:46 +0000
In-Reply-To: <20230602170147.1541355-1-coltonlewis@google.com>
Mime-Version: 1.0
References: <20230602170147.1541355-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602170147.1541355-3-coltonlewis@google.com>
Subject: [PATCH 2/3] KVM: arm64: Clear possible conflict aborts
From:   Colton Lewis <coltonlewis@google.com>
To:     kvm@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear possible conflict aborts by TLB invalidation targeted to the
address that caused the abort.

Making use of FEAT_BBM Level 2 creates the possibility of a conflict
abort when translating addresses, where multiple entries exist in the
TLB for a single input address.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/esr.h | 1 +
 arch/arm64/kvm/mmu.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 8487aec9b6587..41336cfa19ff3 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -123,6 +123,7 @@
 #define ESR_ELx_FSC_SECC_TTW1	(0x1d)
 #define ESR_ELx_FSC_SECC_TTW2	(0x1e)
 #define ESR_ELx_FSC_SECC_TTW3	(0x1f)
+#define ESR_ELx_FSC_CONFLICT	(0x30)

 /* ISS field definitions for Data Aborts */
 #define ESR_ELx_ISV_SHIFT	(24)
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7a68398517c95..96b950f20c8d0 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1591,6 +1591,12 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		return 1;
 	}

+	if (fault_status == ESR_ELx_FSC_CONFLICT) {
+		/* We could be at any level. 0 covers all levels. */
+		__kvm_tlb_flush_vmid_ipa(vcpu->arch.hw_mmu, fault_ipa, 0);
+		return 1;
+	}
+
 	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_esr(vcpu),
 			      kvm_vcpu_get_hfar(vcpu), fault_ipa);

--
2.41.0.rc0.172.g3f132b7071-goog
