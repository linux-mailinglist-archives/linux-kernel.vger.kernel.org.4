Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6FC60FB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiJ0PIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiJ0PIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:08:02 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671841849BD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:07:57 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id ay12so658133qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IIQ4zBFEMq401B7LHco+BoD5rdpZ5Deu1R9Bn5hW7DQ=;
        b=7Ihsof3XsnlOurWNXvNfkJmwVJTfwnhJqhSKxV+DO+L6B3Tu/kqnAq9TVYZ0Duxf3M
         W6Td+3HG86QI9uHlG1WT4lBz7n5Hi+2LDaCPaMcqoAdOVJqEYcsJCUef4MylfmzhXlDc
         eC2w4CBAXy8ttJZMXMHJx6fxvJ1TbafKgtkk0pxH3GiPfyJeVocRes+egtLPyPkq31RO
         4ktx9h4emk4aPCwALiSHRAUqNAQlnxAZnBy5kOi2CF8YvliiLajdG8mGMuNWxe1k70WB
         2r9rJWDKgl0zVfELj6C2YoJAb0AiFdpBaFpHjB4HRcfS91KHRJsaVwXrlCAlTR4W9jN+
         FUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIQ4zBFEMq401B7LHco+BoD5rdpZ5Deu1R9Bn5hW7DQ=;
        b=sr5yPMEwC1pSq5+9N0gx+1kpNT5AwIvz4x660eQ5vMhVCNDTYHgJ7On23wnZqudYU0
         Pfv0PaWi2iBSuVVVhUsetUNuuY7gNuximMwUWFvVi/hBo2CDtVnu0dUPHDGL91U53Hv6
         hBAfiuDiE7S2Mj3oRO7PVYT6l85Drv80N4EYigAEup22faYNuPZHjzHtU+sUnZGfPESR
         lm61AlTJ+JithSFpqoom8p2P6lWGMAWatxKdmYwr2lZ1esDkBPMDVUgduhDA3NPiUw6O
         wjm6NGMPGtGps64dygLMq+/4lUSH/b68Ajann8MNpMaYCrjKDGe+n9b+OPWqh4n1J4hV
         3+WQ==
X-Gm-Message-State: ACrzQf3bCRX7MxdtPDeuGTHrbD/I2qz/dvSXwTq1Hr9J2FLPRezViIWM
        B0YoeIHRlhqaqkegByfacelX0g==
X-Google-Smtp-Source: AMsMyM41MUratBwSfmaBQZiJgUc6R+Z5LNxo3ebXzmvLT/wPQbTT7UxQqNW99RHZzOGPEn1wVa1fQw==
X-Received: by 2002:a05:622a:50e:b0:3a4:e734:409e with SMTP id l14-20020a05622a050e00b003a4e734409emr10328431qtx.497.1666883276551;
        Thu, 27 Oct 2022 08:07:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id q68-20020a378e47000000b006b929a56a2bsm1163569qkd.3.2022.10.27.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 08:07:56 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:07:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Rik van Riel <riel@surriel.com>, Chris Mason <clm@meta.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] hugetlbfs_no_page vs MADV_DONTNEED race leading to SIGBUS
Message-ID: <Y1qezB09SaZy9pRS@cmpxchg.org>
References: <215d225585ff3c5ea90c64e6c9bdff04ab548156.camel@surriel.com>
 <Y1mMw2mt0my0qVqP@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1mMw2mt0my0qVqP@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:38:43PM -0700, Mike Kravetz wrote:
> On 10/25/22 16:37, Rik van Riel wrote:
> > What are the reasonable alternatives here?
> > 
> > Should we see if anybody can come up with a simple solution
> > to the problem, or would it be better to just disable
> > MADV_DONTNEED on hugetlbfs for now?
> 
> Here is one thought (perhaps crazy).  Do not allow MADV_DONTNEED on
> hugetlb mappings.  This would help with the library code passed hugetlb
> mapping.  For the use cases where MADV_DONTNEED on hugetlb is desirable,
> create ?MADV_DONTNEED_HUGETLB? that only operates on hugetlb mappings.
> In this way the caller must be aware they are operating on a hugetlb
> mapping.

What could also work is implementing mlock() for hugetlb, and having
MADV_DONTNEED respect it.

That would allow libraries/general-purpose allocators to continue
using MADV_DONTNEED without being aware of the underlying memory
situation. Whoever is responsible for setting up the memory pool could
just mlock() - or not, if hugetlb overcommit is enabled - and the GP
allocator would do the right thing in both scenarios.

[ Our setup code is actually already calling mlock() on the hugetlb
  ranges. We never wanted DONTNEED to free hugetlb pages - it just
  happened to work so far because DONTNEED wasn't implemented for
  them. If both DONTNEED and mlock() were implemented, we'd be good. ]

Johannes
