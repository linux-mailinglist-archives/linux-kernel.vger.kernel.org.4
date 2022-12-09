Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AFE6486FF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLIQtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLIQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:49:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC4934F7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670604526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qe+BTEVKYgQkmMXRjr5V0plALCN1Fet6uRUJRVAZNxY=;
        b=Vbp71pcXRWzGtjLaJ6vylAtNt+XzKSmK3gnTujJi451aWV1LTLYW7j5+PZvVtnaxUZOFhT
        2FStsB68VNN5KNS7KAcKNzipe1bB0Z1lUCqreRpSFM8yTGCH2S3uzaF36vy3uUBfLSAhWf
        FDXpo6yCjr5ZBWeK+8WsRRezCSM6rW8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-LGJ0iRw5OaWbr4iXMJw7HQ-1; Fri, 09 Dec 2022 11:48:45 -0500
X-MC-Unique: LGJ0iRw5OaWbr4iXMJw7HQ-1
Received: by mail-qk1-f198.google.com with SMTP id bl21-20020a05620a1a9500b006fa35db066aso5552283qkb.19
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 08:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe+BTEVKYgQkmMXRjr5V0plALCN1Fet6uRUJRVAZNxY=;
        b=rFpxXXay9VbAUX0qXMrWXSfyF9pg+ADYhO9ndOYOHNvyxj/tJ2Ht+aPRTluSQjHwyB
         aIzK3ones8EPV7QfkoEwmUSyPoxurIfklW1pI5zfM7p4VoFP66/vPGKdkv4w2/1HOq+K
         uekKCpBN2QbJpGtb4wi16BhOb10FP/F/ySwqMvLofhb22zNXAvZ0CZ0FzRrysVEGkjTc
         Xu1a6dN0+koln6nvs+CfWmZktB2vXE7Axgv0uqEeXT9Ytv4N48DLzZj3lffQl2iD75G5
         vzd7V/A6/7HyuOVCtxlJ/BdlzPb4OMkAZwkPV0syzmbHrH5e7teTSpaYBLl2rguNBkdU
         6M4g==
X-Gm-Message-State: ANoB5pkjWlZYRwEL5J4z/rwyW3TepSLXpag/lfcWZ/0JQgrwZRUpkguv
        pxVfN/szUZYOwuA6Ben+vFtybqzCt2z8Ea0gH661al0Sws2KKeBJensmlpt+8TWnUH7AV9Zl+If
        GPGk4tf69RAXiJwi0b9EBlCM4
X-Received: by 2002:ac8:5ec3:0:b0:3a8:2d7:af66 with SMTP id s3-20020ac85ec3000000b003a802d7af66mr3832088qtx.21.1670604525068;
        Fri, 09 Dec 2022 08:48:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5YO3ZtzQAraHqAtoVoKyEkDWBJebgJYBC+tP0jSP21KqHzgBLWHzdltFRoQ6oht8YEo9NAfw==
X-Received: by 2002:ac8:5ec3:0:b0:3a8:2d7:af66 with SMTP id s3-20020ac85ec3000000b003a802d7af66mr3832058qtx.21.1670604524770;
        Fri, 09 Dec 2022 08:48:44 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id k16-20020a05622a03d000b0039a610a04b1sm1233157qtx.37.2022.12.09.08.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:48:43 -0800 (PST)
Date:   Fri, 9 Dec 2022 11:48:36 -0500
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
Message-ID: <Y5Nm5KXeb9Nb/oTX@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-9-peterx@redhat.com>
 <a9cbfa20-b83d-203c-85ef-77ffe9445913@redhat.com>
 <Y5JNXomE5eGo8DyF@x1n>
 <72a62bf5-7633-f35f-75fd-0222fd0ab49f@redhat.com>
 <Y5NIoqXlAvrXkCOM@x1n>
 <56eecd5e-9f1a-0171-0e4f-934e3e6b495a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56eecd5e-9f1a-0171-0e4f-934e3e6b495a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 04:18:11PM +0100, David Hildenbrand wrote:
> On 09.12.22 15:39, Peter Xu wrote:
> > On Fri, Dec 09, 2022 at 11:24:55AM +0100, David Hildenbrand wrote:
> > > For such cases, it would be good to have any evidence that it really helps.
> > 
> > I don't know much on the s390 path, but if a process has a large hugetlb
> > vma, even MADV_DONTNEED will be blocked for whatever long time if there's
> > another process or thread scanning pagemap for this vma.
> > 
> > Would this justify a bit?
> 
> I get your point. But that raises the question if we should voluntarily drop
> the VMA lock already in the caller every now and then on such large VMAs and
> maybe move even the cond_resched() into the common page walker, if you get
> what I mean?
> 
> On a preemtible kernel you could reschedule just before you drop the lock
> and call cond_resched() ... hmm

On full preempt the old cond_resched() doesn't work anyway.  IIUC most
distros now should be using dynamic preempt which makes voluntary mode by
default, which this change should help.

> 
> No strong opinion here, it just looked a bit weird to optimize for a
> cond_resched() if we might just reschedule either way even without the
> cond_resched().

It's really not the core of the patchset.  Let me drop it for now.

-- 
Peter Xu

