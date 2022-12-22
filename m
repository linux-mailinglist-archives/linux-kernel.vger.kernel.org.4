Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD99165480A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiLVVsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiLVVsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:48:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8626027CD2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671745647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVtYaeUGi9GwUE/KA7kWj0SMy+I1gEo3xn9XDp+mYsE=;
        b=KXqERYv0IObLSDl1FyPFddfRMr4oR/fF3bYSr6bjMpHj+wZNhx5BSFV467e5XamD2jJ9/Q
        u6asHcx8n8y17aEO7Goz/NnX9sgnOu3eDVYtwR4yJdBJtBtkCL3+mjDNMduV6p9KAm7MbD
        JPPJkU5m2YSpdC8zryLgpeW2y6osnTs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-rDIvYSESOzGIMJVYaoJCtw-1; Thu, 22 Dec 2022 16:47:26 -0500
X-MC-Unique: rDIvYSESOzGIMJVYaoJCtw-1
Received: by mail-qt1-f199.google.com with SMTP id l11-20020ac8148b000000b003a81fbc3b3bso1246528qtj.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVtYaeUGi9GwUE/KA7kWj0SMy+I1gEo3xn9XDp+mYsE=;
        b=PjWF8qe0s+S/TbntIHkqCiL5VRXLBTlqVVa/fh4kd56YdbfpJPcVAl2FlEX+Lsd83g
         HMavqGQ1fy9q6vbLT97BM627Mols4WXqYDTPdCPLyW7+slRYYdiveWiznADbMReKlZdE
         144BblSGQIcGZjtejlx8onLqhSCFcQk/Ea75G5Gd2vQWnMAd/50sP7VGgv8qJGC91E1W
         gX4DbAdH63BQt+16q8Ri2A9LBCcA4TesGc4oJe7ubIC7nUqhhUMoz6Zb2Qmpc8kC6IgU
         ecXJzwmYoQ096rIzXZ0QhZfyDRDDqNrthJkdyIQIBarZHltG/i4QW+thbo4B3cqg1A7q
         p34g==
X-Gm-Message-State: AFqh2ko97ISfyct0CI09CZgCOHaO5zhhY4o2Yjd1IUHSu+9deJxKn9N6
        LuaR2KMEJMD1IUu5IjbLvMRNTTNrG3wL+V7kd2B8lR+KhDsc17albE97ZkwacpyTowd7/mJLRxI
        7y+UXPY+80oL+nz0GucCVDPFy
X-Received: by 2002:a0c:ca0e:0:b0:4c7:28fd:e9b1 with SMTP id c14-20020a0cca0e000000b004c728fde9b1mr10084344qvk.41.1671745645684;
        Thu, 22 Dec 2022 13:47:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvWEr+Y3tnkwJ3+umXo/u+mUqyVAZ4GvK+tr8jgg2wwTAy6sMMnRAo5w17f6Fgr4G6H/rI6AA==
X-Received: by 2002:a0c:ca0e:0:b0:4c7:28fd:e9b1 with SMTP id c14-20020a0cca0e000000b004c728fde9b1mr10084322qvk.41.1671745645444;
        Thu, 22 Dec 2022 13:47:25 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id q12-20020a05620a2a4c00b006fef61300fesm1060738qkp.16.2022.12.22.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 13:47:24 -0800 (PST)
Date:   Thu, 22 Dec 2022 16:47:21 -0500
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
Subject: Re: [RFC PATCH v2 35/47] userfaultfd: require
 UFFD_FEATURE_EXACT_ADDRESS when using HugeTLB HGM
Message-ID: <Y6TQaZaB+PKObfNs@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-36-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-36-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:51PM +0000, James Houghton wrote:
> @@ -1990,6 +1990,17 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>  		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
>  #ifndef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
>  	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS_HGM;
> +#else
> +
> +	ret = -EINVAL;
> +	if ((uffdio_api.features & UFFD_FEATURE_MINOR_HUGETLBFS_HGM) &&
> +	    !(uffdio_api.features & UFFD_FEATURE_EXACT_ADDRESS))

This check needs to be done upon "features" or "ctx_features", rather than
"uffdio_api.features".  The latter is the one we'll report to the user only.

> +		/*
> +		 * UFFD_FEATURE_MINOR_HUGETLBFS_HGM is mostly
> +		 * useless without UFFD_FEATURE_EXACT_ADDRESS,
> +		 * so require userspace to provide both.
> +		 */
> +		goto err_out;
>  #endif  /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
>  #endif  /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>  
> -- 
> 2.38.0.135.g90850a2211-goog
> 
> 

-- 
Peter Xu

