Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8F667E55F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjA0Mf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbjA0Mft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8A4ABF3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674822894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvUZq9zhTSOpariEqdt1IfiEXwlz3ceeVpAzNf6gzS4=;
        b=XSDDoUkEeAr4ljmfRC3SW9+o9yYVHGpATMyeql/aSmTNE8QpZt99E3aRy6PpFom6dYCt0f
        +hebG8IAfz9wWkTD4ubmSccmFip4atotTS6H65C7zmjKT8vMkzVZgrqim7feZH3/2iTflO
        AonQOWZTcfQ1LsymzhlLGbAX8muPWJA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-LzON_jDzPkS0uVylfr037A-1; Fri, 27 Jan 2023 07:34:53 -0500
X-MC-Unique: LzON_jDzPkS0uVylfr037A-1
Received: by mail-wm1-f70.google.com with SMTP id l19-20020a05600c1d1300b003dc13fc9e42so2722569wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvUZq9zhTSOpariEqdt1IfiEXwlz3ceeVpAzNf6gzS4=;
        b=SFoJ1SLUXA7QhfFS1Q71D4kijJZa7XOiDX0LBIF6YF4+mqopnN7ajeRJOjA5vjczu/
         DYnpeNkGegfA6WEBcQcBnnCVLQkvnmFXW2PalpsMODwHGAY/N4bDOtYSof9HUY+q3Axb
         IpjPLwRDe11JnHsJehYLHiBYMruCcJ0mkQhM9jNV1V8GN9iU5/oXxm5qJROdTuj3jjxb
         YAgQL7t63Pfn+O42y07pVLZrOn9otZQiQFs9YOYEm1Ua5DbFtp/rnMQQOTSsp8ml0NCm
         Yq7PzBdBEv5wfMFmAuoM3bU3VMAwsml9wrj4iNYfI8yPVc7UwfHM4vkNcGuxpi5GaKJX
         u2hg==
X-Gm-Message-State: AO0yUKW2LZ36YIzUUbTjEtCV+lfpKnL9l/cdFuU6Yxhy1+i0FrrYibHn
        ObJRxoKE/Zrld2O5kJy9AIDEJuM1Afa4i2LtlayTbgx6Utg3lvzHfKvzvbIw6zYZZa3GysuPsxS
        f8TitLqMWGaP7dTmkW0A2mxrl
X-Received: by 2002:adf:c7c2:0:b0:2bf:d617:6aa0 with SMTP id y2-20020adfc7c2000000b002bfd6176aa0mr1251838wrg.66.1674822892430;
        Fri, 27 Jan 2023 04:34:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8KHfQ+JrxXe4wE8YfNkipOTaYkjMGsfUoE0u82WBLyCb+27hsIT6Rl48f0jOZhn5HYYgkV8g==
X-Received: by 2002:adf:c7c2:0:b0:2bf:d617:6aa0 with SMTP id y2-20020adfc7c2000000b002bfd6176aa0mr1251801wrg.66.1674822892038;
        Fri, 27 Jan 2023 04:34:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:2600:5c01:dcac:6d6:415? (p200300cbc70526005c01dcac06d60415.dip0.t-ipconnect.de. [2003:cb:c705:2600:5c01:dcac:6d6:415])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d53d1000000b0024cb961b6aesm3841439wrw.104.2023.01.27.04.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 04:34:51 -0800 (PST)
Message-ID: <cbca813e-cdaf-6938-570e-17dd26e3cd87@redhat.com>
Date:   Fri, 27 Jan 2023 13:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-3-dhowells@redhat.com> <Y9L3yA+B1rrnrGK8@ZenIV>
 <Y9MAbYt6DIRFm954@ZenIV> <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
 <Y9Mwt1EMm8InCHvA@ZenIV> <20230127123030.qfmgkthuzlxadpkk@quack3>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230127123030.qfmgkthuzlxadpkk@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.23 13:30, Jan Kara wrote:
> On Fri 27-01-23 02:02:31, Al Viro wrote:
>> On Fri, Jan 27, 2023 at 12:44:08AM +0100, David Hildenbrand wrote:
>>> On 26.01.23 23:36, Al Viro wrote:
>>>> On Thu, Jan 26, 2023 at 09:59:36PM +0000, Al Viro wrote:
>>>>> On Thu, Jan 26, 2023 at 02:16:20PM +0000, David Howells wrote:
>>>>>
>>>>>> +/**
>>>>>> + * iov_iter_extract_will_pin - Indicate how pages from the iterator will be retained
>>>>>> + * @iter: The iterator
>>>>>> + *
>>>>>> + * Examine the iterator and indicate by returning true or false as to how, if
>>>>>> + * at all, pages extracted from the iterator will be retained by the extraction
>>>>>> + * function.
>>>>>> + *
>>>>>> + * %true indicates that the pages will have a pin placed in them that the
>>>>>> + * caller must unpin.  This is must be done for DMA/async DIO to force fork()
>>>>>> + * to forcibly copy a page for the child (the parent must retain the original
>>>>>> + * page).
>>>>>> + *
>>>>>> + * %false indicates that no measures are taken and that it's up to the caller
>>>>>> + * to retain the pages.
>>>>>> + */
>>>>>> +static inline bool iov_iter_extract_will_pin(const struct iov_iter *iter)
>>>>>> +{
>>>>>> +	return user_backed_iter(iter);
>>>>>> +}
>>>>>> +
>>>>>
>>>>> Wait a sec; why would we want a pin for pages we won't be modifying?
>>>>> A reference - sure, but...
>>>>
>>>> After having looked through the earlier iterations of the patchset -
>>>> sorry, but that won't fly for (at least) vmsplice().  There we can't
>>>> pin those suckers;
>>>
>>> We'll need a way to pass FOLL_LONGTERM to pin_user_pages_fast() to handle
>>> such long-term pinning as vmsplice() needs. But the release path (unpin)
>>> will be the same.
>>
>> Umm...  Are you saying that if the source area contains DAX mmaps, vmsplice()
>> from it will fail?
> 
> Yes, that's the plan. Because as you wrote elsewhere, it is otherwise too easy
> to lock up operations such as truncate(2) on DAX filesystems.

Right, it's then the same behavior as we already have for other 
FOLL_LONGTERM users, such as RDMA or io_uring.

... if we're afraid of breaking existing setups we could add some kind 
of fallback to copy to a buffer like ordinary pipe writes.

-- 
Thanks,

David / dhildenb

