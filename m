Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98B46746F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjASXN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjASXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:12:59 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212931BD9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:07:05 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso4672094wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mbI3crUnZHE33dCw4UMEiMuxL329KBkUWgeNaQcR87U=;
        b=Ol0oPKVfH3C5OpKN4RdqGeOUFC0rkaPwfQOzVbtQ2rKlgtCahTIUAOjtqj5WYunROs
         UnGrAvTCKMeUZXTYUx8agsQiwA77ULjFyT1hC93EZA67Mem44q6tWCxjSJjG4wRDPWAP
         hO2BINkygCbPCF+NRVkvYnqJYMXLm3ua6VvTMhRKsEpf7ZWA+3lH7V9UCNmORqK7/koy
         s+Bxqd5beN0vgluWliHX1A1FRm9Hc/M7gKajgIaYlL4Zn0+ziZ2av+Ytug75S0MfxJt8
         HU2GNWjA3lb7XLd+/ngHLUCUO4QXEgHAW9PyZalLRA7BHsEpc3zIcsoge0N5ujELMzTh
         ed2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbI3crUnZHE33dCw4UMEiMuxL329KBkUWgeNaQcR87U=;
        b=4BtmfNuypZQ31FfFcTzEtvhd6zgHjjhLY2+DS0EaYnZ5FPjosYwbD0hb3eDkNj3YYK
         1skaS8HtcpPm3lI9qCkcs+SLhEsL57E00mvwKMQqtzdtkLtyrBKroLO0ru1oNEnHH0BB
         nsvEnQKWqaDggYo6Tf5Xj9iEdMzCYLwvosTBFOy9Bzjt6MUUkoBTGk5nYCUdF6FvgyJc
         yk2tFPTnZHhvKikTnVd9Uple8ruqv3mRJU/MPCX5vWXW557WJFbqOjZFGRzOD5oZnAtP
         wedfAjQNliaZlH/gK8zwqrBpRtKKju3iC+m6ti3T4ZSErFPsMKMGMgaoXlAyagLNDIbs
         MFFg==
X-Gm-Message-State: AFqh2krCh9sQXwgCqxUnrrIcol/oUutA0B2B3Dxc8DinnhjUUxFMwPlw
        FfXN3yE3M3UoYPjT2lLIhj2jed7xk8ZvmlT0165hvg==
X-Google-Smtp-Source: AMrXdXt2/t2D3yu+VxSHvwvBrUb8EGhOVUMYirstDNc5cXLRFIG9XzXTn22/3s/wXvvT6pAXmmRP9zR96PCAsMgzAXo=
X-Received: by 2002:a05:600c:3095:b0:3d9:7950:dc5f with SMTP id
 g21-20020a05600c309500b003d97950dc5fmr672841wmn.120.1674169623606; Thu, 19
 Jan 2023 15:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-36-jthoughton@google.com> <Y8nGK2N5E15cenr1@x1n>
In-Reply-To: <Y8nGK2N5E15cenr1@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 19 Jan 2023 15:06:27 -0800
Message-ID: <CADrL8HXHe85Jgiv9JatzMUhmqg0K5WGrGe_S+aZHobqzDYFLFQ@mail.gmail.com>
Subject: Re: [PATCH 35/46] hugetlb: add MADV_COLLAPSE for hugetlb
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

On Thu, Jan 19, 2023 at 2:37 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 05, 2023 at 10:18:33AM +0000, James Houghton wrote:
> > +     /*
> > +      * Grab the VMA lock and mapping sem for writing. This will prevent
> > +      * concurrent high-granularity page table walks, so that we can safely
> > +      * collapse and free page tables.
> > +      *
> > +      * This is the same locking that huge_pmd_unshare requires.
> > +      */
> > +     hugetlb_vma_lock_write(vma);
> > +     i_mmap_lock_write(vma->vm_file->f_mapping);
>
> One thing I just noticed - do we need the mmap write lock here?  I don't
> quickly see what stops another thread from having the mmap read and walking
> upon the pgtables being collapsed.

Maybe. Does huge_pmd_unshare() have the same problem?
