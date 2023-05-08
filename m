Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F06FBA1C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjEHVnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjEHVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2583C35
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683582061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SbaY/+tG3VKfkc100DquRuCLrkw9MdA9beMhNTT5GyA=;
        b=WH/lcgnXiB9uSe4bLJB1wpij5nSp/1IbBo8kcN3skPuhRvdezgW+xlCMwU3QQXkFx3bi90
        fpqyczscl2cIv+yrtmX4s4+q+OCUZgt6rvQaeCxGZRiOL8Mo42N8jRzt04eqhmhBq4c+zu
        Ow0UqEoLzYG2995WDQRwqlMGVNL2N4c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-b3WL_rcMOEy3FUrUar2f6Q-1; Mon, 08 May 2023 17:37:05 -0400
X-MC-Unique: b3WL_rcMOEy3FUrUar2f6Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24e015fcf81so2803317a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581825; x=1686173825;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbaY/+tG3VKfkc100DquRuCLrkw9MdA9beMhNTT5GyA=;
        b=FtHIM73/SwvK14b7okQ2LyzySvxGrm7LmY+B0Aj/DpciK893tV6TF38XZGtAUkofWW
         yFLQrmXEEG+tJKefNWxDxzsXfu+D5N+qCj3I029ewcttaGdFAG6/WkfFJuAM+icPtRPV
         iyNI7m2hC+/2snkL+jU5EkFaV8M6Qy+OuCRfyHEB3V0CPx0mZlaGc42GXW8A630OkPKN
         qzhmcU62seLqN9KH+MxhNPmbHIlhB4L5bNkOPsFe5eE7y2bd+qKzYADRNvxEx5ukbbvz
         4QJ4AwHotZdc+Zczg/iv/+h50t00E5NBE6+nTdevgBCo9dtFEXOnNxcCxN2L8XkEPegu
         axlg==
X-Gm-Message-State: AC+VfDwHLSawcXVxVDRoa0/tJMbAQMD/yYDmIUTIWszlCkkrTYzFtdVZ
        ZRiPGX+s+oZvS+eonA0yIxw9xMbjw55vWGSNsEOlM4uZY/7vDbmi87NKn9OashneWTC+c7LXa4h
        W4u9JjnfDulVPaF9mdqzjqX7O
X-Received: by 2002:a17:90b:85:b0:24e:4350:cb50 with SMTP id bb5-20020a17090b008500b0024e4350cb50mr11893379pjb.29.1683581824918;
        Mon, 08 May 2023 14:37:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7nKf1qYn8A5U44GBKxCnO/4AvQjaPfLG0Rt4rAZhAHdTrR5txTZCZtvxSUeejYPDf00CLB0Q==
X-Received: by 2002:a17:90b:85:b0:24e:4350:cb50 with SMTP id bb5-20020a17090b008500b0024e4350cb50mr11893353pjb.29.1683581824527;
        Mon, 08 May 2023 14:37:04 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:5835:5bd3:f0c8:e5ef? ([2001:4958:15a0:30:5835:5bd3:f0c8:e5ef])
        by smtp.gmail.com with ESMTPSA id m187-20020a6326c4000000b00524dde7231dsm6819401pgm.9.2023.05.08.14.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 14:37:04 -0700 (PDT)
Message-ID: <8019cf35-e631-0252-0d38-d2454f5f0e11@redhat.com>
Date:   Mon, 8 May 2023 23:37:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: usbdev_mmap causes type confusion in page_table_check
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ruihan Li <lrh2000@pku.edu.cn>
Cc:     syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <000000000000258e5e05fae79fc1@google.com>
 <20230507135844.1231056-1-lrh2000@pku.edu.cn>
 <CA+CK2bBe2YKYM3rUTCnZ0RF=NFUR9VqO-QYn3ygPsFJWLY1MUA@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CA+CK2bBe2YKYM3rUTCnZ0RF=NFUR9VqO-QYn3ygPsFJWLY1MUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.23 23:27, Pasha Tatashin wrote:
> On Sun, May 7, 2023 at 9:58 AM Ruihan Li <lrh2000@pku.edu.cn> wrote:
>>
>> Hi all,
> 
> Hi Ruihan,
> 
> Thank you for bisecting, and great analysis of the problem.
> 
>> Recently, syzbot reported [1] ("kernel BUG in page_table_check_clear"). After
>> some bisection, I found out that when usbdev_mmap calls remap_pfn_range on
>> kmalloc'ed memory, it causes type confusion between struct folio and slab in
>> page_table_check. As I will explain below, it seems that both usb-side and
>> mm-side need some fixes. So I have cc'd linux-usb and linux-mm here, as well
>> as their maintainers, to see whether there are any comments on the proposed
>> way to fix.
>>
>>   [1] https://lore.kernel.org/all/000000000000258e5e05fae79fc1@google.com/
>>
>> To handle mmap requests for /dev/bus/usb/XXX/YYY, usbdev_mmap first allocates
>> memory by calling usb_alloc_coherent and then maps it into the user space
>> using remap_pfn_range:
>>
>> static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
>> {
>>          // ...
>>          mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
>>                          &dma_handle);
>>          // ...
>>          if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
>>                  if (remap_pfn_range(vma, vma->vm_start,
>>                                      virt_to_phys(usbm->mem) >> PAGE_SHIFT,
>>                                      size, vma->vm_page_prot) < 0) {
>>                          // ...
>>                  }
>>          }
>>          // ...
>> }
>>
>> Note that in this case, we consider the DMA-unavailable scenario, which, to be
>> honest, is rare in practice. However, syzbot emulates USB devices using a
>> module named dummy_hcd, and since these devices are emulated, DMA is not
>> available at all.
>>
>> Meanwhile, usb_alloc_coherent calls hcd_buffer_alloc, which uses kmalloc for
>> memory allocation:
>>
>> void *hcd_buffer_alloc(
>>          struct usb_bus          *bus,
>>          size_t                  size,
>>          gfp_t                   mem_flags,
>>          dma_addr_t              *dma
>> )
>> {
>>          // ...
>>          if (!hcd_uses_dma(hcd)) {
>>                  *dma = ~(dma_addr_t) 0;
>>                  return kmalloc(size, mem_flags);
>>          }
>>          // ...
>> }
>>
>> However, during the update of the page table to map the kmalloc'd page into
>> the user space, page_table_check_set attempts to determine whether the page is
>> anonymous using PageAnon:
>>
>> static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
>>                                   unsigned long pfn, unsigned long pgcnt,
>>                                   bool rw)
>> {
>>          // ...
>>          anon = PageAnon(page);
>>          for (i = 0; i < pgcnt; i++) {
>>                  // ...
>>                  if (anon) {
>>                          BUG_ON(atomic_read(&ptc->file_map_count));
>>                          BUG_ON(atomic_inc_return(&ptc->anon_map_count) > 1 && rw);
>>                  } else {
>>                          BUG_ON(atomic_read(&ptc->anon_map_count));
>>                          BUG_ON(atomic_inc_return(&ptc->file_map_count) < 0);
>>                  }
>>                  // ...
>>          }
>>          // ...
>> }
>>
>> This call to PageAnon is invalid for slab pages because slab reuses the bits
>> in struct page/folio to store its internal states, and the anonymity bit only
>> exists in struct page/folio. As a result, the counters are incorrectly updated
>> and checked in page_table_check_set and page_table_check_clear, leading to the
>> bug being raised.
> 
> We should change anon boolean to be:
> 
> anon = !PageSlab(page) && PageAnon(page);
> 
> This way, we will have a correct way to determine anon pages, and the
> rest will fall into file_map_count. The file (non-anon) PTEs are OK to
> be double mapped, so there won't be any problems from page_table_check
> point of view even if it is a slab page.


I'm surprised that we allow mapping slab pages to user space. I somehow 
remember that this is a big no-no.

Do we really want to allow that? Are there many such users or is this 
the only one?

If we do support it, we might want to update some PageAnon() checks in 
mm/gup.c too to exclude slab pages ...

-- 
Thanks,

David / dhildenb

