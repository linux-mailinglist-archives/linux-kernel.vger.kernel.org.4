Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52598622667
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKIJMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKIJLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:11:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E972250E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667984995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gp1nu7gDdjQPLi62onKx+VMmcKi4JmumYYSuGwj42UE=;
        b=LdKLA2FXVctRvtCIUpblRGgkMXDjXdhza9IWOay45pNMe6IIf/Pcj3t0YDKUxeU4DEr7tB
        xc8+6wEmU9Zdwp3G+YdCfM8ibk7AMBe5iaEI/cHyik9k8vk9GwbSL2ZPaKneI3Bt5jR49w
        GLFdHP2CwhByfhUvfQEIXeNeFDeRFL8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-416-qBgfqMkiMPGqHDUuUI_RdA-1; Wed, 09 Nov 2022 04:09:54 -0500
X-MC-Unique: qBgfqMkiMPGqHDUuUI_RdA-1
Received: by mail-wm1-f69.google.com with SMTP id e8-20020a05600c218800b003cf634f5280so339133wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gp1nu7gDdjQPLi62onKx+VMmcKi4JmumYYSuGwj42UE=;
        b=zO9Da81HJeqo0777FH7B/cBwpQhcTf9s63JIQGGaVaS8mxkLva9ju4a3vMC0RZ+mhL
         N6ZaFWG4XK17HZ1z84OyKzNiRZp81eRUdo5HDvWyYHnktWK9iqQK5HDSkrQG29GMz9s9
         /tIOup9xHIYX1P0XYrBzWhe/apVIZwxZxAYUIldyqPJnbGSes+eReEfCPiys9xSdXyeo
         J3mb7drpmpw6/Tq0eQD4RFiCceZuQpjETbDG2+Pf81vXkUcbGIaCdTqcyX5RLwv+6Xrr
         skI+wwCgh4iCMWIiboyDVeBkd1nNPukKwwbJmwmhYUfdDnRBqCwvw2JSvnBj05LNbiA9
         S7iw==
X-Gm-Message-State: ACrzQf0SMadp3kykKIB1M6PLLi6A/tZwLXCxbD6S5uNY9CUwDYk7Ns72
        FgBvpRCggh+7Ic55lnFIyEeCM/ll2S79SdGb1Lri0E10kC5laLY9yvP5u3TdNtYuaM6Ni1IRQxd
        bOxCINfWO8vJJqDc6mjd4IE21
X-Received: by 2002:a05:6000:16c8:b0:236:c60d:22b9 with SMTP id h8-20020a05600016c800b00236c60d22b9mr34218723wrf.526.1667984992779;
        Wed, 09 Nov 2022 01:09:52 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5b4W/+KStIQIEd31Opg71eedm54oI8YXOA25VraYMWJIMF7jYyeAE5P55LvkdaxbispEfo6g==
X-Received: by 2002:a05:6000:16c8:b0:236:c60d:22b9 with SMTP id h8-20020a05600016c800b00236c60d22b9mr34218703wrf.526.1667984992514;
        Wed, 09 Nov 2022 01:09:52 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id n19-20020a05600c3b9300b003b4c979e6bcsm1014454wms.10.2022.11.09.01.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:09:51 -0800 (PST)
Message-ID: <7ba6da25-9ce4-f146-8480-c2614154fbb4@redhat.com>
Date:   Wed, 9 Nov 2022 10:09:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 4/8] KVM: SVM: retrieve VMCB from assembly
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        nathan@kernel.org, thomas.lendacky@amd.com,
        andrew.cooper3@citrix.com, peterz@infradead.org,
        jmattson@google.com, stable@vger.kernel.org
References: <20221108151532.1377783-1-pbonzini@redhat.com>
 <20221108151532.1377783-5-pbonzini@redhat.com> <Y2r6FqZyT4XxUkYB@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y2r6FqZyT4XxUkYB@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 01:53, Sean Christopherson wrote:
> On Tue, Nov 08, 2022, Paolo Bonzini wrote:
>> This is needed in order to keep the number of arguments to 3 or less,
>> after adding hsave_pa and spec_ctrl_intercepted.  32-bit builds only
>> support passing three arguments in registers, fortunately all other
>> data is reachable from the vcpu_svm struct.
> 
> Is it actually a problem if parameters are passed on the stack?  The assembly
> code mostly creates a stack frame, i.e. %ebp can be used to pull values off the
> stack.

It's not, but given how little love 32-bit KVM receives, I prefer to 
stick to the subset of the ABI that is "equivalent" to 64-bit.

> no one cares about 32-bit and I highly doubt a few extra PUSH+POP
> instructions will  be noticeable.

Same reasoning (no one cares about 32-bits), different conclusions...

>> What fields are actually used is (like with any other function)
>> "potentially all, you'll have to read the source code and in fact you
>> can just read asm-offsets.c instead".  What I mean is, I cannot offhand
>> see or remember what fields are touched by svm_prepare_switch_to_guest,
>> why would __svm_vcpu_run be any different?
> 
> It's different because if it were a normal C function, it would simply take
> @vcpu, and maybe @spec_ctrl_intercepted to shave cycles after CLGI.

Not just for that, but especially to avoid making 
msr_write_intercepted() noinstr.

> But because
> it's assembly and doesn't have to_svm() readily available (among other restrictions),
> __svm_vcpu_run() ends up taking a mishmash of parameters, which for me makes it
> rather difficult to understand what to expect.

Yeah, there could be three reasons to have parameters in assembly:

* you just need them (@svm)

* it's too much of a pain to compute it in assembly 
(@spec_ctrl_intercepted, @hsave_pa)

* it needs to be computed outside the clgi/stgi region (not happening 
here, only mentioned for completeness)

As this patch shows, @vmcb is not much of a pain to compute in assembly: 
it is just two instructions, and not passing it in simplifies register 
allocation (the weird push/pop goes away) because all the arguments 
except @svm/_ASM_ARG1 are needed only after vmexit.

> Oooh, and after much staring I realized that the address of the host save area
> is passed in because grabbing it after VM-Exit can't work.  That's subtle, and
> passing it in isn't strictly necessary; there's no reason the assembly code can't
> grab it and stash it on the stack.

Right, in fact that's not the reason why it's passed in---it's just to 
avoid coding page_to_pfn() in assembly, and to limit the differences 
between the regular and SEV-ES cases.  But using a per-CPU variable is 
fine (either in addition to the struct page, which "wastes" 8 bytes per 
CPU, or as a replacement).

> What about killing a few birds with one stone?  Move the host save area PA to
> its own per-CPU variable, and then grab that from assembly as well.

I would still place it in struct svm_cpu_data itself, I'll see how it 
looks and possibly post v3.

Paolo

