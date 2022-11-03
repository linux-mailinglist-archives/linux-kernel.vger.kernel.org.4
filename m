Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80867617492
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKCCzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKCCzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787D513F96;
        Wed,  2 Nov 2022 19:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B9161CF4;
        Thu,  3 Nov 2022 02:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9E9C433C1;
        Thu,  3 Nov 2022 02:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667444086;
        bh=4KHUanK4Eb1jeTKJdS189VeKoR1cBDb90sED4WqUSPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cffox6kD0l4pbNz+Sgn+ZsQKAETP+3Ml6lKhXxyg9Zhh4SWrcKx6Oy23PkTWQl20t
         3RE4KLtOvIAzJZJ2hjicbCkCaQNRhJhvIYYGPV8tgY8GA0JF6vWXHTOFee2hZHePG/
         WaJjkpYkqG6obxXY9rJc8hCjSoCn4lcvTyMny3t8=
Date:   Thu, 3 Nov 2022 03:55:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tty: Convert tty_buffer flags to bool
Message-ID: <Y2Mtricfx/HxiEHc@kroah.com>
References: <20221019105504.16800-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019105504.16800-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:55:03PM +0300, Ilpo Järvinen wrote:
> The struct tty_buffer has flags which is only used for storing TTYB_NORMAL.
> There is also a few quite confusing operations for checking the presense
> of TTYB_NORMAL. Simplify things by converting flags to bool.
> 
> Despite the name remaining the same, the meaning of "flags" is altered
> slightly by this change. Previously it referred to flags of the buffer
> (only TTYB_NORMAL being used as a flag). After this change, flags tell
> whether the buffer contains/should be allocated with flags array along
> with character data array. It is much more suitable name that
> TTYB_NORMAL was for this purpose, thus the name remains.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v2:
> - Make it more obvious why flags is not renamed (both in kerneldoc
>   comment and commit message).
> 
>  drivers/tty/tty_buffer.c   | 28 ++++++++++++++--------------
>  include/linux/tty_buffer.h |  5 +----
>  include/linux/tty_flip.h   |  4 ++--
>  3 files changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 5e287dedce01..b408d830fcbc 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -107,7 +107,7 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
>  	p->commit = 0;
>  	p->lookahead = 0;
>  	p->read = 0;
> -	p->flags = 0;
> +	p->flags = true;
>  }
>  
>  /**
> @@ -249,7 +249,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
>   * __tty_buffer_request_room	-	grow tty buffer if needed
>   * @port: tty port
>   * @size: size desired
> - * @flags: buffer flags if new buffer allocated (default = 0)
> + * @flags: buffer has to store flags along character data
>   *
>   * Make at least @size bytes of linear space available for the tty buffer.
>   *
> @@ -260,19 +260,19 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
>   * Returns: the size we managed to find.
>   */
>  static int __tty_buffer_request_room(struct tty_port *port, size_t size,
> -				     int flags)
> +				     bool flags)
>  {
>  	struct tty_bufhead *buf = &port->buf;
>  	struct tty_buffer *b, *n;
>  	int left, change;
>  
>  	b = buf->tail;
> -	if (b->flags & TTYB_NORMAL)
> +	if (!b->flags)
>  		left = 2 * b->size - b->used;
>  	else
>  		left = b->size - b->used;
>  
> -	change = (b->flags & TTYB_NORMAL) && (~flags & TTYB_NORMAL);
> +	change = !b->flags && flags;
>  	if (change || left < size) {
>  		/* This is the slow path - looking for new buffers to use */
>  		n = tty_buffer_alloc(port, size);
> @@ -300,7 +300,7 @@ static int __tty_buffer_request_room(struct tty_port *port, size_t size,
>  
>  int tty_buffer_request_room(struct tty_port *port, size_t size)
>  {
> -	return __tty_buffer_request_room(port, size, 0);
> +	return __tty_buffer_request_room(port, size, true);

Did this logic just get inverted?

Maybe it's the jet-lag, but this feels like it's not correct anymore.

Maybe a commet up above where you calculate "left" would make more sense
as to what is going on?

thanks,

greg k-h
