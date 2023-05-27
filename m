Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43E713691
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 23:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjE0Vua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 17:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE0Vu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 17:50:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D6E1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 14:50:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6e1394060so13138975e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 14:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685224225; x=1687816225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTsVdUYETUvQYhUsw1vPQ/A3pGTfainUln+I/qbbldc=;
        b=CQgaY0bmsaNbweVhEC0EK6GXufe06allmuKFEgeGlfGP9QY+P6tncaRLlow9wr+dJm
         Mx+iiysTQEZnoWlNMRz8e5xU2nCLr0d3HfcGL+HtuRCabqOOtFALGjticDrsVQQrD+0y
         +0lySbjFg+qZmklNrU+6HS6Sg4UOu9DIgyoTAX+NRrQ+Wrb++UfBGrMeyb4JGsu6uAd9
         zwuKp4uT3YUh4Jjque+4SRcMj9WhJCQlVPpODZbNZhRW38+/28OUVW3sWLSnWeHJ22jk
         zN96CH7Z6W1C5DdBb9hM2HpZRWkORsdGHGmLxICUk00a1Up7mAXkAc+K3rcU94B4EXdQ
         W9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685224225; x=1687816225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTsVdUYETUvQYhUsw1vPQ/A3pGTfainUln+I/qbbldc=;
        b=G2A8/9IdDi2wwV27KUy1pYSuaIHl09xWnIcS2XcIQ6Qu9aWi7koNK6E27SuXBL0Lqu
         8nWVd0YAqNpramwiSwgP9Zywxq+FrAMPZaTJgxysdr0fkei3HzRGNUNoaTHhfAMEQEDz
         mgKBsN4akVbSKU7hw9AdU+4ePJXQ6v6La+06UHJJbboO2lHrswhpv3z1fpmByU2PIWy+
         7Mxta0QI158pmazqJh4qDCb5XKgosLyyJL89Jvi+UJOeRPkten5H5fcm1SiRHq7xNbXp
         0ilacS97j8XLrUpUD0WEwLdZWZ8MEyVicCUlxMSa19IERcVFy2/aMi/O8Jy2n9AcUHw5
         IzvA==
X-Gm-Message-State: AC+VfDyrEoVaOFmpS36Zwd3cmuQil3iLn6T0wFTQF63sA+yj379Awu5A
        zSBx3vw/VPZsFshIJsI1Kps=
X-Google-Smtp-Source: ACHHUZ6iYmBy5nvwNicNEHak52BAfb3Xn61RNndtwukSHqCQVlO+DGtBHKytR6CyIp8smldrBn3WzA==
X-Received: by 2002:a7b:cd8e:0:b0:3f6:113a:2023 with SMTP id y14-20020a7bcd8e000000b003f6113a2023mr5496015wmj.12.1685224224699;
        Sat, 27 May 2023 14:50:24 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id r8-20020adfdc88000000b003077f3dfcc8sm8977794wrj.32.2023.05.27.14.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 14:50:23 -0700 (PDT)
Date:   Sat, 27 May 2023 22:50:22 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/9] mm: vmalloc: Rename adjust_va_to_fit_type() function
Message-ID: <7afd7647-15c2-4398-89a6-ed50b4115b84@lucifer.local>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522110849.2921-3-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:08:42PM +0200, Uladzislau Rezki (Sony) wrote:
> This patch renames the adjust_va_to_fit_type() function
> to a shorter variant and more expressive. A new name is
> va_clip().
>
> There is no a functional change as a result of this patch.

Small nit - I think:-

'This patch renames the adjust_va_to_fit_type() function to va_clip() which
is shorter and more expressive.'

Reads better here.

>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 409285b68a67..5f900efec6a9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1383,9 +1383,9 @@ classify_va_fit_type(struct vmap_area *va,
>  }
>
>  static __always_inline int
> -adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> -		      struct vmap_area *va, unsigned long nva_start_addr,
> -		      unsigned long size)
> +va_clip(struct rb_root *root, struct list_head *head,
> +	struct vmap_area *va, unsigned long nva_start_addr,
> +	unsigned long size)
>  {
>  	struct vmap_area *lva = NULL;
>  	enum fit_type type = classify_va_fit_type(va, nva_start_addr, size);
> @@ -1501,7 +1501,7 @@ va_alloc(struct vmap_area *va,
>  		return vend;
>
>  	/* Update the free vmap_area. */
> -	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> +	ret = va_clip(root, head, va, nva_start_addr, size);
>  	if (WARN_ON_ONCE(ret))
>  		return vend;
>
> @@ -3979,9 +3979,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  			/* It is a BUG(), but trigger recovery instead. */
>  			goto recovery;
>
> -		ret = adjust_va_to_fit_type(&free_vmap_area_root,
> -					    &free_vmap_area_list,
> -					    va, start, size);
> +		ret = va_clip(&free_vmap_area_root,
> +			&free_vmap_area_list, va, start, size);
>  		if (WARN_ON_ONCE(unlikely(ret)))
>  			/* It is a BUG(), but trigger recovery instead. */
>  			goto recovery;
> --
> 2.30.2
>

Otherwise,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
