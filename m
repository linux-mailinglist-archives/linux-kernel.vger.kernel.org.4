Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EBB6AD1DE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCFWm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjCFWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:42:13 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900FC82ABF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:41:52 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id ju20-20020a170903429400b0019ea5ea044aso4926233plb.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678142512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPKVdqaDisFdGAfkqGOe8iBVNEZA/ukGWtJHDgVP+Ak=;
        b=klnvvsrGwCWY0xNtfxRp0OMIN4OSqxCgEdWWZinxsMr8EM4F+vjp47fD1GRBoRu8IE
         wZMKE+LvsZGr6cs1oHgGJoZFWnvG5xdvsLDp/0NKn/b1AR4vIl5EA8B1J15BkOjB1jLL
         o6IYaDl/UuNu0obuHxfVfilPm66n989izaFjrKf/m3gcPb3gyNx/SdEC1/akRr4FlvNw
         JuLuP9ZlyvrcmVrmDT/kaTrfx4pXk1OVn2iy0llzINsLsQHYQYo8jLQt/JYxWJLe3FIy
         CpN+mlqM8PTTTe5Qk0msOFVot0e31lagshAQzRtr+WP+tHSnhAXhsRtLnEbDZ87L0tfA
         TufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPKVdqaDisFdGAfkqGOe8iBVNEZA/ukGWtJHDgVP+Ak=;
        b=mmJtF6aydOsmMJTttQIJMSvUxwFeO4/b+y1q8pyYmuVNFHILwuFI4IZQfJS4d6ZnBk
         dgg9pzd7OSytmdW0yqkU8SYf7Uw/KmsByQFVmEz9aclW/HnHN9/kDvKA/uO4Inglgdh1
         cfwGeTxki19KItaqJZBwfXmLVD/BZK7WFGiW2w7F2oyDo70I5JV2n9ZMYB8NU5IuEdJP
         og6Dl8K6CLKYERKcNovszAnjZ+Bts7tzu9AZ1hbsNp9oZQHJeeFYxHlTIXYvRPx5HGq9
         rCAo3PlmX756OS84JVBuKZW+OigDLO6ruzeXrkISv+Zm2Jb7HHt5f9J/LqIVmkFSss6k
         z8Xw==
X-Gm-Message-State: AO0yUKVrn3a4Ez/JO8A5HPABCUuMyU6JgZEE1pJidrg9wJ1wjMlytyRa
        H5CCPACWaIAvmm+s+Zui1JO4ovXuuuPM
X-Google-Smtp-Source: AK7set9/b67iH4rOLvz1VS8akjODPn7aZygSqISR8KUp+OH3XeVyxRNJMmsPzTjQ8S9WaZK/QW0Hqkh4C5W5
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a62:8782:0:b0:60f:b143:8e09 with SMTP id
 i124-20020a628782000000b0060fb1438e09mr5432145pfe.1.1678142511907; Mon, 06
 Mar 2023 14:41:51 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:41:19 -0800
In-Reply-To: <20230306224127.1689967-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306224127.1689967-11-vipinsh@google.com>
Subject: [Patch v4 10/18] KVM: x86/mmu: Add per VM NUMA aware page table capability
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add KVM_CAP_NUMA_AWARE_PAGE_TABLE capability. This capability enables a
VM to allocate its page tables, specifically lower level page tables, on
the NUMA node of underlying leaf physical page pointed by the page table
entry.

This patch is only adding this option, future patches will use the
boolean numa_aware_page_table to allocate page tables on appropriate
NUMA node.

For now this capability is for x86 only, it can be extended to other
architecture in future if needed.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++++
 arch/x86/kvm/x86.c              | 10 ++++++++++
 include/uapi/linux/kvm.h        |  1 +
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 185719dbeb81..64de083cd6b9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1467,6 +1467,12 @@ struct kvm_arch {
 	 */
 #define SPLIT_DESC_CACHE_MIN_NR_OBJECTS (SPTE_ENT_PER_PAGE + 1)
 	struct kvm_mmu_memory_cache split_desc_cache;
+
+	/*
+	 * If true then allocate page tables near to underlying physical page
+	 * NUMA node.
+	 */
+	bool numa_aware_page_table;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f706621c35b8..71728abd7f92 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4425,6 +4425,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VAPIC:
 	case KVM_CAP_ENABLE_CAP:
 	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
+	case KVM_CAP_NUMA_AWARE_PAGE_TABLE:
 		r = 1;
 		break;
 	case KVM_CAP_EXIT_HYPERCALL:
@@ -6391,6 +6392,15 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->lock);
 		break;
+	case KVM_CAP_NUMA_AWARE_PAGE_TABLE:
+		r = -EINVAL;
+		mutex_lock(&kvm->lock);
+		if (!kvm->created_vcpus) {
+			kvm->arch.numa_aware_page_table = true;
+			r = 0;
+		}
+		mutex_unlock(&kvm->lock);
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d77aef872a0a..5f367a93762a 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1184,6 +1184,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
 #define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 225
 #define KVM_CAP_PMU_EVENT_MASKED_EVENTS 226
+#define KVM_CAP_NUMA_AWARE_PAGE_TABLE 227
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

