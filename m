Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC2704863
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjEPJCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjEPJCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB8C6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684227677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uouDHzwyKCOfVfc0oyLKQ3cuTBh+BdzwOJFz6auqBmY=;
        b=Nus+OulUTtZNI7jtdbFV85UPSsMYAYyPJeTNGALZtpOyJDzm9wiZKhauoo/2Kzo3csivno
        niocM+nsWFypdF9MsT+tQt9Sv8FfLhpXuJcXHD73ervMagpuHQb7gPj6dZsnSo80ewX2wN
        6Eb5AjX0X9xJhmkiPlC224asViK3E0U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-knShtw2lOImKTEFrH-y8GQ-1; Tue, 16 May 2023 05:01:15 -0400
X-MC-Unique: knShtw2lOImKTEFrH-y8GQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f427ccf3b6so12561285e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684227674; x=1686819674;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uouDHzwyKCOfVfc0oyLKQ3cuTBh+BdzwOJFz6auqBmY=;
        b=hcDVsdMbLy072g5UCzsoA5UQxJzpMG3w/8E3ctpVZe8k9fxBFcPPhYjUBtr+bvOnTv
         Gto4SoOOHcwIon8kMEDHOEJySHuUHuMLl9nzHecCYSdP8pezc7nCIMp2VchYlj5dz4fU
         S+yA/AKuPhpaob6dS82Tfps8x3qmbrhnB/k3YlWFASg5+rxl42n//rydEukFLmRojLgY
         gGczpzvwua5Q9qXMpu7GMyMVZxtIjGQ/vjXFMvD3h360beKHeL+VpyI1xsdwRFmu80jX
         uz6Ybpidwwg5lrTsT8bjabmeko8upY6W+7OYexeIw6FZ8ZBo+eyEoPPS1zSTta6oYsH5
         Vg9Q==
X-Gm-Message-State: AC+VfDy1uETyB9lAaeFO1ygPrDA718+Gsb2yy5rSg1Nd3jzaci8GBVWU
        +rWYWULURVDCv6BrW9l11f9c48zoD3AfwyRUST4aah2yn4wBvYa6bZt2AhgDKxxam1yzhlsiLnq
        WJfo58xCYVQ0bcRmDnfAT+ypj
X-Received: by 2002:a05:600c:3b88:b0:3f4:2405:a0af with SMTP id n8-20020a05600c3b8800b003f42405a0afmr1669159wms.0.1684227674553;
        Tue, 16 May 2023 02:01:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CrQC+cJc481OFA/7rWIIR2qxQYfxGRukNmwdoEsO8OASyoIH2ay8TvTlyh/wpF9ABfCDijw==
X-Received: by 2002:a05:600c:3b88:b0:3f4:2405:a0af with SMTP id n8-20020a05600c3b8800b003f42405a0afmr1669133wms.0.1684227674227;
        Tue, 16 May 2023 02:01:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-74.dyn.eolo.it. [146.241.225.74])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003f07ef4e3e0sm33088768wmo.0.2023.05.16.02.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:01:13 -0700 (PDT)
Message-ID: <cf5c8fe8e5b47766005c1f093153f630774f644b.camel@redhat.com>
Subject: Re: [PATCH net-next] octeontx2-pf: Add support for page pool
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org
Date:   Tue, 16 May 2023 11:01:12 +0200
In-Reply-To: <20230515055607.651799-1-rkannoth@marvell.com>
References: <20230515055607.651799-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-15 at 11:26 +0530, Ratheesh Kannoth wrote:
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 7045fedfd73a..df5f45aa6980 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -217,9 +217,10 @@ static bool otx2_skb_add_frag(struct otx2_nic *pfvf,=
 struct sk_buff *skb,
>  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
>  				va - page_address(page) + off,
>  				len - off, pfvf->rbsize);
> -
> +#ifndef CONFIG_PAGE_POOL
>  		otx2_dma_unmap_page(pfvf, iova - OTX2_HEAD_ROOM,
>  				    pfvf->rbsize, DMA_FROM_DEVICE);
> +#endif

Don't you need to do the same even when CONFIG_PAGE_POOL and !pool-
>page_pool ?

>  		return true;
>  	}
> =20
> @@ -382,6 +383,8 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfv=
f,
>  	if (pfvf->netdev->features & NETIF_F_RXCSUM)
>  		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> =20
> +	skb_mark_for_recycle(skb);

Don't you need to set the recycle only when pool->page_pool?

Overall it looks like that having both the pool->page_pool and
CONFIG_PAGE_POOL checks in place add a few possible sources of bugs.

Cheers,

Paolo

