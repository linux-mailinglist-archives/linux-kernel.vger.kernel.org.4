Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BE360421E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiJSKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiJSKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:54:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055A8696D8;
        Wed, 19 Oct 2022 03:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59036B8229E;
        Wed, 19 Oct 2022 10:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88169C433D6;
        Wed, 19 Oct 2022 10:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666175111;
        bh=RwGyyGPL1pOAzeitY3Ie8HVkAFv9vvGLhWgA2HmbVwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFa6Ga7j9yH/OPaFUpNuc1TYDkEOTlwQHSNw0hQ5f8QAJVqPAkPrl9eeisVt1KnsW
         aAGSV655nT72vJ/uvHpJ2R4b5BFUL9QLn269hVyg6guB1xm7yCcE+bKOSzlTf+HKz6
         SI4juPHZ/6ipCRjacRDl3Y6EVfKZaMeTBoRpKJgc=
Date:   Wed, 19 Oct 2022 12:25:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: Convert tty_buffer flags to bool
Message-ID: <Y0/QhJBW1TapqrjC@kroah.com>
References: <20221019094241.10870-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019094241.10870-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:42:39PM +0300, Ilpo Järvinen wrote:
> The struct tty_buffer has flags which is only used for storing TTYB_NORMAL.
> There is also a few quite confusing operations for checking the presense
> of TTYB_NORMAL. Simplify things by converting flags to bool.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/tty_buffer.c   | 28 ++++++++++++++--------------
>  include/linux/tty_buffer.h |  5 +----
>  include/linux/tty_flip.h   |  4 ++--
>  3 files changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 5e287dedce01..be3431575a19 100644
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
> + * @flags: buffer flags if new buffer allocated

If all this does is store TTYB_NORMAL, why not name it "ttyb_normal"?
Leaving it at "flags" and having that be a boolean is just confusing.

thanks,

greg k-h
