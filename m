Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36278619A77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiKDOsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiKDOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB84E2728
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667573233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dduFxNUnMZtaYg6bmwVG1UIu2rSweaRMsLL9I6qL7vU=;
        b=c8fh8cGGgnsmmTEcJtHEfNZocSrhT5FaGXWpxznqPiKyY79YehCUq/B/31UKEo+wZb/dND
        XtugQ6fKBVrGhTjCRjyq1qh8VM/7TEC8eQclfB0aU9kt7G+E0iy46yMa4DiRABK76OjxkK
        +Jn/nJ2bx/bbC4OMRZWCJYyQ9BgdRBs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-nucE-hcZNgq_7KolCVahyg-1; Fri, 04 Nov 2022 10:47:11 -0400
X-MC-Unique: nucE-hcZNgq_7KolCVahyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C0E987B2A7;
        Fri,  4 Nov 2022 14:47:11 +0000 (UTC)
Received: from ovpn-192-136.brq.redhat.com (ovpn-192-136.brq.redhat.com [10.40.192.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D4A2C2C8D9;
        Fri,  4 Nov 2022 14:47:09 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] KVM: VMX: nVMX: Make eVMCS enablement more robust
Date:   Fri,  4 Nov 2022 15:47:04 +0100
Message-Id: <20221104144708.435865-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Simplify PATCH4 by not using evmcs_get_supported_ctls() and doing more
  macro magic to avoid having two evmcs_check_vmcs_conf{u32, u64} variants
  [Sean]

This is a continuation of "KVM: VMX: Support updated eVMCSv1 revision + use
vmcs_config for L1 VMX MSRs" work:
https://lore.kernel.org/kvm/20220830133737.1539624-1-vkuznets@redhat.com/

and a preparation to enabling new eVMCS features for Hyper-V on KVM, namely
nested TSC scaling.

Future proof KVM against two scenarios:
- nVMX: A new feature which doesn't have a corresponding eVMCSv1 field gets
 implemented in KVM but EVMCS1_UNSUPPORTED_* defines are left unchanged.
- VMX: A new feature supported by KVM but currently missing in eVMCSv1 gets
 implemented in a future Hyper-V version breaking KVM.

Note: 'vmx/evmcs.{c,h}' are renamed to 'vmx/hyperv.{c,h}' in
https://lore.kernel.org/kvm/20221004123956.188909-7-vkuznets@redhat.com/

Vitaly Kuznetsov (4):
  KVM: nVMX: Sanitize primary processor-based VM-execution controls with
    eVMCS too
  KVM: nVMX: Invert 'unsupported by eVMCSv1' check
  KVM: nVMX: Prepare to sanitize tertiary execution controls with eVMCS
  KVM: VMX: Resurrect vmcs_conf sanitization for KVM-on-Hyper-V

 arch/x86/kvm/vmx/evmcs.c | 88 +++++++++++++++++++++++++++++--------
 arch/x86/kvm/vmx/evmcs.h | 93 +++++++++++++++++++++++++++++++++-------
 arch/x86/kvm/vmx/vmx.c   |  5 +++
 3 files changed, 152 insertions(+), 34 deletions(-)

-- 
2.38.1

