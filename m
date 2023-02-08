Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8668EC7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjBHKOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:14:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1424345A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675851243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ME71NVvKp2x1te3CcnQMIWa4oEmZB0HEW3AvhOptsO8=;
        b=cJPZlfHqAUmuGCDdx3tggnEv0hVw/LZUKDv22x/t8mzvu9Cnn+Bj2srOZiNLYywr1HG45o
        pAINPdqQVzoo8A+vzvVequA1VZ0hAUKRcjtOF1+RMqMytdE+5SnA/R0TJtglESMoevK2tt
        i1kR43gxOuDD2GM/Wh1J794mb+fvKyk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-4Aty7J8JNMyX4QjyeYKvMg-1; Wed, 08 Feb 2023 05:14:01 -0500
X-MC-Unique: 4Aty7J8JNMyX4QjyeYKvMg-1
Received: by mail-wr1-f70.google.com with SMTP id w10-20020a5d544a000000b002c3de7a10b0so1772013wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ME71NVvKp2x1te3CcnQMIWa4oEmZB0HEW3AvhOptsO8=;
        b=y1jgzXdl1d5msnEtvYYhYGHAVxoC2FRYNqmUA77WaBSaDMhhhBWLy0c5u2CvEyYNCF
         vK2Xebnj69dSnE1OxIFvzkCm/t0VXm3CANbJSusNb8wlujJwQmM2NKxGxpDOl7hJZwvY
         of8Pl2uvaSB2piYh3pVZHkPX3MyFRAEzo6UDlNEOLiZ3sCIoJWBlLtT1TNAB50NNl7S3
         qssceJhjr+TzWSonhxj4DGAnXpy6oIda6L5qRIh8iZjKXcnBNRCjNKrAJc9EurQzq36J
         seUi0pW9fiBOjih2qYFjFvF8sRiqgSMjhcfjyVyPlAiNoqq3vJDKMI/aWzomBX/FSGrF
         sVHg==
X-Gm-Message-State: AO0yUKWn6jpAAFbaWEutOu13p3bmVuC+jayYUkKhUqNm00oz4JOyOB9v
        4Dr3X0yckjiiwdumSgfkR59D5U3hjyRm3Alc/+OBQbCchdvWG00BuZ7Q2m0DkbQkXdYHlFi2rmW
        NTVrbLiBpWRQSSNd0gLS05rMY
X-Received: by 2002:a05:600c:1688:b0:3dd:caa8:3ae2 with SMTP id k8-20020a05600c168800b003ddcaa83ae2mr6131970wmn.6.1675851239764;
        Wed, 08 Feb 2023 02:13:59 -0800 (PST)
X-Google-Smtp-Source: AK7set8tVMja9BGeK7SFvSxfu2oOsWjpNFKTJBKL/QbzxmRe7J182tCeCQFsWiVPrkEbqzyq9yjqpg==
X-Received: by 2002:a05:600c:1688:b0:3dd:caa8:3ae2 with SMTP id k8-20020a05600c168800b003ddcaa83ae2mr6131946wmn.6.1675851239477;
        Wed, 08 Feb 2023 02:13:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:b300:758c:6214:cd51:8ab0? (p200300cbc704b300758c6214cd518ab0.dip0.t-ipconnect.de. [2003:cb:c704:b300:758c:6214:cd51:8ab0])
        by smtp.gmail.com with ESMTPSA id e1-20020a05600c4e4100b003dc49e0132asm1535063wmq.1.2023.02.08.02.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 02:13:58 -0800 (PST)
Message-ID: <ebed9128-a56f-0493-0cc8-d13e1de077fc@redhat.com>
Date:   Wed, 8 Feb 2023 11:13:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC v3 2/4] mm: move PG_slab flag to page_type
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-3-42.hyeyoo@gmail.com>
 <15fda061-72d9-2ee9-0e9f-6f0f732a7382@suse.cz> <Y9dI88l2YJZfZ8ny@hyeyoo>
 <Y9dRlNhh6O99tg4E@casper.infradead.org>
 <59630801-42b4-22e8-0ef6-5a5b8636dfbd@redhat.com>
 <Y+NvCts0JPBmAifu@kernel.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y+NvCts0JPBmAifu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.23 10:44, Mike Rapoport wrote:
> On Fri, Feb 03, 2023 at 05:04:01PM +0100, David Hildenbrand wrote:
>> On 30.01.23 06:11, Matthew Wilcox wrote:
>>> On Mon, Jan 30, 2023 at 01:34:59PM +0900, Hyeonggon Yoo wrote:
>>>>> Seems like quite some changes to page_type to accomodate SLAB, which is
>>>>> hopefully going away soon(TM). Could we perhaps avoid that?
>>>>
>>>> If it could be done with less changes, I'll try to avoid that.
>>>
>>> Let me outline the idea I had for removing PG_slab:
>>>
>>> Observe that PG_reserved and PG_slab are mutually exclusive.  Also,
>>
>> I recall that there are SetPageReserved() calls on pages allocated via slab.
> 
> I did a quick scan, and it seems that all allocated reserved pages come
> from alloc_pages() or vmalloc().
>   

Thanks for checking, good that my memory was wrong :)

> BTW, looking at the current usage of SetPageReserved, it seems that some
> are bogus/historical and some would justify a different page type if we are
> to have 15 bits for PG_kernel.

I remember raising in the past that something like PG_hole might be helpful.

I also recall that most SetPageReserved usage in drivers is to make 
ioremap happy. PG_ioremappable or smth like that would be better.

So yes, that would even help to cleanup the existing PG_reserved usage.

-- 
Thanks,

David / dhildenb

