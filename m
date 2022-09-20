Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D075BF12B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 01:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiITXcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 19:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiITXcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 19:32:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5078D5E64C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:31:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-34a03cb9679so36912477b3.21
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=0dxTPuTzVMWgGi4al8aBVgMoHk8EOTLA2xcY/IFfAgE=;
        b=AJAfFhVlpPBnrGyqemySHBHn78LZyGIFDKqO2SovfQEUEEBpazyrg8J2WovNkGyzRu
         9+u8kKrfNg537aDM0xwHkDVrBu101OtxApcvm1xeSRg+SUl6hl5zuspv68wFOIKG+kWj
         gC6SY9fvWd4zDcTAO6ityQZr0HjCV0nbT8QeiAmZl45FJN0fMZ1/r8J0ea6ZDkTickjO
         kKv4Waq9sgx+OCgxBrGsg1FumPxnJ84sQaYuKw/J68PHv9xkejP2M0qm8PzgdGoiPg9S
         11ejBMVxUWx1hBih50dRggux7wKclIyDwj9r/FTPascnVEF765zpaf5CS4AH8QwYQ9js
         +9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=0dxTPuTzVMWgGi4al8aBVgMoHk8EOTLA2xcY/IFfAgE=;
        b=TwOAS7JmDi2zVXr0cKr+lCe9LzP9p5+7ZQWlNQmlbe7DQtyaaaVxniGSTQax46ikZL
         aVdPIjPdYlyF97shp6HWX3o/Mjllggr5CEgFlB6fAVXQtYmcVhxuxcvgSbz7qroRkHxK
         P+uHViGrgBNqF4g7s4cRAs29tYVvRQ+hQdkx0RCqoJRvpatiwYsccL+YU7kco10o5CCm
         T3nIJgLsvzK0nYvqm65sbgYbRT27R6RTzStCuq9GtW1VrUqIDGJVmunUYciateFSEiWH
         Sdn0vcK43Fx+RFBRnCWFVRew2XhrB5A3fvMlg2+zVMUJcZupkriZ6zPihlS+/EWPkMPC
         jYBA==
X-Gm-Message-State: ACrzQf3GElKF4jCw2TOyqojIXfbgj2JpyejQsPRJlKb/bIPazC9or+kk
        4RrhYkU8Vz5MDbyDtDxP9FH9v++0bnY=
X-Google-Smtp-Source: AMsMyM6eLstN1QP/hzF9oY2nzhUn8JfEvgl/L110KizJ9pP0dAtfP5zNb0DSnvcBY6oJuHvRYadI1Md4qd8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:120f:b0:6a1:f220:5ace with SMTP id
 s15-20020a056902120f00b006a1f2205acemr21856711ybu.141.1663716714545; Tue, 20
 Sep 2022 16:31:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 20 Sep 2022 23:31:16 +0000
In-Reply-To: <20220920233134.940511-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220920233134.940511-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220920233134.940511-11-seanjc@google.com>
Subject: [PATCH v3 10/28] KVM: SVM: Compute dest based on sender's x2APIC
 status for AVIC kick
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compute the destination from ICRH using the sender's x2APIC status, not
each (potential) target's x2APIC status.

Fixes: c514d3a348ac ("KVM: SVM: Update avic_kick_target_vcpus to support 32-bit APIC ID")
Cc: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 84beef0edae3..e9aab8ecce83 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -429,6 +429,7 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
 				   u32 icrl, u32 icrh, u32 index)
 {
+	u32 dest = apic_x2apic_mode(source) ? icrh : GET_XAPIC_DEST_FIELD(icrh);
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
 
@@ -444,13 +445,6 @@ static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
 	 * since entered the guest will have processed pending IRQs at VMRUN.
 	 */
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		u32 dest;
-
-		if (apic_x2apic_mode(vcpu->arch.apic))
-			dest = icrh;
-		else
-			dest = GET_XAPIC_DEST_FIELD(icrh);
-
 		if (kvm_apic_match_dest(vcpu, source, icrl & APIC_SHORT_MASK,
 					dest, icrl & APIC_DEST_MASK)) {
 			vcpu->arch.apic->irr_pending = true;
-- 
2.37.3.968.ga6b4b080e4-goog

