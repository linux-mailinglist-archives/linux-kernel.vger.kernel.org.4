Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B165DABD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbjADQuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240173AbjADQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:48:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6FC4732A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672850693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6EzsGSC3holClBSPQw8EocT+rCm9w6LTUpG8IqXLKaM=;
        b=KmfhUiP1Z4CC5XYWE1y6bb4X3paTR4BHLNiHsyvkK1hSy9BNhGkpmIauh4f2QAVKtFrtS6
        Bsse17u+qgjcH6bQQEQ8giUdoCi6b/cvkKsoyb74VQWJ4rqr/zwJu6eHjoHaFMu3Xxp2gJ
        CtAJd4AYtX+NswBVrw5S6W57LY8xFss=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-YOoYbGWUO_WgRxhhQyXtfw-1; Wed, 04 Jan 2023 11:44:52 -0500
X-MC-Unique: YOoYbGWUO_WgRxhhQyXtfw-1
Received: by mail-qk1-f197.google.com with SMTP id bp6-20020a05620a458600b006ffd3762e78so23472998qkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 08:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EzsGSC3holClBSPQw8EocT+rCm9w6LTUpG8IqXLKaM=;
        b=XVyoIHNFJ6KmxHaTjEdrJHuZftI5qBCnubHreXEVOUYXYszAvWVmw+Nv7Q85SWLVZv
         YNvtJKo9gWg/pCYMU1DsgOxHsyfCgN9g/vYV3XN5L7g1JTFUcoW6IYrxDi+4ZTjfu2dt
         9QAYz8x+tmjy5bE4Z2Fq/KL1vCpIHMr2dK+Z0KFYcW7S59i+jU1WTW/Uzxwe2mKLiWmF
         cO+Kbu0ldNO5xHZtQmkD/2i2ZMd78MboAWZkHEFOynHjkVGJnA+0bTBd3QnXz8V34Pn5
         8AUILqYMc0HLTcoQGUv9njFO8f4JNIzEVJc7a5ytI+fpbjpl/n5evX26reyJ64nQtPqn
         x9ww==
X-Gm-Message-State: AFqh2kqegtM0xMcJy03nJvFVz67fyF8wQ+3pd9ZWnsPU+TIFXTNNKaCK
        FHNWP5r5w99e5KtKriKxvqGiO6tVnv5/dfNPAmvrToNiqmFMJPAc9r8RXiMqQ/D0aBG2IPVYn4c
        iAiX7d1wqmso9bAvEOIofuk6d
X-Received: by 2002:a05:622a:124b:b0:3ab:7bb3:4707 with SMTP id z11-20020a05622a124b00b003ab7bb34707mr50094157qtx.64.1672850692361;
        Wed, 04 Jan 2023 08:44:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtC6/5x1TZXjNxaTZni/mgmGgEGvHrxdB4Ldf1ggEJ59TT3GmI7MMZ8cyzI4+MP/hbyTOvkqA==
X-Received: by 2002:a05:622a:124b:b0:3ab:7bb3:4707 with SMTP id z11-20020a05622a124b00b003ab7bb34707mr50094133qtx.64.1672850692030;
        Wed, 04 Jan 2023 08:44:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a455600b006fb112f512csm24300165qkp.74.2023.01.04.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 08:44:51 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:44:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christian Brauner <brauner@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: remove zap_page_range and create zap_vma_pages
Message-ID: <Y7WtAXpZM3Mxi95N@x1n>
References: <20230104002732.232573-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230104002732.232573-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 04:27:32PM -0800, Mike Kravetz wrote:
> zap_page_range was originally designed to unmap pages within an address
> range that could span multiple vmas.  While working on [1], it was
> discovered that all callers of zap_page_range pass a range entirely within
> a single vma.  In addition, the mmu notification call within zap_page
> range does not correctly handle ranges that span multiple vmas.  When
> crossing a vma boundary, a new mmu_notifier_range_init/end call pair
> with the new vma should be made.
> 
> Instead of fixing zap_page_range, do the following:
> - Create a new routine zap_vma_pages() that will remove all pages within
>   the passed vma.  Most users of zap_page_range pass the entire vma and
>   can use this new routine.
> - For callers of zap_page_range not passing the entire vma, instead call
>   zap_page_range_single().
> - Remove zap_page_range.
> 
> [1] https://lore.kernel.org/linux-mm/20221114235507.294320-2-mike.kravetz@oracle.com/
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

