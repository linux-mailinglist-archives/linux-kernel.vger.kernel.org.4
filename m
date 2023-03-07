Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C3E6AD3C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCGBUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCGBUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:20:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592B367EE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 17:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678152000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qrw2gr+qx7DWb3UAvdR/mcFIQhqsDgcX3EEuLph/d4=;
        b=YGeRZmkt7KTnmfz0mjbJg7dpkGGflmQPQEwP2U3RoDgEjIjwDq0sLFrNl/L7jawKbGyXou
        V/6djRUqTh2s2HMDxNwPuIjMLaHKe3raP6r1IJM8xkLeV0l0KetebFhABURHHI+jCl+WuW
        jnYMOIKpJfBAGU5cG3HgDeHdp2u2vX4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-qDVqU_rcMJGf3_973YsV-Q-1; Mon, 06 Mar 2023 20:19:59 -0500
X-MC-Unique: qDVqU_rcMJGf3_973YsV-Q-1
Received: by mail-qv1-f70.google.com with SMTP id d27-20020a0caa1b000000b00572765a687cso6619884qvb.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 17:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678151999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qrw2gr+qx7DWb3UAvdR/mcFIQhqsDgcX3EEuLph/d4=;
        b=3UDI4DwQqfM69eK5hWlLQ+D9m3+BGzAjZSCi1gPEde2UmPwWLQcUQgLmWzchcughqx
         8+hH38np0xDKyZKEwvbHhJ5vj0A7ZEJBwnElSZrincLVfabD1l3ktT7lloR7gtqi7hgm
         btnvVoPRDIMNcfwzXHQmpgAOrP1LWfKNYHprurvVz0bybw71f3GSI3YyWZSviinWv4rW
         mL0TsPLp0zvlBK9E/QiqnLfRjbfdovhZXIhj968BDd00e99GLCrwIOHyEbgotb4CrHGQ
         wzPFaFCB3E4TiIK05QAYA91/rIgI9mQnAa4fbfIxLGxgatQwHrS2f5m72XVsC+V51NSh
         RFaw==
X-Gm-Message-State: AO0yUKVaUyaOLWelCF3jAYtiFbMfmw3z0jIJ3lc2ldrJs1ydLLEAwoM7
        aGWp880OU0YpQMfcnjLdYlFvNG/DAf+c5dU/ufTbVykyPrWkAsSYA12jNaOi9Hd5x6gLWD7zmda
        JtRfGl1fyUVVvhOtEEvSQL94q
X-Received: by 2002:ac8:7d12:0:b0:3bf:d71e:5b08 with SMTP id g18-20020ac87d12000000b003bfd71e5b08mr25643225qtb.3.1678151999073;
        Mon, 06 Mar 2023 17:19:59 -0800 (PST)
X-Google-Smtp-Source: AK7set+YPHN/ncr0Du5Ek2aNycnO04K6K6elfomWX85YMAJoHPLqYfwEiEIk3YRAWh/HHoBKpUm+sw==
X-Received: by 2002:ac8:7d12:0:b0:3bf:d71e:5b08 with SMTP id g18-20020ac87d12000000b003bfd71e5b08mr25643186qtb.3.1678151998762;
        Mon, 06 Mar 2023 17:19:58 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id j11-20020a05622a038b00b003bd0f0b26b0sm8855311qtx.77.2023.03.06.17.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:19:58 -0800 (PST)
Date:   Mon, 6 Mar 2023 20:19:56 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 4/5] mm: userfaultfd: don't separate addr + len
 arguments
Message-ID: <ZAaRPCntR94hGBL2@x1n>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306225024.264858-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:50:23PM -0800, Axel Rasmussen wrote:
> We have a lot of functions which take an address + length pair,
> currently passed as separate arguments. However, in our userspace API we
> already have struct uffdio_range, which is exactly this pair, and this
> is what we get from userspace when ioctls are called.
> 
> Instead of splitting the struct up into two separate arguments, just
> plumb the struct through to the functions which use it (once we get to
> the mfill_atomic_pte level, we're dealing with single (huge)pages, so we
> don't need both parts).
> 
> Relatedly, for waking, just re-use this existing structure instead of
> defining a new "struct uffdio_wake_range".
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c              | 107 +++++++++++++---------------------
>  include/linux/userfaultfd_k.h |  17 +++---
>  mm/userfaultfd.c              |  92 ++++++++++++++---------------
>  3 files changed, 96 insertions(+), 120 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index b8e328123b71..984b63b0fc75 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -95,11 +95,6 @@ struct userfaultfd_wait_queue {
>  	bool waken;
>  };
>  
> -struct userfaultfd_wake_range {
> -	unsigned long start;
> -	unsigned long len;
> -};

Would there still be a difference on e.g. 32 bits systems?

[...]

>  static __always_inline int validate_range(struct mm_struct *mm,
> -					  __u64 start, __u64 len)
> +					  const struct uffdio_range *range)
>  {
>  	__u64 task_size = mm->task_size;
>  
> -	if (start & ~PAGE_MASK)
> +	if (range->start & ~PAGE_MASK)
>  		return -EINVAL;
> -	if (len & ~PAGE_MASK)
> +	if (range->len & ~PAGE_MASK)
>  		return -EINVAL;
> -	if (!len)
> +	if (!range->len)
>  		return -EINVAL;
> -	if (start < mmap_min_addr)
> +	if (range->start < mmap_min_addr)
>  		return -EINVAL;
> -	if (start >= task_size)
> +	if (range->start >= task_size)
>  		return -EINVAL;
> -	if (len > task_size - start)
> +	if (range->len > task_size - range->start)
>  		return -EINVAL;
>  	return 0;
>  }

Personally I don't like a lot on such a change. :( It avoids one parameter
being passed over but it can add a lot indirections.

Do you strongly suggest this?  Shall we move on without this so to not
block the last patch (which I assume is the one you're looking for)?

Thanks,

-- 
Peter Xu

