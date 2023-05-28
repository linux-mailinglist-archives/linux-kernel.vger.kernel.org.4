Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFDE71380D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 08:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjE1GRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 02:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE1GR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 02:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D2DD9
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685254601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xyjjfsHJGz4btJpbkZnZFyAqXrjeVJSFODC6tRwjNqo=;
        b=Kut2tu61HX2Nfi5BRC38uZHW8dcgpAkBXvnDPGjyWL59R7VDUYKoRxteiuLFnF5wJveDge
        bJ3C2kvQUpI/vX6hv3rNmP8Tq4lDBBgHW51UuyraKTDnfsoWl4QfO01j40g8O1hvfSFsOc
        irLf6rwVNglfN8fCiMKsBGKUUVELr8M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-3-uzq6yVNPSoOGeLfMo8mw-1; Sun, 28 May 2023 02:16:39 -0400
X-MC-Unique: 3-uzq6yVNPSoOGeLfMo8mw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30a8f6d7bbdso672199f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 23:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685254598; x=1687846598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyjjfsHJGz4btJpbkZnZFyAqXrjeVJSFODC6tRwjNqo=;
        b=JVMhVwYjLlAvQWKV/9kgEZeQnJb9ziYZXo/440JPAyq+uN5JHeNcSt+oarqf3bi7cm
         kwqivqE12R2tMRrpddXtHZu/9T4Z1UaexpqKGngx/2hYwVhNYZpbWDwLQwb5tBU4NYMk
         JVNCCYWklTbUmX4v8u3DkBEnUUc/xJsDFMOn7ys+OwE1bidfl63hckUgq5XbfXS+IyjE
         bdoItXY9diJja6MAqkYIAkaMP/h4vjrsgPx9SjY5ARFtwf4ByKVg4QSYksmzP4KUu5Tx
         b3wx76vyORr6I1mKwOK8UT1Th2Tp1tq6p1TCP5xepXLRXFeKn9x42EvfxnneAjH/W3gN
         p4Ig==
X-Gm-Message-State: AC+VfDy0rr5VcjjmE3VcIiDPiaVZO+xB5T74fnBh4fCG8R6o3VMM7gcp
        WGwItEMXpoS1WW0Y+65vRo3gIiDdTY9kGCSYLTGRiaw7Xb3WWGluHxdCSzQbmjQxb4HUvqVx3Uc
        g9QaiLrzd1ITkPEFpSHQ3B/tA
X-Received: by 2002:adf:eccc:0:b0:306:2aa0:ce81 with SMTP id s12-20020adfeccc000000b003062aa0ce81mr6910620wro.30.1685254598297;
        Sat, 27 May 2023 23:16:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dFHG2HLfd2Q3dXDNjbmL0ir54ug1fj6Cozz0mkZHs3U/h67Qlj5dhak5C/0LI3cKmRJ/97g==
X-Received: by 2002:adf:eccc:0:b0:306:2aa0:ce81 with SMTP id s12-20020adfeccc000000b003062aa0ce81mr6910604wro.30.1685254597977;
        Sat, 27 May 2023 23:16:37 -0700 (PDT)
Received: from redhat.com ([2.52.146.27])
        by smtp.gmail.com with ESMTPSA id l21-20020a1c7915000000b003f603b8eb5asm10308080wme.7.2023.05.27.23.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 23:16:37 -0700 (PDT)
Date:   Sun, 28 May 2023 02:16:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Liang Chen <liangchen.linux@gmail.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, pabeni@redhat.com, alexander.duyck@gmail.com
Subject: Re: [PATCH net-next 1/5] virtio_net: Fix an unsafe reference to the
 page chain
Message-ID: <20230528021008-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526054621.18371-1-liangchen.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 01:46:17PM +0800, Liang Chen wrote:
> "private" of buffer page is currently used for big mode to chain pages.
> But in mergeable mode, that offset of page could mean something else,
> e.g. when page_pool page is used instead. So excluding mergeable mode to
> avoid such a problem.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>

Ugh the subject makes it looks like current code has a problem
but I don't think so because I don't think anything besides
big packets uses page->private.

The reason patch is needed is because follow up patches
use page_pool.
pls adjust commit log and subject to make all this clear.


> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5a7f7a76b920..c5dca0d92e64 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -497,7 +497,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  			return NULL;
>  
>  		page = (struct page *)page->private;
> -		if (page)
> +		if (!vi->mergeable_rx_bufs && page)

To be safe let's limit to big packets too:

	if (!vi->mergeable_rx_bufs && vi->big_packets && page)



>  			give_pages(rq, page);
>  		goto ok;
>  	}
> -- 
> 2.31.1

