Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21207363EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjFTHCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjFTHCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E067CE4D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687244491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4nP6ZoAOV09d+oi+b7tvDAzdD2oINBI0GeeIWlxKJYo=;
        b=XJTfpUI14BG2LveocOiz+lzZTN33LyFB3SQ/vWqY9Erhye0WF2yM9nWsL7EoF2XqweOH69
        RtB+kzTEyxT9+2NE5ijBEhMmGEWkgn2FN5zEWgmNxfj26XlTPR08xYfbCuG/lsiiOznv9o
        ZreaduDHWH8UB6nAp1NsaRY0H0n46U4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-zLEhwWlZOKeyzwT5eXTl_Q-1; Tue, 20 Jun 2023 03:01:28 -0400
X-MC-Unique: zLEhwWlZOKeyzwT5eXTl_Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f9b5bbd79aso3715815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687244486; x=1689836486;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nP6ZoAOV09d+oi+b7tvDAzdD2oINBI0GeeIWlxKJYo=;
        b=JyxfSFOskfko94vk979Rc+GumjIq+HWCSxsKOGWyeJtrTeYTQQ2QKAjpffTkS0m/2q
         k/5nxJAwqzwjRIGZjxSDe/X8vjtXHq7tQycETDwoc+B3o2Wm8T+tPHAcZtQEZy0x0OiP
         xgAmesPjYg/7uvVrtoB385LNVDhPB+qpx3/p5teQtzIoBTbujoh/rgyelDo5ZPEcBXUD
         W04dMg9m2eEMbu8+I7iFeEzHtbmMB/6jvaCuTcDGUVwx0ojtcthn6ETNkzVPqoRJpTZq
         7o6fXmXXDSov5aGXxwjgAozCJbsmEMXNy5oh4zFdCBwVx+wf9ymYX2hJ4szIxm0biWQM
         avsg==
X-Gm-Message-State: AC+VfDwOEZYLItAL+uLbyhoxqSe9FuQfOVY6wMfENJp+chNlQSPBRaSw
        ZV3L2wQYdZCY1nLwCOCfAGfR8RuKY6FtmVh7fi53IHpWo/vxE0bKqeMf2ExKWEVMT8xcTHTPdq7
        wCA7TnefYBQ75SOuhlGDeVPw9
X-Received: by 2002:a05:600c:b4d:b0:3f8:fbb6:c17e with SMTP id k13-20020a05600c0b4d00b003f8fbb6c17emr6977637wmr.20.1687244486327;
        Tue, 20 Jun 2023 00:01:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Z02pit2Yxc/YAdscK4ehXZIK4w4/7to93F0O2TrhC1WoDCfwsI+GEqSHr4XjUrJ63GgfUlQ==
X-Received: by 2002:a05:600c:b4d:b0:3f8:fbb6:c17e with SMTP id k13-20020a05600c0b4d00b003f8fbb6c17emr6977622wmr.20.1687244485963;
        Tue, 20 Jun 2023 00:01:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:d200:8745:c520:8bf6:b587? (p200300cbc739d2008745c5208bf6b587.dip0.t-ipconnect.de. [2003:cb:c739:d200:8745:c520:8bf6:b587])
        by smtp.gmail.com with ESMTPSA id q4-20020adff784000000b0030aec5e020fsm1241014wrp.86.2023.06.20.00.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 00:01:24 -0700 (PDT)
Message-ID: <24f4a22e-7d3b-544b-320f-bba5abb92285@redhat.com>
Date:   Tue, 20 Jun 2023 09:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-4-peterx@redhat.com> <ZJDMFDUZdGngQbzw@x1n>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/7] mm/hugetlb: Add page_mask for
 hugetlb_follow_page_mask()
In-Reply-To: <ZJDMFDUZdGngQbzw@x1n>
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

On 19.06.23 23:43, Peter Xu wrote:
> On Tue, Jun 13, 2023 at 05:53:42PM -0400, Peter Xu wrote:
>> @@ -6506,6 +6507,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>>   		 * because we hold the ptl lock and have verified pte_present().
>>   		 */
>>   		WARN_ON_ONCE(try_grab_page(page, flags));
>> +		*page_mask = huge_page_mask(h);
> 
> Sorry, I was wrong this line.  It should be:
> 
> 		*page_mask = ~huge_page_mask(h) >> PAGE_SHIFT;
> 

That's ... surprising. It feels like either page_mask or 
huge_page_mask() has a misleading name ....

h->mask = ~(huge_page_size(h) - 1);


For PMDs, we do

ctx->page_mask = HPAGE_PMD_NR - 1;


Maybe

*page_mask = PHYS_PFN(huge_page_size(h)) - 1;

Would be clearer.

I guess "page_mask" should actually be "pfn_mask" ... but the meaning 
regarding PAGE_MASK are still inverted ...

-- 
Cheers,

David / dhildenb

