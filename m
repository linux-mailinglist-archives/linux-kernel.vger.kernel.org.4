Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBCA6E0D94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjDMMmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDMMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78D993D1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681389707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3dYaUxw3D2j5vjazPvcJJsjf7qa/tkOt/AsUugtvjw=;
        b=ZbwGg8PJkMryusvRRo5KWnKEZAE3BRJaNbTjlu9UvG1EsoaXcUB5m4AiFXCpZDmSaM+43M
        BL8da3kv33w3dOYkrjfHJ0mOtzNXPY5wGUoEoXebgftWcN72G441MD1Peg5oEvZ1NCeI5x
        hbO2735vqbwLvKggM/mGQ6jkeWc72EM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-qYSwLccAMvOAqRZM698WNQ-1; Thu, 13 Apr 2023 08:41:46 -0400
X-MC-Unique: qYSwLccAMvOAqRZM698WNQ-1
Received: by mail-wr1-f70.google.com with SMTP id d30-20020adfa35e000000b002f53b0a3377so752710wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681389705; x=1683981705;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3dYaUxw3D2j5vjazPvcJJsjf7qa/tkOt/AsUugtvjw=;
        b=lKYek9S7fk9eXwi1NssdvIfFYeKG88eXpasqFSGra9CXljthcr+Y56xAHdZt/qwz+P
         EcNsyco1sZdfu1UJ9P5DpGEge/mKgYpTHhw1IUlvvFzlSEbQ9mZZxtNIRxK87m0VDDu+
         XxvhlMkcvMmye983tArIg3pmV0D49H6e7UPz9pNM0eUhlSgHevT08kswqMiheoJ0Umiz
         8DvWIF6udBNXVpbyxNqwWzJYw7twn9gRa9+bBkojw6q7qmz++qQEuCd1K/fm4sCwUuFz
         5NisYQ/igbBwDL4v23xGMWdtW5odv3JOP0BKUqe1r5+pTR5ns16yB+JDtziZlwuEwwQD
         /Yjg==
X-Gm-Message-State: AAQBX9drPwc33CuQIpwTcD2hsSwuky6XfBI/iz5DuHlkoniqD+WK1RSB
        XklDk2f2w00Uml43N/fhbuewfrFJthv94rS69zvxj/FoZwfqEyYaK9BCUgVpi+Z6if6E84fLEWz
        kcZp8fDw+IpB3LliZRqSTenSx
X-Received: by 2002:a05:6000:182:b0:2c9:b9bf:e20c with SMTP id p2-20020a056000018200b002c9b9bfe20cmr1384301wrx.2.1681389705393;
        Thu, 13 Apr 2023 05:41:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350aTY91v5mpZFzN5+r31N2yPV2YStw3MrraVcnXey4pmNW0tl7fgMD6B90YOR+GLQRT9XfAbNA==
X-Received: by 2002:a05:6000:182:b0:2c9:b9bf:e20c with SMTP id p2-20020a056000018200b002c9b9bfe20cmr1384276wrx.2.1681389705044;
        Thu, 13 Apr 2023 05:41:45 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id b7-20020adfde07000000b002f3fcb1869csm1222217wrm.64.2023.04.13.05.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 05:41:44 -0700 (PDT)
Message-ID: <c1902449-ab9d-4e26-c532-5df0a73dc1f9@redhat.com>
Date:   Thu, 13 Apr 2023 14:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
References: <93f2614e-4521-8bc8-2eca-e7ad03e7e399@redhat.com>
 <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
 <37946.1681288867@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: find_get_page() VS pin_user_pages()
In-Reply-To: <37946.1681288867@warthog.procyon.org.uk>
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

On 12.04.23 10:41, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> I suspect that find_get_page() is not the kind of interface you want to use
>> for the purpose you describe. find_get_page() is a wrapper around
>> pagecache_get_page() and seems more like a helper for implementing an fs
>> (looking at the users and the fact that it only considers pages that are in
>> the pagecache).
> 
> Btw, at some point we're going to need public functions to get extra pins on
> pages.  vmsplice() should be pinning the pages it pushes into a pipe - so all
> pages in a pipe should probably be pinned - and anyone who splices a page out
> of a pipe and retains it (skbuffs spring strongly to mind) should also get a
> pin on the page.

As discussed, vmsplice() is a bit special, because it has 
longterm-pinning semantics: we'd want to migrate the page out of 
ZONE_MOVABLE/MIGRATE_CMA/... because the page might remain pinned in the 
pipe possibly forever, controlled by user space. 
pin_user_pages(FOLL_LONGTERM) would do the right thing, but we might 
ahve to be careful with extra pins.


I guess it depends on what we want to achieve. Let's discuss what would 
happen when we want to pin some page (and not going via pin_user_page()) 
that's definitely not an anon page -- so let's assume a pagecache page:

(a) Short-term pinning when already pinned (extra pins): easy.
(b) Short-term pinning when not pinned yet: should be fairly easy
     (pin_user_pages() doesn't do anything special for pagecache pages
      either).
(c) Long-term pinning when already long-term pinned (extra long-term
     pinnings): easy
(d) Long-term pinning when already short-term pinned: problematic,
     because we might have to migrate the page first, but it's already
     pinned ... and if we obtained the page via pin_user_page() from a
     MAP_PRIVATE VMA, we'd  have to do another
     pin_user_page(FOLL_LONGTERM) that would properly break COW and give
     us an anon page ...
(e) Long-term pinning when not pinned yet: fairly easy, but we might
     have to migrate the page first (like FOLL_LONGTERM would).


Regarding anon pages, we should pin only via pin_user_page(), so the 
"not pinned" case does not apply. Replicating pins -- (a) and (c) -- is 
usually easy, but (d) is similarly problematic.

Focusing again on !anon pages: if it's just "get another short-term pin 
on an already pinned page", it's easy (and I recall John H. had 
patches). If it's "get a long-term pin on an already pinned page", it 
can be problematic.

Any pages that will never have to be migrated when long-term pinning 
(just some allocated kernel page without MOVABLE semantics) are super 
easy to pin, and to add extra pins to.

> 
> So should all pages held by an skbuff be pinned rather than ref'd?  I have a
> patch to use the bottom two bits of an skb frag's page pointer to keep track
> of whether the page it points to is ref'd, pinned or neither, but if we can
> make it pin/not-pin them, I only need one bit for that.

It might possibly be the right thing. But ref'd vs. pinned really only 
makes a difference to (a) pages mapped into user space or (b) pages in 
the pageache. Of course, in any case, long-term semantics have to be 
respected if the page to pin might have been allocated with MOVABLE 
semantics.

-- 
Thanks,

David / dhildenb

