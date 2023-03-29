Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4908D6CDB22
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjC2Nse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC2Nsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D884EFB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680097650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WaGawcRlLjgjbqbLfH4brTMhieMGCOaue1qd648kpQ=;
        b=ZEysvv2pQdy8fScpPiK2dPpdsOcZmmP2Fz1Yknx1DdGTVssEY+vw/rSL81+DACuVvWuTV3
        tjC7dvSe8FCIf+aZ+j1hIeD0a5gn20V1+kEW9BLhBisIRvaqKxeHe4SUAFVo6yQ4M5YM+a
        KYfUOQxKinsi/d443U3U3uUYL0yZvlc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Wpg4RePnPNeynyhr05NUgg-1; Wed, 29 Mar 2023 09:47:29 -0400
X-MC-Unique: Wpg4RePnPNeynyhr05NUgg-1
Received: by mail-ed1-f70.google.com with SMTP id p36-20020a056402502400b004bb926a3d54so22301501eda.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680097646; x=1682689646;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WaGawcRlLjgjbqbLfH4brTMhieMGCOaue1qd648kpQ=;
        b=nmna8Ao9M6dNvWxycGJDrvLjHA3mD3WadqKpOoU01JNF0mXfkzaN9UXQAtTB11RkdD
         1vtbHSZBG2QdSZPAGCK3WdjK32tc/iOmb/Ytp2QD+WGV4zj6SfXrTF71HlC69u+YGSVT
         qzXFZ+CReQA/xGdubiAkkWp6RYaJC+malRQiD2DM55rwMk0gCl/M6VGP/YqURpmGxTIi
         jaKBP0hqDsTTREcjffmumgpZ/8kxEPwJckn2jWQTuFGtl5byq1ApDJyq9T0+UR+uSerD
         tbeC/oP9lje60MieQwTd+C6spQcUWAr+hq9vN87L1tmKaA2ypwjUf2pXRMovd/LxyK1R
         1DUw==
X-Gm-Message-State: AAQBX9e/0l/8iG5pYCcfeKeoX+6NLMBc47ODnNpESjMI08Ob7vPlWsC3
        B5glh2H9m88xayxS+UUn5O4zAt5X6JONrZM3sT+oHBx/G657w8laUSnzxMtHBOd1ijvEJni5S9B
        QCmwYnsZsVMJqYJf7muYx0mPC
X-Received: by 2002:a05:6402:45:b0:4fc:c644:6141 with SMTP id f5-20020a056402004500b004fcc6446141mr20578421edu.0.1680097645874;
        Wed, 29 Mar 2023 06:47:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350ahTfMAGWoqyXG20wsWX1BRxAlLAjMIZlvjxIF6/FUi/EGrdh3ViA6rXIAt5l+CP4h8W7y0HQ==
X-Received: by 2002:a05:6402:45:b0:4fc:c644:6141 with SMTP id f5-20020a056402004500b004fcc6446141mr20578389edu.0.1680097645482;
        Wed, 29 Mar 2023 06:47:25 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm16943477edd.66.2023.03.29.06.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 06:47:24 -0700 (PDT)
Message-ID: <244097d2-3d14-6031-7733-62be75036d88@redhat.com>
Date:   Wed, 29 Mar 2023 15:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Lee Jones <joneslee@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <20211208015236.1616697-8-seanjc@google.com>
 <1548c1a4-4681-4d98-ee43-44bc97b3bdee@linaro.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 07/26] KVM: VMX: Move preemption timer <=> hrtimer
 dance to common x86
In-Reply-To: <1548c1a4-4681-4d98-ee43-44bc97b3bdee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 14:34, Tudor Ambarus wrote:
> This patch fixes the bug reported at:
> LINK:
> https://syzkaller.appspot.com/bug?id=489beb3d76ef14cc6cd18125782dc6f86051a605
> 
> One may find the strace at:
> LINK:https://syzkaller.appspot.com/text?tag=CrashLog&x=1798b54ec80000
> and the c reproducer at:
> LINK:https://syzkaller.appspot.com/text?tag=ReproC&x=10365781c80000
> 
> Since I've no experience with kvm, it would be helpful if one of you can
> provide some guidance. Do you think it is worth to backport this patch
> to stable (together with its prerequisite patches), or shall I try to
> get familiar with the code and try to provide a less invasive fix?

I think it is enough to fix the conflicts in vmx_pre_block and
vmx_post_block, there are no prerequisites:

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0718658268fe..895069038856 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7577,17 +7577,11 @@ static int vmx_pre_block(struct kvm_vcpu *vcpu)
  	if (pi_pre_block(vcpu))
  		return 1;
  
-	if (kvm_lapic_hv_timer_in_use(vcpu))
-		kvm_lapic_switch_to_sw_timer(vcpu);
-
  	return 0;
  }
  
  static void vmx_post_block(struct kvm_vcpu *vcpu)
  {
-	if (kvm_x86_ops.set_hv_timer)
-		kvm_lapic_switch_to_hv_timer(vcpu);
-
  	pi_post_block(vcpu);
  }
  
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fcfa3fedf84f..4eca3ec38afd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10022,12 +10022,28 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
  
  static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
  {
+	bool hv_timer;
+
  	if (!kvm_arch_vcpu_runnable(vcpu) &&
  	    (!kvm_x86_ops.pre_block || static_call(kvm_x86_pre_block)(vcpu) == 0)) {
+		/*
+		 * Switch to the software timer before halt-polling/blocking as
+		 * the guest's timer may be a break event for the vCPU, and the
+		 * hypervisor timer runs only when the CPU is in guest mode.
+		 * Switch before halt-polling so that KVM recognizes an expired
+		 * timer before blocking.
+		 */
+		hv_timer = kvm_lapic_hv_timer_in_use(vcpu);
+		if (hv_timer)
+			kvm_lapic_switch_to_sw_timer(vcpu);
+
  		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
  		kvm_vcpu_block(vcpu);
  		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
  
+		if (hv_timer)
+			kvm_lapic_switch_to_hv_timer(vcpu);
+
  		if (kvm_x86_ops.post_block)
  			static_call(kvm_x86_post_block)(vcpu);
  
@@ -10266,6 +10282,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
  			r = -EINTR;
  			goto out;
  		}
+		/*
+		 * It should be impossible for the hypervisor timer to be in
+		 * use before KVM has ever run the vCPU.
+		 */
+		WARN_ON_ONCE(kvm_lapic_hv_timer_in_use(vcpu));
  		kvm_vcpu_block(vcpu);
  		if (kvm_apic_accept_events(vcpu) < 0) {
  			r = 0;

The fix is due to the second "if" changing from
kvm_x86_ops.set_hv_timer to hv_timer.

Paolo

