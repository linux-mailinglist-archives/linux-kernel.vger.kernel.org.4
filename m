Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56E9706F43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEQRXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEQRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:23:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52728728A;
        Wed, 17 May 2023 10:23:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3063433fa66so704507f8f.3;
        Wed, 17 May 2023 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684344201; x=1686936201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BKD2whEK1ythHrThH/kmgQln8MVyL2sg+QVZlHM2h4=;
        b=SBC//ysUyt07A2/dgDEBiBiArbsFSHb0XkiDqC3g3wRyEVTTBadlJS+ClVJK8O7mEo
         g6HovdKo6e7cAzRNepEyhrpzCgIrwvlDwb8np/iRSWaFdWlccDVCQd0c2HiBCaZhxlKg
         hxfQ5Oui6egclQgMfzb9N6AZiJrctTqJov1LEgHwWYOg5FnleKCDmWxfDFZU9tm7aWSC
         +eHZ6h9WGz1ISEIIL5MQu/4VvyHWPbxhgvQy0ArBoir18+i1O8WJ27hVZLkZExyRSU36
         Vj74LBwRo/A+Jyw4F4bZ/BcQoGsKqh91TE7SejGERdy1uECmgz5SIbkccF0QkqtghDeV
         8h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344201; x=1686936201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BKD2whEK1ythHrThH/kmgQln8MVyL2sg+QVZlHM2h4=;
        b=B913GSLN43BxOOqzVEy6UXKC8/xjVJsLtBe2P9ZgSxy7BNWLhv+W218cH45CDGNSCF
         F7odf6QlyIuEFnek82sxogKqN643k6eUx4SRQ2Omxt4W0Uwsi0lbUnaPcXB0lFznWQsK
         BG1ARirjK/tJ0eh/lwUol5xXBcZuTN2TGnjuVv1/nsqxkigA97NplI5htA1KdnvxPInO
         KuDngaqj/8dtk42C5DhHpaExCkKlrmyiyEOKxUxA+Oxt6KWqBvU5Al04++9a2/TgLdsf
         pKAQ7kQvboOTk9/pWYK8lJ9oGtNNG13jfBiJdOM5fIVoZ0ELS2X2WRlqHka4RQRClTse
         1Dtg==
X-Gm-Message-State: AC+VfDy9F8AVnaFy/flwZYAE2azk9o5a5f5dhOYpFqf2Zp6hpGUvySnx
        M98wifIr7pVWFZIPHQCwiefv1BvKx8e5QQ==
X-Google-Smtp-Source: ACHHUZ4Bm7EWE3rQkQrjXhJTqdVO9G3J0QmcuTgJ1GRFii3dXQfi9F5ixtgIaHCSJOkT0h7drZ1UnA==
X-Received: by 2002:a5d:4a8f:0:b0:306:2d3d:a108 with SMTP id o15-20020a5d4a8f000000b003062d3da108mr1133169wrq.11.1684344200527;
        Wed, 17 May 2023 10:23:20 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id z8-20020adfe548000000b00306281cfa59sm3321041wrm.47.2023.05.17.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:23:19 -0700 (PDT)
Date:   Wed, 17 May 2023 18:23:18 +0100
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
Subject: Re: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
Message-ID: <a23dc138-a7b3-40c7-adf9-68b2c8185e08@lucifer.local>
References: <20230517150408.3411044-1-peterx@redhat.com>
 <20230517150408.3411044-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517150408.3411044-3-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:04:08AM -0400, Peter Xu wrote:
> We used to not pass in the pgoff correctly when register/unregister uffd
> regions, it caused incorrect behavior on vma merging and can cause
> mergeable vmas being separate after ioctls return.
>
> For example, when we have:
>
>   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
>
> Then someone unregisters uffd on range (5-9), it should logically become:
>
>   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
>
> But with current code we'll have:
>
>   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
>
> This patch allows such merge to happen correctly before ioctl returns.
>
> This behavior seems to have existed since the 1st day of uffd.  Since pgoff
> for vma_merge() is only used to identify the possibility of vma merging,
> meanwhile here what we did was always passing in a pgoff smaller than what
> we should, so there should have no other side effect besides not merging
> it.  Let's still tentatively copy stable for this, even though I don't see
> anything will go wrong besides vma being split (which is mostly not user
> visible).
>

Maybe a Reported-by me since I discovered the fragmentation was already
happening via the repro? :)

> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: linux-stable <stable@vger.kernel.org>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 17c8c345dac4..4e800bb7d2ab 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	bool basic_ioctls;
>  	unsigned long start, end, vma_end;
>  	struct vma_iterator vmi;
> +	pgoff_t pgoff;
>
>  	user_uffdio_register = (struct uffdio_register __user *) arg;
>
> @@ -1484,8 +1485,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		vma_end = min(end, vma->vm_end);
>
>  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> +				 vma->anon_vma, vma->vm_file, pgoff,
>  				 vma_policy(vma),
>  				 ((struct vm_userfaultfd_ctx){ ctx }),
>  				 anon_vma_name(vma));
> @@ -1565,6 +1567,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	unsigned long start, end, vma_end;
>  	const void __user *buf = (void __user *)arg;
>  	struct vma_iterator vmi;
> +	pgoff_t pgoff;
>
>  	ret = -EFAULT;
>  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> @@ -1667,8 +1670,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			uffd_wp_range(vma, start, vma_end - start, false);
>
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> +				 vma->anon_vma, vma->vm_file, pgoff,
>  				 vma_policy(vma),
>  				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
>  		if (prev) {
> --
> 2.39.1
>

Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>
