Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618165BBEE5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIRQNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 12:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIRQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 12:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8BB193D3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663517618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+8agvNBGUyGIAQ5pKg2At+vWnr16zzpuv2mjJP9dWI=;
        b=bqMP8z8ERcqsYA8pbpK6VX3dN55l6Lgh/IDUyFlxKFyfHHTQISVfeOpadlJNs99lNuj1XH
        XWhTTGrM0ck3PNclCUbcqzrjXjBhzkxe0P3MoeHfDd9qTbD44liFiQNC5iERPiw6AhBy8A
        84FAAN7llLFjDdJHZkhxsIKZhE9qFdU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-192-C1PW2bUINj-R8aCq4rMZ8A-1; Sun, 18 Sep 2022 12:13:37 -0400
X-MC-Unique: C1PW2bUINj-R8aCq4rMZ8A-1
Received: by mail-qv1-f69.google.com with SMTP id y16-20020a0cec10000000b004a5df9e16c6so17906526qvo.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 09:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Y+8agvNBGUyGIAQ5pKg2At+vWnr16zzpuv2mjJP9dWI=;
        b=hWjMpWTBhnNE9Q/zxgBcTcskDOlnR8HLGeXGuGZbQwVOjTeT96vsErZpoiK+JcXnvE
         WCpNdXKNmXxVsubYHGJDEwHrjOYvjFyGrfYUTcphdFvcoytsj6YF5rIF8WBWvFD8DewK
         ULjyaxPKCSDVN94lRiuKlCsTMgia3WeUngI+uBJxv7EwjhG3r0bIcPSpO204ze5ah7yt
         3FrM18sPhHFW5Eeo9IfUNP721M1pEg1CheC1ad7sFZ+piWZrpIwrXVS9hqPKy4nMiZv6
         NT2TxehXzZj9xBED/opPk5rnL1OgFuS6S25VZtmS8rku1C04bU3iPLScXBr0dwKMqTAn
         f64Q==
X-Gm-Message-State: ACrzQf3Rh6y0Retwco/qCDrEs9Y+4J/pt8kyuuDGGqyu8Am2gdnl6Xx/
        xam5f6/tFkjDo8exPCBNaYxtyAWGTDFK8nM95v3U6RUnFivdJNmSTKSjb9DBL+2XN2bt0GWq8j9
        DQmuYQOiTvZJa6ef0BQLIYobo
X-Received: by 2002:a05:622a:1484:b0:35c:db7a:1699 with SMTP id t4-20020a05622a148400b0035cdb7a1699mr6235416qtx.555.1663517617042;
        Sun, 18 Sep 2022 09:13:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7kyh4KRdjnIbqm4q/+cp4TkJc5By0D9c8Em/cv9lQoWU2Xxze9PuD30wUYDvtZt8f/vSYfRQ==
X-Received: by 2002:a05:622a:1484:b0:35c:db7a:1699 with SMTP id t4-20020a05622a148400b0035cdb7a1699mr6235395qtx.555.1663517616816;
        Sun, 18 Sep 2022 09:13:36 -0700 (PDT)
Received: from ?IPV6:2a04:ee41:4:31cb:e591:1e1e:abde:a8f1? ([2a04:ee41:4:31cb:e591:1e1e:abde:a8f1])
        by smtp.gmail.com with ESMTPSA id w14-20020ac84d0e000000b003436103df40sm8762874qtv.8.2022.09.18.09.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 09:13:36 -0700 (PDT)
Message-ID: <5f0345d2-d4d1-f4fe-86ba-6e22561cb6bd@redhat.com>
Date:   Sun, 18 Sep 2022 18:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 0/9] kvm: implement atomic memslot updates
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20220909104506.738478-1-eesposit@redhat.com>
 <YxtOEgJhe4EcAJsE@google.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <YxtOEgJhe4EcAJsE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 09/09/2022 um 16:30 schrieb Sean Christopherson:
> On Fri, Sep 09, 2022, Emanuele Giuseppe Esposito wrote:
>> KVM is currently capable of receiving a single memslot update through
>> the KVM_SET_USER_MEMORY_REGION ioctl.
>> The problem arises when we want to atomically perform multiple updates,
>> so that readers of memslot active list avoid seeing incomplete states.
>>
>> For example, in RHBZ https://bugzilla.redhat.com/show_bug.cgi?id=1979276
> 
> I don't have access.  Can you provide a TL;DR?

You should be able to have access to it now.

> 
>> we see how non atomic updates cause boot failure, because vcpus
>> will se a partial update (old memslot delete, new one not yet created)
>> and will crash.
> 
> Why not simply pause vCPUs in this scenario?  This is an awful lot of a complexity
> to take on for something that appears to be solvable in userspace. 
> 

I think it is not that easy to solve in userspace: see
https://lore.kernel.org/qemu-devel/20200312161217.3590-1-david@redhat.com/


"Using pause_all_vcpus()/resume_all_vcpus() is not possible, as it will
temporarily drop the BQL - something most callers can't handle (esp.
when called from vcpu context e.g., in virtio code)."

Probably @Paolo and @Maxim can add more to this.

Thank you,
Emanuele

