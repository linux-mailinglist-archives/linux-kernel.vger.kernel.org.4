Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D195652DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiLUITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiLUISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:18:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12721814
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:17:56 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.25.143])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8AA736602CB6;
        Wed, 21 Dec 2022 08:17:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671610675;
        bh=9v9PWqa/qTx5cLrzTGi9/aiXNRHSQhPIhrxa12rDPXI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=L61GocnZyLdobxoaWkciTAuhJH5ImCZENucuu+fNdyuyCe+eiW+4PQcoGIyv3iZCc
         3yiI6L8GEp1oau1i88ADFY0KeZLFuwePQYuysPcuQUnFpSIV9AOImhTrHkobJup9G2
         tRyvJygfN6aviuv4qKdoaCcp27SNBwOghUcqX2H64Be20PJ61paGkfClWr9/P+G0A5
         jrKF1NQGaV5CvJVXja0srpmzVof5IES0DQpv75d7CFIqjqANane+70rb2czQigxT50
         F+GeE59qLaABLWMjYa6lYBCq6CRFbvDxWVszsmXu2kRh0EcxUvDJFAFtOQxI7o90xJ
         jitCL7owd04BQ==
Message-ID: <0d0e370c-04bd-aca4-ecb9-e50c06022183@collabora.com>
Date:   Wed, 21 Dec 2022 13:17:47 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel@collabora.com
Subject: Re: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
To:     Peter Xu <peterx@redhat.com>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-2-peterx@redhat.com>
 <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com> <Y3gRy8pUiYWFGqcI@x1n>
 <a9984aa6-41bc-17c3-b564-87b997c0f2d0@collabora.com> <Y3vq18eTOE0e7I1+@x1n>
 <e3c26b56-5458-eb25-c753-fc4c058ba1b1@collabora.com> <Y6Hc2d+7eTKs7AiH@x1n>
 <0a3e3397-6ff3-1203-52cb-49636ef38247@collabora.com> <Y6IGr2Y21GlLTSRl@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y6IGr2Y21GlLTSRl@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/22 12:02 AM, Peter Xu wrote:
> On Tue, Dec 20, 2022 at 11:15:00PM +0500, Muhammad Usama Anjum wrote:
>> Hi Peter,
> 
> Hi, Muhammad,
> 
> [...]
> 
>> Nothing has changed for the userspace. But when the default soft-dirty
>> feature always updates the soft-dirty flag in the PTEs regardless of
>> VM_SOFTDIRTY is set or not
> 
> But it was not?  I don't see why the pte flags must be considered at all if
> VM_SOFTDIRTY is set in existing code base, or before this patch.
I completely agree that setting pte flags isn't needed if VM_SOFTDIRTY is
set. It is wasted effort. Before this patch, the effort was being wasted in
the default part of the feature and in the other related components as
well. After this patch, the effort is being wasted only in the default part
of the feature and other related components have stopped doing this wasted
effort which is a good thing. But now there is discrepancy that one part of
code keeps on tracking pte while other has moved on/improved.

> 
>> why does other components of the mm stop caring for soft-dirty flag in
>> the PTE when VM_SOFTDIRTY is set?
>>
>>>
>>> Your approach introduced PAGEMAP_NO_REUSED_REGIONS but that special
>>> information is not remembered in vma, IIUC that's why you find things
>>> messed up.  Fundamentally, it's because you're trying to reuse soft-dirty
>>> design but it's not completely soft-dirty anymore.
>> Correct, that's why I'm trying to find a way to correct the soft-dirty
>> support instead of using anything else. We should try and correct it. I've
>> sent a RFC to track the soft-dirty flags for sub regions in the VMA.
> 
> Note that I'm not against the change if that's servicing the purpose of the
> enhancement you're proposing.  But again I wouldn't use "correct" as the
> word here because I still didn't see anything wrong with the old code.
> 
> so IMHO the extra complexity on handling VM_SOFTDIRTY (even if to drop it
> and replace with other structures to maintain ranged soft-dirty) needs to
> be justified along with the feature introduced, not be justified as a fix.
The question of tracking re-used regions should be answered by the original
developers of the feature. I've been trying to get comments from them. But
I've not got any. Maybe some conference talk can work where the
maintainers/developers are present? Or I'll summarize the whole problem and
ask Andrew directly.

> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
