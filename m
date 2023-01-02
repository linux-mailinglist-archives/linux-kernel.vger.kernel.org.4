Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A53F65B213
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjABMae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjABMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409625C3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672662582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SsQgSClMPCuWXDoBAs08rfcVfM2ikXYgEDtEpVkmjqs=;
        b=PsuNdicKWG9b/mCCc0QDAO+CLdvr14zEP1SkEURQTSytIV7N1SpKHh3eqAp5AIgSu4QUmU
        XXWm5cx74OuFfJG592RrzT9OB6/Que8dcOiVcBgtnicTI2F1Lu3BQm/Z2WYasesrVYBHkf
        DNe73FDZv/mcOiQRuTFNvxL3zP5GKwo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-uryQ8AkDNyCd-0peVaOUbA-1; Mon, 02 Jan 2023 07:29:40 -0500
X-MC-Unique: uryQ8AkDNyCd-0peVaOUbA-1
Received: by mail-wr1-f72.google.com with SMTP id r10-20020adfa14a000000b0025ba73dff40so3172631wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsQgSClMPCuWXDoBAs08rfcVfM2ikXYgEDtEpVkmjqs=;
        b=yGqKeBsl38zKhYFcQCtVSd3HMHeIf9zJfEzjDGtUCg+KBF3y+WFTMJevltWF9xfVG8
         6JZR4Mfud7EhDcUK1/yos4fmg5Km1xaUqqt7Me3ERzN4daNZ+M+JGvCXGqBdAo0hzqYU
         MTjRPFwOfTZXHCo7r8NhebIHF/rvR7GiGknAVYLde2ucMmDqMNegi/cgnmozXB5o8v7s
         5Lhc/wKiSy6DdoQiMLgfTPWIyf+vWBlLP66D50vCoj32DrzHAPwAn9tuzzL2e7dVNF+G
         1KRZ6XW7jWuLz2+EmGozjNpXxET19ideSZaxeDLkltDgm65hnKlWTTtAORjsJ+5MFaIY
         Q3Ow==
X-Gm-Message-State: AFqh2kocSISsEOY0eZSPSApH7jYKTr1dDEoLVnlvOamGAQXvm1CmZYZB
        yIvWt93XeMFihFdbSe7p1mpdx/n104onZgAbNO99syje1AwCpEJ9X2eCTWuDc6u1kSi4Is+l8v+
        pzopG70p9Ic+6MKsIb4zH1k1e
X-Received: by 2002:a5d:4244:0:b0:268:d5af:66dc with SMTP id s4-20020a5d4244000000b00268d5af66dcmr24978219wrr.68.1672662579427;
        Mon, 02 Jan 2023 04:29:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu+tTkmy+8dDuXq3ZCkiQC/4wDsyInMKvU7jFQ8qpCPA3OEuu8gZfGHnTqc0LbQHeZkuaJfOg==
X-Received: by 2002:a5d:4244:0:b0:268:d5af:66dc with SMTP id s4-20020a5d4244000000b00268d5af66dcmr24978202wrr.68.1672662579114;
        Mon, 02 Jan 2023 04:29:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d42d2000000b00288a3fd9248sm14298080wrr.91.2023.01.02.04.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 04:29:38 -0800 (PST)
Message-ID: <57f7576b-542b-6ec0-fc5b-5a8c3bed5868@redhat.com>
Date:   Mon, 2 Jan 2023 13:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel@collabora.com, Peter Xu <peterx@redhat.com>,
        Paul Gofman <pgofman@codeweavers.com>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-2-peterx@redhat.com>
 <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com> <Y3gRy8pUiYWFGqcI@x1n>
 <a9984aa6-41bc-17c3-b564-87b997c0f2d0@collabora.com> <Y3vq18eTOE0e7I1+@x1n>
 <e3c26b56-5458-eb25-c753-fc4c058ba1b1@collabora.com>
 <40cc5f89-fa10-e107-671e-84bdcf7a4430@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
In-Reply-To: <40cc5f89-fa10-e107-671e-84bdcf7a4430@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.12.22 15:14, Muhammad Usama Anjum wrote:
> On 12/19/22 5:19 PM, Muhammad Usama Anjum wrote:
>> Addition of vma_soft_dirty_enabled() has tinkered with the soft-dirty PTE
>> bit status setting. The internal behavior has changed. The test case was
>> shared by David
>> (https://lore.kernel.org/all/bfcae708-db21-04b4-0bbe-712badd03071@redhat.com/).
>> The explanation is as following:
>>
>> _Before_ addition of this patch(76aefad628aae),
>> m = mmap(2 pages)
>> clear_softdirty()
>> mremap(m + pag_size)
>> mprotect(READ)
>> mprotect(READ | WRITE);
>> memset(m)
>> After memset(),
>> 			PAGE-1		PAGE-2
>> VM_SOFTDIRTY		set		set
>> PTE softdirty flag	set		set
>> /proc//pagemap view	set		set
>>
>>
>> _After_ addition of this patch(76aefad628aae)
>> m = mmap(2 pages)
>> clear_softdirty()
>> mremap(m + page_size)
>> mprotect(READ)
>> mprotect(READ | WRITE);
>> memset(m)
>> After memset(),
>> 			PAGE-1		PAGE-2
>> VM_SOFTDIRTY		set		set
>> PTE softdirty flag	*not set*	set
>> /proc//pagemap view	set		set
>>
>> The user's point of view hasn't changed. But internally after this patch,
>> the soft-dirty tracking in PTEs gets turn off if VM_SOFTDIRTY is set. The
>> soft-dirty tracking in the PTEs shouldn't be just turned off when mprotect
>> is used. Why? Because soft-dirty tracking in the PTEs is always enabled
>> regardless of VM_SOFTDIRTY is set or not. Example:
>>
>> m = mem(2 pages)
>> At this point:
>> 			PAGE-1		PAGE-2
>> VM_SOFTDIRTY		set		set
>> PTE softdirty flag	not set		not set
>> /proc//pagemap view	set		set
>> memset(m)
>> At this point:
>> 			PAGE-1		PAGE-2
>> VM_SOFTDIRTY		set		set
>> PTE softdirty flag	set		set
>> /proc//pagemap view	set		set
>>
>> This example proves that soft-dirty flag on the PTE is set regardless of
>> the VM_SOFTDIRTY.
> 
> Hi Andrew and Cyrill,
> 
> Peter doesn't agree with me here that this change in behavior should be
> reverted etc. Please comment.

For the records, I agree with Peter: As 76aefad628aa ("mm/mprotect: fix 
soft-dirty check in can_change_pte_writable()") documents, this patch 
fixed real problems.

/proc/pagemap works as expected right now such that we don't have an 
under-indication. Internal representation is an implementation detail.

Whatever we do, there must not be an under-indication of softdirty. That 
is the ABI guaranteed (especially for anonymous memory). "No 
over-indication" was never the ABI guarantee.

For your use case, you want to reduce over-indication. I suggested 
looked into alternatives.

-- 
Thanks,

David / dhildenb

