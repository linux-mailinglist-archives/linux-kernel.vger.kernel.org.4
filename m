Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A816602D6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjAFPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjAFPOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:14:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9303780AFA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673018006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vvgD97kU9+qL6QG9gHAa/Xv7qOhCnerL5qxmQkJWWRU=;
        b=S4W5IiEH87D/5Lj5NUTU/tpDdgAJ20erRIgYWJvVX915DKZLBkizBlR8PE0QfYHwv0pxVE
        dUrcD/PmK8CVz0sATPAZRXzi/PGBa7Fra7UqU1UQZ1/X3r6nQDChWQxsNc1y4KzQKOPDQd
        RIEV4dp2RBenSsLf+iKlVJloFDzSmog=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-78-D-HdO6c6MbeoP8lGewUIBw-1; Fri, 06 Jan 2023 10:13:25 -0500
X-MC-Unique: D-HdO6c6MbeoP8lGewUIBw-1
Received: by mail-il1-f198.google.com with SMTP id z19-20020a921a53000000b0030b90211df1so1267662ill.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 07:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvgD97kU9+qL6QG9gHAa/Xv7qOhCnerL5qxmQkJWWRU=;
        b=4FprfzIQ3dGU+Jk20KMO3LuRsYjhj9XeDdQstJqLY/GmiAzkwMjpLBN97opnvmYfwg
         Ub63wX4U7wzDCanlYRlqI2zHDPqQwDMRIxOUacoLL2X21bby5ot3kL2Aj7tYOtfm1tq3
         3wb1XfR867AkPu2cVwLOSkUht1rmOWC/aAHSLR6iYusDRNEsfj6BQILXOfTbSoQkUnpD
         XK/9r7qrEVUyepCLOTAf9J4rOr3y6Y1zsLQCTp6gSQ+dLuoVhtQNnoC3KIuyGF+ewbjg
         Y4FPekfYpEMR2sTxviRu8wzCxvXZGUsIqMwiUKCHvUJI0g4E4I10+amwYHY7JklKoiHB
         RfnA==
X-Gm-Message-State: AFqh2kou/dDPfGixlNBVd9fE7+LEU2qltNAlkndpUkF6mrk2PTUHC90V
        lZWkXc6f8Wqb3YMhc+fNbMYJPw/U4/E6qOEA51ZwklGGr/HiStGIiGkSw9v5yrMBB23CtlH0aN9
        CEG6LsJ0NAQ22cO/j0/l+2DIm
X-Received: by 2002:a92:bf0c:0:b0:30c:3c0:7a56 with SMTP id z12-20020a92bf0c000000b0030c03c07a56mr24217607ilh.5.1673018004595;
        Fri, 06 Jan 2023 07:13:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs3hQLfmCVyQgkBZC8bBnFmi+ERVvFTRai4qzR4899jssfiWjGnVGb901SbWzQdZA/o/Zn/ZA==
X-Received: by 2002:a92:bf0c:0:b0:30c:3c0:7a56 with SMTP id z12-20020a92bf0c000000b0030c03c07a56mr24217586ilh.5.1673018004392;
        Fri, 06 Jan 2023 07:13:24 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id s11-20020a92cc0b000000b0030380d1e24bsm444093ilp.30.2023.01.06.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 07:13:23 -0800 (PST)
Date:   Fri, 6 Jan 2023 10:13:14 -0500
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
Subject: Re: [PATCH 34/46] hugetlb: userfaultfd: when using MADV_SPLIT, round
 addresses to PAGE_SIZE
Message-ID: <Y7g6ihsCTIC765CO@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-35-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105101844.1893104-35-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 10:18:32AM +0000, James Houghton wrote:
> MADV_SPLIT enables HugeTLB HGM which allows for UFFDIO_CONTINUE in
> PAGE_SIZE chunks. If a huge-page-aligned address were to be provided,
> userspace would be completely unable to take advantage of HGM. That
> would then require userspace to know to provide
> UFFD_FEATURE_EXACT_ADDRESS.
> 
> This patch would make it harder to make a mistake. Instead of requiring
> userspace to provide UFFD_FEATURE_EXACT_ADDRESS, always provide a usable
> address.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5af6db52f34e..5b6215e03fe1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5936,28 +5936,27 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>  						  unsigned long addr,
>  						  unsigned long reason)
>  {
> +	u32 hash;
> +	struct vm_fault vmf;
> +
>  	/*
>  	 * Don't use the hpage-aligned address if the user has explicitly
>  	 * enabled HGM.
>  	 */
>  	if (hugetlb_hgm_advised(vma) && reason == VM_UFFD_MINOR)
> -		haddr = address & PAGE_MASK;
> -
> -	u32 hash;
> -	struct vm_fault vmf = {
> -		.vma = vma,
> -		.address = haddr,
> -		.real_address = addr,
> -		.flags = flags,
> +		haddr = addr & PAGE_MASK;
>  
> -		/*
> -		 * Hard to debug if it ends up being
> -		 * used by a callee that assumes
> -		 * something about the other
> -		 * uninitialized fields... same as in
> -		 * memory.c
> -		 */
> -	};
> +	vmf.vma = vma;
> +	vmf.address = haddr;
> +	vmf.real_address = addr;
> +	vmf.flags = flags;

Const fields here:

mm/hugetlb.c: In function ‘hugetlb_handle_userfault’:
mm/hugetlb.c:5961:17: error: assignment of member ‘vma’ in read-only object
 5961 |         vmf.vma = vma;
      |                 ^ 
mm/hugetlb.c:5962:21: error: assignment of member ‘address’ in read-only object
 5962 |         vmf.address = haddr;   
      |                     ^      
mm/hugetlb.c:5963:26: error: assignment of member ‘real_address’ in read-only object                                                                                                          
 5963 |         vmf.real_address = addr;

> +	/*
> +	 * Hard to debug if it ends up being
> +	 * used by a callee that assumes
> +	 * something about the other
> +	 * uninitialized fields... same as in
> +	 * memory.c
> +	 */

PS: I think we can drop this along the way.

>  
>  	/*
>  	 * vma_lock and hugetlb_fault_mutex must be dropped before handling
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
Peter Xu

