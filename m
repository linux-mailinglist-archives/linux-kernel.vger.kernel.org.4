Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0588260B37D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiJXRH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiJXRG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252F981111
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666626018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBAegUasNa5RuqJ7q9GZwuYTzFErEwMDb+Eg1mrTrvE=;
        b=GYNG67W+DA8GF/NETLzBpt9k4MMmo7LfXTfmJXuPE8CWlMO95uNL0xknFBE8FcZYdp3sZ0
        KlTgUJ6T8nXQ0c2ZoqsmqhuQljjTEN3vk9yvGEo/2R6yHZlpbmZ5cviPLlRWiPR9TcG6Aa
        TEYn2vhBBdgLAHSrCmQXcdkJuvi0z1M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-yPoM1ZQVN3qBiIehV9rDaw-1; Mon, 24 Oct 2022 11:26:39 -0400
X-MC-Unique: yPoM1ZQVN3qBiIehV9rDaw-1
Received: by mail-wm1-f72.google.com with SMTP id h129-20020a1c2187000000b003bf635eac31so4275986wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBAegUasNa5RuqJ7q9GZwuYTzFErEwMDb+Eg1mrTrvE=;
        b=mJJPiqgs9vraXtSSpiJKsYsGJhC3ZhPgpv9Ucr3ipOBMASyGUnGywEuVTyJa0dLvMT
         xDgCVfQIvmRkNVHGDjW/dqYgdtzY6Vl26e7ZsxAdy1QZU50iAfPNxD8Q3PBom6iGX9MB
         LpQxV3QrIatUI3IBLS6viFqiDoPc5bhoXXuk5KFnvkbeIMV6z3bPIlLsibtWo5AKhGxX
         0LgRuvgiCDDmNwPZJkkW8LUbGf7DyGyQfD6fuc1Ki8vmFsMKqkjad6SgoMWvT70/AO/W
         CJGTlSidik10UYeddY+fx+EM4oqUjncKw75wHa0I5D/jIVzXCSoEwMeRgZ/o8dJdNbXg
         3tkA==
X-Gm-Message-State: ACrzQf0Xz5mQi2/lDyEyN+HUKaobGZwQUAWzwxJE7wmhAJ3rYlj+lXvK
        YhhSE2LhIBBzl0D2UzZulx5uNX0Q7gQnt1vPuPKkx600aewz3GNEvGgLMSBCRt/uyDJy+kbef+q
        rtJ9etN5fPU0B8a72R3mYwzkx
X-Received: by 2002:a5d:5a11:0:b0:22e:3ed1:e426 with SMTP id bq17-20020a5d5a11000000b0022e3ed1e426mr21883714wrb.642.1666625197887;
        Mon, 24 Oct 2022 08:26:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4QYF0qpu+Yh4YQF+Y42ukyfMe46omRnCHz7TFmRMmq2+h+eVJ2IzD1faJk9A3cMFb5eNTxMw==
X-Received: by 2002:a5d:5a11:0:b0:22e:3ed1:e426 with SMTP id bq17-20020a5d5a11000000b0022e3ed1e426mr21883650wrb.642.1666625197580;
        Mon, 24 Oct 2022 08:26:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:f100:6371:a05b:e038:ac2c? (p200300cbc704f1006371a05be038ac2c.dip0.t-ipconnect.de. [2003:cb:c704:f100:6371:a05b:e038:ac2c])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c0b5500b003cdf141f363sm194606wmr.11.2022.10.24.08.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 08:26:37 -0700 (PDT)
Message-ID: <e0371b20-0edf-0fc3-71db-e0c94bd0f290@redhat.com>
Date:   Mon, 24 Oct 2022 17:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Content-Language: en-US
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <CAGtprH_MiCxT2xSxD2UrM4M+ghL0V=XEZzEX4Fo5wQKV4fAL4w@mail.gmail.com>
 <20221021134711.GA3607894@chaop.bj.intel.com> <Y1LGRvVaWwHS+Zna@google.com>
 <20221024145928.66uehsokp7bpa2st@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221024145928.66uehsokp7bpa2st@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.10.22 16:59, Kirill A . Shutemov wrote:
> On Fri, Oct 21, 2022 at 04:18:14PM +0000, Sean Christopherson wrote:
>> On Fri, Oct 21, 2022, Chao Peng wrote:
>>>>
>>>> In the context of userspace inaccessible memfd, what would be a
>>>> suggested way to enforce NUMA memory policy for physical memory
>>>> allocation? mbind[1] won't work here in absence of virtual address
>>>> range.
>>>
>>> How about set_mempolicy():
>>> https://www.man7.org/linux/man-pages/man2/set_mempolicy.2.html
>>
>> Andy Lutomirski brought this up in an off-list discussion way back when the whole
>> private-fd thing was first being proposed.
>>
>>    : The current Linux NUMA APIs (mbind, move_pages) work on virtual addresses.  If
>>    : we want to support them for TDX private memory, we either need TDX private
>>    : memory to have an HVA or we need file-based equivalents. Arguably we should add
>>    : fmove_pages and fbind syscalls anyway, since the current API is quite awkward
>>    : even for tools like numactl.
> 
> Yeah, we definitely have gaps in API wrt NUMA, but I don't think it be
> addressed in the initial submission.
> 
> BTW, it is not regression comparing to old KVM slots, if the memory is
> backed by memfd or other file:
> 
> MBIND(2)
>         The  specified policy will be ignored for any MAP_SHARED mappings in the
>         specified memory range.  Rather the pages will be allocated according to
>         the  memory  policy  of the thread that caused the page to be allocated.
>         Again, this may not be the thread that called mbind().

IIRC, that documentation is imprecise/incorrect especially when it comes 
to memfd. Page faults in shared mappings will similarly obey the set 
mbind() policy when allocating new pages.

QEMU relies on that.

The "fun" begins when we have multiple mappings, and only some have a 
policy set ... or if we already, previously allocated the pages.

-- 
Thanks,

David / dhildenb

