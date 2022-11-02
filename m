Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479DB616B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiKBRn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKBRn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B9D20F70
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667410978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAUqrmYfF3xUJAkjKE7ByhXsI3srxGB0kalohC3F0q0=;
        b=C6F3D4qmeoAyylikrTxr+ZN5TRkV4fd4Ry3vybDBy425vsU1ki4gzs6BCkvQGWK5K9hAG8
        Q1mFCyzkngX05Fs+HfuH0h8rf31nTLckZKJraBl+f4RbSBuzNuS9DUQclemQDZSE4uwe1+
        iPlC7gke5bn0latnn70Qo508tBEzVko=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-36-k8ksDJDKNOWtnj3xg21Q1g-1; Wed, 02 Nov 2022 13:42:56 -0400
X-MC-Unique: k8ksDJDKNOWtnj3xg21Q1g-1
Received: by mail-ej1-f72.google.com with SMTP id he6-20020a1709073d8600b0078e20190301so10561320ejc.22
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAUqrmYfF3xUJAkjKE7ByhXsI3srxGB0kalohC3F0q0=;
        b=C0IhCgGklPdOXYo529ekLSRYOrZZZ3zrIweYw/8ujFlw8LXpK9Xsp+WlPcQnsIvXI+
         DrYdurK+cBt3BCL2L8POpJE0aS1AC8am+N4DZGODhJQM9AXW/Z2YhKrAih1sQjYDmiCz
         ahN8pWXwkZ0rJAkIG5vtiY2QkivsOxjk6jE0VkeTg/4pCfeQr61Fbwpg4okAgKjJueUl
         4lN34cbcNbOq2hHKXagkn+DiIKlyHWkb+68uyZU/R3UZ7UYwyIwWwh1jQrz1/BrdCNOv
         oZStCea/AsbMt7u8CPZip9UnAIJ5r/JS/pz5DnSxrIHTGmRjDoFn7ePZ9XGFKUeRlEo+
         cGUw==
X-Gm-Message-State: ACrzQf2IsMAlCPkZ4HGrKwLs2Zbo2lKIsu561VJHjmR5W92GxN5F6K1r
        hoGU4fHlZBilx2PJ6vsr+C6Bj8T2ibc4X/Ta1hcneNeCvNS8XIgcXCppHpSfeNBTZ3Q91ScWeMo
        7Y8hZqnm83KHRgatXgOnjpq46
X-Received: by 2002:a17:906:9510:b0:7ad:fd3e:124b with SMTP id u16-20020a170906951000b007adfd3e124bmr5810250ejx.502.1667410975717;
        Wed, 02 Nov 2022 10:42:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4r3SCfEC3KPurGLuEOLlwNRGuvpRxFybhdq3Lga4T29czjy5Y6cVGWjXUrODPXm3r0wfx/Jg==
X-Received: by 2002:a17:906:9510:b0:7ad:fd3e:124b with SMTP id u16-20020a170906951000b007adfd3e124bmr5810234ejx.502.1667410975520;
        Wed, 02 Nov 2022 10:42:55 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id y26-20020a1709063a9a00b0078246b1360fsm5613231ejd.131.2022.11.02.10.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:42:55 -0700 (PDT)
Message-ID: <26b40d14-1ce3-13c2-dd13-492e0ebd6adc@redhat.com>
Date:   Wed, 2 Nov 2022 18:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/7] KVM: VMX: remove regs argument of __vmx_vcpu_run
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com, jpoimboe@kernel.org
References: <20221028230723.3254250-1-pbonzini@redhat.com>
 <20221028230723.3254250-2-pbonzini@redhat.com> <Y2AH6sevOvD/GnKV@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y2AH6sevOvD/GnKV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 18:37, Sean Christopherson wrote:
>>   	if (IS_ENABLED(CONFIG_KVM_INTEL)) {
>>   		BLANK();
>> +		OFFSET(VMX_vcpu_arch_regs, vcpu_vmx, vcpu.arch.regs);
> Is there an asm-offsets-like solution that doesn't require exposing vcpu_vmx
> outside of KVM?  We (Google) want to explore loading multiple instances of KVM,
> i.e. loading multiple versions of kvm.ko at the same time, to allow intra-host
> migration between versions of KVM to upgrade/rollback KVM without changing the
> kernel (RFC coming soon-ish).  IIRC, asm-offsets is the only place where I haven't
> been able to figure out a simple way to avoid exposing KVM's internal structures
> outside of KVM (so that the structures can change across KVM instances without
> breaking kernel code).
> 

It's possible to create our own asm-offsets.h file using something 
similar to the logic in Kbuild:

#####
# Generate asm-offsets.h

offsets-file := include/generated/asm-offsets.h

always-y += $(offsets-file)
targets += arch/$(SRCARCH)/kernel/asm-offsets.s

arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)

$(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
         $(call filechk,offsets,__ASM_OFFSETS_H__)

Paolo

