Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED66F89F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjEEUBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEEUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2111B4C0F
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683316849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ukBlLJAAZaQ/r1CAoE/M1VTZFpBfXgEo6B4FhT6NEws=;
        b=bz1vUos3EgWOyj4Cb7qTJYnieDa3EJijoEU7xstJnnaOgqQonSUv5L/KTSffgM7WENpv/p
        ZG+quZLjun5qqoI9x4XAMcILSgRxNBCHHSp4pYW6rsQBhcNY4ThHdLivdS3iMgfQdvY4AP
        AYzXpcNWnX++stz4XuoNoV2AzSpXD58=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-7jzUMzZLMNqlcMBl0Kx-zA-1; Fri, 05 May 2023 16:00:48 -0400
X-MC-Unique: 7jzUMzZLMNqlcMBl0Kx-zA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f175a24fd1so12609405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 13:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683316847; x=1685908847;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukBlLJAAZaQ/r1CAoE/M1VTZFpBfXgEo6B4FhT6NEws=;
        b=ANH+9JT+/Mkm2K4muNBCh3B/7vdPM2QenJxXKKHyauf8ioqfhgF6wKduzUxD5EmF5T
         VkxQC0MF2k067dwpSsGS+/MNZ+9v03pMdPdnCoQ6MioRVmCsd6qJ+TULmt2Ns3CYrHmE
         GFVWwdnYsIWZmNsbe482oROeDitSF7NGtMvhxD+CzVuEKqEbp4tu7xRz8G8a8/Xov6tD
         e+ifywn1ho3+KpTqu3Fs6dlVG1NKqwES3a80+CQLh1m4TDIid10/t20ucvRIrmgm+ddw
         Zr6h98+Ue+JhOSYpLyh8gXx6iI+XOPjvalpcmCmerOId8HabR7bWoxWLMeS0bw9wJtnt
         /cEQ==
X-Gm-Message-State: AC+VfDzxX/Edng9ua0x3VPrnzsTv2pTmSx+xGqOl/zvWhpn2RPi4hf6+
        CcC1x6U79FZs7p5qfZz7XSM+KR/8yhpxoEGw8M9E5+x8RZtxUl9QruHsOTZbwtLjQjxw60snsgS
        0x2VKKam6zUYaFGhNmr4y1i1I
X-Received: by 2002:a7b:c8c3:0:b0:3f3:21f7:a3f5 with SMTP id f3-20020a7bc8c3000000b003f321f7a3f5mr1898751wml.34.1683316847032;
        Fri, 05 May 2023 13:00:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7AWMCmWZgMXJ3itkQkjvhLZgFXfiQcw67zZcDRqQM7ZUHVlWWfxUAlasyIVWHcBoHop640zA==
X-Received: by 2002:a7b:c8c3:0:b0:3f3:21f7:a3f5 with SMTP id f3-20020a7bc8c3000000b003f321f7a3f5mr1898726wml.34.1683316846698;
        Fri, 05 May 2023 13:00:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71f:6900:2b25:fc69:599e:3986? (p200300cbc71f69002b25fc69599e3986.dip0.t-ipconnect.de. [2003:cb:c71f:6900:2b25:fc69:599e:3986])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bcd17000000b003ee443bf0c7sm8738510wmj.16.2023.05.05.13.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 13:00:46 -0700 (PDT)
Message-ID: <6db68140-0612-a7a3-2cec-c583b2ed3a61@redhat.com>
Date:   Fri, 5 May 2023 22:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, Michael Roth <michael.roth@amd.com>,
        wei.w.wang@intel.com, Mike Rapoport <rppt@kernel.org>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <ZD1oevE8iHsi66T2@google.com>
 <658018f9-581c-7786-795a-85227c712be0@redhat.com>
 <CS465PQZS77J.J1RP6AJX1CWZ@suppilovahvero>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CS465PQZS77J.J1RP6AJX1CWZ@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.04.23 15:28, Jarkko Sakkinen wrote:
> On Mon Apr 17, 2023 at 6:48 PM EEST, David Hildenbrand wrote:
>> On 17.04.23 17:40, Sean Christopherson wrote:
>>> What do y'all think about renaming "restrictedmem" to "guardedmem"?
>>
>> Yeay, let's add more confusion :D
>>
>> If we're at renaming, I'd appreciate if we could find a terminology that
>> does look/sound less horrible.
>>
>>>
>>> I want to start referring to the code/patches by its syscall/implementation name
>>> instead of "UPM", as "UPM" is (a) very KVM centric, (b) refers to the broader effort
>>> and not just the non-KVM code, and (c) will likely be confusing for future reviewers
>>> since there's nothing in the code that mentions "UPM" in any way.
>>>
>>> But typing out restrictedmem is quite tedious, and git grep shows that "rmem" is
>>> already used to refer to "reserved memory".
>>>
>>> Renaming the syscall to "guardedmem"...
>>
>> restrictedmem, guardedmem, ... all fairly "suboptimal" if you'd ask me ...
> 
> In the world of TEE's and confidential computing it is fairly common to
> call memory areas enclaves, even outside SGX context. So in that sense
> enclave memory would be the most correct terminology.

I was also thinking along the lines of isolated_mem or imem ... 
essentially, isolated from (unprivileged) user space.

... if we still want to have a common syscall for it.

-- 
Thanks,

David / dhildenb

