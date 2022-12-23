Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A435C6549A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiLWAOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiLWAOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:14:03 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3326AC2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:14:02 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id il11-20020a17090b164b00b00219a4366109so3968907pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLuChDmHZy9fZJAsWYadyMA42cALgM97d3TAhY29bd4=;
        b=qesxOioXaSBJL1ruAcCimnE/4E3MkzM5ZdGrQ40tnDmX4p1zgoouiyYp1MUFj51vYO
         nNfOwW6LG4WVVZlUPnlDY4+m1g5Ot+S+a+sxVijlNBf3A1ztamoTbu1JNeB6zcat62bv
         4sZKS+O6SR4BDGU2SdZQmbQddafokLgtJEAamTcU9EXpGLpzv5QpwfcuaDT1U1ByTR8t
         Yn9Pel1JcW6C3LxBscnyfw+zgkMrzXFOvu0/lfQMKNp1hjPCg42eLccXB6PKdZ97pd5/
         03ryjbSSeYTi7TOD9AP2l+5tIQA4MenYW7GXMmsAvoZ+uhGJvLzF654L0FA35u/haI3Y
         1Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLuChDmHZy9fZJAsWYadyMA42cALgM97d3TAhY29bd4=;
        b=H6d7VGF+05cg5PSvO59chYQTH7WdZxn3Tz98c9M/GMsqiIAE1cc3Wfydc4PlkcPJhu
         y6Vsvpf71onUcQnCaceN9TA6gjsVuu0/TzcplPKIy1bHk3IiXtLvvqI2+ryIi9gjneph
         pOKdFEAAknVAtPPMp6OkegTeJX88qtr0urIyl/yvMbFmoBPxgKEN2vCjjPj+qVnvED8p
         Oc+1ZXbyCNeU6FMeaJKj8TdKfw4lsuy83zDNUzMEBJS2YcmZvHlfQrlLewJ6JsQkSerm
         CmPLo6M3lm3zpNAKAFhR9aCYclYwY9+UtFyLYIAE03jGvIuoeWYUUn1uyVpQW2rm+kgn
         AwoQ==
X-Gm-Message-State: AFqh2kooKyPNaJ71Ydf2yfnR5inzTCJm3yo3NCQrGnWkCsTEVuh9e0cu
        Wh3+iF3pUDCV1qhOqa8F2oBrvX98t8MK0F0h
X-Google-Smtp-Source: AMrXdXvCa2RPlxHRHVP2d/nxmRmmfc6ud8BYwgOQ+ATjacORH6WxAk8C9L+XSPvx7xJyS+iVx1Es8D2izekn2BrB
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:aa7:870f:0:b0:576:a1d3:a157 with SMTP
 id b15-20020aa7870f000000b00576a1d3a157mr451723pfo.32.1671754442064; Thu, 22
 Dec 2022 16:14:02 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:13:47 +0000
In-Reply-To: <20221223001352.3873203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221223001352.3873203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223001352.3873203-4-vannapurve@google.com>
Subject: [V3 PATCH 3/8] KVM: selftests: x86: Support changing gpa encryption masks
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for guest side functionality to modify encryption/shared
masks for entries in page table to allow accessing GPA ranges as private
or shared.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  4 ++
 .../selftests/kvm/lib/x86_64/processor.c      | 39 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 3617f83bb2e5..c8c55f54c14f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -945,6 +945,10 @@ void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 			void (*handler)(struct ex_regs *));
 
+void guest_set_region_shared(void *vaddr, uint64_t size);
+
+void guest_set_region_private(void *vaddr, uint64_t size);
+
 /* If a toddler were to say "abracadabra". */
 #define KVM_EXCEPTION_MAGIC 0xabacadabaULL
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index ab7d4cc4b848..42d1e4074f32 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -276,6 +276,45 @@ static uint64_t *guest_code_get_pte(uint64_t vaddr)
 	return (uint64_t *)&pte[index[0]];
 }
 
+static void guest_code_change_region_prot(void *vaddr_start, uint64_t mem_size,
+	bool private)
+{
+	uint64_t vaddr = (uint64_t)vaddr_start;
+	uint32_t num_pages;
+
+	GUEST_ASSERT(gpgt_info != NULL);
+	uint32_t guest_page_size = gpgt_info->page_size;
+
+	GUEST_ASSERT(!(mem_size % guest_page_size) && !(vaddr % guest_page_size));
+	GUEST_ASSERT(gpgt_info->enc_mask | gpgt_info->shared_mask);
+
+	num_pages = mem_size / guest_page_size;
+	for (uint32_t i = 0; i < num_pages; i++) {
+		uint64_t *pte = guest_code_get_pte(vaddr);
+
+		GUEST_ASSERT(pte);
+		if (private) {
+			*pte &= ~(gpgt_info->shared_mask);
+			*pte |= gpgt_info->enc_mask;
+		} else {
+			*pte &= ~(gpgt_info->enc_mask);
+			*pte |= gpgt_info->shared_mask;
+		}
+		asm volatile("invlpg (%0)" :: "r"(vaddr) : "memory");
+		vaddr += guest_page_size;
+	}
+}
+
+void guest_set_region_shared(void *vaddr, uint64_t size)
+{
+	guest_code_change_region_prot(vaddr, size, /* shared */ false);
+}
+
+void guest_set_region_private(void *vaddr, uint64_t size)
+{
+	guest_code_change_region_prot(vaddr, size, /* private */ true);
+}
+
 void sync_vm_gpgt_info(struct kvm_vm *vm, vm_vaddr_t pgt_info)
 {
 	gpgt_info = (struct guest_pgt_info *)pgt_info;
-- 
2.39.0.314.g84b9a713c41-goog

