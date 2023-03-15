Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91936BBD79
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCOTnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCOTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:43:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F69233DA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:43:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso1772424wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678909398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=faGj14zwqsds1k0brXyrvNbil7oPyorU3jtCVxRIE+E=;
        b=CqKWAXw5aP4qj4PRd2coPP/BKlwUpxk8Qq8oCoGvAX2bOsnMKQpfV87WspTRgF7r8I
         o6BbCB8E4aP/X9b/47q3BACYewFF8G/kgut23QasJmxhZPF1thAuWfkE7oERVgEJ4t5M
         GTt1ZooPo5EYuqSZ93/EqfjIyFhFifMhKUgQ55PRE7JBVuH7TqUM3AIMpeyo3IzP8WiD
         dNJt0qcs5Q+zLa0Gxi74Caodf4+9/WgmQY4ChQEaLhdDK1Kf3bA9fiqyqh5111faKy7s
         FUbFDVDVmstkMsPhEOdE0BuYUvTfTP42BJIDH712VIy1ocQGdgeEw1FFSTBJTxooLtND
         b3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faGj14zwqsds1k0brXyrvNbil7oPyorU3jtCVxRIE+E=;
        b=xHlDd2wEMhw/3GuEQKBBejIW3Xh5S4mB92+jmYj0Q/9DLhmouQTKJbRVQpWWj96LTO
         SjvpVsS8iMw7j+17gOx+As1Pzvz+vKD7O309JCZUMSTZLm70FaY6xVyk96JoYTac/iNp
         QA4HijHOpt8d8Csmza9NoGGdfx8L2VAO7zUCHTrd+Dtuq7hAM+TiKrYB+WQSoHo8Hqp0
         Yl363GRX6F/WCkTU6ve95+gqsv5dKhKoF0W4lVkLGpBbk2oECE/1zBTTIvC8uCouEH60
         Iq9ptKDjEtS9zCju9CFtFOdwdDp6qyyhgx1R5mgaxCdfqN4ZeTnj0u27IFfvqurJOqkt
         Ziyg==
X-Gm-Message-State: AO0yUKVAjvZsGHcDMKvL5SLqFhSkgWONX0msX7jIoR9JPqLqM0GOnfri
        Bj2/jnlUpiYyCrGYGNvIYHYwnVZQlyc=
X-Google-Smtp-Source: AK7set8zVKajDUElQgs1Ba36/Q7Q1gh8V4Hs0L9VhxlX/f8mCLCNZZw2Y7DKczu3jZudG12O07o1hg==
X-Received: by 2002:a05:600c:1f11:b0:3df:ee64:4814 with SMTP id bd17-20020a05600c1f1100b003dfee644814mr18026500wmb.20.1678909398252;
        Wed, 15 Mar 2023 12:43:18 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id q20-20020a1ce914000000b003dfe549da4fsm2722922wmc.18.2023.03.15.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:43:17 -0700 (PDT)
Date:   Wed, 15 Mar 2023 19:43:16 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 03/10] mm/mmap/vma_merge: use the proper vma pointers in
 cases 1 and 6
Message-ID: <14e3bc0b-3deb-4bc1-a400-5dfc44b46f4e@lucifer.local>
References: <20230309111258.24079-1-vbabka@suse.cz>
 <20230309111258.24079-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309111258.24079-4-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:12:51PM +0100, Vlastimil Babka wrote:
> Case 1 is now shown in the comment as next vma being merged with prev,
> so use 'next' instead of 'mid'. In case 1 they both point to the same
> vma.
>
> As a consequence, in case 6, the dup_anon_vma() is now tried first on
> 'next' and then on 'mid', before it was the opposite order. This is not
> a functional change, as those two vma's cannnot have a different
> anon_vma, as that would have prevented the merging in the first place.
>

This makes me wonder whether there might be further simplifications based upon
known conditions of mergeability to be had (as e.g. is_mergeable_anon_vma()
would have prevented otherwise). But perhaps I will discover these later in the
series :)

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mmap.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1af4c9bc2c87..c33237b283c9 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -605,7 +605,7 @@ static inline void vma_complete(struct vma_prepare *vp,
>
>  		/*
>  		 * In mprotect's case 6 (see comments on vma_merge),
> -		 * we must remove the one after next as well.
> +		 * we are removing both mid and next vmas
>  		 */
>  		if (vp->remove2) {
>  			vp->remove = vp->remove2;
> @@ -948,13 +948,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	/* Can we merge both the predecessor and the successor? */
>  	if (merge_prev && merge_next &&
>  	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
> -		remove = mid;				/* case 1 */
> +		remove = next;				/* case 1 */
>  		vma_end = next->vm_end;
> -		err = dup_anon_vma(prev, mid);
> +		err = dup_anon_vma(prev, next);
>  		if (mid != next) {			/* case 6 */
> +			remove = mid;
>  			remove2 = next;
> -			if (!mid->anon_vma)
> -				err = dup_anon_vma(prev, next);
> +			if (!next->anon_vma)
> +				err = dup_anon_vma(prev, mid);
>  		}
>  	} else if (merge_prev) {
>  		err = 0;				/* case 2 */
> --
> 2.39.2
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
