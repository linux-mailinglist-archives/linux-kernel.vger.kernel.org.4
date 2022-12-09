Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1918A6483F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLIOkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLIOka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:40:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077E21B9C1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670596776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCeskwiHpWOAgomtB/9x1S3AV/0GyFM2DFyZzy0TWI4=;
        b=IrVqmfvAdNitqZt5h1jOSDeuJ3EQTmBd6LqCCsZDKvpZIsB/6Tn4ZJmnK8PoMrk8RqD3TB
        zCw7FQyiwukpKWpduC/+51NVNCDVxepxFPeFVPCLUNzMUtXepYgoYM+patR93wbQgqXbtQ
        J4WoGOOUdKE9JGRw1PHD9msM1b2nl9s=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-6RYmbQuEPDK3u-gNNw3p8A-1; Fri, 09 Dec 2022 09:39:35 -0500
X-MC-Unique: 6RYmbQuEPDK3u-gNNw3p8A-1
Received: by mail-yb1-f199.google.com with SMTP id e15-20020a5b0ccf000000b006ed1704b40cso5132612ybr.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCeskwiHpWOAgomtB/9x1S3AV/0GyFM2DFyZzy0TWI4=;
        b=Hf0pPGfJ47oz0OqujmLB2VcsWHgjCd4GarFH6elt0P520eegYbcw0YRXdizDL8CoNQ
         s1AZES6LdNCe5g8wbABjim/s8FoBIOgc2u6MNGYAnER2tvZw80ZuDAuH2LM8prPfnTGV
         XWOf1DTQSeFAh5NACSzsPLbWoyyobmRMJPvF6qaJBnqGEFHmd1UDm05jZ37hzbjoUVGC
         EGOqQhaAvjq5J6Yj9/QuAuZjjzqd2HSYERnt9SzJRPLyX9b4sN1TUscuIWv3Hhv8fh9I
         UEucNH/i/CxJGkHwRywXPLe/uIldPwTDEiHD0zZVkvV+i8uOyB0+24EamQUXviCNT9Bt
         ge5A==
X-Gm-Message-State: ANoB5pmob8zvb0GvfUnOe4F/Oa5J7gvlziEqCpONye9rJXNh4TzMK5cB
        Owmxwm+cyVfJyLc6wKuJoW3WNLP1RSZHSTwBEAHjaRaDwRBzvc3QDgBNXPjDwniZOBTGj40dx8m
        4YACNNc+MgsBWOvDgMk07fskh
X-Received: by 2002:a05:7500:53d1:b0:ea:ada0:1fd5 with SMTP id y17-20020a05750053d100b000eaada01fd5mr362423gab.33.1670596774526;
        Fri, 09 Dec 2022 06:39:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6/0nCQ5bt3gKHOC8oSlO0XyXnR156+Xc0b03y9Hj9KtBO5tqL462ejhQMdh3cJRGFz31dx9w==
X-Received: by 2002:a05:7500:53d1:b0:ea:ada0:1fd5 with SMTP id y17-20020a05750053d100b000eaada01fd5mr362409gab.33.1670596774162;
        Fri, 09 Dec 2022 06:39:34 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id m11-20020a05620a290b00b006e702033b15sm1275350qkp.66.2022.12.09.06.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:39:32 -0800 (PST)
Date:   Fri, 9 Dec 2022 09:39:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v2 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to
 pmd unshare
Message-ID: <Y5NIoqXlAvrXkCOM@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-9-peterx@redhat.com>
 <a9cbfa20-b83d-203c-85ef-77ffe9445913@redhat.com>
 <Y5JNXomE5eGo8DyF@x1n>
 <72a62bf5-7633-f35f-75fd-0222fd0ab49f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72a62bf5-7633-f35f-75fd-0222fd0ab49f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 11:24:55AM +0100, David Hildenbrand wrote:
> For such cases, it would be good to have any evidence that it really helps.

I don't know much on the s390 path, but if a process has a large hugetlb
vma, even MADV_DONTNEED will be blocked for whatever long time if there's
another process or thread scanning pagemap for this vma.

Would this justify a bit?

It's just that the vma lock is taken write far more than mmap_lock taken
write I think, meanwhile what we need here is only release the lock and
retake, nothing else.  It didn't make things over complicated, IMO.

No strong ipinion from my side, as I said to me it's really low hanging
fruit.  If you still think that doesn't justify and if Mike doesn't have a
preference either I can just drop it for later.

-- 
Peter Xu

