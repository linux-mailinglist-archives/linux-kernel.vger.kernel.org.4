Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B688B710102
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbjEXWdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbjEXWdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F3E41
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684967483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GSyBtTjyewnVuXUDzPKeU1svAYpm8O8laUSlUsa6VxU=;
        b=hayEwaNnLDjIK6+i5+xvADQ3GwKqNheywGjPAeP/Ilk8ZMunOIW8NOmtlv3S1AQu73pyht
        tVECoFJfOwN4dhGu+3JEqoQ4naxYUGucnUsuyXPqkNRJK/lEjydctgdxvZhW08j5h4F0JJ
        N+okLnvxfAEWhQ9IlSRNiS0D7G8s8nE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Ylri8fHoMMOKtimWcUb_Bg-1; Wed, 24 May 2023 18:31:21 -0400
X-MC-Unique: Ylri8fHoMMOKtimWcUb_Bg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f386bb966cso2510251cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684967481; x=1687559481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSyBtTjyewnVuXUDzPKeU1svAYpm8O8laUSlUsa6VxU=;
        b=fOrpRbO7MoFDzBDesnimHa87Wb4KsTkSps+C1tXdx61nVXWU1f/ly59jbsrS9C4EiU
         uuZICzp/Gwb63iGI55A3k5Bc0t++c5PH74aMQBJA9KOJGjxMwYI/RlErabBDTq79HkSu
         X+RWjKe2sM5uo+6eW9HTwUVFjm40iTgXkBUEUWkXSdv9FgZM9ghMwGNn5bEE9i71tRoq
         IyKr5rF3GFtRSmhyWVq33gkOTS/7alJqzNZs88lqOLGiEKMODxr52h/n/w6iyzjQzs0C
         81htB3e7vin+VMyZMjmH0RUJZJ3H42wvRKhKAh6nDNyJLCi1gDzqXj+gQLDlq5tKXYlz
         h7Ww==
X-Gm-Message-State: AC+VfDykiM/eFYfPXaTQ4XEOTKPkGGbOcCEth9nEIg+55JibuNGFYWJm
        pA1OQqDt/7cRgkrEoeifkaB0T/Yuq+wr0a0sIRQyVC70yeXdXesnbmdzFXCdNjwIZ4xMLaQQBww
        n5TRvFppb05Ig44uO3kIVhZy2
X-Received: by 2002:a05:622a:1a91:b0:3f4:fdaa:8e14 with SMTP id s17-20020a05622a1a9100b003f4fdaa8e14mr5323995qtc.2.1684967481231;
        Wed, 24 May 2023 15:31:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lzJovrBCoBI/H1khO1XbOY9927arBDiTQfPlewasaQC7ZJQNBI1Nc0ad1Htf4u2VKsVVQ2g==
X-Received: by 2002:a05:622a:1a91:b0:3f4:fdaa:8e14 with SMTP id s17-20020a05622a1a9100b003f4fdaa8e14mr5323940qtc.2.1684967480926;
        Wed, 24 May 2023 15:31:20 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b003f6ac526568sm3112027qtw.39.2023.05.24.15.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:31:20 -0700 (PDT)
Date:   Wed, 24 May 2023 18:31:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 14/31] fs/userfaultfd: retry if pte_offset_map() fails
Message-ID: <ZG6QNhFhyNxyn5PK@x1n>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <424274a4-7c13-e14-b380-428fc69a45c5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <424274a4-7c13-e14-b380-428fc69a45c5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 10:06:32PM -0700, Hugh Dickins wrote:
> Instead of worrying whether the pmd is stable, userfaultfd_must_wait()
> call pte_offset_map() as before, but go back to try again if that fails.
> 
> Risk of endless loop?  It already broke out if pmd_none(), !pmd_present()
> or pmd_trans_huge(), and pte_offset_map() would have cleared pmd_bad():
> which leaves pmd_devmap().  Presumably pmd_devmap() is inappropriate in
> a vma subject to userfaultfd (it would have been mistreated before),
> but add a check just to avoid all possibility of endless loop there.

Agreed, afaiu that's for either PFNMAP or MIXEDMAP vmas only.  Maybe we can
use a WARN_ON_ONCE() for that to be clear, but no strong opinions.

> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

