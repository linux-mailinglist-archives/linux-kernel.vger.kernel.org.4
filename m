Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85567D8C1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjAZWtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAZWtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ECFB463
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674773291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLBfAkoL6ZyX3A8oP3kQ2yLyRZ4PLk/qBUxFp+JImYg=;
        b=HUQ2mHEq3s3CG1Ww+MBKO9fcfG9/vxGWDM5tppBs+ff1jJiMJM75D+QyL2yJCqgWk5KeFW
        MtD/yDQQuB3yHUJKMtRmBYVVdN4wFlxPq9ZgarNyTTsKhRoEX8hHLRb1RMorpKSP1zPIk5
        QZ2LWYBm20JHGbVmKeFdFbMLFM4TwcI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-h6QLkUJ0NVqUeOP5aibHYQ-1; Thu, 26 Jan 2023 17:48:10 -0500
X-MC-Unique: h6QLkUJ0NVqUeOP5aibHYQ-1
Received: by mail-qv1-f70.google.com with SMTP id l6-20020ad44446000000b00537721bfd2dso1869851qvt.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLBfAkoL6ZyX3A8oP3kQ2yLyRZ4PLk/qBUxFp+JImYg=;
        b=4mNJgaT1wtoFCMRsRpzyUVph6LTXkLft0XCd5L+hn7H3DJUdZdtaEbBSr1LjeiRXVh
         T0gZ9xSUlTpb7XITEj4j6NlbJfDx2q9KtqOY4B5MoyOrEZa1zg4cjs+j6z65UzdgGpek
         o66WVA6jAxreuhGuWhFPLirGrZSxtrFO4kTSfXPkOOgFclmL37w1cW8knPdvzsw5wC9j
         gVXts4/kH4zYWmI42gpN+KahVNWj9iAM0tEyvOqNeTS7fo4s7wbBk8psoX3btL0C2owx
         iyHuxiSrjj4duSfj1fAEQbSHVJ2/yrHGl+AXgnp3pjdUfghH2fRBCoYkLmTxOsQHlwqF
         KHsA==
X-Gm-Message-State: AFqh2kpw7FixWS0Lp5S+M0kyvwbvDyWbGVkly/uEQQVrnhodcfShYwjA
        obIlCZ2eTmxF+sYZlx19yxAZScg4s+diJWf94a4qfdWyQzhDKYEHLlxrpywmKtfR0YkWGgf+oWe
        YYfvYJhHD7fHG+3N5tVxRSxMm
X-Received: by 2002:a05:622a:5086:b0:3b6:3c39:916e with SMTP id fp6-20020a05622a508600b003b63c39916emr54766524qtb.45.1674773289229;
        Thu, 26 Jan 2023 14:48:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuNjDkdcubvsGil3MKn08xe70j/wphCYOerzdAaod5Z1ZjDGjQiL1eur58Xwpkvcx22JnAAtA==
X-Received: by 2002:a05:622a:5086:b0:3b6:3c39:916e with SMTP id fp6-20020a05622a508600b003b63c39916emr54766502qtb.45.1674773288998;
        Thu, 26 Jan 2023 14:48:08 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a220f00b006fc9fe67e34sm124647qkh.81.2023.01.26.14.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:48:08 -0800 (PST)
Date:   Thu, 26 Jan 2023 17:48:06 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] Fixes for hugetlb mapcount at most 1 for shared PMDs
Message-ID: <Y9MDJuPWsk9820xD@x1n>
References: <20230126222721.222195-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230126222721.222195-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:27:19PM -0800, Mike Kravetz wrote:
> This issue of mapcount in hugetlb pages referenced by shared PMDs was
> discussed in [1].  The following two patches address user visible
> behavior caused by this issue.
> 
> Patches apply to mm-stable as they can also target stable backports.
> 
> Ongoing folio conversions cause context conflicts in the second patch
> when applied to mm-unstable/linux-next.  I can create separate patch(es)
> if people agree with these.
> 
> [1] https://lore.kernel.org/linux-mm/Y9BF+OCdWnCSilEu@monkey/
> Mike Kravetz (2):
>   mm: hugetlb: proc: check for hugetlb shared PMD in /proc/PID/smaps
>   migrate: hugetlb: Check for hugetlb shared PMD in node migration

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

