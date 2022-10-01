Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4209C5F17E3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiJABCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiJABCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:02:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2111E5886
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3521c1a01b5so56805057b3.23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=LyAH7hE4jcL9QcgVMCH2onNrTIVmeTtfuLQRhpXukZY=;
        b=MlccqVYVRGGnVkH/IoFciw4sGjXt0kp761f3WozY1LkqPii8NOsfz5TI6jRX0ScdEi
         be+cHOBk3Rd44MIY03XLtWQ1R5wca3jFhe5LedINJRQ3D+YqxEJcyixFQey64/Qg2zEo
         9qgBs+NV5fLTkbYMoDkIUOP1xrMHW44TiPq3sPfC4rnJCmASJYfwDId5FfqpREtIfPKm
         q7s6mBAK12dQqU59hN7FdLeo0rv9hwP419T3rbDYrqzFDDYFZ+HxiuuOgAA6xkzXxNU9
         unZ+rkn0VNl+fgoVEVJ15OENOoio2zWzhzyw6JPdmtU1mjocXLebprCEyy4o7+q4hZFR
         URuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=LyAH7hE4jcL9QcgVMCH2onNrTIVmeTtfuLQRhpXukZY=;
        b=wK8lWgkX6Q0cie0RK8d0BLMPQGU+TT4KagqYyaNFLp/74ECrVso34t/TFVuWXd3XY/
         MPjXN0LgnAHwN5InnM0ZeRq6MgXa/tYzaSpyEgUqPo0v4t4UXKI1L5lJyFqc2QBVBRMi
         WllYFnqph8wVFo7bOSmiDrVvsI6kDFYGp0emPcI/njlumhXLPC4K4vcwWK9W3KujGCNE
         NH/bJ5mLW7MbjO2zLhY7Ntc53GrBp/8COPC514p0p3HX6pxYKtkwp+9z8PRBpnLbpOY1
         0BGkJLVL4w6NxraGBeEFaWids/mClgQU8kn913tJ9JZ6uWHSK2BAhm2JVukL1fsihlQe
         JftQ==
X-Gm-Message-State: ACrzQf3uhy9Jqhxmq6LPhkFFatg5a3HEtGz2Qu0BFOXy69R8aU2j7bJV
        RSfqdh7lNf6EHG4tKmgW68yEMGE7eFk=
X-Google-Smtp-Source: AMsMyM6C+3TlSeGlunUd1eW9Rp33CCs61sjN1XLPKi3j4nR57e92LiXCa3ye9Lka2dxO2w6jaAv/RqCkfuU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10a:b0:6af:b884:840e with SMTP id
 o10-20020a056902010a00b006afb884840emr10898548ybh.330.1664585996098; Fri, 30
 Sep 2022 17:59:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  1 Oct 2022 00:59:05 +0000
In-Reply-To: <20221001005915.2041642-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221001005915.2041642-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221001005915.2041642-23-seanjc@google.com>
Subject: [PATCH v4 22/32] KVM: x86: Disable APIC logical map if vCPUs are
 aliased in logical mode
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

Disable the optimized APIC logical map if multiple vCPUs are aliased to
the same logical ID.  Architecturally, all CPUs whose logical ID matches
the MDA are supposed to receive the interrupt; overwriting existing map
entries can result in missed IPIs.

Fixes: 1e08ec4a130e ("KVM: optimize apic interrupt delivery")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/lapic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 7fd55e24247c..14f03e654de4 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -341,11 +341,12 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		if (!mask)
 			continue;
 
-		if (!is_power_of_2(mask)) {
+		ldr = ffs(mask) - 1;
+		if (!is_power_of_2(mask) || cluster[ldr]) {
 			new->logical_mode = KVM_APIC_MODE_MAP_DISABLED;
 			continue;
 		}
-		cluster[ffs(mask) - 1] = apic;
+		cluster[ldr] = apic;
 	}
 out:
 	old = rcu_dereference_protected(kvm->arch.apic_map,
-- 
2.38.0.rc1.362.ged0d419d3c-goog

