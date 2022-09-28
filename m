Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF96A5EDE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiI1ODa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiI1OD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813D66C135
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664373805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3g42XETLWROK5vKG8OlaJRSjBZ46PuNDTUQkdxQffSI=;
        b=eTG+dKNN/MCoblv2vn/gUNueRSoBh6erp05wWlTCFEIS3C2jy+ye7+/oK+fRi8bHPTv6X2
        SVYiOWIfULZBCzDfaMkcYHVFuacuDY3WG7uiymBGyjDrWKPeCggIWmdZRXrptB+japEovM
        bxzUW5/6i3U4JR9p1ogbrXSWXC6HiHo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-t90ahPxMMV-0UXbAkWathA-1; Wed, 28 Sep 2022 10:03:23 -0400
X-MC-Unique: t90ahPxMMV-0UXbAkWathA-1
Received: by mail-wm1-f71.google.com with SMTP id e3-20020a05600c218300b003b4e4582006so605956wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=3g42XETLWROK5vKG8OlaJRSjBZ46PuNDTUQkdxQffSI=;
        b=aUisRFPhnS94DKV6yZ5bZ4DDcnfcfeY2cqmsJSPR198lNbZVL7TseYInldp73qBcNm
         m44sAWqajQKeZDsdibQqm/DG4HRzhTUHGDBRhwUy2O/DQUfmSIb+8Ktdt2X8mL2bYxnC
         UdA1cwjhGySm3AwwuW1b5FR0udhqb7b6OJNmIkuTkZmzIH9mxCSmu11PLK4hpCI8UZGe
         K4v2mxnDrBy2lb3R0kyC6dh6z2KNvQbQ8NOZKYHYzj4BVyVNTwbi9y3y2d+n4LPG72O6
         Z6LT3xkb2VHuPyeTZTC3VHAuNFl2FbYnk3bL5zFtLxWrEm+hrcbJhVwjsZBh8SCjXJE5
         fW1w==
X-Gm-Message-State: ACrzQf0gw62YhQdEbJIkLpuBaN4tiqvYs6bAe1G8IS90HCNBVW2bpwD3
        /k2kUfen+kTdJXrFdfjFYxStIY4dgI+YN92NGwG6Q9WAc1h/Cr+ZUfXX3IkcFWdQ1bSgnJ3X4ib
        48T13LQKn7OnzpHgsN0ohlmRh
X-Received: by 2002:a05:6000:1689:b0:22a:a66d:1f37 with SMTP id y9-20020a056000168900b0022aa66d1f37mr20953967wrd.197.1664373802199;
        Wed, 28 Sep 2022 07:03:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ELLQED00nR1Z+ZvxqEmG4byd8/bnKeeNrTnLv/m+ZE8ddVj32aihv7u5mlLSmhLo8aHoyjA==
X-Received: by 2002:a05:6000:1689:b0:22a:a66d:1f37 with SMTP id y9-20020a056000168900b0022aa66d1f37mr20953914wrd.197.1664373801781;
        Wed, 28 Sep 2022 07:03:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:1100:add9:5f61:6b94:7540? (p200300cbc7041100add95f616b947540.dip0.t-ipconnect.de. [2003:cb:c704:1100:add9:5f61:6b94:7540])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c069400b003a5fa79007fsm1744360wmn.7.2022.09.28.07.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:03:21 -0700 (PDT)
Message-ID: <c12f848d-cb54-2998-8650-2c2a5707932d@redhat.com>
Date:   Wed, 28 Sep 2022 16:03:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Chih-En Lin <shiyn.lin@gmail.com>, Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
 <YzNUwxU44mq+KnCm@strix-laptop>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
In-Reply-To: <YzNUwxU44mq+KnCm@strix-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.22 21:53, Chih-En Lin wrote:
> On Tue, Sep 27, 2022 at 06:38:05PM +0000, Nadav Amit wrote:
>> I only skimmed the patches that you sent. The last couple of patches seem a
>> bit rough and dirty, so I am sorry to say that I skipped them (too many
>> “TODO” and “XXX” for my taste).
>>
>> I am sure other will have better feedback than me. I understand there is a
>> tradeoff and that this mechanism is mostly for high performance
>> snapshotting/forking. It would be beneficial to see whether this mechanism
>> can somehow be combined with existing ones (mshare?).
> 
> Still thanks for your feedback. :)
> I'm looking at the PTE refcount and mshare patches. And, maybe it can
> combine with them in the future.
> 
>> The code itself can be improved. I found the reasoning about synchronization
>> and TLB flushes and synchronizations to be lacking, and the code to seem
>> potentially incorrect. Better comments would help, even if the code is
>> correct.
>>
>> There are additional general questions. For instance, when sharing a
>> page-table, do you properly update the refcount/mapcount of the mapped
>> pages? And are there any possible interactions with THP?
> 
> Since access to those mapped pages will cost a lot of time, and this
> will make fork() even have more overhead. It will not update the
> refcount/mapcount of the mapped pages.

Oh no.

So we'd have pages logically mapped into two processes (two page table 
structures), but the refcount/mapcount/PageAnonExclusive would not 
reflect that?

Honestly, I don't think it is upstream material in that hacky form. No, 
we don't need more COW CVEs or more COW over-complications that 
destabilize the whole system.

IMHO, a relaxed form that focuses on only the memory consumption 
reduction could *possibly* be accepted upstream if it's not too invasive 
or complex. During fork(), we'd do exactly what we used to do to PTEs 
(increment mapcount, refcount, trying to clear PageAnonExclusive, map 
the page R/O, duplicate swap entries; all while holding the page table 
lock), however, sharing the prepared page table with the child process 
using COW after we prepared it.

Any (most once we want to *optimize* rmap handling) modification 
attempts require breaking COW -- copying the page table for the faulting 
process. But at that point, the PTEs are already write-protected and 
properly accounted (refcount/mapcount/PageAnonExclusive).

Doing it that way might not require any questionable GUP hacks and 
swapping, MMU notifiers etc. "might just work as expected" because the 
accounting remains unchanged" -- we simply de-duplicate the page table 
itself we'd have after fork and any modification attempts simply replace 
the mapped copy.

But devil is in the detail (page table lock, TLB flushing).

"will make fork() even have more overhead" is not a good excuse for such 
complexity/hacks -- sure, it will make your benchmark results look 
better in comparison ;)

-- 
Thanks,

David / dhildenb

