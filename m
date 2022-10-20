Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68775605B39
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiJTJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiJTJb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6CC157F6F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666258283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nm86sopHALiAvOTB3Mb1uaCRxtNMK3Osw7jYg3LC+M0=;
        b=PrBzeCYAoQuMxz23urWDMNkIm5te+d7ccZd/Ny3fT2+GBPnEdZQzALrJUB0+ZWxImEOq0R
        FxlTuhZwN9aiV2wCuoOqdZKlnGjeOvZ3/+qd0nm8GSV8P1te/gh8W9+vapaOfVD/6YmAEk
        iJ9eu6619IYI28GShB35+XZwssdMIUc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-MgE-q4rgP1SE4fwskpXN-A-1; Thu, 20 Oct 2022 05:31:18 -0400
X-MC-Unique: MgE-q4rgP1SE4fwskpXN-A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9305729324B0;
        Thu, 20 Oct 2022 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-192-51.brq.redhat.com [10.40.192.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4AAC49BB60;
        Thu, 20 Oct 2022 09:31:14 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 4/4] KVM: x86: forcibly leave nested mode on vCPU reset
Date:   Thu, 20 Oct 2022 12:30:55 +0300
Message-Id: <20221020093055.224317-5-mlevitsk@redhat.com>
In-Reply-To: <20221020093055.224317-1-mlevitsk@redhat.com>
References: <20221020093055.224317-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While not obivous, kvm_vcpu_reset leaves the nested mode by
clearing 'vcpu->arch.hflags' but it does so without all the
required housekeeping.

This makes SVM and VMX continue to use vmcs02/vmcb02 while
the cpu is not in nested mode.

In particular, in SVM code, it makes the 'svm_free_nested'
free the vmcb02, while still in use, which later triggers
use after free and a kernel crash.

This issue is assigned CVE-2022-3344

Cc: stable@vger.kernel.org
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d86a8aae1471d3..313c4a6dc65e45 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11931,6 +11931,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	WARN_ON_ONCE(!init_event &&
 		     (old_cr0 || kvm_read_cr3(vcpu) || kvm_read_cr4(vcpu)));
 
+	kvm_leave_nested(vcpu);
 	kvm_lapic_reset(vcpu, init_event);
 
 	vcpu->arch.hflags = 0;
-- 
2.26.3

