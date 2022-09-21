Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6215C016A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiIUP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiIUP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5D198C8F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663773944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8g6nkZR4NZyZXQonCEiVMud1aiPVM+hfQjCyGlaQk0=;
        b=XLR/xS0NlhoasVBCO2YlzmQDa1DnLE6EcmakaMoXqRKr/tg7hRku9XurKUquOSlykeiQCF
        3+NLmloxT4mfpQs/GQiOP5++JlwYifhA3+GDtw6rupyU2Dd71Y381MMRbWSZr3S4u3pRH0
        kSxovxUvgsTSB/eLxAZxwoOTdwheGks=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-rjeSpSJcOaG34hBRSwI9CA-1; Wed, 21 Sep 2022 11:25:39 -0400
X-MC-Unique: rjeSpSJcOaG34hBRSwI9CA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43599858F17;
        Wed, 21 Sep 2022 15:25:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4B082166B26;
        Wed, 21 Sep 2022 15:25:35 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 22/39] KVM: x86: Expose Hyper-V L2 TLB flush feature
Date:   Wed, 21 Sep 2022 17:24:19 +0200
Message-Id: <20220921152436.3673454-23-vkuznets@redhat.com>
In-Reply-To: <20220921152436.3673454-1-vkuznets@redhat.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With both nSVM and nVMX implementations in place, KVM can now expose
Hyper-V L2 TLB flush feature to userspace.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 8ae32ec87efb..1eb2e3c8b392 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2764,6 +2764,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 
 		case HYPERV_CPUID_NESTED_FEATURES:
 			ent->eax = evmcs_ver;
+			ent->eax |= HV_X64_NESTED_DIRECT_FLUSH;
 			ent->eax |= HV_X64_NESTED_MSR_BITMAP;
 			ent->ebx |= HV_X64_NESTED_EVMCS1_PERF_GLOBAL_CTRL;
 			break;
-- 
2.37.3

