Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A111169A92C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBQKlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBQKlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:41:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A099E62FF7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:41:05 -0800 (PST)
Received: from [192.168.10.28] (unknown [119.155.16.218])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3672A66021A1;
        Fri, 17 Feb 2023 10:41:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676630464;
        bh=8pIiR66rNGUMu2TCI8ZyhpmZ6WKJjoXJUbmf1lKrgXY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=no6u20rMm6YO6MgHK0jkrI2daypqWpGso0y1VhkoWeaNfYRkSWJk5n/epFayoJPvm
         pX5XOlE2jE66AkjeYsCphfL3+3JPSN9alJ7FS7GWdViwIc3BunLhbnif6MEI2eI4UD
         yyWGjiJSW2HAZLk7f59oKiqiyEN4SaQTj+rIo+JWC847am7UXxeGJquyqr48rz5KO8
         u1t55NfmwXpkD3gEer0zd6GgnlF0ZUXuGhOC7hK4MnGxfTyeg05DLt5NEmJ1kAun/T
         aaKnSjNLSAtAEd8bMdoQvfLmR4tyWEavrwmmFidJW7CWBhtcSjMB89yxIUNGsDS7Og
         aChk8eruyA8Aw==
Message-ID: <643097f2-f29e-313b-cfb1-4095ae641448@collabora.com>
Date:   Fri, 17 Feb 2023 15:40:51 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm/userfaultfd: add VM_WARN_ONCE()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230216091656.2045471-1-usama.anjum@collabora.com>
 <20230216091656.2045471-2-usama.anjum@collabora.com>
 <4d29a9ec-027d-06b9-8543-87d386e58c94@redhat.com>
 <c239e126-9b75-9a81-6142-a8e518e769e2@collabora.com> <Y+6Rc8RUiv7xAlKH@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+6Rc8RUiv7xAlKH@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 1:26 AM, Peter Xu wrote:
> On Thu, Feb 16, 2023 at 02:48:51PM +0500, Muhammad Usama Anjum wrote:
>> On 2/16/23 2:24 PM, David Hildenbrand wrote:
>>> On 16.02.23 10:16, Muhammad Usama Anjum wrote:
>>>> Add VM_WARN_ONCE() to uffd_wp_range() to detect range (start, len) abuse.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>>   mm/userfaultfd.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>>>> index 77c5839e591c..d89ed44d2668 100644
>>>> --- a/mm/userfaultfd.c
>>>> +++ b/mm/userfaultfd.c
>>>> @@ -717,6 +717,8 @@ long uffd_wp_range(struct mm_struct *dst_mm, struct
>>>> vm_area_struct *dst_vma,
>>>>       struct mmu_gather tlb;
>>>>       long ret;
>>>>   +    VM_WARN_ONCE(start < dst_vma->vm_start || start + len >
>>>> dst_vma->vm_end,
>>>> +             "The address range exceeds VMA boundary.\n");
>>>
>>> VM_WARN_ON_ONCE is sufficient (sorry for spelling out the wrong variant
>>> earlier).
>> Will do in the next version. Thanks.
> 
> Shall we just squash the two patches?
Will squash in next version.

> 

-- 
BR,
Muhammad Usama Anjum
