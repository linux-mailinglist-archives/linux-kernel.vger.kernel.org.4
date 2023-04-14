Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293226E255C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjDNONM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNONJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4AABBBA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681481440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBJcDdrehYg3SZ2Ix8rUQUtqCFLW+xk9PSNCEfkHWo0=;
        b=RW/IUEJ2DgLrQ87YOD5sdHRbozgY3Sg+6y+jVsFozNs5uzsz6MS2aiMeRFk4sueGnZDvBn
        BzuNWwOHP3NHsB4Bqpac6vtRvCuE+zj7RGbkGaU+Rz3dk8rP/bTdmIeDQCn2QumfTmmjdI
        YtJU06ArNOEzOVeDR2EGjxFqojbiBF0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-ywIVU7UpMPqEq_tv06L9zg-1; Fri, 14 Apr 2023 10:10:13 -0400
X-MC-Unique: ywIVU7UpMPqEq_tv06L9zg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3e8d943d3a4so2602461cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481402; x=1684073402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBJcDdrehYg3SZ2Ix8rUQUtqCFLW+xk9PSNCEfkHWo0=;
        b=HOREK+fbg7zote0dV6l3SSEkeXrUf7pp0nqG9HYGeDBHkHWFjSJ8C5XsTkGE2XpZ/7
         5I5z8C7cG7ICmFkqcyGVfbmWEBWk2yKBTRX7HOSix4ANivcu0Zo/MFzsGqYoaAFmm6mY
         VlvYedJsjobb/NRsZE+g5VazUHiCkN/N8NWc+RySMTiBiNuta/+tO5pnP6wLnQutMGs6
         6Urc0JP05O3hUHHyTZqgG4Gx1oLN4o7ySikC+UFWVPacbzK0XemYZwDfhObzYMqEmKhC
         sAJt9ujJ8Vi/j7NEbJO9GFpZ3MWHz0SMymcKViaSS88DEzbDynWI4bGH4U/wjvBYzxAB
         D1cw==
X-Gm-Message-State: AAQBX9e6/OKKavtDRHV3e+JZw9KFRMgqfYux784jql7gM3eqv7wfsca8
        gh20IDa6SaYO/Dwtplyw01qh8rkQxJyj8t5RvaVNPEnnr1tEoiMRUmet4v7hFCOxCSr7jV5q3m2
        5OUZcJJYqRqGmtypttihj73nR
X-Received: by 2002:a05:622a:1aa6:b0:3e2:be32:cb74 with SMTP id s38-20020a05622a1aa600b003e2be32cb74mr4132333qtc.3.1681481402019;
        Fri, 14 Apr 2023 07:10:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350YlxdVN3PEcEohxkc/OlBg9FGCz1kPQs1IRyI0P9QL2e261ZWOZ7Gw5ZM7ii3yiUjZ5ZVzz6Q==
X-Received: by 2002:a05:622a:1aa6:b0:3e2:be32:cb74 with SMTP id s38-20020a05622a1aa600b003e2be32cb74mr4132300qtc.3.1681481401721;
        Fri, 14 Apr 2023 07:10:01 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id f17-20020a05620a281100b00748676d89e7sm1253297qkp.8.2023.04.14.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:10:01 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:09:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@mbosol.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/6] mm/hugetlb: Fix uffd-wp during fork()
Message-ID: <ZDlet0+oZ2nrnUdu@x1n>
References: <20230413231120.544685-1-peterx@redhat.com>
 <20230413231120.544685-2-peterx@redhat.com>
 <9cb84b60-6b51-3117-27cb-a29b3bd9e741@mbosol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cb84b60-6b51-3117-27cb-a29b3bd9e741@mbosol.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 12:45:29PM +0300, Mika Penttilä wrote:
> >   		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
> >   			swp_entry_t swp_entry = pte_to_swp_entry(entry);
> > -			bool uffd_wp = huge_pte_uffd_wp(entry);

[1]

> >   			if (!is_readable_migration_entry(swp_entry) && cow) {
> >   				/*
> > @@ -5049,11 +5050,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >   				swp_entry = make_readable_migration_entry(
> >   							swp_offset(swp_entry));
> >   				entry = swp_entry_to_pte(swp_entry);

[2]

> > -				if (userfaultfd_wp(src_vma) && uffd_wp)
> > -					entry = huge_pte_mkuffd_wp(entry);
> > +				if (userfaultfd_wp(src_vma) &&
> > +				    pte_swp_uffd_wp(entry))
> > +					entry = pte_swp_mkuffd_wp(entry);
> 
> 
> This looks interesting with pte_swp_uffd_wp and pte_swp_mkuffd_wp ?

Could you explain what do you mean?

I think these helpers are the right ones to use, as afaict hugetlb
migration should follow the same pte format with !hugetlb.  However, I
noticed I did it wrong when dropping the temp var - when at [1], "entry"
still points to the src entry, but at [2] it's already pointing to the
newly created one..  so I think I can't drop the var, a fixup should like:

===8<===
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 083aae35bff8..cd3a9d8f4b70 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5041,6 +5041,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
                        set_huge_pte_at(dst, addr, dst_pte, entry);
                } else if (unlikely(is_hugetlb_entry_migration(entry))) {
                        swp_entry_t swp_entry = pte_to_swp_entry(entry);
+                       bool uffd_wp = pte_swp_uffd_wp(entry);

                        if (!is_readable_migration_entry(swp_entry) && cow) {
                                /*
@@ -5050,8 +5051,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
                                swp_entry = make_readable_migration_entry(
                                                        swp_offset(swp_entry));
                                entry = swp_entry_to_pte(swp_entry);
-                               if (userfaultfd_wp(src_vma) &&
-                                   pte_swp_uffd_wp(entry))
+                               if (userfaultfd_wp(src_vma) && uffd_wp)
                                        entry = pte_swp_mkuffd_wp(entry);
                                set_huge_pte_at(src, addr, src_pte, entry);
===8<===

Besides, did I miss something else?

Thanks,

-- 
Peter Xu

