Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7B7031D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbjEOPtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbjEOPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:49:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0DE1FCF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684165701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C/AmINL4tMPA1IYAOYGHnj9N13Le1qyoYJvFHckB0ME=;
        b=QWQLlRq4+sMLfAoFJybgRa/FBxTx2YhEYS6RxrZg3Zzpryl3O7Nr445Yzn9dsDOvXZMv2J
        Ny/zimhw5yz1xh6e1Nv5xa9DQcbAQcNjVS7s/kqedwSPQfSH+92fd8cnwBu30LIZR6w1/7
        7XSu630ryrn4p6tLISZLAmiHoAzL+6s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-JaPaPJrwMWaxmRHO-hWkpQ-1; Mon, 15 May 2023 11:48:20 -0400
X-MC-Unique: JaPaPJrwMWaxmRHO-hWkpQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75805d64044so25114885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684165700; x=1686757700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/AmINL4tMPA1IYAOYGHnj9N13Le1qyoYJvFHckB0ME=;
        b=H1l0rTYu6egzSwVHF71EeRivulEoHaaY3uPBpv67XMyzxucoLFXjMFC3WqaNKjym8m
         qEx+I5sSao30aZcklDIU64fJPwjgnX6fbDFpEtDzHk7V85zArMBwNlttOYrskcDzzcX+
         mz0JWCVUCt+Zzluh6ZRZm5ArVmxG+IzaE3/wzGvI8UqftjNJcQWTOEYFa+jrszY3DjBA
         oHAj65PEHGIXO+BhkxFj8PpNjn+qbRsIfegZ+g9AtJjVt96MxcEfXJfbnYMkwFYfmHEg
         Xd6ZwHgQ46YZyp5c5mVQm+4II86UMPZL8AZC9lEh0WRKAVyaPZ6Kk+/PKXRuWXuEK1aF
         nF4Q==
X-Gm-Message-State: AC+VfDzDWsT1yqXYsngi9eHTbSy0h/gbWqm44ZxxjFd2Y5fc0C+wq1iA
        3hprnt+QcGZUHWOgtuBZ39MpX2Tl/40eWs7Bvys+UeNm68mcdzM9XvU+nI8yJUKl2ColYTRYSEw
        NHOt0sO93WMCW0zkI7m7u921M
X-Received: by 2002:a05:622a:508:b0:3f5:1def:67fd with SMTP id l8-20020a05622a050800b003f51def67fdmr10587292qtx.2.1684165700009;
        Mon, 15 May 2023 08:48:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7nE1rgdvC+MTyt8L8N+MkclX/xGEuHVV8DtNlREmY8pvvsSrKBMLd6hHFUfy4s7sUBq78AsQ==
X-Received: by 2002:a05:622a:508:b0:3f5:1def:67fd with SMTP id l8-20020a05622a050800b003f51def67fdmr10587251qtx.2.1684165699672;
        Mon, 15 May 2023 08:48:19 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id w41-20020a05622a192900b003f4def78743sm4184354qtc.91.2023.05.15.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 08:48:19 -0700 (PDT)
Date:   Mon, 15 May 2023 11:48:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/gup: Fixes FOLL_UNLOCKABLE against FOLL_NOWAIT
Message-ID: <ZGJUQWFBMBfbKHaz@x1n>
References: <20230512003102.3149737-1-peterx@redhat.com>
 <ZF5yHLMDCLq4IBqC@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZF5yHLMDCLq4IBqC@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 02:06:36PM -0300, Jason Gunthorpe wrote:
> On Thu, May 11, 2023 at 08:31:02PM -0400, Peter Xu wrote:
> 
> > E.g., with current code we could at last have FAULT_FLAG_RETRY_NOWAIT set
> > even if with a FOLL_UNLOCKABLE gup which doesn't make a lot of
> > sense.
> 
> I would say NOWAIT and UNLOCKABLE are different things. UNLOCKABLE
> says the mmap sem is allowed to be unlocked, which is true, and NOWAIT
> says it shouldn't "wait" (which is something more nebulous than just
> sleep). In FOLL_ flag terms it would be fine if the mmap sem was
> unlocked while doing NOWAIT - even though the fault hanlder will not
> doe this.
> 
> The only caller is fine with this too.
> 
> !UNLOCKABLE literally means not to ever drop the mmap lock which is
> not something KVM needs at all.

The problem is FOLL_NOWAIT implies FAULT_FLAG_RETRY_NOWAIT internally.

Then we'll have FAULT_FLAG_RETRY_NOWAIT+FAULT_FLAG_KILLABLE which makes it
very confusing, because RETRY_NOWAIT means we never release mmap lock or
retry, then KILL means "if we wait, allow us to be killed".

Considering FOLL_UNLOCKABLE is an internal flag while FOLL_NOWAIT a public
(even if only with a single caller...), I'd still think it makes more sense
and cleaner to just remove FOLL_UNLOCKABLE if FOLL_NOWAIT, no?

Again, nothing to blame for previous commit (I explained in the commit
message too that we don't need fixes, but simply a cleanup), but it seems
removing this confusion of NOWAIT+UNLOCKABLE could be helpful to me.

> 
> So I'd say it is fine as is. A caller should never assume that calling
> an unlocked function or passing null locked means that the mmap sem
> won't be unlocked while running indirectly because of other GUP
> flags. If it wants this behavior it needs to ask for it explicitly
> with a locked GUP call and a NULL locked.
> 
> > Since at it, the same commit added unconditional FOLL_UNLOCKABLE in
> > faultin_vma_page_range(), which is code-wise correct becuase the helper
> > only has one user right now and it always has "locked" set.  
> 
> Not quite, it is correct because that is the API contract of this
> function. The caller must provide a non-NULL locked and non-NULL
> locked at the external interfaces always mean it can be unlocked while
> running.

Hmm yes, that's the contract.  But then it makes more sense to assert on
that contract (by checking locked)?

How about I rework the commit message but keep the change (which literally
only add the assertion)?

-- 
Peter Xu

