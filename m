Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFC686D8F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjBASCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjBASCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:02:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868D4DCDC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675274497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzqzAAb573Rx+S9XOi2MvYGh3YMO5S6xiAho5p3UfWw=;
        b=e2mg+G2iQPP23BWIYa+7Qbd7fm82s8TyFU1b90hc84q2tPsvABjePgDkzuyOQiyXg+KFnV
        9nLaNJrYbrVRgDdLe98zmS5kuW5dva14oyrI9EHvuYFzzoA9cerYVRTL8jGAbsqCx82/CD
        ETohlx/fD/tA3lt4eTw5E/rEoN+JkG8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-144-sJh75HKEO3Ck8I-6eZ3tiA-1; Wed, 01 Feb 2023 13:01:36 -0500
X-MC-Unique: sJh75HKEO3Ck8I-6eZ3tiA-1
Received: by mail-wm1-f70.google.com with SMTP id k17-20020a05600c1c9100b003dd41ad974bso1358001wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzqzAAb573Rx+S9XOi2MvYGh3YMO5S6xiAho5p3UfWw=;
        b=sCoQIcmwZX+mdXVE5XN39Y7oeWnOO34SLXTpby4/ta77VDlYqlDoFzhMzsVxygDsAt
         L1EitVuklbM59OPo9laEAPo/revBoB/eGbQrSXXJDKIXu49Vvt1QlTPl13xJv6WfJk6j
         +leWFyU1RixIEx+6aoLILjSQa4vlsG0vGeoqsXU2rJDTLj3I7Zvkxm51ZIm3YZOFS67L
         8StLUBXXm9AAhiAH7eN21lYwNh/bNfg8cQ5cOGy/UdJf7b9wUCo4dfxJeFgKXOlEE2sQ
         IeJ1AKeP7luhQOrC6qQTe1xftZkNQg1ATQd6yTZ+RU0nXk8tHmnzPD83BThlGaiUFCFr
         ozoA==
X-Gm-Message-State: AO0yUKVyzWEkxc/Ddult23IoCAle5cu0oIdLESt2ZgCZOIGVRIH4Qv0R
        NCiMC2M7LqHamfNEzAzATTP1e9nrWhWMIfe1RzG1tcprM2BUjt/Qt6odzAy2qhwZrxGmpzdpQPZ
        THDabhmF7r+8jRyiVSaVfp/Td
X-Received: by 2002:a05:600c:3ba3:b0:3dc:58a2:3900 with SMTP id n35-20020a05600c3ba300b003dc58a23900mr2913442wms.29.1675274495070;
        Wed, 01 Feb 2023 10:01:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+/xHGDYtC/e/DSVq6MtlcqpQluPH2ueNrUdpbpHeoXKUweiE6CqyCelXmWCRF0Sy/EvM8qUA==
X-Received: by 2002:a05:600c:3ba3:b0:3dc:58a2:3900 with SMTP id n35-20020a05600c3ba300b003dc58a23900mr2913404wms.29.1675274494825;
        Wed, 01 Feb 2023 10:01:34 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6231.dip0.t-ipconnect.de. [91.12.98.49])
        by smtp.gmail.com with ESMTPSA id p35-20020a05600c1da300b003db16770bc5sm2524684wms.6.2023.02.01.10.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 10:01:34 -0800 (PST)
Message-ID: <d0454798-b8d6-d47f-9b57-b196d0a6e357@redhat.com>
Date:   Wed, 1 Feb 2023 19:01:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
To:     James Houghton <jthoughton@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
References: <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com>
 <Y9Li93O6Ffwcr+vn@x1n>
 <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
 <Y9f+jMLWy6ngpYuR@x1n>
 <CADrL8HX3sf6OO3PXS1g6b2dKf8b5phQ7oyNR0dVT=sAOdTmmqw@mail.gmail.com>
 <Y9gzOqwKcu7p/PEw@x1n>
 <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
 <Y9m/VVRABt0Blfjh@x1n>
 <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
 <7a1bc3c5-6efe-87ab-1276-f71fc440c821@redhat.com>
 <CADrL8HWNitzWTs4N=-CdGaY_GNUi4PORoN9r=qH3xbHmdcMwjA@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CADrL8HWNitzWTs4N=-CdGaY_GNUi4PORoN9r=qH3xbHmdcMwjA@mail.gmail.com>
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

>>> 1. The RFC v2 way, which is head-only, and we increment the compound
>>> mapcount for each PT mapping we have. So a PTE-mapped 2M page,
>>> compound_mapcount=512, subpage->_mapcount=0 (ignoring the -1 bias).
>>> 2. The THP-like way. If we are fully mapping the hugetlb page with the
>>> hstate-level PTE, we increment the compound mapcount, otherwise we
>>> increment subpage->_mapcount.
>>> 3. The RFC v1 way (the way you have suggested above), which is
>>> head-only, and we increment the compound mapcount if the hstate-level
>>> PTE is made present.
>>>
>>> With #1 and #2, there is no concern with folio_mapcount(). But with
>>> #3, folio_mapcount() for a PTE-mapped 2M page mapped in a single VMA
>>> would yield 1 instead of 512 (right?). That's what I mean.
>>
>> My 2 cents:
>>
>> The mapcount is primarily used (in hugetlb context) to
>>
>> (a) Detect if a page might be shared. mapcount > 1 implies that two
>> independent page table hierarchies are mapping the page. We care about
>> mapcount == 1 vs. mapcount != 1.
>>
>> (b) Detect if unmapping was sucessfull. We care about mapcount == 0 vs.
>> mapcount != 0.
>>
>> For hugetlb, I don't see why we should care about the subpage mapcount
>> at all.
> 
> Agreed -- it shouldn't really matter all that much.
> 
>>
>> For (a) it's even good to count "somehow mapped into a single page table
>> structure" as "mapcount == 1" For (b), we don't care as long as "still
>> mapped" implies "mapcount != 0".
> 
> Thanks for your thoughts, David. So it sounds like you're still
> squarely in the #3 camp. :)

Well, yes. As long as we can get it implemented in a clean way ... :)

-- 
Thanks,

David / dhildenb

