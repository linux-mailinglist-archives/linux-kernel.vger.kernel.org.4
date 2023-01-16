Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E6F66BB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjAPKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAPKSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:18:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4411A95B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673864277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoqwI+WfW2YX1zBiZhXX6tIkshOZecUe6DtUqu/J1c4=;
        b=SangRvmns9bdyGzS0VniOdfKY2wq9FoJ4fvhx48leFa/tX+ayav2m5v6/jh0NQVciaJuwg
        2kwYkkfdxI2S1+qthWTRVc1SnUz9/j/r9p+sSvo9scFPwScfCC6Tvn5fvu6LxvtRJzWHo5
        Z7O70frSdIqqKIah/mxTL4Y7eJR6SrA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-FUYF5cAGMA6c7ywpaanXiA-1; Mon, 16 Jan 2023 05:17:56 -0500
X-MC-Unique: FUYF5cAGMA6c7ywpaanXiA-1
Received: by mail-wm1-f71.google.com with SMTP id z22-20020a05600c0a1600b003db00dc4b69so440905wmp.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoqwI+WfW2YX1zBiZhXX6tIkshOZecUe6DtUqu/J1c4=;
        b=H3c81GyCRfGoNj92ZMRS6+UNpiROVzHIEeMWuH+ZvR8j3yromty4I7IkLo4a0pL3ju
         wcSfJyChSHkYbvKDp1VldtrAyNqczetWeOQzABiHumZeM4B05sYbLc6E6KFf4w0UoeOr
         FaZPccU6/odYPxhn6KW3OiciC4VKE7Fgb582WBFBYhMdM19L371vNLrRM6FizPluruy4
         A8i2OH+JTCG3N2zVjq333IqvViOPakaqi0wF35xXj2oZvbjgl6nZMNx+gyNphPT3l6iL
         yVSTq9+OpCTQMJF78dXun+aVooDU5Yj5N6BTOaZXXhOtbknXWDtmwnZCSiLbiwGOaTOG
         m0hQ==
X-Gm-Message-State: AFqh2kr/fDDkNn9K6nJgWrH7lotJjXH4E2ayYlEMGoJ4cda7rcWS0a4P
        JIfnvEb2MYi+up8F6JMQYYWrJ/o2ZeK78HgPHsGcL0etHr1/7Xh7RtAGcywmflhZD0KpUbVVMTE
        Nh0iZHr0wLtr+yjXFHDRb8zHl
X-Received: by 2002:adf:f6cf:0:b0:2bc:858a:3def with SMTP id y15-20020adff6cf000000b002bc858a3defmr7286488wrp.5.1673864275294;
        Mon, 16 Jan 2023 02:17:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsw1f4fxhjEtEz+P+Gk5cOHrWmBaeN+EJ/aeu07b++MxfTtTmC697Oy/NM954Nv8W9cHtD2tQ==
X-Received: by 2002:adf:f6cf:0:b0:2bc:858a:3def with SMTP id y15-20020adff6cf000000b002bc858a3defmr7286475wrp.5.1673864275005;
        Mon, 16 Jan 2023 02:17:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1000:21d5:831d:e107:fbd6? (p200300cbc704100021d5831de107fbd6.dip0.t-ipconnect.de. [2003:cb:c704:1000:21d5:831d:e107:fbd6])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm25937199wrb.107.2023.01.16.02.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:17:54 -0800 (PST)
Message-ID: <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
Date:   Mon, 16 Jan 2023 11:17:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>
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
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com> <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
 <Y8AnROAtMngKntnq@x1n>
 <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
 <Y8BtJzBLTpw5IR+H@x1n>
 <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y8B8mW2zSWDDwp7G@x1n>
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

On 12.01.23 22:33, Peter Xu wrote:
> On Thu, Jan 12, 2023 at 04:17:52PM -0500, James Houghton wrote:
>> I'll look into it, but doing it this way will use _mapcount, so we
>> won't be able to use the vmemmap optimization. I think even if we do
>> use Hugh's approach, refcount is still being kept on the head page, so
>> there's still an overflow risk there (but maybe I am
>> misunderstanding).
> 
> Could you remind me what's the issue if using refcount on the small pages
> rather than the head (assuming vmemmap still can be disabled)?

The THP-way of doing things is refcounting on the head page. All folios 
use a single refcount on the head.

There has to be a pretty good reason to do it differently.

-- 
Thanks,

David / dhildenb

