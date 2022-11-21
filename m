Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5624C6329AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKUQhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiKUQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:36:32 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E2C8463
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=6Jdq67axWtUO34awWLIaNKXOMCvzA9J92byS0Y3jkdI=; b=Sfn/BmoyQJaLmjkFqMzo6E3ccw
        9w8vK8RT339KYN4on2o/f89RERCq2lJXGDD6W1oc67dTSqp4n2WR9UcPOMyIJTwgGP84au8H4B1Yl
        Fz9P0MyaGGwTKNJq4E/SZL8iWbh4m6fHfsKdmuh0i3OXHKkYoV80OMDBMyxaMy6M7EUMwYs6X3SAE
        QVzLw/42djImpPeX9KJb3lsuRNg2hH8n/v2zjH+EGdUD93OhPcuqLkLtZMY8VdQ8uyT93Gg5zR8pH
        FMbI2mAOgs3X+nWvKNZJn6hRaEqdDI5g7m9xVNUJcxna9wmE9T0uMnqhupuOmZF2BGA4PaCFtWZ/U
        +2JYYWwBhz0yaxROhm2UxtEJlU2vTM01S/ruQmneuNKzGLgD4pgR4ihvUnaxNtspFIy0o4r3NgN9h
        mmv7Otaq0dLEyW8ZlPBiI3zG7jf71TJQyKpXIuG8cJXPN3Lzs/lnQE5oiCVZ8VQ6YDIkLc6FnS6og
        cu9re7un9iUXBdoqFrXs6PeCIcqKKQlHFrUOwKcBS8cgpArcaoXFfd+L3PsEMZJRO8n6iwN/lGZAC
        Ic+aLgyZSh+zYrLTiVAooNlOAxIbtuNHaZcykXyUb4WZuaqyPgpPFeE072Rm4hdMPHVzzLecKUaCF
        AUzPXci8K+yTYg5hYGclUDlp2nCrwSWFx6PYUHIxw=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     GUO Zihua <guozihua@huawei.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 1/2] 9p/xen: check logical size for buffer size
Date:   Mon, 21 Nov 2022 17:35:56 +0100
Message-ID: <37091478.n1eaNAWdo1@silver>
In-Reply-To: <20221118135542.63400-1-asmadeus@codewreck.org>
References: <20221118135542.63400-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 18, 2022 2:55:41 PM CET Dominique Martinet wrote:
> trans_xen did not check the data fits into the buffer before copying
> from the xen ring, but we probably should.
> Add a check that just skips the request and return an error to
> userspace if it did not fit
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> 
> This comes more or less as a follow up of a fix for trans_fd:
> https://lkml.kernel.org/r/20221117091159.31533-1-guozihua@huawei.com
> Where msize should be replaced by capacity check, except trans_xen
> did not actually use to check the size fits at all.
> 
> While we normally trust the hypervisor (they can probably do whatever
> they want with our memory), a bug in the 9p server is always possible so
> sanity checks never hurt, especially now buffers got drastically smaller
> with a recent patch.
> 
> My setup for xen is unfortunately long dead so I cannot test this:
> Stefano, you've tested v9fs xen patches in the past, would you mind
> verifying this works as well?
> 
>  net/9p/trans_xen.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index b15c64128c3e..66ceb3b3ae30 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -208,6 +208,14 @@ static void p9_xen_response(struct work_struct *work)
>  			continue;
>  		}
>  
> +		if (h.size > req->rc.capacity) {
> +			dev_warn(&priv->dev->dev,
> +				 "requested packet size too big: %d for tag %d with capacity %zd\n",
> +		                 h.size, h.tag, rreq->rc.capacity);
> +			req->status = REQ_STATUS_ERROR;
> +			goto recv_error;
> +		}
> +

Looks good (except of s/rreq/req/ mentioned by Stefano already).

>  		memcpy(&req->rc, &h, sizeof(h));

Is that really OK?

1. `h` is of type xen_9pfs_header and declared as packed, whereas `rc` is of 
   type p9_fcall not declared as packed.

2. Probably a bit dangerous to assume the layout of xen_9pfs_header being in
   sync with the starting layout of p9_fcall without any compile-time 
   assertion?

>  		req->rc.offset = 0;
>  
> @@ -217,6 +225,7 @@ static void p9_xen_response(struct work_struct *work)
>  				     masked_prod, &masked_cons,
>  				     XEN_9PFS_RING_SIZE(ring));
>  
> +recv_error:
>  		virt_mb();
>  		cons += h.size;
>  		ring->intf->in_cons = cons;
> 



