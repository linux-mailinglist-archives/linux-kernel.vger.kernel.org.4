Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3566C3D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCUWAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCUWA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:00:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C3975B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l84-20020a252557000000b00b61b96282a4so15614720ybl.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679436027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2pSG5VWmqJOQAcZFq9+VDplzIlr7FmeqQZuXEVRazw=;
        b=CapADCaxZJSclql7XSUlwPtEzWodyt0ZlKgUzR1YZzbY+OoabPx9Io0xt3T2lMBg1d
         nQau2muHFYgZjvDCXtTmgnDobeaSoFXW09jRj9UVq0c06edNe1fdboBQ/FhLBcnlXDNM
         KR+YUT4rbgZ34eRrt5kd8HxvBPEqQSzk8e1IhsXxQM8nLsspr/TEWTI2tOtXbQBqQyjN
         HEjAe3RIzenZOkWArXwtVjOUlHjTfPBGx6QROJ9e4pJ/tgr3hOXAmxogZ1QX0LOWYGx0
         9VGUy+3Ht3swyuu/6GY/qco2c95BElcMOmdyc9ruIimjHS5kCbZwb/fG9MvgLAAwFZXt
         j6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2pSG5VWmqJOQAcZFq9+VDplzIlr7FmeqQZuXEVRazw=;
        b=tE7nS9iM+JXpI6sZAun7gFcBg97UIpI9Fdip4ob/mBgn2nPd1D5TJNssMdtWhuLRet
         N3W74l1ShGmtMQ02kcBqiX0fcmbC0/+DtjmkPYCYn/BAcKlSdMy3aHhwUq+a4i4+j5Yo
         9yvg8vC9fJ3mtjKHHA0/VrH16tLw7YnYS2BYQbnW9WHhxGEptaJX7yTyv4rxyXy+Q5CE
         6uHtJ/v3syTc4mDUX+JzbGli935Tcn4NeRk/cCw/K64J0OdVtkvCyS3UENF9W/5s403B
         HY0JKQU+otgZ66HYtmqf1preyZMg2Ce2qNzZPlH793zut1fR3E7go72sM6cTvLGiWYrt
         6cPQ==
X-Gm-Message-State: AAQBX9eEiN5yCCbg5ImW4lOJghDyxETZhnigj16SaDZ0ZMjCJsB6C0Ry
        JoqtcaQj9O81mp+gNV2kPex8BO9oOQw=
X-Google-Smtp-Source: AKy350YQSQiwJABBg4LrQxgcwJuDItXoq3fvtBNLZ/fcyahwKCiYuVH0awsgCBzU/qICGrqlOVnO3noUKAM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18cd:b0:ad0:a82:7ef2 with SMTP id
 ck13-20020a05690218cd00b00ad00a827ef2mr2161016ybb.8.1679436027667; Tue, 21
 Mar 2023 15:00:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 15:00:10 -0700
In-Reply-To: <20230321220021.2119033-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230321220021.2119033-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230321220021.2119033-3-seanjc@google.com>
Subject: [PATCH v4 02/13] KVM: x86/mmu: Use kvm_ad_enabled() to determine if
 TDP MMU SPTEs need wrprot
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vipin Sharma <vipinsh@google.com>

Use the constant-after-module-load kvm_ad_enabled() to check if SPTEs in
the TDP MMU need to be write-protected when clearing accessed/dirty status
instead of manually checking every SPTE.  The per-SPTE A/D enabling is
specific to nested EPT MMUs, i.e. when KVM is using EPT A/D bits but L1 is
not, and so cannot happen in the TDP MMU (which is non-nested only).

Keep the original code as sanity checks buried under MMU_WARN_ON().
MMU_WARN_ON() is more or less useless at the moment, but there are plans
to change that.

Link: https://lore.kernel.org/all/Yz4Qi7cn7TWTWQjj@google.com
Signed-off-by: Vipin Sharma <vipinsh@google.com>
[sean: split to separate patch, apply to dirty path, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7c25dbf32ecc..5a5642650c3e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1621,7 +1621,10 @@ static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (!is_shadow_present_pte(iter.old_spte))
 			continue;
 
-		if (spte_ad_need_write_protect(iter.old_spte)) {
+		MMU_WARN_ON(kvm_ad_enabled() &&
+			    spte_ad_need_write_protect(iter.old_spte));
+
+		if (!kvm_ad_enabled()) {
 			if (is_writable_pte(iter.old_spte))
 				new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
 			else
@@ -1685,13 +1688,16 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (!mask)
 			break;
 
+		MMU_WARN_ON(kvm_ad_enabled() &&
+			    spte_ad_need_write_protect(iter.old_spte));
+
 		if (iter.level > PG_LEVEL_4K ||
 		    !(mask & (1UL << (iter.gfn - gfn))))
 			continue;
 
 		mask &= ~(1UL << (iter.gfn - gfn));
 
-		if (wrprot || spte_ad_need_write_protect(iter.old_spte)) {
+		if (wrprot || !kvm_ad_enabled()) {
 			if (is_writable_pte(iter.old_spte))
 				new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
 			else
-- 
2.40.0.rc2.332.ga46443480c-goog

