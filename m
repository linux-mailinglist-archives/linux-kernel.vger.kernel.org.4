Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C86971663C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjE3PJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjE3PJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:09:27 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC481BF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:08:57 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-30ae8a5006dso3994058f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685459331; x=1688051331;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=INyGt+QwuTfaFJp7EMJqWEOGoXUhxd+HBtKKNdnZww4=;
        b=KCvwHCzwHpZZcpBVv1I1bLVHxO8Xn2ykPeOkv2+KApmacnGFPK6nf/m23byfUEnWss
         JPn9KobcIzYTNjur4ig/onz6AWeR5RNE0aknK92u/onIH9hZ59bkBT/Z3kS42C5bDN2G
         ijShs3+RjX/Kyug5HfHwMD6rf945IC5Rb60s1gop/te04Uwtr84EwbUEs7YrUqnreG/n
         eREjm5sR5mqfWssu4wU3/quLaDOUC7QKSQaaiRRHSnhoF7+f+cK+dVXqf95XrN8AdMiI
         1I08XmHJ2RwLI/M0G/GOXG10F6zNKZxndz8fVfWBLLp0OgpDirhtbwh8taxNGl9nduTd
         AuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685459331; x=1688051331;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INyGt+QwuTfaFJp7EMJqWEOGoXUhxd+HBtKKNdnZww4=;
        b=bHZClQtxHfEz22GA+bQsNF0dnaoate2UkS1YNL4tXaCeZsU/3X6qORHFCukMH7Yy4d
         lUQNEhiVbJFk6z5kZJrXAOa9hVtclji0N0wOSfSGyjtHV/hg+GKHNMX+sKkEkYcKZ1oA
         Krk9W5vk0HYrKdFhaBgN1SY+3DSGWTKxkLArvLVHzd0auQOA5rai8Qwe4Nak5Jh+aLNE
         NoX35OCtF4pudqTlHVMSPd4XnZEUs3Dqrrdqjb88c2FI4/4llUlCJkRVnEqj286EAQ7f
         pF4yHLUlBlZTLtgtqvdRJce0vxOlMP/5wYFeU/+Oh7OQ9md1RGBt2p6lBEwJBdAzYehi
         99bQ==
X-Gm-Message-State: AC+VfDwJb3mX3cNDOZbJrocT1RzdK2vDzhPtSfiXXNdkg0IXmEtLrh9e
        e6FX0gjV+98A3wuHKwlf5nIDkgaJTeLvcg==
X-Google-Smtp-Source: ACHHUZ7trUbccosip83Jp1hHUHvUBBwTyfaeunBbCnY0yI3RJzF02Xs+ZkFq/94n82IAdm05j7g66a3Ser3rDQ==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6000:46:b0:30a:b030:9ce1 with SMTP id
 k6-20020a056000004600b0030ab0309ce1mr431213wrx.5.1685459330796; Tue, 30 May
 2023 08:08:50 -0700 (PDT)
Date:   Tue, 30 May 2023 15:08:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230530150845.2856828-1-smostafa@google.com>
Subject: [PATCH v3] KVM: arm64: Use BTI for nvhe
From:   Mostafa Saleh <smostafa@google.com>
To:     maz@kernel.org, oliver.upton@linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     tabba@google.com, qperret@google.com, will@kernel.org,
        catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com, bgardon@google.com,
        gshan@redhat.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ARM64_BTI_KERNEL compiles the kernel to support ARMv8.5-BTI.
However, the nvhe code doesn't make use of it as it doesn't map any
pages with Guarded Page(GP) bit.

kvm pgtable code is modified to map executable pages with GP bit
if BTI is enabled for the kernel.

At hyp init, SCTLR_EL2.BT is set to 1 to match EL1 configuration
(SCTLR_EL1.BT1) set in bti_enable().

One difference between kernel and nvhe code, is that the kernel maps
.text with GP while nvhe maps all the executable pages, this makes
nvhe code need to deal with special initialization code coming from
other executable sections (.idmap.text).
For this we need to add bti instruction at the beginning of
__kvm_handle_stub_hvc as it can be called by  __host_hvc through
branch instruction(br) and unlike SYM_FUNC_START, SYM_CODE_START
doesn=E2=80=99t add bti instruction at the beginning, and it can=E2=80=99t =
be modified
to add it as it is used with vector tables.
Another solution which is more intrusive is to convert
__kvm_handle_stub_hvc to a function and inject =E2=80=9Cbti jc=E2=80=9D ins=
tead of
=E2=80=9Cbti c=E2=80=9D in SYM_FUNC_START

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
v2 -> v3:
- Map all executable pages with GP bit instead of just .text, this
  simplifies the code and avoids hacks in pgtable code.
v1 -> v2:
- Enable BTI for nvhe also.
- Only set GP bit for executable pages from pgtable code.
- Set SCTLR_EL2.BT when BTI is used.
- use system_supports_bti() for consistency.
- Add hyp_init_valid_leaf_pte.
v1: https://lore.kernel.org/all/20230516141846.792193-1-smostafa@google.com=
/
---
 arch/arm64/include/asm/sysreg.h    |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 12 ++++++++++++
 arch/arm64/kvm/hyp/pgtable.c       |  7 ++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysre=
g.h
index e72d9aaab6b1..204124ce86c4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -558,6 +558,7 @@
 			 (BIT(18)) | (BIT(22)) | (BIT(23)) | (BIT(28)) | \
 			 (BIT(29)))
=20
+#define SCTLR_EL2_BT	(BIT(36))
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define ENDIAN_SET_EL2		SCTLR_ELx_EE
 #else
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/h=
yp-init.S
index a6d67c2bb5ae..f3ee66aa2f9d 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -128,6 +128,13 @@ alternative_if ARM64_HAS_ADDRESS_AUTH
 		     SCTLR_ELx_ENDA | SCTLR_ELx_ENDB)
 	orr	x0, x0, x1
 alternative_else_nop_endif
+
+#ifdef CONFIG_ARM64_BTI_KERNEL
+alternative_if ARM64_BTI
+	orr	x0, x0, #SCTLR_EL2_BT
+alternative_else_nop_endif
+#endif /* CONFIG_ARM64_BTI_KERNEL */
+
 	msr	sctlr_el2, x0
 	isb
=20
@@ -196,6 +203,11 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
 SYM_CODE_END(__kvm_hyp_init_cpu)
=20
 SYM_CODE_START(__kvm_handle_stub_hvc)
+	/*
+	 * __kvm_handle_stub_hvc called from __host_hvc through branch instructio=
n(br) so
+	 * we need bti j at beginning.
+	 */
+	bti j
 	cmp	x0, #HVC_SOFT_RESTART
 	b.ne	1f
=20
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 3d61bd3e591d..a79a45fc4047 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -34,7 +34,7 @@
 #define KVM_PTE_LEAF_ATTR_LO_S2_SH_IS	3
 #define KVM_PTE_LEAF_ATTR_LO_S2_AF	BIT(10)
=20
-#define KVM_PTE_LEAF_ATTR_HI		GENMASK(63, 51)
+#define KVM_PTE_LEAF_ATTR_HI		GENMASK(63, 50)
=20
 #define KVM_PTE_LEAF_ATTR_HI_SW		GENMASK(58, 55)
=20
@@ -42,6 +42,8 @@
=20
 #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
=20
+#define KVM_PTE_LEAF_ATTR_HI_S1_GP	BIT(50)
+
 #define KVM_PTE_LEAF_ATTR_S2_PERMS	(KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | \
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
@@ -371,6 +373,9 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot=
, kvm_pte_t *ptep)
=20
 		if (device)
 			return -EINVAL;
+
+		if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && system_supports_bti())
+			attr |=3D KVM_PTE_LEAF_ATTR_HI_S1_GP;
 	} else {
 		attr |=3D KVM_PTE_LEAF_ATTR_HI_S1_XN;
 	}
--=20
2.41.0.rc0.172.g3f132b7071-goog

