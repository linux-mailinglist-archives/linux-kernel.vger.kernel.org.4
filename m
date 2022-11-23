Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A029C6356AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiKWJc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiKWJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:31:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9806F2189F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669195761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UK8W/f6JX0V0buNKgwaW7N3X4d6jcuFhKnmILB+4f5c=;
        b=ao7KSc5zfc+wA47s+rsR/ZM4qXOzrbzQfHSgFZAbTl9bf2/nyiOmnuo5cXa7JmFFnD1JHa
        nC4wJ1RyK7rKFKCMt5aqZIgDWyiRSgrrxo21+gPFiIDZEKY6Sa1TGZwSkuAQthVicco3Gj
        mt3lcaiD7lYm2SiOjxo7DUxpiF9gpMI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-120-PmT_8PIbMAWecP6RIrSLkw-1; Wed, 23 Nov 2022 04:29:18 -0500
X-MC-Unique: PmT_8PIbMAWecP6RIrSLkw-1
Received: by mail-wm1-f72.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso9369478wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK8W/f6JX0V0buNKgwaW7N3X4d6jcuFhKnmILB+4f5c=;
        b=fKPEt6PAelWv3ZzI9i+JVo4G+86EFoHV+2hi5lCiyUZHG7dkOPolTV4x8F7/UquS7D
         swVr6Uqfwbua+uEWD0ovmNJDpRcL1VSf46noUpNAo62K2h+Kt9/7fjxljV8z24p+VoK5
         mqDfU28CQC6w/+yvLoez8N+dj4LFbzrE+vy69cAsTzpns8ZBoNB0t1iTAVQ82N8ds4mW
         WPMc/TcYKIBqfbqNZZdcAwZjz54rrInb8Rc+6gL8tI1B4JnBrGwKhWkQ/P3cUC7L8x+k
         FsJ9vJXe1aqZSR53xfRdsLBxWrfePQBW1rqaUHFt3jCLbJm5lWb1RvflIm3vyOEufcKI
         ixlA==
X-Gm-Message-State: ANoB5pmstzFHuEZUNQFsA34hmYYY+oRQ7a5X3a6moSMcvw7RU7fTldKe
        X33OJ30dPX1SDMk6rAR2kFWgmGdqOwhGf3nppDNDohOTk4U9fUn7kUcO+yyiDOiz4aN4QkUvpQX
        TLnvAX+ZJVSXu9PKshxV+0QSz
X-Received: by 2002:a05:600c:2213:b0:3cf:a6eb:3290 with SMTP id z19-20020a05600c221300b003cfa6eb3290mr12096287wml.116.1669195757287;
        Wed, 23 Nov 2022 01:29:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7/opCgmSRLhbgLaahs3dmcIF2YGbvr3mHchJssUcljoxsHHnw+Uj8AEtvdzDFHmHTRUpp1JQ==
X-Received: by 2002:a05:600c:2213:b0:3cf:a6eb:3290 with SMTP id z19-20020a05600c221300b003cfa6eb3290mr12096266wml.116.1669195756960;
        Wed, 23 Nov 2022 01:29:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id d9-20020adfef89000000b00241dd5de644sm5961918wro.97.2022.11.23.01.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 01:29:16 -0800 (PST)
Message-ID: <224b7bb5-6e82-7894-b5d4-44abd3c411dc@redhat.com>
Date:   Wed, 23 Nov 2022 10:29:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v4 06/10] mm/hugetlb: convert
 add_hugetlb_page() to folios and add hugetlb_cma_folio()
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com
References: <20221118222002.82588-1-sidhartha.kumar@oracle.com>
 <20221118222002.82588-7-sidhartha.kumar@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221118222002.82588-7-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.22 23:19, Sidhartha Kumar wrote:
> Convert add_hugetlb_page() to take in a folio, also convert
> hugetlb_cma_page() to take in a folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

[...]

>   
> @@ -1525,21 +1525,21 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
>   		h->surplus_huge_pages_node[nid]++;
>   	}
>   
> -	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> -	set_page_private(page, 0);
> +	folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
> +	folio_change_private(folio, 0);
>

As raised (CC'ed you), this should be s/0/NULL/

-- 
Thanks,

David / dhildenb

