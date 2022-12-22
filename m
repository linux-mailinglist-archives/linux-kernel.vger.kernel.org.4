Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8346547DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiLVV3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLVV27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C0B12AAE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671744495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3m+P6TgC1w6BUj8pVbwI/HR3GgXbzkCBv6mggYtjhfI=;
        b=igQrc0JPxCDwghwVMQysUAVbeH14/jz231bpQbuOjyeBesvvSkztBiqYq1VgPLySVqiddr
        0p2vZelLHAUjhk9DcGlKz1iswhTI0Uwy1bUd6vaemkw1nugAktCVUr/I30DGiI2k5OoVzG
        YgpIgMj2rAg007SmRek10mfAPIv130Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-179-8x9ZhEVxMjiBaFRChSSXEQ-1; Thu, 22 Dec 2022 16:28:14 -0500
X-MC-Unique: 8x9ZhEVxMjiBaFRChSSXEQ-1
Received: by mail-qv1-f71.google.com with SMTP id y11-20020ad457cb000000b004c6fafdde42so1533512qvx.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m+P6TgC1w6BUj8pVbwI/HR3GgXbzkCBv6mggYtjhfI=;
        b=PI57ojIoFGKrh7w2WcEf20wsX51eBK8HwsNRJ4qV0JdL7XNQUgBUxn7EOxFbeLI7cu
         k3mRa3LeQQgOO61q3ffrfw9+7XVdDQkl6JjnJv6mVXD8MPN7guDIqM+UAi6P5s2eGraJ
         C5PpUQKnQmPk7OvmkIMnPX+b6AR2ROX8gmXKagQhSMupDL66nFkM01eJkOx7kIBIcawg
         TjVtagkffRy8ROCisWT2j89tdTY9t3KSLEZT3y7noYkdayQuBJNAHtC/6kYLhx8D3/w5
         cIfLWTS9cZeocgLgZQFQ39kGwFFLETGPkXPj2/Ec3UaJv/amVmIbcIfqund0MjYV+mEY
         Yf7g==
X-Gm-Message-State: AFqh2kpZHyNvvISd2J/aSCwmpPKzE/zgr/ECzo2hWjdRZG4V56dqymwR
        JDStAbfy9QGpfqKkZtkZwEoqeWRKXq9C5rGIUpmauucA4eL/H8LbUYyy4UOiASCAhpN1QgOjbvf
        1X9+iZ+xRdz9V2S0IxEvRfMdE
X-Received: by 2002:ad4:4f53:0:b0:4e8:1593:e036 with SMTP id eu19-20020ad44f53000000b004e81593e036mr8639641qvb.32.1671744493984;
        Thu, 22 Dec 2022 13:28:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtBswMScGQIuIfbwQ8CgNRsmLkwy7qynihZhGW1bKlHfBb6+LD86F6LxBUHXWuFz14xzUZDuA==
X-Received: by 2002:ad4:4f53:0:b0:4e8:1593:e036 with SMTP id eu19-20020ad44f53000000b004e81593e036mr8639621qvb.32.1671744493728;
        Thu, 22 Dec 2022 13:28:13 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id n78-20020a374051000000b006f9ddaaf01esm932241qka.102.2022.12.22.13.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 13:28:12 -0800 (PST)
Date:   Thu, 22 Dec 2022 16:28:10 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v1 0/2] mm/hugetlb: uffd-wp fixes for
 hugetlb_change_protection()
Message-ID: <Y6TL6ugDzZ89RBUY@x1n>
References: <20221222205511.675832-1-david@redhat.com>
 <Y6TJYl78od9XQuvj@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6TJYl78od9XQuvj@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 04:17:22PM -0500, Peter Xu wrote:
> On Thu, Dec 22, 2022 at 09:55:09PM +0100, David Hildenbrand wrote:
> > Playing with virtio-mem and background snapshots (using uffd-wp) on
> > hugetlb in QEMU, I managed to trigger a VM_BUG_ON(). Looking into the
> > details, hugetlb_change_protection() seems to not handle uffd-wp correctly
> > in all cases.
> > 
> > Patch #1 fixes my test case. I don't have reproducers for patch #2, as
> > it requires running into migration entries.
> > 
> > I did not yet check in detail yet if !hugetlb code requires similar care.

Ah I should have left a message here but I forgot - afaict shmem is all fine.

> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: Miaohe Lin <linmiaohe@huawei.com>
> > 
> > David Hildenbrand (2):
> >   mm/hugetlb: fix PTE marker handling in hugetlb_change_protection()
> >   mm/hugetlb: fix uffd-wp handling for migration entries in
> >     hugetlb_change_protection()
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Thanks, David.
> 
> -- 
> Peter Xu

-- 
Peter Xu

