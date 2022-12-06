Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF84C644E37
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiLFVwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLFVwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0483E0B2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 13:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670363469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nj0whFws2Fn002TRCkbhTkgQ4WLnLwXu8owr0nEppH0=;
        b=UutCjktM2K9LMwWNULU195HQlChNOM4d7XFD0wTYE7GoQ/IE4Z1yX7CBFsBOtbwkeOUl4F
        3Qhhn7YKzUst836IdeNVfEiK9ZD1HTqFskWKaGzvDXxceu8aktTWye6X7Y9mdw/h1O8A0P
        u6eHMY8GZeCErxiW0psVzNYp9iIgMxA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-iK5pmlnQNUSHQSCZwldqVA-1; Tue, 06 Dec 2022 16:51:08 -0500
X-MC-Unique: iK5pmlnQNUSHQSCZwldqVA-1
Received: by mail-qk1-f197.google.com with SMTP id x2-20020a05620a448200b006fa7dad5c1cso22482738qkp.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 13:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj0whFws2Fn002TRCkbhTkgQ4WLnLwXu8owr0nEppH0=;
        b=Qs+SYTGUi/coX7W41l835mNVTOfyc7GAFxQP+AtUFvAlnoiSJCT/2KXSLYzkO8FkdA
         8UOQY9kXwj+1Gr63JxprTsSZTc+pjyKJRxJBHkQRB5ol45wR+iILzg2VN2hfSihcW5ys
         OT7rXidRdpb3zVtbVOHSipG9Ym8BERoBzLuiL1wb7PhPrmDXqSaMENjUqQ9s0jeueKRJ
         zvMlewTF5eNVnid6GkM78ag/RY3NRVYgFQXk3yCvDTHs3BbuPxuAWHKYmaae5nxOr1yT
         T+zLaLb0ksMyM5HbSttmyWD4Jh5r2NTT/8cST4gw4+Q2T+jVwvGmdx9uqEuAG6Ad6v9Y
         MpyA==
X-Gm-Message-State: ANoB5pmuB0uQM7AJm6j7D/Fcbnu0jKAINLD3q3Q//1Q4sfPR4i18Rkk2
        MuhZ57cKmhyWsxSbxMaBOsnKHqlv+nXyt8jQeaL8Y94mTWtwQ+TcpYV10D4DxuoFYiVWQ7Vz8MW
        WDfGj/8EUc1VFq9IQ86TspnNv
X-Received: by 2002:a05:622a:4d89:b0:39c:da20:d454 with SMTP id ff9-20020a05622a4d8900b0039cda20d454mr633718qtb.45.1670363467228;
        Tue, 06 Dec 2022 13:51:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5jzrGR9pnH7+zFAmw+Zeqojea6tLoa90BDqkV4NXJMVgz5BQLDIWp/lblniehjYKCxpMZmNw==
X-Received: by 2002:a05:622a:4d89:b0:39c:da20:d454 with SMTP id ff9-20020a05622a4d8900b0039cda20d454mr633697qtb.45.1670363465509;
        Tue, 06 Dec 2022 13:51:05 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id de7-20020a05620a370700b006b615cd8c13sm15779134qkb.106.2022.12.06.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:51:05 -0800 (PST)
Date:   Tue, 6 Dec 2022 16:51:03 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Message-ID: <Y4+5R+nh0W0RUX9R@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com>
 <Y45/5ezH6uwn7Cfy@monkey>
 <0813b9ed-3c92-088c-4fb9-45fb648c6e73@nvidia.com>
 <Y49xlV8I2/92Flha@x1n>
 <97e3a8f2-df75-306e-2edf-85976c168955@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97e3a8f2-df75-306e-2edf-85976c168955@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:03:45PM -0800, John Hubbard wrote:
> On 12/6/22 08:45, Peter Xu wrote:
> > I've got a fixup attached.  John, since this got your attention please also
> > have a look too in case there's further issues.
> > 
> 
> Well, one question: Normally, the pattern of "release_lock(A); call f();
> acquire_lock(A);" is tricky, because one must revalidate that the state
> protected by A has not changed while the lock was released. However, in
> this case, it's letting page fault handling proceed, which already
> assumes that pages might be gone, so generally that seems OK.

Yes it's tricky, but not as tricky in this case.

I hope my documentation supplemented that (in the fixup patch):

+ * @hugetlb_entry:     if set, called for each hugetlb entry.  Note that
+ *                     currently the hook function is protected by hugetlb
+ *                     vma lock to make sure pte_t* and the spinlock is valid
+ *                     to access.  If the hook function needs to yield the
+ *                     thread or retake the vma lock for some reason, it
+ *                     needs to properly release the vma lock manually,
+ *                     and retake it before the function returns.

The vma lock here makes sure the pte_t and the pgtable spinlock being
stable.  Without the lock, they're prone to be freed in parallel.

> 
> However, I'm lagging behind on understanding what the vma lock actually
> protects. It seems to be a hugetlb-specific protection for concurrent
> freeing of the page tables?

Not exactly freeing, but unsharing.  Mike probably has more to say.  The
series is here:

https://lore.kernel.org/all/20220914221810.95771-1-mike.kravetz@oracle.com/#t

> If so, then running a page fault handler seems safe. If there's something
> else it protects, then we might need to revalidate that after
> re-acquiring the vma lock.

Nothing to validate here.  The only reason to take the vma lock is to match
with the caller who assumes the lock taken, so either it'll be released
very soon or it prepares for the next hugetlb pgtable walk (huge_pte_offset).

> 
> Also, scattering hugetlb-specific locks throughout mm seems like an
> unfortuate thing, I wonder if there is a longer term plan to Not Do
> That?

So far HMM is really the only one - normally hugetlb_entry() hook is pretty
light, so not really throughout the whole mm yet.  It's even not urgently
needed for the other two places calling cond_sched(), I added it mostly
just for completeness, and with the slight hope that maybe we can yield
earlier for some pmd unsharers.

But yes it's unfortunate, I just didn't come up with a good solution.
Suggestion is always welcomed.

Thanks,

-- 
Peter Xu

