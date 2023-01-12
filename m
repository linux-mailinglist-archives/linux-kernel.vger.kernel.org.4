Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040D8667E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjALSfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbjALSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:35:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE427BDD9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:06:33 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e3so9687333wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GHqB03IG/Fw5jEYQ9HlahhtZMg0ZvXSmKsAYDV0YaZg=;
        b=tJTIczFVTGyPtATfIAyHXZd+Ng/jYBYxMbc0eeAAkpztxNFUKPFL/9DE5YIxeq3nfg
         rc9VVmHTZvvkFsSnImYgHR/LFMzRLaZrD4kc+AGpEYtWTi6V0va1YUdd/bLBGku24Jm2
         GeYfMIB8M8gPZYLQ41SzH3PEbieeWbLR+w4QwNz1qQS9j6eDkqDs4WFF4KCEJnQX3ntt
         tTDMMbIHKd7KDOUDDn3bkSasHFAMpXBc5Sa5P5gsO/Ivhg39ypknmR8SxsIC7JRYrfM5
         6AqnTG6yVwPRy0mvBWo/YUegigjql3TgH93Ykw7rzkhQfbiQj2N9gD5tq9x+Okb2rAe6
         ViJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHqB03IG/Fw5jEYQ9HlahhtZMg0ZvXSmKsAYDV0YaZg=;
        b=8GCiRgUVKNyzmCniySd3HZd5uOrqubYGhi0JeDNw2hkPhS/U052smVzK254Jpc+u2P
         kv5vfjDjy5vmUNey0JRB/ldnJf6Q1o/Gh2Dy1CDcEpsOMXX4QkTzfmvhuptgHVL9Vvfq
         c6Xhbc4lffEkdfUHrYT5dTQXAic4CxaxwYZuYWsc2CMsCb6dZzw1GtIfewV5AwdewAY7
         BqViKG4t3ZiTUwDb1Hv7qJMiEgH0SqqpetD0k75UJFGvOPyH+6RkKu4fOxu4M7a22YBk
         ZOF2/xQvMprMs9ETsFTme4jf+hIcmddsKzSRjcX7emQdBl4GhcoW6/HZkrAlO6kqqWco
         Qr6A==
X-Gm-Message-State: AFqh2kpuNKSntNujpKw8kw/uwGyj6ST3OPYzQktbkO1LAQcVUZvAjTzh
        bpKWPF/zGiy9U4eE3ZHoswpWeIBUf6YxZNqlvccRsw==
X-Google-Smtp-Source: AMrXdXu264pOZwJk3yk7MRJ+NQrXDkP38ZUjQLFidAyqY7tna+NJTpDws/gZ24hIETMvoKRrHe9jrF0h2ZJJJFuIF78=
X-Received: by 2002:a5d:6b51:0:b0:2b7:74c3:560d with SMTP id
 x17-20020a5d6b51000000b002b774c3560dmr1478500wrw.39.1673546778479; Thu, 12
 Jan 2023 10:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-20-jthoughton@google.com> <Y8BLKaKy9CUCy/vy@x1n>
In-Reply-To: <Y8BLKaKy9CUCy/vy@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 12 Jan 2023 13:06:07 -0500
Message-ID: <CADrL8HX6Y5uUDeAViTmU6ysPezGzRtB=P76mxc3RG53_OUaNCw@mail.gmail.com>
Subject: Re: [PATCH 19/46] hugetlb: add HGM support for follow_hugetlb_page
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 1:02 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 05, 2023 at 10:18:17AM +0000, James Houghton wrote:
> > @@ -6731,22 +6746,22 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >                * and skip the same_page loop below.
> >                */
> >               if (!pages && !vmas && !pfn_offset &&
> > -                 (vaddr + huge_page_size(h) < vma->vm_end) &&
> > -                 (remainder >= pages_per_huge_page(h))) {
> > -                     vaddr += huge_page_size(h);
> > -                     remainder -= pages_per_huge_page(h);
> > -                     i += pages_per_huge_page(h);
> > +                 (vaddr + pages_per_hpte < vma->vm_end) &&
> > +                 (remainder >= pages_per_hpte)) {
> > +                     vaddr += pages_per_hpte;
>
> This silently breaks hugetlb GUP.. should be
>
>                         vaddr += hugetlb_pte_size(&hpte);
>
> It caused misterious MISSING events when I'm playing with this tree, and
> I'm surprised it rooted here.  So far the most time consuming one. :)

Thanks Peter!! And the `vaddr + pages_per_hpte < vma->vm_end` should
be `vaddr + hugetlb_pte_size(&hpte) < vma->vm_end` too.
