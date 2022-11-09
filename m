Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C150622FA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiKIQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiKIQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:05:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FACC21265
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668009890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBkgf+uP/YsjwEv/Zat4qHyDX9ghIOy9Sg+JfdkUrSQ=;
        b=Y7uhU7bOQtnZHILkKGbMGqny7W/KH17iM0QwzOU7yrvU2OogImKSOqtjKaWGKTOKXN2Sgn
        +xD6OKEnLDSgdI+yVlLN+fpJ82kCxlfZEcRXdCw5DIDJfhLiMYmOmtP3lL4n/pQek107t2
        ZQh/STxTpyZ4TvhfTFVT1lWBzsWZlEY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-JujtnmS2PPa-qnogOWV8Wg-1; Wed, 09 Nov 2022 11:04:49 -0500
X-MC-Unique: JujtnmS2PPa-qnogOWV8Wg-1
Received: by mail-wr1-f69.google.com with SMTP id h26-20020adfaa9a000000b002364ad63bbcso5163176wrc.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBkgf+uP/YsjwEv/Zat4qHyDX9ghIOy9Sg+JfdkUrSQ=;
        b=g7l68yV4b4mbptI+Br0EByxyjuCxtBequdLZ2PSwruItCF6+fv10wkofoPSgbQQ8iD
         BH3G2oe/595zHcWKYSAzBXv4JTj7gdRkwrplLu2A8dCwOwKlK1/nt64rO/brbYcLHo/r
         QXWxfxBeevw+NWdpHcg6OVTJcxYh7aDpLUghmxFn9tcNZfnhr96aIY8iXajfEbTuqOzS
         4D/H2btem5VO5+uJQ4Kp1xh1D9cH3qnlBBSr4LCzt4ecVwazr0xYAbp+/USHxVhCEy+v
         57uhRQjRrjEQExvdJtf0IcWHUGIDKyLgdh442usz6HlfeTsdEEn3hARx7iqvWM+sLCYy
         /5zw==
X-Gm-Message-State: ACrzQf0YfuDGaIdeS2sIHgsljlvcZOplE8malUNN7lpQ6RE/tySU/ykd
        jDKTxFbWL5TTxCy/FNOZao8o8EwuG4TfYjCOn9I4hfrf5t8HPOznPnl38vKdY1ckIAdMIAc4yHW
        elGWt38OH7gzc/IeFCNlxQDo/
X-Received: by 2002:a5d:5292:0:b0:236:ccb9:673b with SMTP id c18-20020a5d5292000000b00236ccb9673bmr34930290wrv.317.1668009887733;
        Wed, 09 Nov 2022 08:04:47 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4HgLnFrPxOWHNRB06tzRu9505xj1HfpUMdLUAJw6Qda4RwBKiIpJ9bQdaLn3FfmWg5+LKE5g==
X-Received: by 2002:a5d:5292:0:b0:236:ccb9:673b with SMTP id c18-20020a5d5292000000b00236ccb9673bmr34930261wrv.317.1668009887458;
        Wed, 09 Nov 2022 08:04:47 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id n17-20020a5d6611000000b002383edcde09sm13554431wru.59.2022.11.09.08.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 08:04:46 -0800 (PST)
Message-ID: <cf24a179-3c19-f4b2-d62d-3c812f46c4dc@redhat.com>
Date:   Wed, 9 Nov 2022 17:04:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 03/11] KVM: SVM: adjust register allocation for
 __svm_vcpu_run
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, jmattson@google.com,
        stable@vger.kernel.org
References: <20221109145156.84714-1-pbonzini@redhat.com>
 <20221109145156.84714-4-pbonzini@redhat.com> <Y2vFIR+T+9SFY0xO@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y2vFIR+T+9SFY0xO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 16:20, Sean Christopherson wrote:
>> keep the pointer to the struct vcpu_svm in %rdi.  This way
>> it is possible to load svm->vmcb01.pa in %rax without
>> clobbering the pointer to svm itself.
>
> If you feel like doing fixup before pushing, add a note to call out that avoiding
> RAX will also be "necessary" to play nice with loading/storing MSR_SPEC_CTRL?
> When fiddling with this code, I found the RDMSR/WRMSR clobbers to be far more
> problematic than the VMCB pointers.

I tried to avoid the "in the future" phrasing which some people dislike. 
  I'll rephrase anyway.  Even without taking 
RDMSR/WRMSR/VMLOAD/VMRUN/VMSAVE into account, avoiding the potential 
clash with 32-bit register arguments is a decent reason for the patch 
anyway.

Paolo

