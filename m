Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864CE6C6797
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCWMFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjCWMFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:05:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC35B84
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:03:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso931925wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679573026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TeiulGRJuAG8oV3+nSxuU+e5BdoA3oJAm0zh1OHOoQY=;
        b=bnXNzBQwmOq0q/QSsr3o8zZd/0xdbYPBHZ59TxEv9j725JKXeofdx/aZeL1D8eCWaU
         WpIr6JBYOLWdXl1A+x28YtZq7kE5Ai3lL6mXIMZcWCAQWUqqROvn2j93rCjLu/OK7eL9
         tlHdemCXTusvbjoGWj332SUk1MGBmDSwBhApsVpOpuIJvvlPfCmGk3/lqZEBprxRE7sf
         ZgX4Y5HnfaFT+YOqj18DjFR4/MZwUBZvlpSeFsyL/NmKvzjQPD7l6hEzJX891MhOvt1i
         UcOnu1kiUVWLhONtILhLB5frJPVUTtJCyEDDh+8a/A148wmIgmwMIksaZSS3n5WRckPP
         fsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeiulGRJuAG8oV3+nSxuU+e5BdoA3oJAm0zh1OHOoQY=;
        b=e0CW1lf65yZV3pJ1XWH/q/gzxyK0DOEa9Sgql14XRhDEgFGm4C2UEJrmh+9zrvrEzp
         2UnekGJF0yE49zK7WKzpNs13kWVqsvoZ1Clcf4JvNdD/pxU/8xEQ6LhxwY7nBJ+rDVaQ
         hT/4QvqlzbcNun7TPS9CqN8CmDk8ZqANkESvMZnFYMA2sDQPFNfoOBLMn7ghxuLXiTFv
         MrueNxXO6xKWr5QEKwpujOQtRTwWkH5vH2YQHYcauD/o6fxOt1QaJx6Qas7Wk/5pEZ1F
         dQg3lMRhPN0Q7itHDCE5650uxt01UV73183G5r3GmbihpbxMnYP8eR88u4Z85oIBxrBD
         AJxw==
X-Gm-Message-State: AO0yUKW9GY1WxzBUPyxKqt8RHbVdSKa7s3622EWbvpELGGyujNMGGyuE
        UWpJJRsCoTtcyVm5Kcjbfys=
X-Google-Smtp-Source: AK7set/cQOWUea/d79eWNQjNG1Mc2o8W27XFk4hxmba5L79MsY8xd0cMreE4dc3uzSnvzx1xPhB7Sg==
X-Received: by 2002:a7b:c409:0:b0:3ee:2b04:e028 with SMTP id k9-20020a7bc409000000b003ee2b04e028mr2231927wmi.14.1679573026088;
        Thu, 23 Mar 2023 05:03:46 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b003ee2a0d49dbsm1695390wmo.25.2023.03.23.05.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:03:45 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:03:44 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/3] mm/mmap/vma_merge: actually set next to NULL if not
 applicable
Message-ID: <21236776-232e-4653-8bd0-8a2dcc6fe63c@lucifer.local>
References: <20230323115903.1483668-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323115903.1483668-1-arnd@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:58:34PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> As clang builds point out, the variable 'next' is now uninitialized
> in some conditions as a result of a previous patch that tried to
> rely on it being NULL here:
>
> mm/mmap.c:939:11: error: variable 'next' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         else if (!curr)
>                  ^~~~~
> mm/mmap.c:952:15: note: uninitialized use occurs here
>         merge_next = next && mpol_equal(policy, vma_policy(next)) &&
>                      ^~~~
>
> Fixes: e887ecae997e ("mm/mmap/vma_merge: set next to NULL if not applicable")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/mmap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 54099a604cf8..c01d43bd694e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -939,6 +939,8 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	else if (!curr)
>  		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
>  		next = vma_lookup(mm, end);
> +	else
> +		next = NULL;
>
>  	/* Can we merge the predecessor? */
>  	if (prev && addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
> --
> 2.39.2
>

This was already fixed in a more recent series of this patch set (at
v3). Sorry for this reaching -next!

See https://lore.kernel.org/all/cover.1679516210.git.lstoakes@gmail.com/
