Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F5865F8DC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjAFBPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbjAFBNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:13:46 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2A2755ED
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:13:43 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b197-20020a621bce000000b00581b15e98cdso52507pfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=32VPrBOq73WvzaefBtIggxIbeFo+/Cphxagan15DZtk=;
        b=jd8smTqkN0IDXl0EXdgRXlAJ/OS3kl8MhbTYhzhDohUUGbZZl5lSPukmE+oBw3lj7z
         PxNhmSnmJVnRb6FSuglJuxUQTCkRHNOz5eq5KcA1W7oKV68H5fHcnolhQXk+fddFJ1Hd
         hbZici3wfOyM0UW98R0ko2SBRyhhQmDianmMPJx0070qaH81nLGCKtLl7bEKABvmi7aO
         QK4wuHY0UZazpgqwD++59W+5Kg31nQ5tD4f08Ij0GC45cK5kBY4EZHIu8FdH2MMpLI6V
         PITyVaUx5b0jz2DOJdrcwYTr1ajr0cdExOuhyfistWyms77xsn9VyfX02NLrkyFryM/h
         oyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32VPrBOq73WvzaefBtIggxIbeFo+/Cphxagan15DZtk=;
        b=sbgCPVqrR1TwJGD9DuWVTtQcelEoPmyvfkY1UFoqaUfoZSUAgwH7uF4hP5BQwZXpQj
         NwYWfJQsKu9l84mwarO50gQWEKySwzfD906nvuN7P/bUenLj313Rfq9ESqZje1vz7v3R
         nLnqTchANu8S/BkqaHSi4GflnUdqMGZABLTzhxvf3l8uy40Ol6KYa1E4IIFBWpVtgoVy
         goaiVxFUHX0F0P4NPwatqDKHm2tlgK7NxVuXkgRbwu/PpvDtXgQEIGEsErGWZPSvjo3y
         6x6L8/KvcSGCwNp715fka98jCEC4IIAQJRu2OsP+hStUx7JXs5/6l/mm7rxLXfZuzCEu
         1XJA==
X-Gm-Message-State: AFqh2kr3wQXKTXaSmyCUj8c9+c4+jjXowVvHGKwxwVcZkPgQKVS1xM5T
        BGZxMnhSHs6SRnazo3gVoYLRexOzLlU=
X-Google-Smtp-Source: AMrXdXtuJEBL1IRZU3ombN6RWg4sQ5n5Oog+uPmHfCTlEmqlHlrX4+YyMkSQ683RnTNJrI0x6tppXZ5xgHc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:ee05:0:b0:581:c732:2b60 with SMTP id
 e5-20020a62ee05000000b00581c7322b60mr1822093pfi.25.1672967622912; Thu, 05 Jan
 2023 17:13:42 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  6 Jan 2023 01:12:50 +0000
In-Reply-To: <20230106011306.85230-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230106011306.85230-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230106011306.85230-18-seanjc@google.com>
Subject: [PATCH v5 17/33] KVM: x86: Explicitly skip optimized logical map
 setup if vCPU's LDR==0
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>,
        Greg Edwards <gedwards@ddn.com>
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

Explicitly skip the optimized map setup if the vCPU's LDR is '0', i.e. if
the vCPU will never respond to logical mode interrupts.  KVM already
skips setup in this case, but relies on kvm_apic_map_get_logical_dest()
to generate mask==0.  KVM still needs the mask=0 check as a non-zero LDR
can yield mask==0 depending on the mode, but explicitly handling the LDR
will make it simpler to clean up the logical mode tracking in the future.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 355ea688df4a..2aee712e42bb 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -286,10 +286,12 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 			continue;
 
 		ldr = kvm_lapic_get_reg(apic, APIC_LDR);
+		if (!ldr)
+			continue;
 
 		if (apic_x2apic_mode(apic)) {
 			new->mode |= KVM_APIC_MODE_X2APIC;
-		} else if (ldr) {
+		} else {
 			ldr = GET_APIC_LOGICAL_ID(ldr);
 			if (kvm_lapic_get_reg(apic, APIC_DFR) == APIC_DFR_FLAT)
 				new->mode |= KVM_APIC_MODE_XAPIC_FLAT;
-- 
2.39.0.314.g84b9a713c41-goog

