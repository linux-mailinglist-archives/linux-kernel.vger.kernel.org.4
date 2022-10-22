Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33B360829F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJVAGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiJVAFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:05:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23C27DF5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=FsbSvlVxGH7D4k107lqA7eAi/c6cWz3yuiU0rZC9C0c=; b=P/YCZyVR5WywsGYepOjMLoI/6m
        gNoCbFA0S4qyJZ3aG6rm5vWUGAaBy3mHiMSyqlKm8bmFHQcLGam8VXlKN4onx3bnL03TyFZEMSdoI
        bio51BYZZiTPOxUu/O2dw94MTmJtDzfGLcUNYUWCngxnj2s8YbEGFUlpvxmJ+4x17c1YRKLqTA1lN
        0nEr7jUt/qrNCvPKLPg0sGICr+MPqPi6NB+0nzpVhYdBUSyDJ51I9d1XkMRMwizgj1SIOivmSAiKQ
        nYT0kik2KAuHwBi3BdNA5ErWkjoI2P+0KGWK36OksaKefA+Y8RyL2ToAgI8/W7le89qgBkmKE64+v
        8BQPyCTw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1om1yc-00ATqf-O9; Sat, 22 Oct 2022 00:02:58 +0000
Message-ID: <a0e2af81-39de-8c25-e7bd-f2234a0d7f8b@infradead.org>
Date:   Fri, 21 Oct 2022 17:02:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [shmem] 7a7256d5f5: WARNING:possible_recursive_locking_detected
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <yujie.liu@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <202210211215.9dc6efb5-yujie.liu@intel.com>
 <Y1KZ/NF5bNG1wykf@casper.infradead.org>
 <20221021133041.5811e1fb291eb6aaf122a59c@linux-foundation.org>
 <Y1Mh2S7fUGQ/iKFR@iweiny-desk3> <Y1MymJ/INb45AdaY@iweiny-desk3>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y1MymJ/INb45AdaY@iweiny-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/22 17:00, Ira Weiny wrote:

> 
> I was about to get this patch ready to send when I found this:
> 
> commit b6ebaedb4cb1a18220ae626c3a9e184ee39dd248
> Author: Andrea Arcangeli <aarcange@redhat.com>
> Date:   Fri Sep 4 15:47:08 2015 -0700
> 
>     userfaultfd: avoid mmap_sem read recursion in mcopy_atomic
> 
>     If the rwsem starves writers it wasn't strictly a bug but lockdep
>     doesn't like it and this avoids depending on lowlevel implementation  
>     details of the lock.
>     
>     [akpm@linux-foundation.org: delete weird BUILD_BUG_ON()]
>     Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>     Acked-by: Pavel Emelyanov <xemul@parallels.com>
> ...
> 
> So I wonder if the true fix is something to lockdep?
> 
> Regardless I'll send the below patch because it will restore things to a
> working order.


with ; added to each + line.

> But I'm CC'ing Andrea for comments.
> 
> Ira
> 
>>
>> Ira
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 8280a5cb48df..6c8e99bf5983 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2424,9 +2424,11 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>>
>>                 if (!zeropage) {        /* COPY */
>>                         page_kaddr = kmap_local_folio(folio, 0);
>> +                       pagefault_disable()
>>                         ret = copy_from_user(page_kaddr,
>>                                              (const void __user *)src_addr,
>>                                              PAGE_SIZE);
>> +                       pagefault_enable()
>>                         kunmap_local(page_kaddr);
>>
>>                         /* fallback to copy_from_user outside mmap_lock */
>>
>>

-- 
~Randy
