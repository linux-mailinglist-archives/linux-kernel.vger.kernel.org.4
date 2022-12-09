Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A433647AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLIAoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLIAol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:44:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29272A0FA5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670546625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOQAgPN2OM3Qoh4w5J3XT6I3W+H9FIcVJ7CHfGCLLVU=;
        b=BxwXqgjXFJITcqnEkGwbKkWeZ/qtIUKXmC7L1B6C6S+6NtaAiZJc8jOD6TbBslqSrnTh7s
        Cs6SqengrXFeuoTA0pL4vm6knGDVwG7uVHW37mcYoPFJEyUW/99uHAiOjZVoBYEguNEW4+
        e1z3Lmf5QuCPnRsIF+WBLnfE1yE8BU4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-daLczFXfPUqjkuxuWPdrAg-1; Thu, 08 Dec 2022 19:43:42 -0500
X-MC-Unique: daLczFXfPUqjkuxuWPdrAg-1
Received: by mail-qk1-f199.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso3415178qkp.21
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 16:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOQAgPN2OM3Qoh4w5J3XT6I3W+H9FIcVJ7CHfGCLLVU=;
        b=DKsYACV0+88kW6wTTJAhRsk9stAMh0ksiuVKZ8JWawpGpqA1ur5k7Y3dFVb/oWPg5v
         2Bik5VZF5xr9Zcu+HDfbv+FhRXTj8vhTShQtOb+OlLmAhWR+IITWFtJqVDJoKNdOYRGo
         Zzn4Qd1faarkQ73FqZaZwlwNyKbt4hoDd1crCkEUXYJ+VtHLFYSWuAGh4IFeTFoW1usI
         9lhnoxyofclCbJSy+3L9wRrb6mkXi2BZ7OlK/4AkdUpipDxM7ZS2txG+pwTBuqmIkrnl
         22a8MOi5SURnqEx6jkoffh0+D5gHqhe+bFc1VA3fR+5KyCdtBan94i4KrPY1jqP3HB9F
         l6Fw==
X-Gm-Message-State: ANoB5plBeHQJ9L/+V487u5lQgJOpyYmnqqiiLimNVhu/ZY8tNBoOaXJC
        oA1TYPpuFUs9zalW5SodAvTF8oMPtDSvdm2Z+qNC1OBp1gjjiR74bntSNoAYWWt+WcqUdFYPQVZ
        fAzWnUQwtvorSa22zpNe2Vecj
X-Received: by 2002:a05:6214:4283:b0:4c6:99cb:347 with SMTP id og3-20020a056214428300b004c699cb0347mr6739383qvb.38.1670546621697;
        Thu, 08 Dec 2022 16:43:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6vNPXFnBfP41Kw3F4yG2Y/tCEvs98o4Mwa9bR+8CQc/ImHAQskUQTptwE7im0S7QmgyTtJ4A==
X-Received: by 2002:a05:6214:4283:b0:4c6:99cb:347 with SMTP id og3-20020a056214428300b004c699cb0347mr6739369qvb.38.1670546621489;
        Thu, 08 Dec 2022 16:43:41 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q23-20020a05620a2a5700b006fcc6d9a626sm13577487qkp.78.2022.12.08.16.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:43:40 -0800 (PST)
Date:   Thu, 8 Dec 2022 19:43:38 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 10/10] mm/hugetlb: Document why page_vma_mapped_walk()
 is safe to walk
Message-ID: <Y5KEukhLUgskntDE@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203158.651092-1-peterx@redhat.com>
 <6a970de6-e3da-f57d-14fd-55f65ddcb27d@nvidia.com>
 <Y5JRhU+9QqoUuSdR@x1n>
 <61751d01-2ba4-efc0-9cb8-eeeb3d70908d@nvidia.com>
 <Y5JjTPTxCWSklCan@x1n>
 <7f3096c5-c3cc-4ead-7c5e-8bade6c930da@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f3096c5-c3cc-4ead-7c5e-8bade6c930da@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 04:24:19PM -0800, John Hubbard wrote:
> It does! And now for the comment, I'll think you'll find that this suffices:
> 
> 		/*
> 		 * All callers that get here will already hold the i_mmap_rwsem.
> 		 * Therefore, no additional locks need to be taken before
> 		 * calling hugetlb_walk().
> 		 */
> 
> ...which, considering all the data above, is probably the mother of
> all summaries. :)  But really, it's all that people need to know here, and
> it's readily understandable without wondering what KSM has to do with this,
> for example.

I'm okay with the change. :)

I think what I'll do is I'll move part of the original one into commit
message, and take the new version in the code.

Thanks,

-- 
Peter Xu

