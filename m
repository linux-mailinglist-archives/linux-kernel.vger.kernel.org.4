Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC8D5F85CA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJHPRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHPRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:17:34 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E145F6E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:17:32 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <m.v.b@runbox.com>)
        id 1ohBZv-005sgY-HQ; Sat, 08 Oct 2022 17:17:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID;
        bh=ckAECo5Hee38U9yD/vQmVIvkFJ4wx3mMw6mzw2eeuNs=; b=GVKxVqd1VDdL3NEIDagwkT/XCi
        nEiN9yuacrMjamKgdY8KNWopW2T4AzZOMgtNvSIWoputKNbJMv70Uleuuk5h6lydCTEM0VSfvHkRT
        YyaTUSnPil/DQ6TaYQhaFoBuz5Ynb+Cf3UU/+ZMyQ17CRRUrbWXedkyghC4jr3aKANysDeaYRBPOg
        +bnyhkZuyHmO0q892RGRn7GYCMss8Nt7vNgnUp+Gxco9DdTf5NKPjhT+5fsWTDqxnwBlL+ZagkkmH
        1KX8OgyYuq9DsuCDvOdA0+/PCs9ZVUj8YqaJ8D10C3ya2n3o/CT8e4Cad2Lz/6bs0Km3Y5CxDoI6n
        Cb89UNUQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1ohBZu-0007DE-Sw; Sat, 08 Oct 2022 17:17:27 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (536975)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1ohBZr-00088a-QG; Sat, 08 Oct 2022 17:17:23 +0200
Message-ID: <9cdb37b7-b4c0-3bc3-ecdc-643ddc2fbcc5@runbox.com>
Date:   Sat, 8 Oct 2022 11:17:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 0/2] xen/gntdev: Fixes for leaks and VMA splitting
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20221002222006.2077-1-m.v.b@runbox.com>
 <9aa1e6ba-a153-8dfa-ce28-3ab78b26c6e4@suse.com>
Content-Language: en-CA
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
In-Reply-To: <9aa1e6ba-a153-8dfa-ce28-3ab78b26c6e4@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-07 01:17, Juergen Gross wrote:
> On 03.10.22 00:20, M. Vefa Bicakci wrote:
>> Hi all,
>>
>> First of all, sorry for the delay!
>>
>> These patches continue the code review for the following patches:
>>    https://lore.kernel.org/xen-devel/20220912040002.198191-1-m.v.b@runbox.com/t/#u
>>
>> The original description of the patch set is as follows:
>>
>>    "The changes in this patch series intend to fix the Xen grant device
>>    driver, so that grant mapping leaks caused by partially failed grant
>>    mapping operations are avoided with the first patch, and so that the
>>    splitting of VMAs does not result in incorrectly unmapped grant pages
>>    with the second patch. The second patch also prevents a similar issue
>>    in a double-mapping scenario, where mmap() is used with MAP_FIXED to
>>    map grants over an existing mapping created with the same grants, and
>>    where grant pages are unmapped incorrectly as well."
>>
>> A summary of the changes from v1 is as follows:
>> - Addressed Juergen's code review comment regarding the first patch.
>> - Amended the description of the second patch to note that the described
>>    issues are encountered with PV domains.
>>
>> Verification notes:
>>
>> - I have tested these commits on top of Linux v5.15.70 and v5.15.71, and
>>    I verified that they compile successfully on top of the tag
>>    "next-20220930", which corresponds to the base commit ID included at
>>    the bottom of this e-mail.
>>
>> - My tests consist of using a kernel with Qubes OS v4.1's patches and
>>    these patches on my main computer for day-to-day tasks, in conjunction
>>    with Qubes OS's version of the Xen hypervisor v4.14.5, with the latter
>>    custom-compiled with CONFIG_DEBUG.
>>
>> - I used a test program that verifies the following scenarios with an
>>    unprivileged paravirtualized (PV) Xen domain:
>>
>>    - A program mmap()s two pages from another Xen domain and munmap()s
>>      the pages one by one. This used to result in implicit unmap errors
>>      to be reported by Xen and a general protection fault to be triggered
>>      by Xen in the affected domain, but now works as expected.
>>    - A program mmap()s two pages from another Xen domain and then
>>      attempts to remap (via MAP_FIXED) the same mapping again over the
>>      same virtual address. This used to result in similar issues
>>      (implicit unmap errors and general protection fault), but now is
>>      rejected by the kernel.
>>    - A program mmap()s two pages from another Xen domain and then
>>      attempts to mmap() the same mapping again to a different virtual
>>      address, by passing NULL as mmap()'s first argument. This used to be
>>      rejected by the kernel, and it continues to be rejected by the
>>      kernel.
>>
>> - Unprivileged PVH Xen domains were also sanity tested with the same
>>    test program. I should note that PVH domains worked as expected
>>    without these patches too.
>>
>> - Finally, I have verified that the original "g.e. 0x1234 still pending"
>>    issue does not appear after rapidly resizing GUI windows in Qubes OS
>>    v4.1.
> 
> Series pushed to xen/tip.git for-linus-6.1
> 
> 
> Juergen

I am a bit late, but thank you for reviewing the changes and merging them!

Vefa
