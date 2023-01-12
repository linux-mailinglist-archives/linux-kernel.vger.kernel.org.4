Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC9667E26
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjALS3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjALS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:28:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428536535E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673546545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuKMi4vAJYMWUwbwRllSnbl5M+pgJqBDP4pp7tga73o=;
        b=bs0U7V9UTWoquzuqM2GbLNOtMkF5h6/mwjFcEB6BIYoU6qv+C5cXtXwIPbxxczYK6/kr4/
        H8jzWaqQ2uw+m4AMy0Q0t0Nz6kPz4Mxb2MBxDLs41pu4fGQGaDF8vo5d3H/flQiAGYMOjj
        C4ZYjZwUGUhremfPVwPsx+WFIUzHa5o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-NGe5B80ANLuindRui_G8EA-1; Thu, 12 Jan 2023 13:02:21 -0500
X-MC-Unique: NGe5B80ANLuindRui_G8EA-1
Received: by mail-pg1-f198.google.com with SMTP id h185-20020a636cc2000000b004820a10a57bso8616082pgc.22
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuKMi4vAJYMWUwbwRllSnbl5M+pgJqBDP4pp7tga73o=;
        b=yAbGiQAqGjrErC5sUtYPEf3U6GGrmn9Y8D96pOr0bzSsrHLJs7YIQaktfy2X+Yb4mr
         0IoydMVe0i+VNxlMJYsBTdV5FVWLiFLUXAeJNT/BmSSI5Zz1gEPE/CSXrRsA/yVAqCum
         uK3LybgCJLTWkzY+nEmDgUE5e2HLcNF+gLEjKC5MneT9npNPNPOQIhSHmH32TP4jaoQN
         RPcjgShFyF/AtnGqix/EzuQsmIiwyc8zTGCMY9o8julEUOHX3ytULhpXlDhvkoqqnlag
         0UkdiN+4s6pk1gOP8psgOw44JAKXBqwE1BqEaSKAvM161BWcq7AdAYV+8Ll71UkGXKEq
         W2hA==
X-Gm-Message-State: AFqh2krb44KDSTYsNA5ySwLWL2zH/3nQpipsqnJcnoitdwKJy6eBKI0P
        rOb/ovWmLsNTrtvKwc7fnpLKyiPLgGZVy5Cb4QN4kwQuS/4FeHNVZUJp10CQSqsHN7j4w+Qe/Se
        EcRnJdbAU/B6ax5Wy8KnaeCgG
X-Received: by 2002:a05:6a20:3c8a:b0:af:8128:757 with SMTP id b10-20020a056a203c8a00b000af81280757mr120011765pzj.61.1673546540385;
        Thu, 12 Jan 2023 10:02:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsoN+BSBshglAeGj72oNHRwP++X0YRFGcL+wPbNBshnFiV69BN5+ZvIPAlz55p9oWr0MchMqg==
X-Received: by 2002:a05:6a20:3c8a:b0:af:8128:757 with SMTP id b10-20020a056a203c8a00b000af81280757mr120011724pzj.61.1673546539983;
        Thu, 12 Jan 2023 10:02:19 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id r8-20020a05620a298800b006bb29d932e1sm11330704qkp.105.2023.01.12.10.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 10:02:18 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:02:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
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
Subject: Re: [PATCH 19/46] hugetlb: add HGM support for follow_hugetlb_page
Message-ID: <Y8BLKaKy9CUCy/vy@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-20-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105101844.1893104-20-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 10:18:17AM +0000, James Houghton wrote:
> @@ -6731,22 +6746,22 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 * and skip the same_page loop below.
>  		 */
>  		if (!pages && !vmas && !pfn_offset &&
> -		    (vaddr + huge_page_size(h) < vma->vm_end) &&
> -		    (remainder >= pages_per_huge_page(h))) {
> -			vaddr += huge_page_size(h);
> -			remainder -= pages_per_huge_page(h);
> -			i += pages_per_huge_page(h);
> +		    (vaddr + pages_per_hpte < vma->vm_end) &&
> +		    (remainder >= pages_per_hpte)) {
> +			vaddr += pages_per_hpte;

This silently breaks hugetlb GUP.. should be

                        vaddr += hugetlb_pte_size(&hpte);

It caused misterious MISSING events when I'm playing with this tree, and
I'm surprised it rooted here.  So far the most time consuming one. :)

> +			remainder -= pages_per_hpte;
> +			i += pages_per_hpte;
>  			spin_unlock(ptl);
>  			hugetlb_vma_unlock_read(vma);
>  			continue;
>  		}

-- 
Peter Xu

