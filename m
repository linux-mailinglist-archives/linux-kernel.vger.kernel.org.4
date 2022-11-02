Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85118616704
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiKBQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiKBQD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910ED2C640
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667404963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1zCVGxNa8Dahm8ZhjlrLhv37ZXOWng8ggXjb+LCFNY=;
        b=Z1qXoT2F6tUeeCbhBuv7dx/BBrGId3LQAN5nBqLsbVwE86Jopop69g0B2Y9YrPwAEcclGs
        z3d7CKocqfEvLVs5xDpiy4VD+fsQA9qrmV7tOT6LR52vSyurWSW3qwuezJDZKo4jqludvn
        vVlncnPrHtJ1fs2rclkPZfne+IyQGlY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-153-Fl_IivSeNmumdphCmHUKgA-1; Wed, 02 Nov 2022 12:02:40 -0400
X-MC-Unique: Fl_IivSeNmumdphCmHUKgA-1
Received: by mail-ed1-f72.google.com with SMTP id y20-20020a056402271400b004630f3a32c3so7943521edd.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1zCVGxNa8Dahm8ZhjlrLhv37ZXOWng8ggXjb+LCFNY=;
        b=vE0Xv8ETT1T6b0qUPdkwdxZRjgysp4XLe5eBDcggYbakh6zMAmjXP2b14jxZzWKr6R
         ECXDpFkltJBfaHvz0NNsHK1myLgfs6ZH8Taj/TeT+jcXBxTO1klo4nzL/hzQPSUYMK0g
         TqXMr+KXRyh6mXAIeQ2mF/edDiSrl13c6ysOqnrACO+wnfKlOqtU9dU6f/+dn5Sc24K0
         xcJ7CZ86JV7tbCnAwX8Rhymhlku1UKn54yJJPsz8lHP6AVEjNyT47hFRYumL8Z7Oa5gV
         xkEYXGyCa4Y6zrwYSSjfSCfT+l3W/371ZOzapX0D+7HEYXDtlhelL8OkT5hVXcT8BOtx
         hUsQ==
X-Gm-Message-State: ACrzQf1JEID7PkGb949+ZFibSUYPKL0oDk7lSmyCK1nqEalKNRJzKgEF
        Ywd4f+wAuD94aZhz5+2t5VR2wxwBfpHpzZlh0caI0shrZcheqLQrSwfOxeYePjqlaitzVRGzfVl
        z2aD/i3JUPeytE0dVEeqDwIMS
X-Received: by 2002:a05:6402:1842:b0:461:59b6:3f1b with SMTP id v2-20020a056402184200b0046159b63f1bmr25549691edy.308.1667404959269;
        Wed, 02 Nov 2022 09:02:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5YtvJPapFSkugwcKMzw/qQFwaodPj4fnR6aRTvMeSgOW9u/Jhki1J4UlEhl9h9Ittg6jov7Q==
X-Received: by 2002:a05:6402:1842:b0:461:59b6:3f1b with SMTP id v2-20020a056402184200b0046159b63f1bmr25549663edy.308.1667404959083;
        Wed, 02 Nov 2022 09:02:39 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id f16-20020a056402069000b00459cd13fd34sm1401714edy.85.2022.11.02.09.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 09:02:37 -0700 (PDT)
Message-ID: <cd7fcdec-bf2c-ca27-4355-ce56ab9538d9@redhat.com>
Date:   Wed, 2 Nov 2022 17:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 6/7] KVM: SVM: move MSR_IA32_SPEC_CTRL save/restore to
 assembly
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com, seanjc@google.com
References: <20221028230723.3254250-1-pbonzini@redhat.com>
 <20221028230723.3254250-7-pbonzini@redhat.com>
 <20221102152814.lmuzib5472zsaroy@treble>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221102152814.lmuzib5472zsaroy@treble>
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

On 11/2/22 16:28, Josh Poimboeuf wrote:
> On Fri, Oct 28, 2022 at 07:07:22PM -0400, Paolo Bonzini wrote:
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -3918,10 +3918,21 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu)
>>   	struct vcpu_svm *svm = to_svm(vcpu);
>>   	unsigned long vmcb_pa = svm->current_vmcb->pa;
>>   
>> +	/*
>> +	 * For non-nested case:
>> +	 * If the L01 MSR bitmap does not intercept the MSR, then we need to
>> +	 * save it.
>> +	 *
>> +	 * For nested case:
>> +	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
>> +	 * save it.
>> +	 */
>> +	bool spec_ctrl_intercepted = msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL);
> 
> This triggers a warning:
> 
>    vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0x3d: call to svm_msrpm_offset() leaves .noinstr.text section
> 
> svm_vcpu_enter_exit() is noinstr, but it's calling
> msr_write_intercepted() which is not.

I suspect I didn't see it because it's inlined here, but it has to be 
fixed indeed.

> That's why in the VMX code I did the call to msr_write_intercepted() (in
> __vmx_vcpu_run_flags) before calling vmx_vcpu_enter_exit().

Yes, it's easy to do the same and do it in svm_vcpu_run().

Paolo

