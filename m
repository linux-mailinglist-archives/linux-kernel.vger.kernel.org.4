Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62183737074
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjFTP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjFTP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AD299
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687274933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eM/7jCZlXs+iYNWQPomo+m+F7tXjtLGkIbkCnuL/RPU=;
        b=L4K9jbHJ5UAEnH8KX08xlf0vphNA8Qjog8IHraukqG98tNpy947N+/WvKMF94BbEEQOjmv
        K5/Q1MzDxHlWBgJQ2xRZ3wHzWDV9gRYlJL+7qln8eqhWti9hkr3HUCmfyPFiXTNG8yRNHH
        J9f2F2h0AGDlWEMQU8HPzQFdKH9FCmI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-UV4B87QQOy6-aJKOWex83A-1; Tue, 20 Jun 2023 11:28:43 -0400
X-MC-Unique: UV4B87QQOy6-aJKOWex83A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7e7cfcae4so26199835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274911; x=1689866911;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eM/7jCZlXs+iYNWQPomo+m+F7tXjtLGkIbkCnuL/RPU=;
        b=MM9VgcYE+JqqXZw0CoZjqsP6QUDwoVWDcQwU08B7W0nsl0alafK7m6Yqp2rjaIpaji
         Tb6RncZUp+R7wxwvGBcnSaf70U6gpRKbb/3o4PCgh6pZP8GMkVcPBTUZDh/YmYi8ZlYY
         q+ZDk9W2wcCnbqofJ6aCOG4HHnn1D76Mw5sou2vbv3I5SXIA2skMLj4YI50mfYuuSu1g
         QNI3z1I1/WPKqfnXgcKvgNcSuwoWRTNYJKu4bVYsJYtVqEAgNQGMHHWaosc2ZOa9G5FY
         st2wjmA7KEmyLksB8nTl6j2cB6u6gcAQ9ShGmIgnGmtiyJK/6Js12cb1HQ7R+OcnNcJ0
         vSJg==
X-Gm-Message-State: AC+VfDyWytaJ7aLVzh70DC7u0lXnQiVyRB/MLtu+ASdWpR35VQ4ha0F3
        5Pu7Tp6Kb0jX3jx/XobQnTjP3BbfeRxF55H7/0mp7eFRqmdfHPwgtJ39pDSMKDNg79MVozhtSaP
        KN3zRlGO+QflBYmKGrNE3Cuxa
X-Received: by 2002:a1c:cc19:0:b0:3f8:fac0:ad40 with SMTP id h25-20020a1ccc19000000b003f8fac0ad40mr11807596wmb.29.1687274911531;
        Tue, 20 Jun 2023 08:28:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73V081DQidSwBFXaCaeMrD6w076nAEzUmU10u3hOhr60yvyWJrCyx55kB0c7MEaBidIzfQKA==
X-Received: by 2002:a1c:cc19:0:b0:3f8:fac0:ad40 with SMTP id h25-20020a1ccc19000000b003f8fac0ad40mr11807567wmb.29.1687274911079;
        Tue, 20 Jun 2023 08:28:31 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23bc9.dip0.t-ipconnect.de. [79.242.59.201])
        by smtp.gmail.com with ESMTPSA id p25-20020a05600c205900b003f9b1131a90sm2591078wmg.23.2023.06.20.08.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:28:30 -0700 (PDT)
Message-ID: <7cd1db3f-9bdf-dc0b-692c-380a2fa14286@redhat.com>
Date:   Tue, 20 Jun 2023 17:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/8] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230619231044.112894-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.23 01:10, Peter Xu wrote:
> follow_page() doesn't use FOLL_PIN, meanwhile hugetlb seems to not be the
> target of FOLL_WRITE either.  However add the checks.
> 
> Namely, either the need to CoW due to missing write bit, or proper CoR on
> !AnonExclusive pages over R/O pins to reject the follow page.  That brings
> this function closer to follow_hugetlb_page().
> 
> So we don't care before, and also for now.  But we'll care if we switch
> over slow-gup to use hugetlb_follow_page_mask().  We'll also care when to
> return -EMLINK properly, as that's the gup internal api to mean "we should
> do CoR".  Not really needed for follow page path, though.
> 
> When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
> clear that it just should never fail.

Oh, and does this comment really belong into this patch or am I confused?

-- 
Cheers,

David / dhildenb

