Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2188E745C55
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGCMg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGCMg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:36:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031B3194;
        Mon,  3 Jul 2023 05:36:27 -0700 (PDT)
Received: from localhost (node-1w7jr9st5p2esmclet71ntnwp.ipv6.telus.net [IPv6:2001:569:beb1:1500:6f9d:3a5c:4d25:e949])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dbrouwer)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3E30B6606F62;
        Mon,  3 Jul 2023 13:36:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688387785;
        bh=lx7TUb/t9gbY5UO78Ghc0Q8wYt4gcWRN85IRsw3jgXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nElUeqo7pEkU1nKU5mha01dU2FwgjboX0QF5zsEmXtkbsNZ/jldZA7+8kU0uMmXhW
         5AU4+YdIKbpv0bubPifNL2Pp4YtK2uqGyL/wqTwCj2UjpuaDeHLGc4tM3NOxNy46WX
         GdMew4LpZ9GXt1K5w3I5YVMG4VPGWo+rq5N6wtpz+VHA/NX/TZIITZ/X1tTwt7CF3H
         WHQdhIXNO/mdGpZdD3xVExbwUhR6VMG2zDghaYpNigoceILaU+dQUAli/SzyeX5fPj
         6fKcJEb43WaEsvkk41XuIKoCJ9KP0aeVVwNfj5n8p9cNOW2buokk0WBejg7vOCmA/Z
         IkXCsBtVwh5kg==
Date:   Mon, 3 Jul 2023 05:36:20 -0700
From:   Deborah Brouwer <deborah.brouwer@collabora.com>
To:     Tuo Li <islituo@gmail.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>
Subject: Re: [PATCH] media: bt8xx: Fix a possible data race in buffer_queue()
Message-ID: <ZKLAxKKc1z53Bm+S@db550>
References: <20230628071951.1011421-1-islituo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628071951.1011421-1-islituo@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 03:19:51PM +0800, Tuo Li wrote:
> The variable btv->loop_irq is often protected by the lock btv->s_lock when
> is accessed. Here is an example in bttv_irq_timeout():
> 
>   spin_lock_irqsave(&btv->s_lock,flags); 
>   ...
>   btv->loop_irq = 0;
>   ...
>   spin_unlock_irqrestore(&btv->s_lock,flags);
> 
> However, it is accessed without holding the lock btv->s_lock in 
> buffer_queue():
> 
>   btv->loop_irq |= 1;
> 
> And thus a data race can occur.
> To fix this possible data race, a lock and unlock pair is added when
> accessing the variable btv->loop_irq in buffer_queue().

hmm I am not sure why buffer_queue() didn't bother holding the
btv->s_lock but in the new version of the bttv driver that I have
been working on, the btv->s_lock is always held before changing
the loop_irq value. 

https://patchwork.linuxtv.org/project/linux-media/cover/cover.1682995256.git.deborah.brouwer@collabora.com/

When the bttv driver is converted to vb2, and the work is almost done,
the old buffer_queue() is totally eliminated, so I don't think it would
make sense to apply this patch now.

> 
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  drivers/media/pci/bt8xx/bttv-driver.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
> index 734f02b91aa3..241c51951627 100644
> --- a/drivers/media/pci/bt8xx/bttv-driver.c
> +++ b/drivers/media/pci/bt8xx/bttv-driver.c
> @@ -1617,13 +1617,16 @@ buffer_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
>  	struct bttv_buffer *buf = container_of(vb,struct bttv_buffer,vb);
>  	struct bttv_fh *fh = q->priv_data;
>  	struct bttv    *btv = fh->btv;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&btv->s_lock,flags);
>  	buf->vb.state = VIDEOBUF_QUEUED;
>  	list_add_tail(&buf->vb.queue,&btv->capture);
>  	if (!btv->curr.frame_irq) {
>  		btv->loop_irq |= 1;
>  		bttv_set_dma(btv, 0x03);
>  	}
> +	spin_unlock_irqrestore(&btv->s_lock,flags);
>  }
>  
>  static void buffer_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
> -- 
> 2.34.1
> 
