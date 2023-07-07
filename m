Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13DF74B6E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjGGTIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjGGTIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F81426A0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688756813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paIBB7sUf/Zqn/4VcL295pzVpCyEKoMCoSkthIK/cDY=;
        b=jQ05UvU4OoIW3AEz0DucWBOUW8A0hS6NT+PgJGkEWp/TXOqa3OQpIPer+oqxg95rT3ifqI
        MEqwJg6fGmyBYbFrHguRiCkZfQkirbkYFzSPXA+XSozCed5npt01cb97Waw+hEFdVBJr1f
        30uiWhjT7x0jusUuOUmz2nGJ+l0Kx5k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-Lpjx4nWbPQOmL68F0cY1tA-1; Fri, 07 Jul 2023 15:06:52 -0400
X-MC-Unique: Lpjx4nWbPQOmL68F0cY1tA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa979d0c32so12643205e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 12:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688756811; x=1691348811;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paIBB7sUf/Zqn/4VcL295pzVpCyEKoMCoSkthIK/cDY=;
        b=hITDprYJD3OnqgLpu1jBSfNeEWpC2cqVuZ8kcCs8QAofL9uS0/RBP4ttAbUSeCLpSq
         UQkCXWYacaz3QIbSgGGsMSSiUe/sk3dbCPo1ibDNGVkXccHChrC4ECztcqTNplyxGk2B
         C3YICBzmxqDUJujErK6ME+X5dqiy0GsCrXubGdYMIOt/G0JchWxJkRCjhkcqAK7v6Plp
         B25f+4LpSA02mJ1eAUMeiCf+hNt/ddMcuAmeTBhIW4p2TQFy4uce1wNKJeIeGWOhW4t5
         YfoUfixldNkYI/cOUjR5ckvC0glB82fqsn7SAbZn6eS296RJtYNsBJM+3qcXMqjMrIh1
         vgHQ==
X-Gm-Message-State: ABy/qLZ9EHRxIq4aeFjrPmC74ueqzb2oOYDZJVHvOipUrB9UWW5fYTJ7
        l5PKUvkBefSuiensdqay4gFxQeBNZxaQBH9UjKFeSLi+cTi4B5O/xsCNKIr4P5hKHH55DUTVca8
        Z8GKaDfB+ItMSGpkMBbSBVQMp
X-Received: by 2002:a7b:c3d5:0:b0:3f6:91c:4e86 with SMTP id t21-20020a7bc3d5000000b003f6091c4e86mr4429232wmj.3.1688756811017;
        Fri, 07 Jul 2023 12:06:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZCPQ0FYZqAu9VBMOE7vXIKu8edRl0ks2ySLHo/6XMBlpctAYBJaE1EDQ7rgfWGU/ApHetcA==
X-Received: by 2002:a7b:c3d5:0:b0:3f6:91c:4e86 with SMTP id t21-20020a7bc3d5000000b003f6091c4e86mr4429208wmj.3.1688756810620;
        Fri, 07 Jul 2023 12:06:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id c26-20020a7bc01a000000b003f7f475c3bcsm10392928wmb.1.2023.07.07.12.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 12:06:49 -0700 (PDT)
Message-ID: <b1e7c52c-cc3a-92c8-e466-3ba5ec2ba2fb@redhat.com>
Date:   Fri, 7 Jul 2023 21:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <87edlkgnfa.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e60630-5e9d-c8df-ab79-cb0767de680e@arm.com>
 <524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com>
 <ZKgZrNuxuq4ACvIb@casper.infradead.org>
 <1e406f04-78ef-6573-e1f1-f0d0e0d5246a@redhat.com>
 <9dd036a8-9ba3-0cc4-b791-cb3178237728@arm.com>
 <a8fed7f8-d285-4628-da4b-0ff82c19c582@redhat.com>
 <c5eb896b-dbb4-396d-62f6-5d5dde2d7df6@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
In-Reply-To: <c5eb896b-dbb4-396d-62f6-5d5dde2d7df6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I still feel that it would be better for the thp and large anon folio controls
>>> to be independent though - what's the argument for tying them together?
>>
>> Thinking about desired 2 MiB flexible THP on aarch64 (64k kernel) vs, 2 MiB PMD
>> THP on aarch64 (4k kernel), how are they any different? Just the way they are
>> mapped ...
> 
> The last patch in the series shows my current approach to that:
> 
> int arch_wants_pte_order(struct vm_area_struct *vma)
> {
> 	if (hugepage_vma_check(vma, vma->vm_flags, false, true, true))
> 		return CONFIG_ARM64_PTE_ORDER_THP; <<< always the contpte size
> 	else
> 		return CONFIG_ARM64_PTE_ORDER_NOTHP; <<< limited to 64K
> }
> 
> But Yu has raised concerns that this type of policy needs to be in the core mm.
> So we could have the arch blindly return the preferred order from HW perspective
> (which would be contpte size for arm64). Then for !hugepage_vma_check(), mm
> could take the min of that value and some determined "acceptable" limit (which
> in my mind is 64K ;-).

Yeah, it's really tricky. Because why should arm64 with 64k base pages 
*not* return 2MiB (which is one possible cont-pte size IIRC) ?

I share the idea that 64k might *currently* on *some platforms* be a 
reasonable choice. But that's where the "fun" begins.

> 
>>
>> It's easy to say "64k vs. 2 MiB" is a difference and we want separate controls,
>> but how is "2MiB vs. 2 MiB" different?
>>
>> Having that said, I think we have to make up our mind how much control we want
>> to give user space. Again, the "2MiB vs. 2 MiB" case nicely shows that it's not
>> trivial: memory waste is a real issue on some systems where we limit THP to
>> madvise().
>>
>>
>> Just throwing it out for discussing:
>>
>> What about keeping the "all / madvise / never" semantics (and MADV_NOHUGEPAGE
>> ...) but having an additional config knob that specifies in which cases we
>> *still* allow flexible THP even though the system was configured for "madvise".
>>
>> I can't come up with a good name for that, but something like
>> "max_auto_size=64k" could be something reasonable to set. We could have an
>> arch+hw specific default.
> 
> Ahha, yes, that's essentially what I have above. I personally also like the idea
> of the limit being an absolute value rather than an order. Although I know Yu
> feels differently (see [1]).

Exposed to user space I think it should be a human-readable value. 
Inside the kernel, I don't particularly care.

(Having databases/VMs on arch64 with 64k in mind) I think it might be 
interesting to have something like the following:

thp=madvise
max_auto_size=64k/128k/256k


So in MADV_HUGEPAGE VMAs (such as under QEMU), we'd happily take any 
flexible THP, especially ones < PMD THP (512 MiB) as well. 2 MiB or 4 
MiB THP? sure, give them to my VM. You're barely going to find 512 MiB 
THP either way in practice ....

But for the remainder of my system, just do something reasonable and 
don't go crazy on the memory waste.


I'll try reading all the previous discussions next week.

-- 
Cheers,

David / dhildenb

