Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88B740CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjF1J1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233974AbjF1JLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687943442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEZTSS72nBXuo6tyqd7R3vTKUEg46hujeqkE667SG0A=;
        b=HoAvKAVJFpkt54F/MNxHamA0770h4cFRXt9EOJluwk6E5pZEv7srx5eLtctyhIiiM+HLH+
        eubM9tuySwruQaTSJ3J/9dBKaajNYJJtO5PrDB85IPagsUedwI5wpXrFk4aduIeEhnN+nU
        QeoiTrK5qWcIBasOr9e9xd7I2fNl1Jw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Iz-pmGXcMYuiWg9X_j52xQ-1; Wed, 28 Jun 2023 05:10:37 -0400
X-MC-Unique: Iz-pmGXcMYuiWg9X_j52xQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbb0c01e71so2345725e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687943436; x=1690535436;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEZTSS72nBXuo6tyqd7R3vTKUEg46hujeqkE667SG0A=;
        b=ALiDn4AcN+hynJD1iTSii/fWWRSTfNUBg6werS/3pTU5ONYp9swkenAOScruDV8OQE
         7+4XkyuJeigeF0LXn1Ke9ND3wYZdfPHakEYRH4kkNsX5oA43tA/gF5oqYCOFMfy1GVZ1
         gUyGvpxQkBZ6wuWdjf5lfD4ooQvaizfbYrqRAFU8jy99zDXE0qo947kY4Kswje4BZoqE
         hhAcFerN3PWOSpEpXXr8KnsMmBZ6UTd5QXDSP0dUqUnIx4Zx3NZ7l04eePVyBJyQVr6W
         58MWyTFKxH4YnBhghszLqtJSpv34w5+kz/+Nt35/y/Xmz+NWVWwVItUCI/nuAjUqW1ai
         8Xqg==
X-Gm-Message-State: AC+VfDz9AHiE51aik9Ys22Brg8to15BxAH8yFBqlWy/CnTV7XhY9NNkH
        HlSxtIhAdifVRcLVNZV/BgfHObSBC01hqKZ9A8Ch4g5uyvwxoy9sE5A/MG/8nAjqLIDyBRGdNot
        w+X2NS01P3/BBxyJzerF5kOQg
X-Received: by 2002:adf:f04b:0:b0:313:eaf5:515 with SMTP id t11-20020adff04b000000b00313eaf50515mr6829735wro.6.1687943436273;
        Wed, 28 Jun 2023 02:10:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UBB7GR8KpUqgDdAhfCP6GxTArGnxnL40cjo4l/KoH9JXl9IFKHdvTs43l0xN4F6KQIp2YJA==
X-Received: by 2002:adf:f04b:0:b0:313:eaf5:515 with SMTP id t11-20020adff04b000000b00313eaf50515mr6829719wro.6.1687943435908;
        Wed, 28 Jun 2023 02:10:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ef00:fa40:f6df:a68d:a0e4? (p200300cbc715ef00fa40f6dfa68da0e4.dip0.t-ipconnect.de. [2003:cb:c715:ef00:fa40:f6df:a68d:a0e4])
        by smtp.gmail.com with ESMTPSA id t15-20020a0560001a4f00b00313f676832bsm6546696wry.93.2023.06.28.02.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 02:10:35 -0700 (PDT)
Message-ID: <cacb6af0-27a8-8dc4-39dc-fc3936ea54eb@redhat.com>
Date:   Wed, 28 Jun 2023 11:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: Keep memory type same on DEVMEM Page-Fault
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        "buddy.zhang" <buddy.zhang@biscuitos.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Venkatesh Pallipadi <venki@google.com>,
        Suresh Siddha <sbsiddha@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>
References: <20230319033750.475200-1-buddy.zhang@biscuitos.cn>
 <20230412142236.407d6d0e6d90232da004980e@linux-foundation.org>
 <20230416113944.c9b50a76a98b9e7c974cfac9@linux-foundation.org>
 <20230619131417.42d4e73d1b7669162ea44e29@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230619131417.42d4e73d1b7669162ea44e29@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.23 22:14, Andrew Morton wrote:
> On Sun, 16 Apr 2023 11:39:44 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> On Wed, 12 Apr 2023 14:22:36 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>>> On Sun, 19 Mar 2023 11:37:50 +0800 "buddy.zhang" <buddy.zhang@biscuitos.cn> wrote:
>>>
>>>> On X86 architecture, supports memory type on Page-table, such as
>>>> PTE is PAT/PCD/PWD, which can setup up Memory Type as WC/WB/WT/UC etc.
>>>> Then, Virtual address from userspace or kernel space can map to
>>>> same physical page, if each page table has different memory type,
>>>> then it's confused to have more memory type for same physical page.
>>>
>>> Thanks.  Nobody has worked on this code for a long time.  I'll cc a few
>>> folks who may be able to comment.
>>>
>>
>> Well that didn't go very well.
>>
>> Buddy, can you please explain what are the user-visible effects of the
>> bug?  Does the kernel crash?  Memory corruption, etc?  Thanks.
>>
> 
> Anyone?
> 

With a clear problem description, ad requested by you, I could be 
motivated to review this and understand the details :)

-- 
Cheers,

David / dhildenb

