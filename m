Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B100F62C4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiKPQh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiKPQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91ED5E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668616207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLeAHhTgIs3sfF0MHUgRVFm01Nu2oqFmzIWBikyuyGo=;
        b=TOZnenHxCWzEVjRyySb75u2lu6ABqujaa3kJvCbe7+q1Q3DrsAXB4wBtfv7cix/u21BMvf
        JN9ddsNqXiAi7UBVwRTukWTG55xHF/p7Gd9XmRaNvIkGNM7BSHryr76LMnfDAgNcLnhLL7
        pOd+LJmjlszGG1n/ruMnKo2TkT6qgEc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-HrR3VGPDN66sbe80GZteLg-1; Wed, 16 Nov 2022 11:30:05 -0500
X-MC-Unique: HrR3VGPDN66sbe80GZteLg-1
Received: by mail-qt1-f197.google.com with SMTP id u31-20020a05622a199f00b003a51fa90654so13394499qtc.19
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLeAHhTgIs3sfF0MHUgRVFm01Nu2oqFmzIWBikyuyGo=;
        b=fzPNj4frlraiI5hI66oyxvtrMpGFifOgod/fP0NAGVB7jdZWg035iWB1+hVTZmUdVu
         wNjIfWOkB5OFdfSOPwrvQ4njUMh2ThfKEPqcaxBCoV+hnp6bFMp08ojKhS05kc2diTEx
         Sh//HqT8scd/0c8KlYlirJqUqfFrjWYN9IlvQtexePF5ASBnGsQNGSjCZ/T9aEOv+TUY
         cdVXCfWW67iUNcDCEMpJypez/pQpZ2akg4h1Sf0dF5ZqZOHexiDM5K2R2CJRm4hPmJFN
         43yGsEUVbqiMfvs5HFMJ9nDFQVnZdYFVS+G0K256Hpi/9UalrhSjYGoeykUZUorwBVOd
         2WmA==
X-Gm-Message-State: ANoB5pmnFOUmR+KHh6r4DBICqFa/s5gtwUoHCncaTGS/39dLK/4lAlyA
        fi+V21/Yafdc/LkxAZASopJNq/6d8I9Ov89gbj7r5Gmd2xqJsonOSsNY/yK8UguZlGy4os9PFoF
        +QpXkpILeRjQ5FYz/LNEI8gec
X-Received: by 2002:ac8:5982:0:b0:35c:ea7a:fcac with SMTP id e2-20020ac85982000000b0035cea7afcacmr22070714qte.172.1668616204834;
        Wed, 16 Nov 2022 08:30:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4H4ODhyaAdfXNNQskKRrtkGtobSVhMccIg90++BBAIaHrmD9mUQVq4LxT2Id/oKQmu/YsDcA==
X-Received: by 2002:ac8:5982:0:b0:35c:ea7a:fcac with SMTP id e2-20020ac85982000000b0035cea7afcacmr22070695qte.172.1668616204607;
        Wed, 16 Nov 2022 08:30:04 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id o23-20020ac872d7000000b0039a610a04b1sm8938544qtp.37.2022.11.16.08.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:30:04 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:30:02 -0500
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
Subject: Re: [RFC PATCH v2 01/47] hugetlb: don't set PageUptodate for
 UFFDIO_CONTINUE
Message-ID: <Y3UQCmlnQXfKhbyE@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-2-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-2-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:17PM +0000, James Houghton wrote:
> This is how it should have been to begin with. It would be very bad if
> we actually set PageUptodate with a UFFDIO_CONTINUE, as UFFDIO_CONTINUE
> doesn't actually set/update the contents of the page, so we would be
> exposing a non-zeroed page to the user.
> 
> The reason this change is being made now is because UFFDIO_CONTINUEs on
> subpages definitely shouldn't set this page flag on the head page.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1a7dc7b2e16c..650761cdd2f6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6097,7 +6097,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	 * preceding stores to the page contents become visible before
>  	 * the set_pte_at() write.
>  	 */
> -	__SetPageUptodate(page);
> +	if (!is_continue)
> +		__SetPageUptodate(page);
> +	else
> +		VM_WARN_ON_ONCE_PAGE(!PageUptodate(page), page);

Yeah the old code looks wrong, I'm just wondering whether we can 100%
guarantee this for hugetlb.  E.g. for shmem that won't hold when we
uffd-continue on a not used page (e.g. by an over-sized fallocate()).

Another safer approach is simply fail the ioctl if !uptodate, but if you're
certain then WARN_ON_ONCE sounds all good too.  At least I did have a quick
look on hugetlb fallocate() and pages will be uptodate immediately.

>  
>  	/* Add shared, newly allocated pages to the page cache. */
>  	if (vm_shared && !is_continue) {
> -- 
> 2.38.0.135.g90850a2211-goog
> 
> 

-- 
Peter Xu

