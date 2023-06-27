Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E373FACD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjF0LLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjF0LLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:11:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171881BE4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:11:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so6120924f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687864309; x=1690456309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD4gCHSw4USDEh9b2CAEXtZoeo6S0MoZYWWqACPYVs8=;
        b=dzEHlwrjAq3l/IoDCt6xjw9i6BF7k8ufg0spNIZ9UqjNxd13I11BAW21Pju0z+hZ0h
         aMw4OO6iqqFMEDwEzhq7i9vZDccssCRfPHPiPI2+1EiwYggI2sQMwpD67Inu68gS/1un
         8nP5FtIC4NNuaaPzx7zzaOAh6whNJr6nAlv1biltWYCJG6uHt+Ci0Ma+Ra8zxy09FZmk
         Tp0o7+EGqKyZYgbREvjtzv3XK9iis5JSz3DJgODhgIap5/m05mSKMieLu/W2noiYiqg8
         fNQSPs/B3wAKNv/ze9YisGOID3fISFoQzBnzRQ2iGa4axNjcJgXVphax52RewIKfy3IZ
         2+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687864309; x=1690456309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD4gCHSw4USDEh9b2CAEXtZoeo6S0MoZYWWqACPYVs8=;
        b=QLmPpufesnUgjQ87VhFBbiHKZkXEk7zPAnjYolIrlD/46i6rVbCZx7Fij6brhLNbk/
         05d9AMoPZCq7ziLIL9VMG89w9yik1QnhW+RQebLA0CFStcFUK/fzWcgu9ZPZlmctf1xd
         Fbv5+SHCFIsmB8GR+S8lomBRfm3BL4enNTYgWrfyZo2n2IBEulihRKFXT6mcmZAPyB/t
         FPJc9AVZoD7AZw4DtJ2HWJKZnGAR0zahU3C71UbJzAgGonOQGCSGVp9ICa/pZsAHEFpg
         FtmOXtSq58TkWk/fBNLaej9zgRWHLmAqtCL5nip2Z1KDvuSyhvgXl4hyixicIHz/EkFU
         /VHg==
X-Gm-Message-State: AC+VfDyZqGgl0Ecxt4I1vunQM729f5j14z0DT58dynvK5qCE0VAP2jI9
        FNA1cBCjXzYH2fGOy5rnLjI=
X-Google-Smtp-Source: ACHHUZ5tDsQRE5joHqQ26TB+UzFNw2k0+hPWY5eFAUhisyYyCd/yGIMjITkKe3p4A3SuFoK8uRLFtQ==
X-Received: by 2002:adf:e585:0:b0:307:8879:6cc1 with SMTP id l5-20020adfe585000000b0030788796cc1mr33160184wrm.71.1687864309194;
        Tue, 27 Jun 2023 04:11:49 -0700 (PDT)
Received: from suse.localnet (host-79-12-109-185.retail.telecomitalia.it. [79.12.109.185])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600001c500b00313f7b077fesm3479235wrx.59.2023.06.27.04.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:11:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Deepak R Varma <drv@mailo.com>
Cc:     linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] gfs2: Replace deprecated kmap_atomic() by kmap_local_page()
Date:   Tue, 27 Jun 2023 13:11:46 +0200
Message-ID: <1905283.taCxCBeP46@suse>
In-Reply-To: <ZJiUKeVy7G6ZkX80@bu2204.myguest.virtualbox.org>
References: <ZJiUKeVy7G6ZkX80@bu2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 25 giugno 2023 21:23:21 CEST Deepak R Varma wrote:
> kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().
> 
> Therefore, replace kmap_atomic() with kmap_local_folio() in
> gfs2_internal_read() and stuffed_readpage().
> 
> kmap_atomic() disables page-faults and preemption (the latter only for
> !PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
> gfs2_internal_read() and stuffed_readpage() does not depend on the
> above-mentioned side effects.
> 
> Therefore, a mere replacement of the old API with the new one is all that
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Note: The Patch is build tested only. I will be happy to run recommended
> testing with some guidance if required.
> 
>  fs/gfs2/aops.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 3b41542d6697..7bd92054d353 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -432,10 +432,10 @@ static int stuffed_readpage(struct gfs2_inode *ip,
> struct page *page) if (error)
>  		return error;
> 
> -	kaddr = kmap_atomic(page);
> +	kaddr = kmap_local_page(page);
>  	memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
>  	memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	flush_dcache_page(page);
>  	brelse(dibh);
>  	SetPageUptodate(page);
> @@ -498,12 +498,12 @@ int gfs2_internal_read(struct gfs2_inode *ip, char 
*buf,
> loff_t *pos, continue;
>  			return PTR_ERR(page);
>  		}
> -		p = kmap_atomic(page);
> +		p = kmap_local_page(page);
>  		amt = size - copied;
>  		if (offset + size > PAGE_SIZE)
>  			amt = PAGE_SIZE - offset;
>  		memcpy(buf + copied, p + offset, amt);

How about using memcpy_from_page()? 

Fabio

> -		kunmap_atomic(p);
> +		kunmap_local(p);
>  		put_page(page);
>  		copied += amt;
>  		index++;
> --
> 2.34.1




