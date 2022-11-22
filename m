Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA741633A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiKVKgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiKVKfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:35:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555E1114E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669113078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykdvRmIbS26no5A1EkFMoh8phJ/ZG+oZwyD+jstP4+s=;
        b=DbRfBoNeYA8VVXpiLDyXbLWur6IDlacIvgbCGfGo7mCmwiAM5mjnZUqqIMYY7/9QktXVRR
        J9J7TnRyrj4BCnBGronR/9xScRU4kdFwvRsDxhbdy60BWvquOTbjZdvnJPVd9y04OFwn3z
        G9eHt3wZDA7gGUcn+b2G0yJjhhdsO5Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-jl13lAToOUafREXBgpvJIA-1; Tue, 22 Nov 2022 05:31:15 -0500
X-MC-Unique: jl13lAToOUafREXBgpvJIA-1
Received: by mail-wm1-f69.google.com with SMTP id l42-20020a05600c1d2a00b003cf8e70c1ecso10796438wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykdvRmIbS26no5A1EkFMoh8phJ/ZG+oZwyD+jstP4+s=;
        b=nZbSjaGn6HvTJyDDLteR7m0jghK6tD+1s7lca0QbouZfYTITecMVW4INXSujLyHzQB
         3cowiu+IDLFZZS52xW+XaMx0vry9YtSmAAk8XsOickoiNaClQ2ujV+mTu8W44Ttf9LWj
         Cq/OVsIhcgStbUN/gjhxv/ZQk/2FddCNfikEO1zXfTNCwjuFo7MOHCLxQHyK/Im2gRwM
         cUS9wiIk3fq32/7/NPTw3zyaL4iMO2jjj+Hnjy4KMyIk6ckv2R42QC9qWSMFUt3wxENV
         YAzPHEyixeuJIvnMbmGjMav4xrmKLpYDN3yJfXqLvBZiF7Kogdywh7mRGUIaaWpXIjY9
         62og==
X-Gm-Message-State: ANoB5plpApW+oUV0YH+Ls+3c4SrLp9NK7zKQ/CZclu76xe8LgQ7xyUjb
        xHa46iVWPuAmZI7qDVMzmK1gUBOe31dl+PjIaAEIxeJi3xG3QGXvVNXY69YQcdUeckbjioWMCsq
        eTZgQ0HVqEYHUPD3ZE2Z9my/H
X-Received: by 2002:a05:6000:1cc:b0:241:a59b:ed46 with SMTP id t12-20020a05600001cc00b00241a59bed46mr2125167wrx.77.1669113074358;
        Tue, 22 Nov 2022 02:31:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5YrCgADMqGTwrj+bNENZSNnAZ5Qe05Ymq5Ia/pp3zudpklpoRD85CqIeoOGPx4XgHnEGIyXg==
X-Received: by 2002:a05:6000:1cc:b0:241:a59b:ed46 with SMTP id t12-20020a05600001cc00b00241a59bed46mr2125144wrx.77.1669113073978;
        Tue, 22 Nov 2022 02:31:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:c300:b066:75e3:f1d2:b69b? (p200300cbc706c300b06675e3f1d2b69b.dip0.t-ipconnect.de. [2003:cb:c706:c300:b066:75e3:f1d2:b69b])
        by smtp.gmail.com with ESMTPSA id l10-20020adff48a000000b002366ded5864sm13552937wro.116.2022.11.22.02.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 02:31:13 -0800 (PST)
Message-ID: <32015e19-fc00-b253-2664-6bb34ef1560e@redhat.com>
Date:   Tue, 22 Nov 2022 11:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221122175323.09ad723e@canb.auug.org.au>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: linux-next: build failure after merge of the mm tree
In-Reply-To: <20221122175323.09ad723e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.22 07:53, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> In file included from include/uapi/linux/posix_types.h:5,
>                   from include/uapi/linux/types.h:14,
>                   from include/linux/types.h:6,
>                   from include/linux/kasan-checks.h:5,
>                   from include/asm-generic/rwonce.h:26,
>                   from ./arch/powerpc/include/generated/asm/rwonce.h:1,
>                   from include/linux/compiler.h:247,
>                   from include/linux/build_bug.h:5,
>                   from include/linux/container_of.h:5,
>                   from include/linux/list.h:5,
>                   from mm/hugetlb.c:6:
> mm/hugetlb.c: In function 'add_hugetlb_page':
> include/linux/stddef.h:8:14: warning: passing argument 2 of 'set_page_private' makes integer from pointer without a cast [-Wint-conversion]
>      8 | #define NULL ((void *)0)
>        |              ^~~~~~~~~~~
>        |              |
>        |              void *
> mm/hugetlb.c:1533:32: note: in expansion of macro 'NULL'
>   1533 |         set_page_private(page, NULL);
>        |                                ^~~~
> In file included from include/linux/mmzone.h:21,
>                   from include/linux/gfp.h:7,
>                   from include/linux/mm.h:7,
>                   from mm/hugetlb.c:8:
> include/linux/mm_types.h:464:70: note: expected 'long unsigned int' but argument is of type 'void *'
>    464 | static inline void set_page_private(struct page *page, unsigned long private)
>        |                                                        ~~~~~~~~~~~~~~^~~~~~~
> 
> Caused by commit
> 
>    1f0d844bcc5b ("mm/hugetlb: stop using 0 as NULL pointer")
> 
> set_page_private() have taken an unsigned long as its second argument
> since (at least) v5.8-rc1.  The cited bugzilla refers to next-20221121,
> but even there:
> 
> $ git grep set_page_private next-20221121:include/linux/mm_types.h
> next-20221121:include/linux/mm_types.h:static inline void set_page_private(struct page *page, unsigned long private)
> 
> In fact the bugzilla refers to mm/hugetlb.c line 1531.  In next-20221121
> that is:
> 
>          folio_change_private(folio, 0);
> 
> I have reverted that commit for today.  Please take more care :-(
> 

Heh, that warning complains about the call to folio_change_private():

$ git show e4cd8d3ff7f9efeb97330e5e9b99eeb2a68f5cf9:mm/hugetlb.c | sed -n '1531p'
         folio_change_private(folio, 0);

And that one is indeed:

$ git grep folio_change_private e4cd8d3ff7f9efeb97330e5e9b99eeb2a68f5cf9:include/linux/pagemap.h
e4cd8d3ff7f9efeb97330e5e9b99eeb2a68f5cf9:include/linux/pagemap.h: * folio_change_private - Change private data on a folio.
e4cd8d3ff7f9efeb97330e5e9b99eeb2a68f5cf9:include/linux/pagemap.h:static inline void *folio_change_private(struct folio *folio, void *data)


I missed in my review that the patch changes set_page_private()
instead because it was applied to the wrong tree ...


The folio_change_private() change is/was from Sidhartha Kumar:


commit 032158fde0b2a59cda2c66a8773135af2a04535e
Author: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Date:   Thu Nov 17 13:14:57 2022 -0800

     mm/hugetlb: convert add_hugetlb_page() to folios and add hugetlb_cma_folio()
     
     Convert add_hugetlb_page() to take in a folio, also convert
     hugetlb_cma_page() to take in a folio.
     
     Link: https://lkml.kernel.org/r/20221117211501.17150-7-sidhartha.kumar@oracle.com
     Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

-- 
Thanks,

David / dhildenb

