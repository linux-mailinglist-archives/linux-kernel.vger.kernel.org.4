Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F56737674
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFTVMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjFTVM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967A110F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687295494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gU8UWWJWFgoQ9BWqYzFjtCCMQSFbRe/QWEx3Oetwzeo=;
        b=cm/PCufUuDwaEwMZA635tkAMwtyc9UrV6EcS+BpidE5BIhbyRVmpyYJo8qZtx+ljMzouM+
        tTSFeloPx55nXZ0kFS9BtIZspx6WPBTLgimbukLDiL6yFKUlRA979gIAiV2WSr+9HCbL6l
        W/NJHGW1QmbSmboDCMuDXT5vk3z6Avo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-7q3cZ_skPJiON9JkuUoZ6A-1; Tue, 20 Jun 2023 17:11:33 -0400
X-MC-Unique: 7q3cZ_skPJiON9JkuUoZ6A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-631e9a9e92bso4137846d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687295492; x=1689887492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU8UWWJWFgoQ9BWqYzFjtCCMQSFbRe/QWEx3Oetwzeo=;
        b=EnsewOUDxiEQ3YVMymdOfvKdSSFhl10ZiwyMtfy++taifIYT7vw7+qRqZ26gzGz4qy
         sfvlf7n7qAvuigJ81ubsxwRriCaYIXNv0EL8kSIOqeOAB1H0lsGiK3Hdu76hoJuDlg1u
         6pwu4Paewj9AaQdpOuN682cf8Gx2wGEiwytUIb1O1UMyrafyFmkfyE5KuSmKRYryCELN
         rOByqWFKkqPSqUKIlc2w+0thTGp8DNmmG2Af5ak/HmBsJpnpHcOvmlxCMS/DQ5XftvXr
         cLsKWO9Akm/+4fiAibkJl057rOsCsu26HnRVpWNw5Y/+KKxc7yF51BQj80ZK2wny4axZ
         27kA==
X-Gm-Message-State: AC+VfDy+v3f7uw9rqBygNGOA/h0oqkmwvkL1sUbQmMq3eZechQVYqpyq
        TtRzXdWWxQp6PrBf+4891+WDoa7a+hI1c9t63xfZGH4mpE1O697DtnIE/2Ki/iijfy9cfcXeyVq
        sDHhs5G0ORoekIgo3CabjG4IM
X-Received: by 2002:a05:622a:292:b0:3ff:3151:a8a7 with SMTP id z18-20020a05622a029200b003ff3151a8a7mr2091059qtw.3.1687295492487;
        Tue, 20 Jun 2023 14:11:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67KxXxa/fr98eOy/24gQ4FhGS1F/cuhF47oElajda/uk0rdsXxswcKRGR+v+VjpN2/lzbTOQ==
X-Received: by 2002:a05:622a:292:b0:3ff:3151:a8a7 with SMTP id z18-20020a05622a029200b003ff3151a8a7mr2091035qtw.3.1687295492139;
        Tue, 20 Jun 2023 14:11:32 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id fc5-20020a05622a488500b003ff243b2509sm1539586qtb.71.2023.06.20.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:11:31 -0700 (PDT)
Date:   Tue, 20 Jun 2023 17:11:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] mm/khugepaged: maintain page cache uptodate flag
Message-ID: <ZJIWAvTczl0rHJBv@x1n>
References: <20230404120117.2562166-1-stevensd@google.com>
 <20230404120117.2562166-5-stevensd@google.com>
 <20230620205547.qzmivkjox2hkpzmm@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230620205547.qzmivkjox2hkpzmm@awork3.anarazel.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:55:47PM -0700, Andres Freund wrote:
> Hi,

Hi, Andres,

> 
> On 2023-04-04 21:01:17 +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> > 
> > Make sure that collapse_file doesn't interfere with checking the
> > uptodate flag in the page cache by only inserting hpage into the page
> > cache after it has been updated and marked uptodate. This is achieved by
> > simply not replacing present pages with hpage when iterating over the
> > target range.
> > 
> > The present pages are already locked, so replacing them with the locked
> > hpage before the collapse is finalized is unnecessary. However, it is
> > necessary to stop freezing the present pages after validating them,
> > since leaving long-term frozen pages in the page cache can lead to
> > deadlocks. Simply checking the reference count is sufficient to ensure
> > that there are no long-term references hanging around that would the
> > collapse would break. Similar to hpage, there is no reason that the
> > present pages actually need to be frozen in addition to being locked.
> > 
> > This fixes a race where folio_seek_hole_data would mistake hpage for
> > an fallocated but unwritten page. This race is visible to userspace via
> > data temporarily disappearing from SEEK_DATA/SEEK_HOLE. This also fixes
> > a similar race where pages could temporarily disappear from mincore.
> > 
> > Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> 
> I noticed that recently MADV_COLLAPSE stopped being able to collapse a
> binary's executable code, always failing with EAGAIN. I bisected it down to
> a2e17cc2efc7 - this commit.
> 
> Using perf trace -e 'huge_memory:*' -a I see
> 
>   1000.433 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 1537, is_shmem: 1, filename: "postgres.2", result: 17)
>   1000.445 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
>   1000.485 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 2049, is_shmem: 1, filename: "postgres.2", result: 17)
>   1000.489 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
>   1000.526 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 2561, is_shmem: 1, filename: "postgres.2", result: 17)
>   1000.532 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
>   1000.570 postgres.2/1872144 huge_memory:mm_khugepaged_collapse_file(mm: 0xffff889e800bdf00, hpfn: 46720000, index: 3073, is_shmem: 1, filename: "postgres.2", result: 17)
>   1000.575 postgres.2/1872144 huge_memory:mm_khugepaged_scan_file(mm: 0xffff889e800bdf00, pfn: -1, filename: "postgres.2", present: 512, result: 17)
> 
> for every attempt at doing madvise(MADV_COLLAPSE).
> 
> 
> I'm sad about that, because MADV_COLLAPSE was the first thing that allowed
> using huge pages for executable code that wasn't entirely completely gross.
> 
> 
> I don't yet have a standalone repro, but can write one if that's helpful.

There's a fix:

https://lore.kernel.org/all/20230607053135.2087354-1-stevensd@google.com/

Already in today's Andrew's pull for rc7:

https://lore.kernel.org/all/20230620123828.813b1140d9c13af900e8edb3@linux-foundation.org/

-- 
Peter Xu

