Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B0962CD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiKPWDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiKPWDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:03:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2129257B56
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668636141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BY9O302VhdNnvghm5TlpWtvjP2cBGB1kArLY14MpKJo=;
        b=homPiDZjRk9l7cq6Dbf7rfXcuT6BpUnSriqhfO4epQp3TKWU+B0/vT61ClKgLCL9ORheXT
        FPHwtU/oVCCJehMCO/09mlp4anWoQXJFcUJpZzBumZp03ewh0lnqqtLM+AljAov00BxCZd
        bVNTsIvu5E6TWqBQa0cyFUlDRpVLBsI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-FSSx4G7oOhGW5DBesx3k4g-1; Wed, 16 Nov 2022 17:02:20 -0500
X-MC-Unique: FSSx4G7oOhGW5DBesx3k4g-1
Received: by mail-qk1-f198.google.com with SMTP id o13-20020a05620a2a0d00b006cf9085682dso10400qkp.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BY9O302VhdNnvghm5TlpWtvjP2cBGB1kArLY14MpKJo=;
        b=6TmlYBLdEbobB3mwBLFHBuat6m4jGniBodHtM44yhwkxD1nHFbppSSIlJT4KPeq/56
         I8IR7Ig/m/lI5xVl+/wymS7BW3kHSIvA+iOAnnQot467VF2Ce6JJtJdFuyK7IgFH18qb
         zMtOwZNeDJbuHRnPIdj5Ovsfk9cmRsKIQkb0tMUDmAREPAmNGTOiJor0jhhLowbpJV/M
         JfC3UNU4uzO7BuE16FcOirtnpx/J6L2TAgu5Fq8oOZNEGYKMWOGz5LTSEfYDTKdQdcQg
         89ijvv6A8JLfGyVTegR6jwTv7A2LwaKCKklGWwUJgj8Nk1XAKZNUPA1Axb6cIZwpFGud
         4uSQ==
X-Gm-Message-State: ANoB5pmbmdDceksDeygdluAcm8Z0nCppFt71MGVo46N0w/KcCLBE8L0I
        S9akqo00kNgJfqmQ/r2v0M8NA2qLofFU+1HkxH1h+/x8cbUpph3Tq7MPXb6ZNM/pOnP9C/iA1bY
        wsxJFVmCSB3vV0eFegde37afo
X-Received: by 2002:a05:622a:4d0b:b0:39c:44cd:34a9 with SMTP id fd11-20020a05622a4d0b00b0039c44cd34a9mr22807427qtb.220.1668636139536;
        Wed, 16 Nov 2022 14:02:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4s3cQI/U2jAJJCBABw7M2A/48iWaBEFWkG0fZ/T9P/Nw67+2nSYaaDK3z0I2utu787UrL2bw==
X-Received: by 2002:a05:622a:4d0b:b0:39c:44cd:34a9 with SMTP id fd11-20020a05622a4d0b00b0039c44cd34a9mr22807371qtb.220.1668636139042;
        Wed, 16 Nov 2022 14:02:19 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a29c100b006faeecef56fsm10884101qkp.68.2022.11.16.14.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:02:18 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:02:17 -0500
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
Subject: Re: [RFC PATCH v2 12/47] hugetlb: add hugetlb_hgm_walk and
 hugetlb_walk_step
Message-ID: <Y3Vd6dxNvGguCyxi@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-13-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-13-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:28PM +0000, James Houghton wrote:
> +/* hugetlb_hgm_walk - walks a high-granularity HugeTLB page table to resolve
> + * the page table entry for @addr.
> + *
> + * @hpte must always be pointing at an hstate-level PTE (or deeper).
> + *
> + * This function will never walk further if it encounters a PTE of a size
> + * less than or equal to @sz.
> + *
> + * @stop_at_none determines what we do when we encounter an empty PTE.

IIUC it is not about empty PTE but swap-or-empty pte?

I'm not sure whether it'll be more straightforward to have "bool alloc"
just to show whether the caller would like to allocate pgtables when
walking the sub-level pgtable until the level specified.

In final version of the code I also think we should drop all the "/*
stop_at_pte */" comments in the callers. Maybe that already means the
meaning of the bool is confusing so we always need a hint.

-- 
Peter Xu

