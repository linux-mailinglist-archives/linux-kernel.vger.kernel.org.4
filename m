Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCAE711141
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbjEYQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEYQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F2A195
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685033118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0Tu4fU+KcSG5J77KSlQHH4rtSJ0YRpV3H+uW69kS8I=;
        b=Ek5l5GFQ9zjDG/5GXyJjNNjeaRVtMfPqiufsMwAw6cjmX+hhNSZsHKFqAWDAfuqPgl/klF
        FTNjJG5zuGpFIDBag50MHss4wQ8X3O8fNkhxzQh7kikMjwjr6ZAX4LQZRPEM3fdlpcn0/p
        VVITj+8Mbp+nTzcYrIfJBZnGwOBwV/Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-0BAJlyI_P1aT4bWXAz5t-g-1; Thu, 25 May 2023 12:45:10 -0400
X-MC-Unique: 0BAJlyI_P1aT4bWXAz5t-g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f6cc1997fdso3447995e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685033109; x=1687625109;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0Tu4fU+KcSG5J77KSlQHH4rtSJ0YRpV3H+uW69kS8I=;
        b=VIaomvblBxJbclerrBwzlhnNbMueRxsvUfJETaoUwYHojzRKw/tROJdfABPZs6aQK2
         DbrrSld2matWwxO0SwZvRcJ4MRz1SvE7efev0tRSKgB5LIKZyPHAS3g9e3eswF8jwoZz
         4qxihL8YmWFOzH0TvZxUmSk7hQACcF+I+QzRr/cIIB8cTNRYjXEjt9lEyhwY0hKs224a
         TKTHdgBCVnwxGbmw7oDV1ypwu70ud1oDP5IUElQzhH0lXa0klaOapNoG2fdPxb4nkwuI
         xCkps1CpRSwezZBwIU8m2ThDH08M1WfnO1FulzCAg3gJITILECkKgTmiPItPVDQEBQT4
         YkuQ==
X-Gm-Message-State: AC+VfDxgndF9q0j+9b64SyB8RFJ3MQxi52gIKy84mcVzGxDI55ERNN0X
        YfiXvX5BDOjdoQtKzHpXHW1MlbpEm61HJoKbfSzSo082RB523tWqO6m79MQq32WHEqpRhI0kltU
        W/FRUAlTfIUMEAqIUtQolHgk5
X-Received: by 2002:a1c:7211:0:b0:3f5:d313:db68 with SMTP id n17-20020a1c7211000000b003f5d313db68mr2880726wmc.5.1685033109061;
        Thu, 25 May 2023 09:45:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6W4IaFO5i4MoXHAAkfRkY0hkh44XQhPljMx5wash4Bf0r2bg4YLJLMBZYpasG0zAq2ikjD8Q==
X-Received: by 2002:a1c:7211:0:b0:3f5:d313:db68 with SMTP id n17-20020a1c7211000000b003f5d313db68mr2880704wmc.5.1685033108696;
        Thu, 25 May 2023 09:45:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:600:4306:6a2b:57d5:2da1? (p200300cbc709060043066a2b57d52da1.dip0.t-ipconnect.de. [2003:cb:c709:600:4306:6a2b:57d5:2da1])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c364600b003f420667807sm6207453wmq.11.2023.05.25.09.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:45:08 -0700 (PDT)
Message-ID: <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com>
Date:   Thu, 25 May 2023 18:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Extending page pinning into fs/direct-io.c
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <ZGxfrOLZ4aN9/MvE@infradead.org>
 <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk>
 <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.23 18:31, Linus Torvalds wrote:
> On Wed, May 24, 2023 at 1:47 AM David Howells <dhowells@redhat.com> wrote:
>>
>> True - but I was thinking of just treating the zero_page specially and never
>> hold a pin or a ref on it.  It can be checked by address, e.g.:
>>
>>      static inline void bio_release_page(struct bio *bio, struct page *page)
>>      {
>>              if (page == ZERO_PAGE(0))
>>                      return;
> 
> That won't actually work.
> 
> We do have cases that try to use the page coloring that we support.
> 
> Admittedly it seems to be only rmda that does it directly with
> something like this:
> 
>          vmf->page = ZERO_PAGE(vmf->address);
> 
> but you can get arbitrary zero pages by pinning or GUPing them from
> user space mappings.
> 
> Now, the only architectures that *use* multiple zero pages are - I
> think - MIPS (including Loongarch) and s390.
> 
> So it's rare, but it does happen.

I think the correct way to test for a zero page is 
is_zero_pfn(page_to_pfn(page).

Using my_zero_pfn(vmf->address) in do_anonymous_page() these can easily 
end up in any process.

-- 
Thanks,

David / dhildenb

