Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592C35EDBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiI1Ll6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiI1Lly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA10B31EF9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664365311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XC67SJ3XDTOlROMlv59qhDGypCtFKH7Px8QsqpEz0sM=;
        b=X/ymLqj7F/F7/rIEY+WABMDJdlbpXfMVQaoQ/G1N912mokHwp2ic+JY7QVIT5fQ/diW4iw
        X+dWUvW6QM5KghXHc6yv/3hsSgBmbEYk0N9WEHr87dTo5ZH+ppIF5EOp4JdmNsQd/eBzHl
        5k0Wo1UInLm0jpqrkTAdBPW7Z5yFxQY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-532-ZQR-6WHaMgm9yfUU2t4-Dw-1; Wed, 28 Sep 2022 07:41:50 -0400
X-MC-Unique: ZQR-6WHaMgm9yfUU2t4-Dw-1
Received: by mail-ej1-f72.google.com with SMTP id gv43-20020a1709072beb00b0077c3f58a03eso5253878ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XC67SJ3XDTOlROMlv59qhDGypCtFKH7Px8QsqpEz0sM=;
        b=FapI3bSlji2Vbw4BCw5WBOLK1OioWcfw3APTmTE8ugmDPWoQRHARrllmOzD1ZKf8zZ
         aES9lGy1CNHem1UVnydwZF4JJhtC1zEdqyZ9aAj5ovd0hlxyk+qCwBWuDpkypQWOkNkp
         ETUlOPzMNm231Mya6JDV6PZ24h0NAT9v3n2LnjzcVPoFgpUc1RhHLRvpi8HxTZnkM96g
         ZVYr2QOLddnY5IP3cdRaiIRjwRFJ827AbgmgvRj4SXJvo+i9cKrAy9YCMPQmMW8Z2yhh
         duhaVLc3qWiOYfBfYIlXZS67FYvh5jZH/r5fr32N5RZxqdOQ//2If7AIPGiQQ61ba22V
         57TA==
X-Gm-Message-State: ACrzQf37lWT9iUfa6bv8JdmTx8EnwFOwexeHROkpuzLasu9aiL93wyQi
        bAaoKYMGMJIgvVKS0mn2KIzopm8OiOrCBUA5eGa0kKgyY3wuZwFJxMGBZOP/ZLRKBaAoNVycwHP
        w1niETe0k3fFsr7PcfH3P69tO
X-Received: by 2002:a17:907:9807:b0:781:feee:f87c with SMTP id ji7-20020a170907980700b00781feeef87cmr27477176ejc.101.1664365309438;
        Wed, 28 Sep 2022 04:41:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68sNi9SdtuWqttYMynS5Szr9EoGEJaZpf4gaxO8d/kIpewfaCdOMKBYdCWPnt+ufOi8mpHlw==
X-Received: by 2002:a17:907:9807:b0:781:feee:f87c with SMTP id ji7-20020a170907980700b00781feeef87cmr27477157ejc.101.1664365309143;
        Wed, 28 Sep 2022 04:41:49 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id gh30-20020a1709073c1e00b0077a11b79b9bsm2236165ejc.133.2022.09.28.04.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:41:48 -0700 (PDT)
Message-ID: <f708d769-5d93-351f-ea24-8fa7deb9f689@redhat.com>
Date:   Wed, 28 Sep 2022 13:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220927152241.194900-1-pbonzini@redhat.com>
 <YzM55hqavzENQq7I@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: allow compiling out SMM support
In-Reply-To: <YzM55hqavzENQq7I@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 19:59, Sean Christopherson wrote:
>> 	The patch isn't pretty.  I could skip all the changes to add WARNs
>> 	to called functions, but the point of adding the config symbol is
>> 	to make sure that those functions, and all the baggage they bring,
>> 	are dead.
> 
> I would much rather we go even further and completely kill off those functions
> at compile time.

Ok, but then we should go all the way and move as much as possible to a 
separate file.  This also means moving the out-of-SMM flow away from the 
emulator, which in turn enables using ctxt only for the GPRs and not for 
ctxt->ops.

I have already done all that and it's quite a bit nicer; I'll send it 
once I've tested it with more than just smm_test.  I left a couple stubs 
behind where the balance seemed to be better that way (mostly for use in 
kvm_vcpu_ioctl_x86_set_vcpu_events), but most of the code is compiled out.

> There are side effects that should also be eliminated, e.g. x86 should not define
> __KVM_VCPU_MULTIPLE_ADDRESS_SPACE so that usersepace can't create memslots for
> SMM.  Dropping the functions entirely wrapping those #defines in #ifdef as well,
> and so makes it all but impossible for KVM to do anything SMM related.
> 
> Eliminating those at compile time requires a bit more #ifdeffery, but it's not
> awful, and IMO it's better than sprinkling WARNs in a bunch of paths.  KVM_REQ_SMI
> in particular might be going too far, but even for that one I vote to kill it.

Sounds good, though of course some of the various cleanups are best done 
in separate patches.

>>  static int kvm_vcpu_ioctl_smi(struct kvm_vcpu *vcpu)
>>  {
>> -	kvm_make_request(KVM_REQ_SMI, vcpu);
>> -
>> +	if (IS_ENABLED(CONFIG_KVM_SMM))
>> +		kvm_make_request(KVM_REQ_SMI, vcpu);
>>  	return 0;
> 
> This should return -EINVAL, not 0.

I'm a bit wary of changing this in case userspace is relying on it not 
failing, because the paths that lead to the failing ioctl are most 
likely controlled by the guest.

Paolo

