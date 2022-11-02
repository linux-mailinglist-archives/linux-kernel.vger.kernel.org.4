Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558B8616BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiKBSRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKBSRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410DE2EF58
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667413002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jw7b1n/ebpTUgcQG/rFiOjJ5EJAXbmzR8GTB2GXchZg=;
        b=H61iVV/jbxErJkSKsw0EXGD0CZR4gRJwFOOyB8luQK9fNSN8nroId+iexeWkHf3TFTNTZ/
        24Ruwr7t62nFWTAwjhxOvrPa3JTgukEYaHZwwRm8Knh6fbK0Sf+1WRAHMo5zRUkus513Hi
        sMl7+3YzQfvJx9D5pKLSAX7mbihQ34Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-yqz260Y5O4ud1xKhrk4L6Q-1; Wed, 02 Nov 2022 14:16:41 -0400
X-MC-Unique: yqz260Y5O4ud1xKhrk4L6Q-1
Received: by mail-ej1-f69.google.com with SMTP id jg27-20020a170907971b00b007ad9892f5f6so9153428ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jw7b1n/ebpTUgcQG/rFiOjJ5EJAXbmzR8GTB2GXchZg=;
        b=GzjBhq2G61lRr5AORKjTQpBgSLRSukfcYzOnBvAU4sD7QNDjUz0FcET/OEtCd4qevt
         a3i5LNRI3oe8WBgtjVQz1qunKD5XaToRsajQoGom2PcUs4TyWL7UIZqzmAZmp9eJcmDC
         mvPpHvz7K7Xh8YW2UVHFTpy2WGGJR1ncs1XMQZ7oEEoqkwVoAMQS0H3XT3mC8wff5d4w
         7UfkdYuDOtEy8qHd61zvMDuOhxQmPTgijdZ4Xyr1RGmIXohXG9lPXjtk6JBzzXH/K7zj
         stVcQpSL1AKNzMayfMEGF23WFQpbUM1kB13eYTohyL14biBXVreBRYSejR+4GOramOGE
         bhsg==
X-Gm-Message-State: ACrzQf0ejxbgH6UMW0EPgidnRaMCtCANXOXebjBV1hG/VSmxxkJ+0Yll
        4a8pcVcHOzw6zQEB4CSy/Rp8m8hvEexvACzPOC7tGHrh/SITLIBBEQPtZyVd7JgKxAeBwUKyQcv
        zQ8PDbhALJcj+CsBhvS0RwoYO
X-Received: by 2002:a05:6402:3510:b0:461:f781:6dfe with SMTP id b16-20020a056402351000b00461f7816dfemr25254369edd.272.1667412999728;
        Wed, 02 Nov 2022 11:16:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7UA6R8jQnjSfp5PyABI62YVAutDXQCVF5ugPNvKazAfZNC4L2rsedaZ5ctjKOqJgVSsGWNrA==
X-Received: by 2002:a05:6402:3510:b0:461:f781:6dfe with SMTP id b16-20020a056402351000b00461f7816dfemr25254341edd.272.1667412999438;
        Wed, 02 Nov 2022 11:16:39 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id qk4-20020a170906d9c400b007ad69e9d34dsm5756143ejb.54.2022.11.02.11.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 11:16:38 -0700 (PDT)
Message-ID: <aa7f6efc-de4c-c5f6-fb5f-ef514e4513a3@redhat.com>
Date:   Wed, 2 Nov 2022 19:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/6] x86: KVM: Enable AMX-FP16 CPUID and expose it to
 guest
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, ndesaulniers@google.com,
        alexandre.belloni@bootlin.com, peterz@infradead.org,
        jpoimboe@kernel.org, chang.seok.bae@intel.com,
        pawan.kumar.gupta@linux.intel.com, babu.moger@amd.com,
        jmattson@google.com, sandipan.das@amd.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, fenghua.yu@intel.com,
        keescook@chromium.org, jane.malalane@citrix.com, nathan@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221019084734.3590760-1-jiaxi.chen@linux.intel.com>
 <20221019084734.3590760-3-jiaxi.chen@linux.intel.com>
 <639c22a1-b0b0-9fb0-2a9a-060c53f9f540@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <639c22a1-b0b0-9fb0-2a9a-060c53f9f540@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 19:14, Dave Hansen wrote:
>>   
>>   	kvm_cpu_cap_mask(CPUID_7_1_EAX,
>> -		F(AVX_VNNI) | F(AVX512_BF16) | F(CMPCCXADD)
>> +		F(AVX_VNNI) | F(AVX512_BF16) | F(CMPCCXADD) | F(AMX_FP16)
>>   	);
>>   
>>   	kvm_cpu_cap_mask(CPUID_D_1_EAX,
>
> KVM folks, is the idea that every feature that is enumerated to a guest
> needs to be in one of these masks?  Or is there something special about
> the features in these masks?

Yes, all features are vetted manually to see whether they require new 
MSRs and the like.  Therefore, anything that userspace can set in the 
guest's CPUID must be in the list.

Paolo

