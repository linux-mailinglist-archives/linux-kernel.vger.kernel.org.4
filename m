Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1176D8B33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjDEXqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDEXqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:46:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF107695
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:46:01 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l14-20020a170902f68e00b001a1a9a1d326so21650617plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 16:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680738361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xNGeRDIkTtMwdpUunk/LJQ+eOn2n7u25QTc+Qc8ujPk=;
        b=rJK561EpCQv795FsTyfhoO8EAqpBp3c/KWtvnLOSvr6gn69lCDd/7vu+sQnI8tTMN6
         j5DX+bzYSCpbMfudYzJiUim8gStbYAm1J0n9Levs3BOB0cLiHOjcEq1hlTouBhYKlV1o
         XaiW1yUXvQyn+2u0NrQTAFP7clkPz3y9CdkDIp7VWDLUVRmrMEO2JHFJKgg5rBh67YTo
         yTy0JD0cttYZQBg9Y3jqd5ReibwvcjX2QuOiSn3bgS2l3mSHWCFz0EhNXWBCN3exGXk8
         o6/bvbyjNfYr4kOGrfaDYRm75zwXUZihsXBbFUQnO90b90sGQLPxjtEafdQLpB3g0XFj
         FfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680738361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNGeRDIkTtMwdpUunk/LJQ+eOn2n7u25QTc+Qc8ujPk=;
        b=2Sj/K2N21F0F3V1dZeoflR7m7NN0fnmiSAyaLinQ0dWOXG4+Lve52NyuhvJz55JjPu
         sKVmXwmm8HqAZ5rhIMet9VXlfl3F8bpE01hgaEpmH0zHZ58xI1IHUj/07cQm2mK2hGZ1
         o4P3MJjC+SmR8VjEz6g3u16mpbnKw9wh/PTppynbFuzLGyuF3wtaQC0+0Obty6SWbYCY
         deg39qBvzqu7l0L9cz+q7wp52ohRdX7ggc4s+H1Zb5lV4ADpervql9mA5FDIIPn1JGvA
         PtZrx7aSWf0xjOwF+Ntxv9bAvH4zmkGGlS2uyRrzsgm6vdqZmnutW/Sw/IZoOFypJTPx
         rEHQ==
X-Gm-Message-State: AAQBX9cyobnrYBHvBRvoUTNJbMrZMguWuZgaNYoNNpHrUDwvTwTss+Sb
        KfG7DAzmsQ61Xz1OLJQwgKuZU5M+pE0=
X-Google-Smtp-Source: AKy350YAGD7mt7Yp0bWIMzK7Fajyk2Sa1d+Ymi5ciNZWaoO6buaEBr5AjolyMtLiOjNp5pr6v2uqpjhGn3M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7108:0:b0:513:5162:a692 with SMTP id
 m8-20020a637108000000b005135162a692mr1674064pgc.5.1680738360888; Wed, 05 Apr
 2023 16:46:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  5 Apr 2023 16:45:55 -0700
In-Reply-To: <20230405234556.696927-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230405234556.696927-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405234556.696927-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: VMX: Inject #GP on ENCLS if vCPU has paging disabled (CR0.PG==0)
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Binbin Wu <binbin.wu@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>
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

Inject a #GP when emulating/forwarding a valid ENCLS leaf if the vCPU has
paging disabled, e.g. if KVM is intercepting ECREATE to enforce additional
restrictions.  The pseudocode in the SDM lists all #GP triggers, including
CR0.PG=0, as being checked after the ENLCS-exiting checks, i.e. the
VM-Exit will occur before the CPU performs the CR0.PG check.

Fixes: 70210c044b4e ("KVM: VMX: Add SGX ENCLS[ECREATE] handler to enforce CPUID restrictions")
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/sgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index aa53c98034bf..f881f6ff6408 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -375,7 +375,7 @@ int handle_encls(struct kvm_vcpu *vcpu)
 
 	if (!encls_leaf_enabled_in_guest(vcpu, leaf)) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
-	} else if (!sgx_enabled_in_guest_bios(vcpu)) {
+	} else if (!sgx_enabled_in_guest_bios(vcpu) || !is_paging(vcpu)) {
 		kvm_inject_gp(vcpu, 0);
 	} else {
 		if (leaf == ECREATE)
-- 
2.40.0.348.gf938b09366-goog

