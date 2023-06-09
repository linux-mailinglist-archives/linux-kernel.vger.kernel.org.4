Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3F72A4B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjFIU1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFIU1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0913C22
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686342350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1ei889BxGPPugsDqX1JfgeIs0UpcqQ4un9cGqylfqQ=;
        b=G1FHuL3/Tate6Yn9/VZGAF8L+AXWs8DaSI9zSUs7C2H6dRWxOcbX2Ve17uP158lPBc5RtL
        eE7/oT81yLxYM2dCX05L4Z5xpbjfD5dNBfKTweJ0WPygIwM9AoIm5HWYyQjgmfhwVRIYn0
        oIyjgVkoX7EpsAfGbaOrr6w/2xzyqjI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-unmPAmoINrKX-C1KCMGQLg-1; Fri, 09 Jun 2023 16:25:46 -0400
X-MC-Unique: unmPAmoINrKX-C1KCMGQLg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75b147a2548so46707285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686342346; x=1688934346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1ei889BxGPPugsDqX1JfgeIs0UpcqQ4un9cGqylfqQ=;
        b=cYpJe1KoXtSiAMNlbCly2Sf9xZFfuEhZdjoXF8kGMRhenqzg5o3ZeBvf8IzLoAEPzF
         XKAJ/br39ApWTmzdd4CLlwZQx1brnfKFFzbUSW3YwnwVdYBlLSKaQdOcd67W9piSvFfC
         6eudoAgwvkgft6F8p7EJyZkpzk0Or1e3+cQOhGFYGN3/LIcpdkcJHSkxI9qHLx0q4VbD
         b02Bn+JEuo6Ok/MdqLbWH4V3xUbM348pio6tn2jMdi6SJJIP6RI5UN86k7eZisxBXkE1
         XlJvncdbTHM3mZkJSZSqs0pngaDSwkdxqpByRK7SqO7mx5SfhZLC4Q0EQCh6pWQ1zLEw
         TriA==
X-Gm-Message-State: AC+VfDz2irA+dL8UP+2qY6sA2ukYzYipUgjeVG/txgaeESxHqVcekzIz
        Mdwccg7JhDeHxD/IU5c1dqt2a2tMD0X7YYMnEDNlhwWJoEFAPLmjV3Z/K+ZYr4cfGwOFI3fzJq2
        2DweMU2AbMZOr++ttyNTDWgvX
X-Received: by 2002:a05:620a:d96:b0:75e:da20:a10e with SMTP id q22-20020a05620a0d9600b0075eda20a10emr2473290qkl.3.1686342345880;
        Fri, 09 Jun 2023 13:25:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NKhOjdxMH+oNrmbK71omapsMn9RTBUV3pN0ZRaFOZ1AeSTm4AYfnaMXEmeLcoFLzuDlgt+w==
X-Received: by 2002:a05:620a:d96:b0:75e:da20:a10e with SMTP id q22-20020a05620a0d9600b0075eda20a10emr2473280qkl.3.1686342345638;
        Fri, 09 Jun 2023 13:25:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b10-20020a05620a118a00b0075cc5e34e48sm1246914qkk.131.2023.06.09.13.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:25:45 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:25:42 -0400
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
Subject: Re: [PATCH v2 2/6] mm: handle swap page faults under VMA lock if
 page is uncontended
Message-ID: <ZIOKxoTlRzWQtQQR@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609005158.2421285-3-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:51:54PM -0700, Suren Baghdasaryan wrote:
> When page fault is handled under VMA lock protection, all swap page
> faults are retried with mmap_lock because folio_lock_or_retry
> implementation has to drop and reacquire mmap_lock if folio could
> not be immediately locked.
> Instead of retrying all swapped page faults, retry only when folio
> locking fails.
> Note that the only time do_swap_page calls synchronous swap_readpage
> is when SWP_SYNCHRONOUS_IO is set, which is only set for
> QUEUE_FLAG_SYNCHRONOUS devices: brd, zram and nvdimms (both btt and
> pmem). Therefore we don't sleep in this path, and there's no need to
> drop the mmap or per-vma lock.
> Drivers implementing ops->migrate_to_ram might still rely on mmap_lock,
> therefore fall back to mmap_lock in this case.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/filemap.c |  6 ++++++
>  mm/memory.c  | 14 +++++++++-----
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b4c9bd368b7e..7cb0a3776a07 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1706,6 +1706,8 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>   *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
>   *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
>   *     which case mmap_lock is still held.
> + *     If flags had FAULT_FLAG_VMA_LOCK set, meaning the operation is performed
> + *     with VMA lock only, the VMA lock is still held.
>   *
>   * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
>   * with the folio locked and the mmap_lock unperturbed.
> @@ -1713,6 +1715,10 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>  bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>  			 unsigned int flags)
>  {
> +	/* Can't do this if not holding mmap_lock */
> +	if (flags & FAULT_FLAG_VMA_LOCK)
> +		return false;

If here what we need is the page lock, can we just conditionally release
either mmap lock or vma lock depending on FAULT_FLAG_VMA_LOCK?

-- 
Peter Xu

