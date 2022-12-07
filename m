Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1BC646555
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiLGXpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLGXpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:45:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD24E8AACE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670456675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U1znsFGAwUqLG+kZktt6UetlzDgCE2gBi75bO1V4Vw8=;
        b=TQoPDyBvzLNaQ7uwBWOYTemxz4gxLsf9p3o3NaGXtYcAO1545jebdzp6XPRU84TQKRn29V
        LWk8Cpz8a1WC759V5KWXyod4kyaWmwRUWkiftAcGsVxpBFJ+1B63TsdG6ICTTT7l3xtwRt
        ojH8yk3+u56mQSMZNsW9vur9BMlN2cA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-Mcepb5yGMX-ev1yskL8mQg-1; Wed, 07 Dec 2022 18:44:34 -0500
X-MC-Unique: Mcepb5yGMX-ev1yskL8mQg-1
Received: by mail-qt1-f199.google.com with SMTP id cm12-20020a05622a250c00b003a521f66e8eso40109807qtb.17
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1znsFGAwUqLG+kZktt6UetlzDgCE2gBi75bO1V4Vw8=;
        b=BWVZccUp2CcWSUb+hyO+reZu6TRpL+FwzdHqjG01s1g7Ap0EVXUp9X6zykOrWPa7q4
         B26YOfsSK4glofliF5WJGWVGz3LQdXI7JT4xAwJslWcYSu6j1YyR/pgsQX/nHxA3h/5l
         4k/XldK5LMb8S2f1kFf/TUyJRbp0rH6IUNwbXvugOsWIHGXXhQ54mUFK2qtxDuZs1JCf
         X40ZzutToxz2DM335EgLz83YO9FLTdm3wIuujatnY5ZABRkVFwuZbWvhLsnPtwaKaUX7
         cJOX6hYDb9wVeexUnkwmtQUk2GhZBkxBucL3KuFiglXbYPvQTVeQMS0aOPwfnE/feSMT
         vgzw==
X-Gm-Message-State: ANoB5plBWqtALr4WUXzIMe3bn1akSgU7rXaSXsF6vgO5rCeF31LEzZI5
        laJsfYvjxjRJYHjxBGsSFZJHqOyD14mX2FZyhlGsBZazEc2PKqnba8GUc9VWsiTFaz2/F93M9He
        ZcOw4FyuT9GUXixa3AY67fx9u
X-Received: by 2002:a05:622a:1c1:b0:3a4:e849:a235 with SMTP id t1-20020a05622a01c100b003a4e849a235mr2155999qtw.34.1670456674095;
        Wed, 07 Dec 2022 15:44:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5qazXJBp7t7e+vKfk/GGkwSEO9ydBAP5p90VGRjDUmsbibpQEcZsfVIbf6t+ghGod0ZatQjQ==
X-Received: by 2002:a05:622a:1c1:b0:3a4:e849:a235 with SMTP id t1-20020a05622a01c100b003a4e849a235mr2155982qtw.34.1670456673844;
        Wed, 07 Dec 2022 15:44:33 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id w3-20020ac87183000000b0039cd4d87aacsm13882213qto.15.2022.12.07.15.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:44:32 -0800 (PST)
Date:   Wed, 7 Dec 2022 18:44:31 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v2 05/10] mm/hugetlb: Make userfaultfd_huge_must_wait()
 safe to pmd unshare
Message-ID: <Y5ElX/Flm7lrHmCx@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-6-peterx@redhat.com>
 <b3308387-464a-52ae-114b-34ab94e3b5c6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3308387-464a-52ae-114b-34ab94e3b5c6@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 03:19:55PM -0800, John Hubbard wrote:
> On 12/7/22 12:30, Peter Xu wrote:
> > We can take the hugetlb walker lock, here taking vma lock directly.
> > 
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   fs/userfaultfd.c | 18 ++++++++++++++----
> >   1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 07c81ab3fd4d..a602f008dde5 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -376,7 +376,8 @@ static inline unsigned int userfaultfd_get_blocking_state(unsigned int flags)
> >    */
> >   vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> >   {
> > -	struct mm_struct *mm = vmf->vma->vm_mm;
> > +	struct vm_area_struct *vma = vmf->vma;
> > +	struct mm_struct *mm = vma->vm_mm;
> >   	struct userfaultfd_ctx *ctx;
> >   	struct userfaultfd_wait_queue uwq;
> >   	vm_fault_t ret = VM_FAULT_SIGBUS;
> > @@ -403,7 +404,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> >   	 */
> >   	mmap_assert_locked(mm);
> > -	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
> > +	ctx = vma->vm_userfaultfd_ctx.ctx;
> >   	if (!ctx)
> >   		goto out;
> > @@ -493,6 +494,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> >   	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
> > +	/*
> > +	 * This stablizes pgtable for hugetlb on e.g. pmd unsharing.  Need
> > +	 * to be before setting current state.
> > +	 */
> 
> Looking at this code, I am not able to come up with a reason for why the
> vma lock/unlock placement is exactly where it is. It looks quite arbitrary.
> 
> Why not, for example, take and drop the vma lock within
> userfaultfd_huge_must_wait()? That makes more sense to me, but I'm not familiar
> with userfaultfd so of course I'm missing something.
> 
> But the comment above certainly doesn't supply that something.

The part that matters in the comment is "need to be before setting current
state".

	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
	if (is_vm_hugetlb_page(vma))
		hugetlb_vma_lock_read(vma);
	set_current_state(blocking_state);

down_read() can sleep and also modify the task state, we cannot take the
lock after that point because otherwise the task state will be messed up.

-- 
Peter Xu

