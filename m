Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDCA6A84FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCBPOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCBPOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:14:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A959D5274
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:14:17 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8A60366018CA;
        Thu,  2 Mar 2023 15:14:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677770056;
        bh=CcEqHND5mbOVDN70lUAK9blEjv5boHx15r9OKCOPiBw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=hVqkMEDQ84QHoJNQe0kTCcPHsKDUFpk/1SRmYQtPjbYFeM94fajVPlOX8Fu6LNnv7
         8hZR7OjZlrl5f7U86WL08LhzXM+aINLLCotPxs0eL+j2m6rbq853KKLCf9kZP08+y7
         f9tG/h58lU7IcmNXyl9t84lK7PMdRJ8OwJlSANzkWvQ/c1MTz1+PnNvSnM5OjDQmSA
         62vNnWRNHk+/5eDMMqTUKhrl4s9XenOqEyQA4p3DlUJ8f26jmte/KmZONQAwUpG1Bg
         2LNyKZJSq0aMCYYPt4JRqORGUz8okXNFydnyI8PTuTx1OY56Flp2Y2ry5ncD9GI9FK
         a+VbBmjF1RXpg==
Message-ID: <fad40511-3909-4362-5760-bcb57c94e534@collabora.com>
Date:   Thu, 2 Mar 2023 20:14:05 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
To:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n> <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
 <Y/4kjnom6MQqh9iA@x1n> <fb7ec372-2b16-14e1-a8cd-a90f4449661f@collabora.com>
 <640319be-ddb6-d74f-b731-eee5ceab3d01@collabora.com> <Y/9tA2EVglOJ0Ap1@x1n>
 <fc95fd2c-d661-926c-3bdb-8709cb49de3b@collabora.com>
 <8783f47e-76ea-cd24-e373-f2156884cd05@redhat.com> <ZACrOWKWdVYO/EAI@x1n>
 <982c1623-ac28-2743-d6a3-4faf42f72d47@redhat.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <982c1623-ac28-2743-d6a3-4faf42f72d47@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/23 7:01 PM, David Hildenbrand wrote:
> On 02.03.23 14:57, Peter Xu wrote:
>> On Thu, Mar 02, 2023 at 10:37:44AM +0100, David Hildenbrand wrote:
>>> Especially for such large sparse VMAs, the current way of allocating
>>> pagetables to place markers/zeropages is far from optimal.
>>
>> IMHO that's not a generic workload.  As mentioned in the reply there, I
>> would suggest we go with simple then we have space to optimize it in the
>> future if necessary, because the API will be the same.
This is a good idea.

I'm trying to understand why aren't we going with most optimized
implementation. Why aren't we targeting it at this point in time?

>>
> 
> I disagree with "generic workload", we use sparse mmaps all over the place,
> and when blindly used by e.g., CRIU, we'll simply end up wasting memory and
> time.
I've heard about a use case where a file of size 10s of GBs can be mapped
to the memory and then accessed off and on. We need to handle this
correctly and efficiently.

> 
> But I already agreed that this optimization that is a separate thing to
> implement.
> 

-- 
BR,
Muhammad Usama Anjum
