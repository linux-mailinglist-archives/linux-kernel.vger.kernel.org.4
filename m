Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A0D6658E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjAKKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbjAKKWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:22:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD98101C2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673432480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0QaWY+4kX8PIiqZugJgymPBdwuSR/W8TI1AJ/CveFo=;
        b=ULx6Dn616fw9vAyDltYByxvtpY+Ujd+bOE9Y1f7PHPLPEBYQ+v3r0db1FsXGM8Jpon2ZrV
        5ZO1NKdA1msnSZQQw+Dl39iBeTihQ5mLxrYM6kevofXfsYtHgDKTk3WsH/mAtcZEqsuCLc
        1MISAp8VhHz5YbIpNIgZlhOc7cCsWmU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-uwRf87ubO9S2cCbx8de8zg-1; Wed, 11 Jan 2023 05:21:19 -0500
X-MC-Unique: uwRf87ubO9S2cCbx8de8zg-1
Received: by mail-qt1-f200.google.com with SMTP id ez10-20020a05622a4c8a00b003ab6c16856fso7006524qtb.17
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0QaWY+4kX8PIiqZugJgymPBdwuSR/W8TI1AJ/CveFo=;
        b=qnUJDsEXe8+h/p96Ml4IiT/+V5hBo+LT8IRNWLn1EqWehSAPBhee/LVkqr+uRugL4i
         4g9v97oGhyNc+ay1v53PiB8A9ar8oPABEwgjqjIllQoBGnzyx8WY7JY3igQcc4Ns1JA5
         dxRTWtE/yYVv8aRp50dYjNnFNCWx9W3+JoMlwSgeTn4P5WhLBJpRvjbyzqsl0/BZsR3L
         hd/Vfrn3/Dfa0xpb/gDq6dpYUUWXepYzBzDkJj67iJAIIVwuiuGYJnOTRAq2yabi7K9h
         vQuYrxxsSWDC1Ast0zO5OBLhW0SOpgFUOwnEs437x6ivsZT6DMsGbYSfe8QTFOTlw2l/
         492Q==
X-Gm-Message-State: AFqh2krn2ixXTmxD69VavMRhcotO0O7VBfKYDK76zHt3HAYwngNw+K8V
        d1YQQUR0PsEEpr19ddnOy06bNlGEDu6mkTm+ZMKwDvgGURP9cl2ICky6djGlnMEnA1GW5EiDWOj
        d1duxxZOW8LoKY0ZKh0/P+xod
X-Received: by 2002:a0c:be86:0:b0:531:8d1d:e2bd with SMTP id n6-20020a0cbe86000000b005318d1de2bdmr69425336qvi.36.1673432479009;
        Wed, 11 Jan 2023 02:21:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsPSTlHSz+h7N20hM9PF9qyKm7b3kSiKDCN/TaPXx7r4sox3LpfNrU/l6rwV/0xtKx9rZTG+w==
X-Received: by 2002:a0c:be86:0:b0:531:8d1d:e2bd with SMTP id n6-20020a0cbe86000000b005318d1de2bdmr69425307qvi.36.1673432478748;
        Wed, 11 Jan 2023 02:21:18 -0800 (PST)
Received: from [192.168.0.2] (ip-109-43-176-91.web.vodafone.de. [109.43.176.91])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b00705e7daf6f0sm330609qkb.129.2023.01.11.02.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 02:21:18 -0800 (PST)
Message-ID: <32361afe-0f87-b8e1-6214-5a46da31000b@redhat.com>
Date:   Wed, 11 Jan 2023 11:21:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 01/10] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
 <20230110202632.2533978-2-scgl@linux.ibm.com>
 <d124764c-f221-98d8-a286-79efe176515c@redhat.com>
 <205f71e7ea88e7fb2e7bf1e013855b3ed0639150.camel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <205f71e7ea88e7fb2e7bf1e013855b3ed0639150.camel@linux.ibm.com>
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

On 11/01/2023 11.00, Janis Schoetterl-Glausch wrote:
> On Wed, 2023-01-11 at 08:59 +0100, Thomas Huth wrote:
>> On 10/01/2023 21.26, Janis Schoetterl-Glausch wrote:
>>> User space can use the MEM_OP ioctl to make storage key checked reads
>>> and writes to the guest, however, it has no way of performing atomic,
>>> key checked, accesses to the guest.
>>> Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
>>> mode. For now, support this mode for absolute accesses only.
>>>
>>> This mode can be use, for example, to set the device-state-change
>>> indicator and the adapter-local-summary indicator atomically.
>>>
>>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>>> ---
>>>    include/uapi/linux/kvm.h |   7 +++
>>>    arch/s390/kvm/gaccess.h  |   3 ++
>>>    arch/s390/kvm/gaccess.c  | 102 +++++++++++++++++++++++++++++++++++++++
>>>    arch/s390/kvm/kvm-s390.c |  41 +++++++++++++++-
>>>    4 files changed, 151 insertions(+), 2 deletions(-)
>>>
> [...]
> 
>>> +/**
>>> + * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute address.
>>> + * @kvm: Virtual machine instance.
>>> + * @gpa: Absolute guest address of the location to be changed.
>>> + * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
>>> + *       non power of two will result in failure.
>>> + * @old_addr: Pointer to old value. If the location at @gpa contains this value, the
>>> + *         exchange will succeed. After calling cmpxchg_guest_abs_with_key() *@old
>>> + *         contains the value at @gpa before the attempt to exchange the value.
>>> + * @new: The value to place at @gpa.
>>> + * @access_key: The access key to use for the guest access.
>>> + *
>>> + * Atomically exchange the value at @gpa by @new, if it contains *@old.
>>> + * Honors storage keys.
>>> + *
>>> + * Return: * 0: successful exchange
>>> + *         * 1: exchange unsuccessful
>>> + *         * a program interruption code indicating the reason cmpxchg could
>>> + *           not be attempted
>>
>> PGM_OPERATION has also the value 1 ... can we be sure that it never happens
>> here?
> 
> Currently yes, only program errors are those explicit in the code,
> PGM_ADDRESSING and PGM_PROTECTION.
> 
>> ... maybe it would make sense to use KVM_S390_MEMOP_R_NO_XCHG for
>> return value here instead of 1, too, just to be on the safe side?
> 
> I didn't like that idea because I consider KVM_S390_MEMOP_R_NO_XCHG to be
> part of the KVM's api surface and cmpxchg_guest_abs_with_key is an internal
> function that shouldn't concern itself with that.
> 
> But being unclear on PGM_OPERATION is indeed ugly.
> Maybe I should just replace "a program interruption code ..." with the specific ones?

Yes, that would help to avoid this confusion. With such a change feel free 
to add:
Reviewed-by: Thomas Huth <thuth@redhat.com>

