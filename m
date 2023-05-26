Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC335712806
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbjEZOHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbjEZOHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C31F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685110021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAbN/2lmj85EfJ5ZXB9Lxx6BdfoaVulpG4pANfEifWY=;
        b=QHjZfqF7uGFnuNrk0Q5jFnu+Jp/gmZtNkwFaFVFtD9uV4Y37bF77HEvkeq5BwPMHGO0vwo
        GoEQG7xyX6LPR4YlU3M87CZs53ldRKq2pAwp7xcWQl4JO4N5D05dojX8/ItT4g2jIvk6Ax
        wKQ2Gjq80B8h71ZAYXmwwMNghH8IkNA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-n2HqafoLO6mjH2k9bIQ7Tw-1; Fri, 26 May 2023 10:06:59 -0400
X-MC-Unique: n2HqafoLO6mjH2k9bIQ7Tw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f3a7765189so421893e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685110018; x=1687702018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAbN/2lmj85EfJ5ZXB9Lxx6BdfoaVulpG4pANfEifWY=;
        b=KQ0XDwRzZfbmNCw8gFBo8KfPpBX2SXcJq7tLqV9HdvV+7FH+DfDjP3iR/234PgtitQ
         tJ724eZSp66kMYLxpWDUa1o9dQZ21e/NqYVhmKxQi7WNOmcpEoT1/8HlnDRLA+K41RNd
         8NPvcMljyf9advQSf2lGRQXqpAOUEKTlVdIwbt5cqCCBshs7G5TSLkPsSV8V1te5M53y
         wXDAr556kXvRyKr8Pdx3KbrgByn393zfU732DUS9cQxUwcGEvjiWdWugoAFthUJI8pok
         xF7vv7jVI1ZOUgebzI3e8IwJP8jLqH5xW8vBQkrUvRVz6mkJKrg2iBWFSPxyEPWbnfB9
         vmeA==
X-Gm-Message-State: AC+VfDwhvd51M5MOB8EaYlzDPjGX30RPLpTjgBd+jnstQfLUghE0KYlZ
        OejyjCm+WeL+ppmx5AV3X8DbtWOuqk8zVQ1BIX8dzWpb0mLY4j+xrs4w8vwSQUP+0HuU94vVSK0
        8jyZr9kzI3DLOVQKkG6/emYc=
X-Received: by 2002:ac2:59cf:0:b0:4ed:d2cf:857b with SMTP id x15-20020ac259cf000000b004edd2cf857bmr543144lfn.5.1685110017970;
        Fri, 26 May 2023 07:06:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7er+LeGsxnFDYQXWSIbLqlc4+5J32U68qYkTck/GPaTlh3YQQH7LynqG86HW/G1yXwV5CNog==
X-Received: by 2002:ac2:59cf:0:b0:4ed:d2cf:857b with SMTP id x15-20020ac259cf000000b004edd2cf857bmr543126lfn.5.1685110017600;
        Fri, 26 May 2023 07:06:57 -0700 (PDT)
Received: from [192.168.1.121] (85-23-48-202.bb.dnainternet.fi. [85.23.48.202])
        by smtp.gmail.com with ESMTPSA id j22-20020ac253b6000000b004f3aee3aae2sm639896lfh.140.2023.05.26.07.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 07:06:56 -0700 (PDT)
Message-ID: <5dd62fee-56bf-0b54-2e91-c31068a2b040@redhat.com>
Date:   Fri, 26 May 2023 17:06:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next 04/12] mm: Make the page_frag_cache allocator use
 multipage folios
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeroen de Borst <jeroendb@google.com>,
        Catherine Sullivan <csully@google.com>,
        Shailend Chand <shailend@google.com>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
References: <a819dd80-54cc-695f-f142-e3d42ce815a7@huawei.com>
 <20230524153311.3625329-1-dhowells@redhat.com>
 <20230524153311.3625329-5-dhowells@redhat.com>
 <739166.1685105220@warthog.procyon.org.uk>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <739166.1685105220@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26.5.2023 15.47, David Howells wrote:
> Yunsheng Lin <linyunsheng@huawei.com> wrote:
> 
>>> Change the page_frag_cache allocator to use multipage folios rather than
>>> groups of pages.  This reduces page_frag_free to just a folio_put() or
>>> put_page().
>>
>> put_page() is not used in this patch, perhaps remove it to avoid
>> the confusion?
> 
> Will do if I need to respin the patches.
> 
>> Also, Is there any significant difference between __free_pages()
>> and folio_put()? IOW, what does the 'reduces' part means here?
> 
> I meant that the folio code handles page compounding for us and we don't need
> to work out how big the page is for ourselves.
> 
> If you look at __free_pages(), you can see a PageHead() call.  folio_put()
> doesn't need that.
> 
>> I followed some disscusion about folio before, but have not really
>> understood about real difference between 'multipage folios' and
>> 'groups of pages' yet. Is folio mostly used to avoid the confusion
>> about whether a page is 'headpage of compound page', 'base page' or
>> 'tailpage of compound page'? Or is there any abvious benefit about
>> folio that I missed?
> 
> There is a benefit: a folio pointer always points to the head page and so we
> never need to do "is this compound? where's the head?" logic to find it.  When
> going from a page pointer, we still have to find the head.
> 


But page_frag_free() uses folio_put(virt_to_folio(addr)) and 
virt_to_folio() depends on the compound infrastructure to get the head 
page and folio.


> Ultimately, the aim is to reduce struct page to a typed pointer to massively
> reduce the amount of space consumed by mem_map[].  A page struct will then
> point at a folio or a slab struct or one of a number of different types.  But
> to get to that point, we have to stop a whole lot of things from using page
> structs, but rather use some other type, such as folio.
> 
> Eventually, there won't be a need for head pages and tail pages per se - just
> memory objects of different sizes.
> 
>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>> index 306a3d1a0fa6..d7c52a5979cc 100644
>>> --- a/include/linux/mm_types.h
>>> +++ b/include/linux/mm_types.h
>>> @@ -420,18 +420,13 @@ static inline void *folio_get_private(struct folio *folio)
>>>   }
>>>   
>>>   struct page_frag_cache {
>>> -	void * va;
>>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>> -	__u16 offset;
>>> -	__u16 size;
>>> -#else
>>> -	__u32 offset;
>>> -#endif
>>> +	struct folio	*folio;
>>> +	unsigned int	offset;
>>>   	/* we maintain a pagecount bias, so that we dont dirty cache line
>>>   	 * containing page->_refcount every time we allocate a fragment.
>>>   	 */
>>> -	unsigned int		pagecnt_bias;
>>> -	bool pfmemalloc;
>>> +	unsigned int	pagecnt_bias;
>>> +	bool		pfmemalloc;
>>>   };
>>
>> It seems 'va' and 'size' field is used to avoid touching 'stuct page' to
>> avoid possible cache bouncing when there is more frag can be allocated
>> from the page while other frags is freed at the same time before this patch?
> 
> Hmmm... fair point, though va is calculated from the page pointer on most
> arches without the need to dereference struct page (only arc, m68k and sparc
> define WANT_PAGE_VIRTUAL).
> 
> David
> 

--Mika

