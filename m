Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0996C6726B0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjARSWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjARSWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:22:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868903A846
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674066109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkfAUPkyScTipaKcC/XWnnaZrRP9e8MsdaN4fyf8AEA=;
        b=H/b6oe7XQMjGl/qhAacev4HrGGMYSpEPDt3k5jnGbbtojFnZx2ygBeHKoalWEvo8LrRMqC
        c7864uhk27a4Adf8i7SGWqhfcMluH+mYrRq+nu7qbK1pDfyVlLxxoGrY+AcaaMYEh6uUld
        /PgdvP6yNzdvzNRBDRmfSZbwPKi8qQs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-H9wWZdjVPQq4IHG0_9sXwQ-1; Wed, 18 Jan 2023 13:21:46 -0500
X-MC-Unique: H9wWZdjVPQq4IHG0_9sXwQ-1
Received: by mail-wm1-f72.google.com with SMTP id r15-20020a05600c35cf00b003d9a14517b2so1628511wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkfAUPkyScTipaKcC/XWnnaZrRP9e8MsdaN4fyf8AEA=;
        b=eXl2jWfSBAqjp0AsrKoTW424nVdjScRKRqiFPxL4XimWs2ZWUAcsobb+2806AicYJX
         tTx/uFHRvbAdi4DStueVVrJykY0SYBWKDns2NNmWzyVjkd0XhwGBubGIy58iTOIoMFSt
         aJaGsFp/P3nTsAsqGcxtLoB+7xsPKPUv/CMjE+whMEEXGxoRH7sZuY3THCVQPcdzKeEy
         eqgg4UliP5E6xp75oHneYLZv/bQTWzCxqVy0fb9mxpzakFGpYUrdu7kDcLL2FAvnEOvr
         sM9F2XFZ+UXnUYNHOnEkUJAYHmtB72JH0rrkxlURe54tQfpD7MZgZeYEkyTjKuNhWwkr
         04pQ==
X-Gm-Message-State: AFqh2koTsKSiDj8SjgRrdEGEODUQpKMjZsV60OrE5B+p5+KhNMwx5twk
        2zPKWCdlxGbvMioy6ZFcTR0yokVLwzlIOilO7WJOCAOUF5kye+XneCOYY16b0d+SCtYZ7KE5h3Z
        7SmnU4Vgi17VoHNC1i4i28Tgp
X-Received: by 2002:a7b:c4d0:0:b0:3d1:f6b3:2ce3 with SMTP id g16-20020a7bc4d0000000b003d1f6b32ce3mr7892198wmk.35.1674066105813;
        Wed, 18 Jan 2023 10:21:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsVMq3n/sWCHIZHI3DCzEo1tb18y6AtjBtsP27kjnzqUSTu2zjaZeGBExx2m/EzgjVws3Jj3Q==
X-Received: by 2002:a7b:c4d0:0:b0:3d1:f6b3:2ce3 with SMTP id g16-20020a7bc4d0000000b003d1f6b32ce3mr7892185wmk.35.1674066105554;
        Wed, 18 Jan 2023 10:21:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:800:1a88:f98a:d223:c454? (p200300cbc70508001a88f98ad223c454.dip0.t-ipconnect.de. [2003:cb:c705:800:1a88:f98a:d223:c454])
        by smtp.gmail.com with ESMTPSA id fm11-20020a05600c0c0b00b003c21ba7d7d6sm2585970wmb.44.2023.01.18.10.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 10:21:44 -0800 (PST)
Message-ID: <941f0f8f-a2c2-0021-0773-6cfaa81aabd7@redhat.com>
Date:   Wed, 18 Jan 2023 19:21:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
 <Y8AnROAtMngKntnq@x1n>
 <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
 <Y8BtJzBLTpw5IR+H@x1n>
 <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n> <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com> <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
In-Reply-To: <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Once the last piece is unmapped (or simpler: once the complete subtree of
>>> page tables is gone), we decrement refcount+mapcount. Might require some
>>> brain power to do this tracking, but I wouldn't call it impossible right
>>> from the start.
>>>
>>> Would such a design violate other design aspects that are important?
> 
> This is actually how mapcount was treated in HGM RFC v1 (though not
> refcount); it is doable for both [2].
> 
> One caveat here: if a page is unmapped in small pieces, it is
> difficult to know if the page is legitimately completely unmapped (we
> would have to check all the PTEs in the page table). In RFC v1, I
> sidestepped this caveat by saying that "page_mapcount() is incremented
> if the hstate-level PTE is present". A single unmap on the whole
> hugepage will clear the hstate-level PTE, thus decrementing the
> mapcount.
> 
> On a related note, there still exists an (albeit minor) API difference
> vs. THPs: a piece of a page that is legitimately unmapped can still
> have a positive page_mapcount().
> 
> Given that this approach allows us to retain the hugetlb vmemmap
> optimization (and it wouldn't require a horrible amount of
> complexity), I prefer this approach over the THP-like approach.

If we can store (directly/indirectly) metadata in the highest pgtable 
that HGM-maps a hugetlb page, I guess what would be reasonable:

* hugetlb page pointer
* mapped size

Whenever mapping/unmapping sub-parts, we'd have to update that information.

Once "mapped size" dropped to 0, we know that the hugetlb page was 
completely unmapped and we can drop the refcount+mapcount, clear 
metadata (including hugetlb page pointer) [+ remove the page tables?].

Similarly, once "mapped size" corresponds to the hugetlb size, we can 
immediately spot that everything is mapped.

Again, just a high-level idea.

-- 
Thanks,

David / dhildenb

