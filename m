Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743E164C796
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiLNLAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiLNLAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:00:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CA91DDDF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 02:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671015580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+HlVbpIO8Te0sbGMri/YTfV3Faqo0WekfaQjrNCjXM=;
        b=EG/F9OuRwM2ppk8oFiY+S55Ten6oRI6VcAOGB5JM5bZsbpAZcJUFdNCWyiKTRqLpCUsjwS
        6ODzjL8rzv94HKqWnQdOvrIVHA1cKyNoW88eHHK+J9z/JawKnL6mHDRAL4vGLDEvsTF/i8
        8V8R86JOXYSs3lrjLUer1TUjikYcsfo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-350-zP4XRvLbMniDDzTn-1SDiA-1; Wed, 14 Dec 2022 05:59:38 -0500
X-MC-Unique: zP4XRvLbMniDDzTn-1SDiA-1
Received: by mail-wm1-f72.google.com with SMTP id 9-20020a1c0209000000b003d1c0a147f6so7054136wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 02:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+HlVbpIO8Te0sbGMri/YTfV3Faqo0WekfaQjrNCjXM=;
        b=c7NdSgZQyFnIntoIIzZ54hRfKMPDrJhqD6JBOYUNZRwCi22fXxGFLlor1MYbKYfdjA
         evP+l3T+W+0m1TLFTIv3Ti3KnDmDT3kTkl0j4rKY+qBGwsjuDBgm3PMWVhgs9Wve1g/T
         oR5ylAU5HbClZ4QGd9L8t+XfDuqCTkIyxpMNrMWQ+r4mhjBu3xWGI1oHXcAlFVPqwvfa
         GPsbnj+OYZkhTikbv9Ra2kj0RKDePrfAOkklz5Qcrwv5iZmn25+4Qft/VXxng7T4Xgsm
         75U4y9f0wLH6dliVB3vLB2TaNmDllWxoy3q3th/QuWQBmrO9IXfIXG/BOUbwC8QnPeAO
         79UA==
X-Gm-Message-State: ANoB5pl0E8PoVfhOoRArwAwGpcbYfI2YOn0ykVbChQqNKgcHP1fn3qaj
        BIOqG+SFVGSTmBAI4MwqY4hvIhxVFg1nDYC+zTmWK8EiyspLzs62JKSbZg7sFSuxfOi54yqzmEc
        amdeGoIyMWKyQaSVnMBav3agU
X-Received: by 2002:adf:e7c3:0:b0:242:eb5:254f with SMTP id e3-20020adfe7c3000000b002420eb5254fmr16627817wrn.48.1671015577565;
        Wed, 14 Dec 2022 02:59:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4wb5ut4amZ+rSu0sdNHb6RbhZiqPSJyrln8tMZoaZEtKy7rmsy7KhY5jMcuxRnkRr7ab+fcg==
X-Received: by 2002:adf:e7c3:0:b0:242:eb5:254f with SMTP id e3-20020adfe7c3000000b002420eb5254fmr16627801wrn.48.1671015577263;
        Wed, 14 Dec 2022 02:59:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7700:dd7c:92f8:481f:b96b? (p200300cbc7037700dd7c92f8481fb96b.dip0.t-ipconnect.de. [2003:cb:c703:7700:dd7c:92f8:481f:b96b])
        by smtp.gmail.com with ESMTPSA id g17-20020a7bc4d1000000b003cf6e1df4a8sm2016994wmk.15.2022.12.14.02.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 02:59:36 -0800 (PST)
Message-ID: <e679d3fe-be8e-d7c0-798a-df32587553ed@redhat.com>
Date:   Wed, 14 Dec 2022 11:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm/uffd: Always wr-protect pte in pte|pmd_mkuffd_wp()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221208194628.766316-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221208194628.766316-1-peterx@redhat.com>
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

On 08.12.22 20:46, Peter Xu wrote:
> This patch is a cleanup to always wr-protect pte/pmd in mkuffd_wp paths.
> 
> The reasons I still think this patch is worthwhile, are:
> 
>    (1) It is a cleanup already; diffstat tells.
> 
>    (2) It just feels natural after I thought about this, if the pte is uffd
>        protected, let's remove the write bit no matter what it was.
> 
>    (2) Since x86 is the only arch that supports uffd-wp, it also redefines
>        pte|pmd_mkuffd_wp() in that it should always contain removals of
>        write bits.  It means any future arch that want to implement uffd-wp
>        should naturally follow this rule too.  It's good to make it a
>        default, even if with vm_page_prot changes on VM_UFFD_WP.
> 
>    (3) It covers more than vm_page_prot.  So no chance of any potential
>        future "accident" (like pte_mkdirty() sparc64 or loongarch, even
>        though it just got its pte_mkdirty fixed <1 month ago).  It'll be
>        fairly clear when reading the code too that we don't worry anything
>        before a pte_mkuffd_wp() on uncertainty of the write bit.

Don't necessarily agree with (3). If you'd have a broken pte_mkdirty() 
and do the pte_mkdirty() after pte_mkuffd_wp() it would still be broken. 
Because sparc64 and loongarch are simply broken.

> 
> We may call pte_wrprotect() one more time in some paths (e.g. thp split),
> but that should be fully local bitop instruction so the overhead should be
> negligible.
> 
> Although this patch should logically also fix all the known issues on
> uffd-wp too recently on either page migration or numa balancing, but this
> is not the plan for that fix.  So no fixes, and stable doesn't need this.

I don't see how this would fix do_numa_page(), where we only do a 
pte_modify().

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> Note: this patch should be able to apply cleanly with/without the other
> mm/migrate patch, or David's vm_page_prot changes.
> ---
>   arch/x86/include/asm/pgtable.h | 24 ++++++++++++------------
>   include/asm-generic/hugetlb.h  | 16 ++++++++--------
>   mm/huge_memory.c               |  8 +++-----
>   mm/hugetlb.c                   |  4 ++--
>   mm/memory.c                    |  8 +++-----
>   mm/mprotect.c                  |  6 ++----
>   mm/userfaultfd.c               | 18 ++----------------
>   7 files changed, 32 insertions(+), 52 deletions(-)

It's certainly a cleanup, even though we might unnecessarily wrprotect 
(I don't think we care).

-- 
Thanks,

David / dhildenb

