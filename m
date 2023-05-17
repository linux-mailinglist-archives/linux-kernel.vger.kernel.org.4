Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EEB706F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEQRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:21:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320ED3C30;
        Wed, 17 May 2023 10:20:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f42c86543bso7478875e9.3;
        Wed, 17 May 2023 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684344057; x=1686936057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HA+ixEOwCV4Hwwy5VjUh4gi4ftgl8VXHtW5tml/MLqE=;
        b=fUZqBmeKT6KmMPjBLnquAOsfG4TxLX5U+yqd4jMj4CFMMPxPx5afekJgE9u3N60vFs
         czRuwzlzqq0DJbKxeVpYWZcSNn2bWwMsAcNS4KH9J56AGvXDgoKRur/7XwWNtmJ6nzRY
         OsQUioZJqLSVX5C13tPPiwxRz/VpXwHiOU4FKE0UA8ZK9v0oWINFMWEwPHNw+TRLo0JB
         QV4RTp7oLWMayyEg72wa63GGOQ+Ga2bFwXZ2ZFm1mEZhcLA0y7eT0u2PWWemquHO5C3q
         K1hp7fnCac5RZ85ATb61ffkpdjWaEZM8haCq9kVErKIrE+mcClLIASt/LwgP+5vQt/rA
         D6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344057; x=1686936057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA+ixEOwCV4Hwwy5VjUh4gi4ftgl8VXHtW5tml/MLqE=;
        b=aSXAy8cuNse4AjtPhut7kdwMiZu7WwFFacFNYw2c2pNHL47Mfy78PE/solzKGSl3/z
         A9Xkk34NQpthUT817x5IFcTGIDOJf+s7zLfjOOQQO5RCY3DrGrql0S4VepPVx7MMi0yC
         iXSjAFVNSXpbqbuxGE+Hgs3CdbTmOdlGjdR/71uPyCVC+K96eqki/M75ilcGbZ8wi2WI
         hI9IvTrQqVwyw07n7uTmq+LLmVhQFD9CTbzpo7DepKHmh9VsT76wQpfeWULiNE0bl0VM
         Rt3ACBDW0EX2ypoenM9XIVmXZkISVPnF4qThU2Cmh8cciFafpfVChzqC62wh4+GrAjAB
         BzMg==
X-Gm-Message-State: AC+VfDwM69t9iCJiA4dcoP0AXmPCCXSE/qRlqmWFKeFGghZD2Ri3lSQ5
        fzFxPRoO2xvfSjhceB0GTC4=
X-Google-Smtp-Source: ACHHUZ42RsRkUPWyt7iyPDUgEzeLUAEWnTphTkFVUV2Ao1RrkLmyQ1485/W7O1jeZ5yWCPU6AKklrA==
X-Received: by 2002:a7b:c318:0:b0:3f0:a08e:811b with SMTP id k24-20020a7bc318000000b003f0a08e811bmr29765842wmj.13.1684344057210;
        Wed, 17 May 2023 10:20:57 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id y26-20020a7bcd9a000000b003f42a75ac2asm2891446wmj.23.2023.05.17.10.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:20:56 -0700 (PDT)
Date:   Wed, 17 May 2023 18:20:55 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts
 part of vma
Message-ID: <4a68aee6-68d9-4d17-bb7f-cda3910f6f1f@lucifer.local>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517150408.3411044-2-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:04:07AM -0400, Peter Xu wrote:
> It seems vma merging with uffd paths is broken with either
> register/unregister, where right now we can feed wrong parameters to
> vma_merge() and it's found by recent patch which moved asserts upwards in
> vma_merge() by Lorenzo Stoakes:
>
> https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
>
> The problem is in the current code base we didn't fixup "prev" for the case
> where "start" address can be within the "prev" vma section.  In that case
> we should have "prev" points to the current vma rather than the previous
> one when feeding to vma_merge().

This doesn't seem quite correct, perhaps - "where start is contained within vma
but not clamped to its start. We need to convert this into case 4 which permits
subdivision of prev by assigning vma to prev. As we loop, each subsequent VMA
will be clamped to the start."

>
> This patch will eliminate the report and make sure vma_merge() calls will
> become legal again.
>
> One thing to mention is that the "Fixes: 29417d292bd0" below is there only
> to help explain where the warning can start to trigger, the real commit to
> fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
> issue, but unfortunately we may want to keep it in Fixes too just to ease
> kernel backporters for easier tracking.
>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 29417d292bd0 ("mm/mmap/vma_merge: always check invariants")
> Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
> Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> Cc: linux-stable <stable@vger.kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 0fd96d6e39ce..17c8c345dac4 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1459,6 +1459,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>
>  	vma_iter_set(&vmi, start);
>  	prev = vma_prev(&vmi);
> +	if (vma->vm_start < start)
> +		prev = vma;
>
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
> @@ -1625,6 +1627,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>
>  	vma_iter_set(&vmi, start);
>  	prev = vma_prev(&vmi);
> +	if (vma->vm_start < start)
> +		prev = vma;
> +
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
>  		cond_resched();
> --
> 2.39.1
>

Other than that looks good:-

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
