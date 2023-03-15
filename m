Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52596BBDC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjCOUKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjCOUKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:10:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73DB92258
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:10:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t15so18390831wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678911006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjNFc/1sMZOGefBpFSEuqAcOT+g79OJ+uWo9eDYsxwg=;
        b=U04MlTlTCuZLzLmil7UNgqN++w9Yx1ypk+Hb8RZxgFRrUTMtmferA0mFwHFc0Yddib
         Sey4M7QJ8/nbJPj3Fsdhlu7LNKNXazlc7KLQPNzwQo/dHoLJK++E4FdKCW25yQcT7wL0
         9MRdYCAG5gENid8qwX9yh3XW9JgcSnGD8+7uW3h1Lq5Wc5NSeIO0mCnDAFeeFfcZmhUv
         XvAxGtXWZ6neYXJdh9/8irHIVE4FeVkGFANuLYPAZxnX6Lr4zS79YDNDKZOxnMdHaNKs
         TL1o2i7jIV7BLCWmRzEshailuKHjII/KnRDx/ZDJ4XZDS0P/Zu8HM3C6fZTn7ibwiuGm
         l1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678911006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjNFc/1sMZOGefBpFSEuqAcOT+g79OJ+uWo9eDYsxwg=;
        b=yF5VgAf8n+5pPFtPmSYmpLJWs7uRepKGMnX4ALZQo6G1SsyqBQBhy4qja855g9iwH/
         aGmqXMFwsbRatuIuWO5EXn2wsAw4S/wPfdOowwQWn3aZxJorW2iGW7vXEiE/w5deV855
         750aykDmOC7EX6eIt8ZbE9gIxluiwSXnIobmCo2C8Iii7v4qRv/2fcCCkwEU9/NAY92q
         qFuQ7H5H9w+A4G/mRRmpGusvt8UJcywrMZUZ2Vk36p7+k7YzV/wD58ocBxB1pLH6DC1X
         dlnLTO2ryVSrIwJ7U3K4CBd7clGsbrVMNoDxnvBD/OWazPnFOaszwYKQwFTwXa6oLdWw
         XLzg==
X-Gm-Message-State: AO0yUKX8D0F9KXUKMB4nSqbjbjMIHRT2CCaM5UQSsLCMuAoXPbSfPTQt
        OI3ooc34HP1uyN9Wvtmj/uk=
X-Google-Smtp-Source: AK7set/iDb0oAA8W1jHGhwWNaz0h3L+QskK8ZyvbCMZTalMSsRvQCWrk0wnuSpsMMK+XXUx+r1vbUw==
X-Received: by 2002:a5d:4577:0:b0:2ce:a7da:ed5b with SMTP id a23-20020a5d4577000000b002cea7daed5bmr2852784wrc.47.1678911006119;
        Wed, 15 Mar 2023 13:10:06 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id o3-20020a056000010300b002ceac2ccc4asm5567757wrx.23.2023.03.15.13.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 13:10:05 -0700 (PDT)
Date:   Wed, 15 Mar 2023 20:10:04 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 05/10] mm/mmap/vma_merge: initialize mid and next in
 natural order
Message-ID: <b2675efc-e019-43f6-b322-c0217fef5ed6@lucifer.local>
References: <20230309111258.24079-1-vbabka@suse.cz>
 <20230309111258.24079-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309111258.24079-6-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:12:53PM +0100, Vlastimil Babka wrote:
> It is more intuitive to go from prev to mid and then next. No functional
> change.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 420d6847c94c..be60b344e4b1 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -912,10 +912,11 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vm_flags & VM_SPECIAL)
>  		return NULL;
>
> -	next = find_vma(mm, prev ? prev->vm_end : 0);
> -	mid = next;
> -	if (next && next->vm_end == end)		/* cases 6, 7, 8 */
> -		next = find_vma(mm, next->vm_end);
> +	mid = find_vma(mm, prev ? prev->vm_end : 0);
> +	if (mid && mid->vm_end == end)			/* cases 6, 7, 8 */
> +		next = find_vma(mm, mid->vm_end);
> +	else
> +		next = mid;

It feels like the original implementation may have been backwards like this just
to avoid this else branch. Which is silly.

>
>  	/* verify some invariant that must be enforced by the caller */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> --
> 2.39.2
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
