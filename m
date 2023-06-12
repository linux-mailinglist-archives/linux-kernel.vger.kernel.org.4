Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E80F72C5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbjFLN3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjFLN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C85CDF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686576509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+Mj9724bLjeW+8pzZ68MfEqHEOG9kuaFzo38byyj80=;
        b=YdOC6zCwvFAmxoDYNWR8zU2E2SBmwpzgzGKxHP6xyE/SDNkqtlTXXC90/UI4h9cKQYMMPp
        TEJJAGX8ZerUSA93hgKCneDEXI/I4EPWIsuSaZGfjljhrvQJNpKca4utPgAicc5kCqDmoG
        Ys9Kvd8u87LIdaG3LRx2V/fYcKVqyNo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-LrwR3FIJOX685fNc8AcJNw-1; Mon, 12 Jun 2023 09:28:27 -0400
X-MC-Unique: LrwR3FIJOX685fNc8AcJNw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75ec91f26c8so93322785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686576505; x=1689168505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+Mj9724bLjeW+8pzZ68MfEqHEOG9kuaFzo38byyj80=;
        b=V5mMgfEpcvFjbuRPq9nIPYhdEZH2Dpd6LnLYym6BgVtoUFK/jG1LwSl3HIUwMHfeT3
         ATyQyP2rXdoRGU+R0vC1qmQOBEUrO1RExvjWduigk1ZrwE9/npy11q8SODT6cWfDcg1U
         WYI1SVhOhR9j9i5Wa9lrXJy923IQij6rbE+U7oXkE8m4PQegmwu37Ihunc4rdFFok0jG
         J3nIzLjpyEwlbTf1X219GJ9+bEKam7ZgfwYn/9YF75wzrrOoKxmSrI/als1vWtUcSKfx
         PIoeyspm5Cya7KMMyuuPQ/PJ0H9m9nMju6yLbDYWOBhEK45KvXurlz8foPl0amGOSL80
         Hqgg==
X-Gm-Message-State: AC+VfDwd+EsgIdL+EJhDDh9dKpzTqNwEENMO+lmS+LvDEwdVW7nVpZy9
        O8nIR7Nw/M/gPcyKx7qlNXIbVej8pc1eOIWqReAhZas+/fReQhanZ3TpErADUDdB2Nq0onVCGfm
        jRejvvPS/jEDE2b4Raea8fQtF
X-Received: by 2002:a05:620a:6686:b0:75d:50bb:b179 with SMTP id qh6-20020a05620a668600b0075d50bbb179mr8118273qkn.4.1686576505479;
        Mon, 12 Jun 2023 06:28:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BprxQFUiFZp6fqJHIUXhahTd9h2hPRLyFeFh/cmjH1Su/G5+8KHXRL0Z/ZalQt8tJ1pQEsQ==
X-Received: by 2002:a05:620a:6686:b0:75d:50bb:b179 with SMTP id qh6-20020a05620a668600b0075d50bbb179mr8118253qkn.4.1686576505179;
        Mon, 12 Jun 2023 06:28:25 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a128900b0075954005b46sm2859308qki.48.2023.06.12.06.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:28:24 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:28:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 4/6] mm: drop VMA lock before waiting for migration
Message-ID: <ZIcddoWjYlDXNKJA@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-5-surenb@google.com>
 <ZIOOmC26qh4EXUEX@x1n>
 <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:30:10PM -0700, Suren Baghdasaryan wrote:
> On Fri, Jun 9, 2023 at 1:42 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Jun 08, 2023 at 05:51:56PM -0700, Suren Baghdasaryan wrote:
> > > migration_entry_wait does not need VMA lock, therefore it can be dropped
> > > before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VMA
> > > lock was dropped while in handle_mm_fault().
> > > Note that once VMA lock is dropped, the VMA reference can't be used as
> > > there are no guarantees it was not freed.
> >
> > Then vma lock behaves differently from mmap read lock, am I right?  Can we
> > still make them match on behaviors, or there's reason not to do so?
> 
> I think we could match their behavior by also dropping mmap_lock here
> when fault is handled under mmap_lock (!(fault->flags &
> FAULT_FLAG_VMA_LOCK)).
> I missed the fact that VM_FAULT_COMPLETED can be used to skip dropping
> mmap_lock in do_page_fault(), so indeed, I might be able to use
> VM_FAULT_COMPLETED to skip vma_end_read(vma) for per-vma locks as well
> instead of introducing FAULT_FLAG_VMA_LOCK. I think that was your idea
> of reusing existing flags?

Yes.

I'd suggest we move this patch out of the series as it's not really part of
it on enabling swap + uffd.  It can be a separate patch and hopefully it'll
always change both vma+mmap lock cases, and with proper reasonings.

Thanks,

-- 
Peter Xu

