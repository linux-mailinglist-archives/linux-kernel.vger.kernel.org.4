Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906D264A8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiLLUnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiLLUm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A518363
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670877719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z2uxCw+2oIvu/ILYj5euA+kRPg0up0LSvJCE9PhHSN0=;
        b=Pv/0JJVI2t9Cs1k/kqK4EDoPYwl+pl22AwnQpLGR2G5a6Ce758zFJGkfW2RIaeuvZS5Klj
        snqEpyER/Th457JOhwBzrQXSIVnbN4GqB8TlJxw2lB5is9BBr8gRM2JjZ1Y6jJP4Or7ct3
        O/kY02GalSwgWciitQED5v0URVAL9g8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-Wl6eGM-rPwW_KNCooIswZw-1; Mon, 12 Dec 2022 15:41:57 -0500
X-MC-Unique: Wl6eGM-rPwW_KNCooIswZw-1
Received: by mail-wm1-f71.google.com with SMTP id c187-20020a1c35c4000000b003cfee3c91cdso3865970wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:41:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2uxCw+2oIvu/ILYj5euA+kRPg0up0LSvJCE9PhHSN0=;
        b=Eds4+i3jwlJVHfbphPd0990wjLB1c6P2cEs2NCk9DlC/vEmgrMY8S/2h4bgKXlfvGs
         J/oINVXoGgXLrV8zD9qQRq4MrEIvWpG0NQHx/Jov18py1L3VFH732geNtMu9xEYAnRvm
         dPXUinEtF0VGnozw/5EjD9pt9RsVu4K+V0oY6y6nZQccSwC8a/QN3WVkHxmULzqCksCz
         PWEhL602WfjaJbOEgZnaM/qSv7MMOTndm0etw0M0rvqK80xgW7Zos5ExC+WZ1K2XnvdH
         yO1yIpRiJoTbUMW66zNVwv7Fpffkmw5nFSAjJQiZ4kg5wqbjMgopeHMLV5kzBMhzE1wG
         V69Q==
X-Gm-Message-State: ANoB5plCSCM30sewZMf96HPeuUp8cLbRTH9qcpukx85wdXmTM69R1fGt
        cjM6ryxgPF7DRLMCO3v5Z10wTvgepveqv+0Cv7foHs/PWkmY7wwLjX540xdagx2/HF0z+ytU29U
        Cr7YAaSCpWGSyENQNXlcyNJFC
X-Received: by 2002:a7b:c30e:0:b0:3c6:f7ff:6f87 with SMTP id k14-20020a7bc30e000000b003c6f7ff6f87mr13366463wmj.11.1670877716605;
        Mon, 12 Dec 2022 12:41:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6V+fwfdC8Y+PY3oleBzA1Gt3GtqyjsanDv0yhQV9qdsQdGU0QhB8MyaBKKEaH2UQ6mE1DzMA==
X-Received: by 2002:a7b:c30e:0:b0:3c6:f7ff:6f87 with SMTP id k14-20020a7bc30e000000b003c6f7ff6f87mr13366455wmj.11.1670877716422;
        Mon, 12 Dec 2022 12:41:56 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id v10-20020a05600c444a00b003cff309807esm11298387wmn.23.2022.12.12.12.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 12:41:55 -0800 (PST)
Message-ID: <6d96a62e-d5a1-e606-3bd2-c38f4a6c8545@redhat.com>
Date:   Mon, 12 Dec 2022 21:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 6.2
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20221212155027.2841892-1-pbonzini@redhat.com>
 <Y5ddb+tGS7phN1vc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y5ddb+tGS7phN1vc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/22 17:57, Sean Christopherson wrote:
> On Mon, Dec 12, 2022, Paolo Bonzini wrote:
>> Linus,
>>
>> The following changes since commit 8332f0ed4f187c7b700831bd7cc83ce180a944b9:
>>
>>    KVM: Update gfn_to_pfn_cache khva when it moves within the same page (2022-11-23 18:58:46 -0500)
>>
>> are available in the Git repository at:
>>
>>    https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
>>
>> for you to fetch changes up to 1396763d469a83c5d791fa84df7dd17eba83dcf2:
>>
>>    Merge remote-tracking branch 'kvm/queue' into HEAD (2022-12-09 09:15:09 +0100)
> 
> ...
> 
>>        KVM: x86: remove unnecessary exports
> 
> ...
> 
>>        KVM: nVMX: hyper-v: Enable L2 TLB flush
> 
> As reported a few times[1][2], these two collided and cause a build failure when
> building with CONFIG_KVM_AMD=m.

Ouch, the worst thing that can be reported just before a 5-day public 
holiday weekend.

>    ERROR: modpost: "kvm_hv_assist_page_enabled" [arch/x86/kvm/kvm-amd.ko] undefined!
>    make[2]: *** [scripts/Makefile.modpost:126: Module.symvers] Error 1
>    make[1]: *** [Makefile:1944: modpost] Error 2
> 
> The fix is simple enough, maybe just squash it into the merge?

No, I'll fix and respin. :/

Paolo

