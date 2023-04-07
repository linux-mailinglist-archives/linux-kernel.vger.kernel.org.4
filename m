Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2361F6DB64D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjDGWJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDGWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:09:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE545CA08
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 15:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60DC4651B4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 22:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A69C433EF;
        Fri,  7 Apr 2023 22:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680905338;
        bh=BShoxTWx4HlNjbO6Scv7dYkopvwzFqmn1E8X+A2sdI0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kx76WgITtpOTf5Oj8/rBT7WSkFWZXSM8UTVCTXKjXva63R6gQzvk6w+oDGL/MxYtL
         pMcPNC9lKEGoyorJ87ePmxgZ62sN5ifaC9ee9Ccd0oZIW8+hg9TZBpJ48O7xy/XW1n
         aFhiovcvXtDqP6jDIGorEjiK1cJ8ZflXiWldjsKgUxhYDCBOpaA/tz9Xva3w27OWxf
         Bts6jkI72ebLZC+MXyBUqwL1I37R16QQxvHJ0zmqayZyeHTIsZzK1rZG1L/cI+yEWs
         8SnvU07q+9K3pDqDHPMNqW6jK5lV6N5Ccl1ymsWQtRCdKpPRL3IXmmz6ugIEKhwM03
         K4H3ft/HkAtng==
Date:   Fri, 7 Apr 2023 15:08:55 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] xen/pvcalls: don't call bind_evtchn_to_irqhandler()
 under lock
In-Reply-To: <20230403092711.15285-1-jgross@suse.com>
Message-ID: <alpine.DEB.2.22.394.2304071508480.111906@ubuntu-linux-20-04-desktop>
References: <20230403092711.15285-1-jgross@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023, Juergen Gross wrote:
> bind_evtchn_to_irqhandler() shouldn't be called under spinlock, as it
> can sleep.
> 
> This requires to move the calls of create_active() out of the locked
> regions. This is no problem, as the worst which could happen would be
> a spurious call of the interrupt handler, causing a spurious wake_up().
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/lkml/Y+JUIl64UDmdkboh@kadam/
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> V2:
> - remove stale spin_unlock() (Oleksandr Tyshchenko)
> ---
>  drivers/xen/pvcalls-front.c | 46 +++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> index d5d589bda243..b72ee9379d77 100644
> --- a/drivers/xen/pvcalls-front.c
> +++ b/drivers/xen/pvcalls-front.c
> @@ -227,22 +227,30 @@ static irqreturn_t pvcalls_front_event_handler(int irq, void *dev_id)
>  
>  static void free_active_ring(struct sock_mapping *map);
>  
> -static void pvcalls_front_free_map(struct pvcalls_bedata *bedata,
> -				   struct sock_mapping *map)
> +static void pvcalls_front_destroy_active(struct pvcalls_bedata *bedata,
> +					 struct sock_mapping *map)
>  {
>  	int i;
>  
>  	unbind_from_irqhandler(map->active.irq, map);
>  
> -	spin_lock(&bedata->socket_lock);
> -	if (!list_empty(&map->list))
> -		list_del_init(&map->list);
> -	spin_unlock(&bedata->socket_lock);
> +	if (bedata) {
> +		spin_lock(&bedata->socket_lock);
> +		if (!list_empty(&map->list))
> +			list_del_init(&map->list);
> +		spin_unlock(&bedata->socket_lock);
> +	}
>  
>  	for (i = 0; i < (1 << PVCALLS_RING_ORDER); i++)
>  		gnttab_end_foreign_access(map->active.ring->ref[i], NULL);
>  	gnttab_end_foreign_access(map->active.ref, NULL);
>  	free_active_ring(map);
> +}
> +
> +static void pvcalls_front_free_map(struct pvcalls_bedata *bedata,
> +				   struct sock_mapping *map)
> +{
> +	pvcalls_front_destroy_active(bedata, map);
>  
>  	kfree(map);
>  }
> @@ -433,19 +441,18 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
>  		pvcalls_exit_sock(sock);
>  		return ret;
>  	}
> -
> -	spin_lock(&bedata->socket_lock);
> -	ret = get_request(bedata, &req_id);
> +	ret = create_active(map, &evtchn);
>  	if (ret < 0) {
> -		spin_unlock(&bedata->socket_lock);
>  		free_active_ring(map);
>  		pvcalls_exit_sock(sock);
>  		return ret;
>  	}
> -	ret = create_active(map, &evtchn);
> +
> +	spin_lock(&bedata->socket_lock);
> +	ret = get_request(bedata, &req_id);
>  	if (ret < 0) {
>  		spin_unlock(&bedata->socket_lock);
> -		free_active_ring(map);
> +		pvcalls_front_destroy_active(NULL, map);
>  		pvcalls_exit_sock(sock);
>  		return ret;
>  	}
> @@ -821,28 +828,27 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
>  		pvcalls_exit_sock(sock);
>  		return ret;
>  	}
> -	spin_lock(&bedata->socket_lock);
> -	ret = get_request(bedata, &req_id);
> +	ret = create_active(map2, &evtchn);
>  	if (ret < 0) {
> -		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
> -			  (void *)&map->passive.flags);
> -		spin_unlock(&bedata->socket_lock);
>  		free_active_ring(map2);
>  		kfree(map2);
> +		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
> +			  (void *)&map->passive.flags);
>  		pvcalls_exit_sock(sock);
>  		return ret;
>  	}
>  
> -	ret = create_active(map2, &evtchn);
> +	spin_lock(&bedata->socket_lock);
> +	ret = get_request(bedata, &req_id);
>  	if (ret < 0) {
> -		free_active_ring(map2);
> -		kfree(map2);
>  		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
>  			  (void *)&map->passive.flags);
>  		spin_unlock(&bedata->socket_lock);
> +		pvcalls_front_free_map(bedata, map2);
>  		pvcalls_exit_sock(sock);
>  		return ret;
>  	}
> +
>  	list_add_tail(&map2->list, &bedata->socket_mappings);
>  
>  	req = RING_GET_REQUEST(&bedata->ring, req_id);
> -- 
> 2.35.3
> 
