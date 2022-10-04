Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47365F42D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJDMUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJDMUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D401F2EA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664886010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vtxTBoFKlQS05YjdzP5SgsxHgg1muVOwrB43RAkVuE=;
        b=T+Xv7SWBpxaBC5QuIz5JIs60+Oe9nkcPk5gFfNhObuw4jf3ErNusmxy7035AKA8EKRMQZV
        WE7WKHVDuVl634H4H2grhtyKoQHtUe/o/kiuGAyhUZnLNt1sJa8UwbApy25ojIUwUJVlFE
        BBwwiTS1qMLcEh3WA+Sh4PtqmE+awEc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-o0m4P9uIM1qzhB5Wy2BrSA-1; Tue, 04 Oct 2022 08:20:09 -0400
X-MC-Unique: o0m4P9uIM1qzhB5Wy2BrSA-1
Received: by mail-wr1-f72.google.com with SMTP id q28-20020adfab1c000000b0022e0399964dso2809428wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=7vtxTBoFKlQS05YjdzP5SgsxHgg1muVOwrB43RAkVuE=;
        b=oaNqM4vs7HazwLMHVz+2VcSL9ftP80IR3Fs2AYbSnOHkkS3lP35Z8MJ0HuJzRldS8u
         uiHijXR/tBfJUnR9CwFyzBGjFQvsMJSmARDjkfGxLuBnDGhrQ+s2vFLmNtvv8o6NNVtb
         U4/CGZYyO+Qxj+qpOPAttZ47bv89eAbTEujRPXcH0AoeqAxjYjemn2tkJ7LxrMZjfSny
         gRlvcSJmMuIBOCBxZ21s+ANT2UzcX2AV0gaXwXGZBMvwEYNsiWFIpPrBi6fYuIzxti6F
         OXm88IEB+hDVOD8exLUdRkJ8f6cOcW+uLp4PZwi/HaqYpg/4QRetr4z9G+xOgwI80v8D
         oQdw==
X-Gm-Message-State: ACrzQf178NO33MDqosxGdLim8TTn/YTp/QW+T+D5tnRbExuESoVxTed3
        w69gS0l9LzbWVywjyKEyJpa7c2OdXz9T052+MaeUbFJFw56cGYCWBgyAYndVWiEWFo2NOVq+9QP
        WUR752GkJgVU5tdTlB7zF8blo
X-Received: by 2002:a05:600c:4f44:b0:3b4:c554:a5f4 with SMTP id m4-20020a05600c4f4400b003b4c554a5f4mr9685970wmq.107.1664886008531;
        Tue, 04 Oct 2022 05:20:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7kugkKbZzSz2OLcnoNvR7uSkMYCxhboeGC3xGx/kNpQflkcGlpm/s0nPsGNtz+RLLf6t0aTw==
X-Received: by 2002:a05:600c:4f44:b0:3b4:c554:a5f4 with SMTP id m4-20020a05600c4f4400b003b4c554a5f4mr9685947wmq.107.1664886008255;
        Tue, 04 Oct 2022 05:20:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:5000:4fff:1dd6:7868:a36? (p200300cbc70650004fff1dd678680a36.dip0.t-ipconnect.de. [2003:cb:c706:5000:4fff:1dd6:7868:a36])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d5148000000b0022e04bfa661sm10918272wrt.59.2022.10.04.05.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 05:20:07 -0700 (PDT)
Message-ID: <9ac201f6-6295-c606-305f-00cafd099313@redhat.com>
Date:   Tue, 4 Oct 2022 14:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/3] mm/hugetlb: Use hugetlb_pte_stable in migration
 race check
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20221004003705.497782-1-peterx@redhat.com>
 <20221004003705.497782-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221004003705.497782-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.22 02:37, Peter Xu wrote:
> After hugetlb_pte_stable() introduced, we can also rewrite the migration
> race condition against page allocation to use the new helper too.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index fa3fcdb0c4b8..e762c5369a6f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5620,11 +5620,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>   			 * here.  Before returning error, get ptl and make
>   			 * sure there really is no pte entry.
>   			 */
> -			ptl = huge_pte_lock(h, mm, ptep);
> -			ret = 0;
> -			if (huge_pte_none(huge_ptep_get(ptep)))
> +			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
>   				ret = vmf_error(PTR_ERR(page));
> -			spin_unlock(ptl);
> +			else
> +				ret = 0;
>   			goto out;
>   		}
>   		clear_huge_page(page, address, pages_per_huge_page(h));

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

