Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0DF65F6BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbjAEW1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjAEW1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:27:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED065FE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672957575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IvPxEpTqXtyv3jPthKSvUzNzJwMMt3hI7F3eNQ4EAdY=;
        b=LTMJ7+Py174MOODDqZAjEJf3kphbmz9GV91kmHkJMC7r2Giqr+vC34zGOkpnDo+Zrdcidr
        9+O8wdYc8ILaS2FTomAqLVgU3y1zaZUdlYif8OCKHumXzaN+Q9hJbYsT1pJvOkSeJVLZKt
        /QMQvhg6zgpiFfo/zSexzM+3EnBNFdc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-578-4hUeRlc3MKKUrTHsSYWX6A-1; Thu, 05 Jan 2023 17:26:13 -0500
X-MC-Unique: 4hUeRlc3MKKUrTHsSYWX6A-1
Received: by mail-qv1-f72.google.com with SMTP id p11-20020ad451cb000000b005319296a239so13125684qvq.18
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 14:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvPxEpTqXtyv3jPthKSvUzNzJwMMt3hI7F3eNQ4EAdY=;
        b=cTrsyRHDI3c4OEbflVIMDb5dww5R6JEu3xYveLq30MMRBJZGypJhECzJXJfQIfKUiY
         W2ARd56fZ93heyANIjEmLRI/vUJUd08ZwlZYMBY6Aw/hUJtVOsuYIhPh/GgfakNZHTz1
         1eTVb7wPJaqfZWWKX7awvcVQnZst1YKFLnKG/4B2gBo/M4nUnDek6IyBKq1dCl9TLp+i
         8zU9ZhG0s54HeSVTdbKu2f7fDVca/9kU9xS8xvPWWMPdHD2A8801AIbziF0aCK4jvoQJ
         01KDXrZXOrpTdI2Q6jMZof6KLtUexwpoN1UQzz/MdRM1LKOU6g69bDJwtLEqchGcNADo
         2+EA==
X-Gm-Message-State: AFqh2kqY1TF/9LTB7gkywAUIYMf3QYUuICAi92HFA9FyONMcWxr4Rc2C
        pid1XR8JqFKWaFJer/xXkYRoiUmxVCzlVvVBhFtRsupoMGsj4i49nYomxpp1r4Ek9iYDi19vCGg
        +t8Q1Q+adE9/ApIRFYhApom/u
X-Received: by 2002:a05:6214:3713:b0:531:bb5a:3418 with SMTP id np19-20020a056214371300b00531bb5a3418mr31017100qvb.13.1672957573476;
        Thu, 05 Jan 2023 14:26:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvlh5vTKXAN6X3RwzuxulxYHvMHYtS6OyYFdVUWguCIQMkh/0wbkI2XdoM34wDVpB21C2U6/Q==
X-Received: by 2002:a05:6214:3713:b0:531:bb5a:3418 with SMTP id np19-20020a056214371300b00531bb5a3418mr31017078qvb.13.1672957573300;
        Thu, 05 Jan 2023 14:26:13 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id l16-20020a37f910000000b006ef1a8f1b81sm26439445qkj.5.2023.01.05.14.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:26:12 -0800 (PST)
Date:   Thu, 5 Jan 2023 17:26:10 -0500
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
Message-ID: <Y7dOghlx5CDQtHyF@x1n>
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
> @@ -6649,13 +6655,20 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 */
>  		if (absent && (flags & FOLL_DUMP) &&
>  		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
> -			if (pte)
> +			if (ptep)
>  				spin_unlock(ptl);
>  			hugetlb_vma_unlock_read(vma);
>  			remainder = 0;
>  			break;
>  		}
>  
> +		if (!absent && pte_present(pte) &&
> +				!hugetlb_pte_present_leaf(&hpte, pte)) {
> +			/* We raced with someone splitting the PTE, so retry. */
> +			spin_unlock(ptl);

vma unlock missing here.

> +			continue;
> +		}

-- 
Peter Xu

