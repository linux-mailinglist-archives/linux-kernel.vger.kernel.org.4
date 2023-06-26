Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B059C73DCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjFZLAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3FD2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687777155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXfJyOWqEBeEpYhX2cTPTkoQq9Q43qmBhLD8fLh4bpw=;
        b=BVkcQMUa10rVsLefgnSjXWsbRdgpBcPWM8If2saXA+fRkDWqHTmZzmDSjEB71JygGxMLF8
        Kr/yVeECVIYEv1LKIojO6j0OhDAv46Ca0yn9RqAJw7cmTRZEIcoKZ4RdY0cn1YZ/Re22SX
        KFQIBWkNjTx9nqoVSbXzmuNBGmWAOXA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-rnOKZqstNKa4dKtq85zMHg-1; Mon, 26 Jun 2023 06:59:14 -0400
X-MC-Unique: rnOKZqstNKa4dKtq85zMHg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-313f5021d9bso208001f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687777153; x=1690369153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXfJyOWqEBeEpYhX2cTPTkoQq9Q43qmBhLD8fLh4bpw=;
        b=KFq/9ZHehZYmt1/X4/U2XsxB0hmRm1P5BhGThSHfb9gDX0MjDAOiTAiUE4CM8HN6K8
         GxD3IJRL9P4a29qqi/WD48HxWHCyPFlRxeM82QHsf2NGeAMDl75b/VYNSTy0zewWteW2
         r810wcj51J2iPptOwN2RrK5R+kwSv/mGDl5jDJ2WfDCKT8+oaVY2aT1ySH7U+S1X6WFU
         MhSH4ZvNB3xegtFS02BvR/jJjMIcvxaJb95d71G+UBheXxHbCdGo7u5Q23m2hW2uNo+m
         HgxMOY0li0TNC9Hc13aalA4xODi8AtktqwiVTZOsxnrsVjRijB4X1/c3unn+zasgNYs5
         cPSg==
X-Gm-Message-State: AC+VfDz08ILRQAnJzcYUF0jGxjBAd/15jVyLZsfQXt3PlERaR2GARSC6
        u1qWNDlZLBxmarai7QlGPvzBRie+USnH34ria0kAZQR602yhKE7rJeB2Ph4KtnbuR54yyo4vQ3Z
        7WP28en5w6lgw4SqEBCkXkpgO
X-Received: by 2002:adf:f24c:0:b0:313:f152:d7f2 with SMTP id b12-20020adff24c000000b00313f152d7f2mr1562820wrp.36.1687777153332;
        Mon, 26 Jun 2023 03:59:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fjw6zVMUBlhWvbb5tDKN2R5NJeOpv92J240KhbR98FNxoowwQLPcOEEWKp8EXeaTIPBJXuA==
X-Received: by 2002:adf:f24c:0:b0:313:f152:d7f2 with SMTP id b12-20020adff24c000000b00313f152d7f2mr1562809wrp.36.1687777153061;
        Mon, 26 Jun 2023 03:59:13 -0700 (PDT)
Received: from redhat.com ([2.52.156.102])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b0030e56a9ff25sm6981114wrt.31.2023.06.26.03.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 03:59:12 -0700 (PDT)
Date:   Mon, 26 Jun 2023 06:59:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     David Hildenbrand <david@redhat.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/26] virtio-mem: use array_size
Message-ID: <20230626065202-mutt-send-email-mst@kernel.org>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-9-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623211457.102544-9-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:14:39PM +0200, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>     expression E1, E2;
>     constant C1, C2;
>     identifier alloc = {vmalloc,vzalloc};
> @@
>     
> (
>       alloc(C1 * C2,...)
> |
>       alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>       ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/virtio/virtio_mem.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

can't hurt I guess.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 835f6cc2fb66..a4dfe7aab288 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -399,7 +399,7 @@ static int virtio_mem_bbm_bb_states_prepare_next_bb(struct virtio_mem *vm)
>  	if (vm->bbm.bb_states && old_pages == new_pages)
>  		return 0;
>  
> -	new_array = vzalloc(new_pages * PAGE_SIZE);
> +	new_array = vzalloc(array_size(new_pages, PAGE_SIZE));
>  	if (!new_array)
>  		return -ENOMEM;
>
> @@ -465,7 +465,7 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
>  	if (vm->sbm.mb_states && old_pages == new_pages)
>  		return 0;
>  
> -	new_array = vzalloc(new_pages * PAGE_SIZE);
> +	new_array = vzalloc(array_size(new_pages, PAGE_SIZE));
>  	if (!new_array)
>  		return -ENOMEM;
>  
> @@ -588,7 +588,7 @@ static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
>  	if (vm->sbm.sb_states && old_pages == new_pages)
>  		return 0;
>  
> -	new_bitmap = vzalloc(new_pages * PAGE_SIZE);
> +	new_bitmap = vzalloc(array_size(new_pages, PAGE_SIZE));
>  	if (!new_bitmap)
>  		return -ENOMEM;
>  

