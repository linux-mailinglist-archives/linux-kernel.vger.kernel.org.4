Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756C569C5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBTHPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBTHPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:15:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85799977E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:15:39 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CCAC666018CA;
        Mon, 20 Feb 2023 07:15:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676877338;
        bh=GaQ8q2yWSZQVknoEXEBxDV7yMaL3s3t9rakelGBhOcE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=HjkC4gWARwV/Y2CWqKu5d+rvsEnEpgscgjDG/HyIP2DHTKGEW+5At98iXUeK5HhRD
         D4vHLtbia8rysGOjxHU5i2gKLiaiU/3OxoTV1Ua/AxNYMUhPv0Pv5k2Gbs6WaYLxkM
         aLO/rnyGiIAbW+o0wnJbq3Q5hg9PZuNKVLLQ6RCrnghGyNEqkE3JWLEMlsrCjdy6qc
         45ehs4WqNLkZTXuw6dOI3v0NHKNXgdQyLJ76YAvQRJ9CfiT1OUIinBGXWoVxrbp55C
         ect//Zrm/QOabtJf+Y/keo3xeH1+iEZv0mdqO0l2CFG4cn/lEsWtFeMTGI+qHsTf3f
         KHtEIKQV2nQ5w==
Message-ID: <6bdd805d-6a99-a1d5-f376-3d2d0c915d38@collabora.com>
Date:   Mon, 20 Feb 2023 12:15:31 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
To:     Peter Xu <peterx@redhat.com>
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com> <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com> <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com> <Y+6NKPuty9V3nycI@x1n>
 <427298c4-0da9-059f-02ff-c5147d317c87@collabora.com> <Y/AJUi4o5hOKDkgy@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y/AJUi4o5hOKDkgy@x1n>
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

Hi Peter,

Thank you so much for working on this.

On 2/18/23 4:10 AM, Peter Xu wrote:
> Hi, Muhammad,
> 
> On Fri, Feb 17, 2023 at 05:31:19PM +0500, Muhammad Usama Anjum wrote:
>> I've just ran my single threaded selftest [1] over an over again to get
>> some numbers.
>>
>> Without zeropage
>> qemu has 6 cores: 26.0355
> 
> Did you count in the time of read prefault?  Or did you not prefault at
> all?
No, pre-faulting is not being done in both of the runs.

Without zeropage, I'm checking pte_none() to decide if page is dirty.
With zeropage, I'm just checking if WP flag isn't set to decide if page is
dirty.

> 
>> With zeropage
>> qemu has 6 cores: 39.203
>>
>> 33% worse performance with zero pages
>>
>> Definitely, there can be better benchmark application. Please let me know
>> if I should write better benchmarks on my end.
>>
>> [1]
>> https://lore.kernel.org/all/20230202112915.867409-7-usama.anjum@collabora.com
> 
> I'll have a closer look too next week.
> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
