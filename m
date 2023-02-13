Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9A694F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjBMS22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjBMS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5120D37
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676312806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dqas7IKcHMmrzpHpfZ+GZZhhDLN7yPHWj+wWiYjQmUI=;
        b=UiH0YkJ09B1Cokvr+q0BSCfcrIgdAoF6SPZ3b1qKhjb2ehn2+C0mL3sVtOpF4jPz8DM91N
        J0y9CoVJONmcCFMX8n50Mi00xsRAZca3buW474dxhRAU+s0Ku0n/SKSzR91heKJdwLsDBz
        pNupMOWhX1yWXIg9DsLHG4Y7EQuEGm4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-483-V2-1LpDpMXakFUM-hYWlRQ-1; Mon, 13 Feb 2023 13:26:44 -0500
X-MC-Unique: V2-1LpDpMXakFUM-hYWlRQ-1
Received: by mail-ej1-f72.google.com with SMTP id 21-20020a170906225500b0088b953a6df6so8180451ejr.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dqas7IKcHMmrzpHpfZ+GZZhhDLN7yPHWj+wWiYjQmUI=;
        b=LDuj/Gq+uGuhZic+3algO68Hbx42YbqUuWhZTjj9tL/oZuybl2u1FUtVgK/LJfMXIP
         d6DZLo8iVENAhNdkmIurOya4lefrux3RkRTZUnG+eDP+jFr5WzragWYDNPJs0cJ+LkaS
         9COH8J7gMFwcczje8+zAs/ST2cILe/j40/g3zWqPZX7LvfVPKw19DIWJI/xOInaGc3qp
         XxY8J9nnLFbmRYpsxNAPLhfcupTw1lNOxBaJ4ycqe5Oc+SF4hZANunXhOQuDbNgb7Ayd
         vy9S0nXXzmBr33gP3B2OCRdfObfPg3eia40bF1siN4rd06kQ4l4dKE4oJHjF+LS3TB04
         ywdg==
X-Gm-Message-State: AO0yUKUe9e6X/6nZV3rNeUBOBEWwO/ii/qdcqVTHnRTDR4vOKYOpDHOr
        LrItIstYQrI5JSfqNO06LV2QAUBFF4ZGEcABmrD397NGONEUAi68p4n85FIn0BUyCgzIFqaKfL3
        5r8zgdtPyGg3swmc4VURHdO4x
X-Received: by 2002:a17:906:a189:b0:87b:db62:d659 with SMTP id s9-20020a170906a18900b0087bdb62d659mr26218827ejy.19.1676312803543;
        Mon, 13 Feb 2023 10:26:43 -0800 (PST)
X-Google-Smtp-Source: AK7set9LoCpz6wnVKg9S4xNaMygS8ScsWULBPzti431vOcsLeANKUzyaytVJAQm/dkWpkzg4ZDf8fQ==
X-Received: by 2002:a17:906:a189:b0:87b:db62:d659 with SMTP id s9-20020a170906a18900b0087bdb62d659mr26218814ejy.19.1676312803382;
        Mon, 13 Feb 2023 10:26:43 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id h14-20020a17090634ce00b00877e1bb54b0sm7128313ejb.53.2023.02.13.10.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 10:26:42 -0800 (PST)
Message-ID: <ad3c51a3-f46e-c559-7ad8-573564f63875@redhat.com>
Date:   Mon, 13 Feb 2023 19:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianyu Lan <ltykernel@gmail.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
References: <43980946-7bbf-dcef-7e40-af904c456250@linux.microsoft.com>
 <Y+aQyFJt9Tn2PJnC@google.com>
 <9a046de1-8085-3df4-94cd-39bb893c8c9a@linux.microsoft.com>
 <88a89319-a71e-fa90-0dbb-00cf8a549380@redhat.com>
 <21b1ee26-dfd4-923d-72da-d8ded3dd819c@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: "KVM: x86/mmu: Overhaul TDP MMU zapping and flushing" breaks SVM
 on Hyper-V
In-Reply-To: <21b1ee26-dfd4-923d-72da-d8ded3dd819c@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 19:05, Jeremi Piotrowski wrote:
> So I looked at the ftrace (all kvm&kvmmu events + hyperv_nested_*
> events) I see the following: With tdp_mmu=0: kvm_exit sequence of
> kvm_mmu_prepare_zap_page hyperv_nested_flush_guest_mapping (always
> follows every sequence of kvm_mmu_prepare_zap_page) kvm_entry
> 
> With tdp_mmu=1 I see: kvm_mmu_prepare_zap_page and
> kvm_tdp_mmu_spte_changed events from a kworker context, but they are
> not followed by hyperv_nested_flush_guest_mapping. The only
> hyperv_nested_flush_guest_mapping events I see happen from the qemu
> process context.
> 
> Also the number of flush hypercalls is significantly lower: a 7second
> sequence through OVMF with tdp_mmu=0 produces ~270 flush hypercalls.
> In the traces with tdp_mmu=1 I now see max 3.
> 
> So this might be easier to diagnose than I thought: the
> HvCallFlushGuestPhysicalAddressSpace calls are missing now.

Can you check if KVM is reusing a nCR3 value?

If so, perhaps you can just add 
hyperv_flush_guest_mapping(__pa(root->spt), NULL) after 
kvm_tdp_mmu_get_vcpu_root_hpa's call to tdp_mmu_alloc_sp()?

Paolo

