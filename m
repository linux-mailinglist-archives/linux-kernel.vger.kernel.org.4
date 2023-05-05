Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D946F8255
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjEEL4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjEEL4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:56:17 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529321A62F
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:56:14 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-74dfa88c65aso131918585a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1683287773; x=1685879773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MC6iN0jyJ3sebi4322AXijEPMpLwnqb+pxmCX7Z+38=;
        b=c6t9ycwFWpO4ffaF1cs62dqA8Ud7QA8ArgT1GP6X2fYREIsCOD+Y/NvCkbZGiVZ/fy
         wjuwFBUk0aijciVJUBjLXHqOdsUielVPogpIH/MMIGE5drbOApx3mENdMjTMEH8DYsqD
         y1bhOdBzEFpHBlqfnl4p2zcdnPb8L8zvphqnwkqYaehNcbvwfOckObjnUDBCBUYrRnI+
         ZFaP2JIPqBV7KciuKcaqLzisOUn2YemnVEJfKDQXU2eoUmr+USo1JjPS+muL6ZZUFWQ2
         Qs+IET/XRJ7VBAcMCfND9MrqEmdLw4W3LQrZ7DCFGMYjVzFjwcbzLVOqelTU9t+WSdy+
         qsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683287773; x=1685879773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MC6iN0jyJ3sebi4322AXijEPMpLwnqb+pxmCX7Z+38=;
        b=NQvDMWYXL7I9A0j6mqQs0PuP8tZSk/qf/CeamMaf1pNcU1VAOa/GFjzw1mFVs8djXx
         BN+8W+VV8uPFnvEG7nYQqAK0Az35fDFBD0jDkVrIdc+zC5RDC4Vdyy8OzEO9+UHSjuOG
         8FUJpa4guQrFFseVF4cYaUb9frTisRsiGEye3nyCShHyxVR+ojbrBMESKhjLGFExlVPf
         BkDtHiQ4WNBvuStJEyhegBJmdXlGJEj2UsnGD5lalF3qDeaMzcJ9Cz5Ocx9dihi2KrlX
         AFCvcK+W/TzRbfxK3ZtodIjA3037fvOLmWsnSIeL+7T6s1sgT83zozByal5cwOesiQ7f
         xUfQ==
X-Gm-Message-State: AC+VfDwV6uo2ImhoTcSB8bQOIJJw59aqScnsWdqH2hYHK76OoOIITWqI
        GdQcwI7Fx2bwGNeUtZIZaca8Ag==
X-Google-Smtp-Source: ACHHUZ7I0qCeLW4FF0K6C0hJNq+/Vy+umz77y4VnR12vphIX/22E4w+knRfyjxdvcFwRHCXw5i4feg==
X-Received: by 2002:ad4:5cc1:0:b0:5e9:2d8c:9a21 with SMTP id iu1-20020ad45cc1000000b005e92d8c9a21mr1914254qvb.32.1683287773386;
        Fri, 05 May 2023 04:56:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id y18-20020a0cf152000000b0061d5a59c36esm512183qvl.65.2023.05.05.04.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 04:56:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1puu2m-007s8W-Az;
        Fri, 05 May 2023 08:56:12 -0300
Date:   Fri, 5 May 2023 08:56:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ye.xingchen@zte.com.cn
Cc:     leon@kernel.org, jiangjian@cdjrlc.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Use fdget() and fdput()
Message-ID: <ZFTu3IX0sNItM80T@ziepe.ca>
References: <202305051133576690069@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305051133576690069@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 11:33:57AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> convert the fget()/fput() uses to fdget()/fdput().
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/infiniband/core/rdma_core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 29b1ab1d5f93..c35df0b27e86 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -335,7 +335,7 @@ lookup_get_fd_uobject(const struct uverbs_api_object *obj,
>  		      enum rdma_lookup_mode mode)
>  {
>  	const struct uverbs_obj_fd_type *fd_type;
> -	struct file *f;
> +	struct fd f = fdget(fdno);
>  	struct ib_uobject *uobject;
>  	int fdno = id;
> 
> @@ -350,18 +350,17 @@ lookup_get_fd_uobject(const struct uverbs_api_object *obj,
>  	fd_type =
>  		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
> 
> -	f = fget(fdno);
> -	if (!f)
> +	if (!f.file)
>  		return ERR_PTR(-EBADF);

This also has incorrect pairing with fdput

Jason
