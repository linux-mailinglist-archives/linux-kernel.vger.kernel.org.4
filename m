Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D0A65E6F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjAEIka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAEIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:40:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F284C719
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672907980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0EEGFVxQgHq62o0vTXA8Zrg5fmlPp4zowvFDCM/JBo=;
        b=Bs7Situ1gobQ5JG9NCxy//TPhjynX6FWWmpQeOU6m4WDBu5hsvCtOo+nD+NdziMt5X+CNY
        PaME3ZPFTaJmW/i3kvdQ2nD7tTuaWrocfu5fwx6KKo7ox44I1D99UhDabO3IIiRxoNXRgt
        70p5lC4uI8SYwGPiZhES72e8wKamqOg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-262-HbycfYoVOpuECagap_OnIQ-1; Thu, 05 Jan 2023 03:39:38 -0500
X-MC-Unique: HbycfYoVOpuECagap_OnIQ-1
Received: by mail-wm1-f71.google.com with SMTP id c23-20020a7bc857000000b003d97c8d4935so15153528wml.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 00:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0EEGFVxQgHq62o0vTXA8Zrg5fmlPp4zowvFDCM/JBo=;
        b=uKAX1EIoAaFeXKtk2HUthN/pSovDRvAsAJ/ji7/FGM7Sdu/DPaXMzU0nizenNUGvWt
         dK0PpQ9wj6tYBq2IS2E5TB1nGqtGU40uX2WgEeMEIu0Thz6wdjTo6cea2KlZlbO7FupC
         oqoqh0u95hoXQfVwJMFs3GOGAkC8ZZc50wzN1APdVhW0t1uDFRlpUlei6POufjGkcs/7
         IQvZaAPy0uEVFpkVvnVHTplUvcF4v5wqK6V/52e2tb4ezBmvYUmrIGSZwzNRJLvDYMcx
         K4S3+DRF39hQEh4h0uQ1tF6UlPpP77G6w/YAu1vV/off/tVkvTRKliSW2cwf8gDzimuy
         xgmQ==
X-Gm-Message-State: AFqh2krkRqz4oitR63aPgrbMRKlbr/6iomUdMYe0DnLJubWrFfR2x0cu
        dDwwe0Wr1x4vSxKPmJtrEucegpXyvfbUrtPlLUPAKjYbVJ8NrCQWvd8RkZxY0I9sIMaZNfYr52U
        YkCDz3E+mt/hbDDwXH/C5M1DE
X-Received: by 2002:a05:600c:4e09:b0:3d4:5741:af9b with SMTP id b9-20020a05600c4e0900b003d45741af9bmr39382072wmq.0.1672907976071;
        Thu, 05 Jan 2023 00:39:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt+eMzp4Or8SPLGMCE7Sk7rJ0RqIPD6WCkqertmKUjTxcUtwA44aRvdfXaiUEttQmz5pbu3bg==
X-Received: by 2002:a05:600c:4e09:b0:3d4:5741:af9b with SMTP id b9-20020a05600c4e0900b003d45741af9bmr39382056wmq.0.1672907975762;
        Thu, 05 Jan 2023 00:39:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003c6bbe910fdsm1908482wmq.9.2023.01.05.00.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 00:39:35 -0800 (PST)
Message-ID: <db5797a5-c4e9-753d-790a-3d432ac525e3@redhat.com>
Date:   Thu, 5 Jan 2023 09:39:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] mm/hugetlb: Pre-allocate pgtable pages for uffd
 wr-protects
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-stable <stable@vger.kernel.org>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230104225207.1066932-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.23 23:52, Peter Xu wrote:
> Userfaultfd-wp uses pte markers to mark wr-protected pages for both shmem
> and hugetlb.  Shmem has pre-allocation ready for markers, but hugetlb path
> was overlooked.
> 
> Doing so by calling huge_pte_alloc() if the initial pgtable walk fails to
> find the huge ptep.  It's possible that huge_pte_alloc() can fail with high
> memory pressure, in that case stop the loop immediately and fail silently.
> This is not the most ideal solution but it matches with what we do with
> shmem meanwhile it avoids the splat in dmesg.
> 
> Cc: linux-stable <stable@vger.kernel.org> # 5.19+
> Fixes: 60dfaad65aa9 ("mm/hugetlb: allow uffd wr-protect none ptes")
> Reported-by: James Houghton <jthoughton@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/hugetlb.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bf7a1f628357..017d9159cddf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6649,8 +6649,17 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>   		spinlock_t *ptl;
>   		ptep = hugetlb_walk(vma, address, psize);

if (!ptep && likely(!uffd_wp)) {
	/* Nothing to protect. */
	address |= last_addr_mask;
	continue;
} else if (!ptep) {
	...
}

Might look slightly more readable would minimize changes. This should 
work, so

Acked-by: David Hildenbrand <david@redhat.com>

>   		if (!ptep) {
> -			address |= last_addr_mask;
> -			continue;
> +			if (!uffd_wp) {
> +				address |= last_addr_mask;
> +				continue;
> +			}
> +			/*
> +			 * Userfaultfd wr-protect requires pgtable
> +			 * pre-allocations to install pte markers.
> +			 */
> +			ptep = huge_pte_alloc(mm, vma, address, psize);
> +			if (!ptep)
> +				break;
>   		}
>   		ptl = huge_pte_lock(h, mm, ptep);
>   		if (huge_pmd_unshare(mm, vma, address, ptep)) {

-- 
Thanks,

David / dhildenb

