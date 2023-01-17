Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29D670C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjAQWxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAQWw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:52:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:38:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r9so9239599wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ9UkgQeYnMSm21br+/WRYTcl1lVOfAIfRZkpO3j0Eo=;
        b=sqRGz6JOhYVpP9SdbBRwv5+UC5QMn+EWTLENKt3ipj1KVv5EohZco3oue3RZET0H/G
         qqZY3NSsLYd1zY0WuHMUi/3vuNR8pHoxXTQrQW6u0pOc+e4BCgz8SAjw4PpszoM42pD+
         g4g+f04JFI8V5GDBnV1K6yfs0BXFT3tQtJepwieiU9KO8FJy5l80uf7v4Sje6nKFfiGv
         0Qk0V+bhCYPybT8kNg0NP+F5wYh/qgjZKh3iYP16vcF9+UGPkO98HDA4SSKRCV2hJ1tl
         kxMmgudFowSuYd2w2XUwqzO7yUmhL0ggbfGfbwYEwraJ+cJFudfzlujvqHQVORb9+l9O
         fYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQ9UkgQeYnMSm21br+/WRYTcl1lVOfAIfRZkpO3j0Eo=;
        b=tjJ7Oib/wQC4j33GhkP8leSHdlhHdUOroepAAypG2ZQ9aYoQ9JT2XDdyPmKJAjJ9ZY
         y+AJwW/Pmd6pK6gk9jm+pKG6yo9zCfi0GBAORCr8y4as1h0mvJxeVuIHdLWiD4I51xdu
         O5PyQYLhSKdPeRQzkylV/D+4PpmS/IZ+Deb7lIbUCCFG/G6v/Zah3CFN9Hg9rYVmTUvT
         jFPC5LWINyJuEhpDbe1B5BGTYoC0sgKdp0+zgXXOTERAohvd+jsTDwmjDuB3CuO1PbRQ
         2q1C0R36ru0NfpXmJmh7uX9w4D+0BP3VElUsgAZqseADzTOekuT38+EspvIUWOA5aBKC
         c8VA==
X-Gm-Message-State: AFqh2ko/ROLNrxQu0XsPmi4I++kda1MxfkNLfs+dhYqaELBTqAIHGQlA
        HT0GBkGdS9MnUJB5mDa792x9hObUfFAEzIOFchWDdw==
X-Google-Smtp-Source: AMrXdXuBncssOtbY3SF4hHimBtnI+qNtDjcF9d0KJNY9ySE4KG6Iuh6dT12P8C82lXCmkX6VTpPY/Czt1T6CQ0g3sRg=
X-Received: by 2002:a5d:6205:0:b0:2be:1447:c36d with SMTP id
 y5-20020a5d6205000000b002be1447c36dmr267996wru.39.1673991515881; Tue, 17 Jan
 2023 13:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-36-jthoughton@google.com> <Y8cN4G0ICoSSggS+@x1n>
In-Reply-To: <Y8cN4G0ICoSSggS+@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 17 Jan 2023 13:38:24 -0800
Message-ID: <CADrL8HVDyT6D-O=BoeHkA9oaRPLJR62Sxba8FdTjMaQYW-Ttfw@mail.gmail.com>
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

> > +             if (curr < end) {
> > +                     /* Don't hold the VMA lock for too long. */
> > +                     hugetlb_vma_unlock_write(vma);
> > +                     cond_resched();
> > +                     hugetlb_vma_lock_write(vma);
>
> The intention is good here but IIUC this will cause vma lock to be taken
> after the i_mmap_rwsem, which can cause circular deadlocks.  If to do this
> properly we'll need to also release the i_mmap_rwsem.

Sorry if you spent a long time debugging this! I sent a reply a week
ago about this too.

>
> However it may make the resched() logic over complicated, meanwhile for 2M
> huge pages I think this will be called for each 2M range which can be too
> fine grained, so it looks like the "cur < end" check is a bit too aggresive.
>
> The other thing is I noticed that the long period of mmu notifier
> invalidate between start -> end will (in reallife VM context) causing vcpu
> threads spinning.
>
> I _think_ it's because is_page_fault_stale() (when during a vmexit
> following a kvm page fault) always reports true during the long procedure
> of MADV_COLLAPSE if to be called upon a large range, so even if we release
> both locks here it may not tremedously on the VM migration use case because
> of the long-standing mmu notifier invalidation procedure.

Oh... indeed. Thanks for pointing that out.

>
> To summarize.. I think a simpler start version of hugetlb MADV_COLLAPSE can
> drop this "if" block, and let the userapp decide the step size of COLLAPSE?

I'll drop this resched logic. Thanks Peter.
