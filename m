Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881625F17ED
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiJABDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiJABCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:02:35 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118DD15C5BE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:23 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 128-20020a630486000000b00435b18f71b3so3696723pge.19
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=1YftLOszR7bSMAKO/7D6fjHIUaI80mCyDkpMabfIDFg=;
        b=gmlPL8AGoIw5DkSBx9G/sTZrreY5P+Oe1nOe27AcScjwDo5J6rNsdmNQb0IgHx+D3p
         kecZ3wNctj1k1kVELmY8eA4658Usd/F1FX4RuUD/JLfB1IYWqVF0WZPPM7V9hs49mRpq
         zKEGEyMAUbFw8/F7lWbA6kPPZogxLCEt0e1z11EEWQn9tN7TO3WUSW/70TGQN6Mr419k
         kv4XrO7j1dbcTfRH0D3tBVngRbrKQiIB3vSkoB9nFheGpg+QPj9zov9ieJOTWgdMML/u
         MFJsLfjkZNbQZcbuA3NfT/cQyFrxS4gXzM/WpGBE20SQyy+Gxr1wNllI8cH400pMf6mb
         A/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=1YftLOszR7bSMAKO/7D6fjHIUaI80mCyDkpMabfIDFg=;
        b=neVRtxKObJre9rKVkWMKkl5aHq8vgIV3P7Xwn4vwAWNngmPy+apFbeMVq9lDFQy+1c
         SnwGdK7Gml+4OHzhn7Gyttkc7FM/3VFT2XItOefijLNyL9ofcgKazKvBN2aFDAFtZKe8
         r7Se73F+uB0LpsgBq3a0egSUI+aR8WuGR6AWgfIEi17aV8LrQZDuKW6N4OmhGLlxT/mw
         zFyO2JRMhJFG+HPKWg7vPLTiB9nqmpN9y6Gm9LW/2mozgxYLt8kk2AjURdODsUr9Bz/Z
         823DzhLmY0BfEleXocWaLP40NnT2bDOjcXXlBc2WBMgiAPh16ameq413gUbkW+UZPT0A
         iV6Q==
X-Gm-Message-State: ACrzQf0sTPuaT+cY6hUZwDL00975PAYtkZHkK7vqr0c70j0Y+HSHryBP
        kCyb9Pzf58rVOMNMUgDsQMEB6iwFmww=
X-Google-Smtp-Source: AMsMyM4bbivakAwydzxsOMq0VdCBO8L/n4+zGlkn++PwBMD69v5jURd9DF/bYRwI5uEcOJczCeyF1x5mwss=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c950:b0:17c:2248:11b1 with SMTP id
 i16-20020a170902c95000b0017c224811b1mr7190067pla.165.1664586004063; Fri, 30
 Sep 2022 18:00:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:59:10 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-28-seanjc@google.com>
Subject: [PATCH v4 27/32] KVM: SVM: Update svm->ldr_reg cache even if LDR is "bad"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
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

Update SVM's cache of the LDR even if the new value is "bad".  Leaving
stale information in the cache can result in KVM missing updates and/or
invalidating the wrong entry, e.g. if avic_invalidate_logical_id_entry()
is triggered after a different vCPU has "claimed" the old LDR.

Fixes: 18f40c53e10f ("svm: Add VMEXIT handlers for AVIC")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 2b640c73f447..4b6fc9d64f4d 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -539,23 +539,24 @@ static u32 *avic_get_logical_id_entry(struct kvm_vcpu *vcpu, u32 ldr, bool flat)
 	return &logical_apic_id_table[index];
 }
 
-static int avic_ldr_write(struct kvm_vcpu *vcpu, u8 g_physical_id, u32 ldr)
+static void avic_ldr_write(struct kvm_vcpu *vcpu, u8 g_physical_id, u32 ldr)
 {
 	bool flat;
 	u32 *entry, new_entry;
 
+	if (!ldr)
+		return;
+
 	flat = kvm_lapic_get_reg(vcpu->arch.apic, APIC_DFR) == APIC_DFR_FLAT;
 	entry = avic_get_logical_id_entry(vcpu, ldr, flat);
 	if (!entry)
-		return -EINVAL;
+		return;
 
 	new_entry = READ_ONCE(*entry);
 	new_entry &= ~AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK;
 	new_entry |= (g_physical_id & AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK);
 	new_entry |= AVIC_LOGICAL_ID_ENTRY_VALID_MASK;
 	WRITE_ONCE(*entry, new_entry);
-
-	return 0;
 }
 
 static void avic_invalidate_logical_id_entry(struct kvm_vcpu *vcpu)
@@ -575,7 +576,6 @@ static void avic_invalidate_logical_id_entry(struct kvm_vcpu *vcpu)
 
 static void avic_handle_ldr_update(struct kvm_vcpu *vcpu)
 {
-	int ret = 0;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 ldr = kvm_lapic_get_reg(vcpu->arch.apic, APIC_LDR);
 	u32 id = kvm_xapic_id(vcpu->arch.apic);
@@ -589,11 +589,8 @@ static void avic_handle_ldr_update(struct kvm_vcpu *vcpu)
 
 	avic_invalidate_logical_id_entry(vcpu);
 
-	if (ldr)
-		ret = avic_ldr_write(vcpu, id, ldr);
-
-	if (!ret)
-		svm->ldr_reg = ldr;
+	svm->ldr_reg = ldr;
+	avic_ldr_write(vcpu, id, ldr);
 }
 
 static void avic_handle_dfr_update(struct kvm_vcpu *vcpu)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

