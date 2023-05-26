Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D2E712CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbjEZSug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjEZSue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:50:34 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2CB12A;
        Fri, 26 May 2023 11:50:33 -0700 (PDT)
Received: from fpc (unknown [10.10.165.11])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7507144C1011;
        Fri, 26 May 2023 18:50:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7507144C1011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1685127031;
        bh=/Hu6zP8uBmxAWbM+s0NxLmYh8H8p1XHyk+BLGSW8dcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arQ6kULD4fTCQfxrulM1ZPvXcHk9D8E9YWHr9q1rBdOkuAcOuIyvBhN7tan2ElDGS
         SaSrIqPS9Wy2wJrrYt1yFUqGz4fFasM/oqUV2yGuW97jgd+Q70YAxqRP/UoL53ylQq
         /avu0EnLPAl39RWu9A+1PwdC4vYO+TeL8ApGvM1s=
Date:   Fri, 26 May 2023 21:50:26 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Oleksij Rempel <linux@rempel-privat.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de,
        Robin van der Gracht <robin@protonic.nl>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/2] can: j1939: avoid possible use-after-free when
 j1939_can_rx_register fails
Message-ID: <20230526185026.33pcjvoyq5jzlnxk@fpc>
References: <20230526171910.227615-1-pchelkin@ispras.ru>
 <20230526171910.227615-3-pchelkin@ispras.ru>
 <20230526181500.GA26860@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526181500.GA26860@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

thanks for the reply!

On Fri, May 26, 2023 at 08:15:00PM +0200, Oleksij Rempel wrote:
> Hi Fedor,
> 
> On Fri, May 26, 2023 at 08:19:10PM +0300, Fedor Pchelkin wrote:
> 
> 
> Thank you for your investigation. How about this change?
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -285,8 +285,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
>                  */
>                 kref_get(&priv_new->rx_kref);
>                 spin_unlock(&j1939_netdev_lock);
> -               dev_put(ndev);
> -               kfree(priv);
> +               j1939_priv_put(priv);

I don't think that's good because the priv which is directly freed here is
still local to the thread, and parallel threads don't have any access to
it. j1939_priv_create() has allocated a fresh priv and called dev_hold()
so dev_put() and kfree() here are okay.

>                 return priv_new;
>         }
>         j1939_priv_set(ndev, priv);
> @@ -300,8 +299,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
>  
>   out_priv_put:
>         j1939_priv_set(ndev, NULL);
> -       dev_put(ndev);
> -       kfree(priv);
> +       j1939_priv_put(priv);
>  
>         return ERR_PTR(ret);
>  }
> 
> If I see it correctly, the problem is kfree() which is called without respecting
> the ref counting. If CPU1 has priv_new, refcounting is increased. The priv will
> not be freed on this place.

With your suggestion, I think it doesn't work correctly if
j1939_can_rx_register() fails and we go to out_priv_put. The priv is kept
but the parallel thread which may have already grabbed it thinks that
j1939_can_rx_register() has succeeded when actually it hasn't succeed.
Moreover, j1939_priv_set() makes it NULL on error path so that priv cannot
be accessed from ndev.

I also considered the alternatives where we don't have to serialize access
to j1939_can_rx_register() and subsequently introduce mutex. But with
current j1939_netdev_start() implementation I can't see how to fix the
racy bug without it.

> 
> Can you please test it?
> 
> Regards,
> Oleksij
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
