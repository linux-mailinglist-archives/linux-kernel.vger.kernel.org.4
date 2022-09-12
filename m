Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB55B5BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiILOIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiILOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:08:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3588120BFC;
        Mon, 12 Sep 2022 07:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECFFBB80D68;
        Mon, 12 Sep 2022 14:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E1DC433D6;
        Mon, 12 Sep 2022 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662991697;
        bh=buiVR0xeOfFZxK4vE8bQme0175LE+X/w51iFml9/KIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ScspQcHjG9+bN0/TlPu+KRRW691v12GLVYSbjkjjghx+xV5tNV0gBT5N3UohNCUS
         irzG0B4fMXsbliZebzYAYdPNQm4cDR3vxCMs5wGb83ang9Ce8vUNwW1SdqIPQbbIEh
         T+AWDk751VumoE0hE8tx8yJ9lHedONYAEOAwdwn8=
Date:   Mon, 12 Sep 2022 16:08:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] USB: serial: keyspan_pda: remove the unneeded
 result variable
Message-ID: <Yx89armgxAEn61TL@kroah.com>
References: <20220912103700.18338-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912103700.18338-1-xu.panda@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 10:37:01AM +0000, cgel.zte@gmail.com wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> Return the usb_control_msg() directly instead of storing it in
> another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>  drivers/usb/serial/keyspan_pda.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
> index 6fd15cd9e1eb..902675ac7f5c 100644
> --- a/drivers/usb/serial/keyspan_pda.c
> +++ b/drivers/usb/serial/keyspan_pda.c
> @@ -393,12 +393,10 @@ static int keyspan_pda_get_modem_info(struct usb_serial *serial,
>  static int keyspan_pda_set_modem_info(struct usb_serial *serial,
>                                       unsigned char value)
>  {
> -       int rc;
> -       rc = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
> -                            3, /* set pins */
> -                            USB_TYPE_VENDOR|USB_RECIP_INTERFACE|USB_DIR_OUT,
> -                            value, 0, NULL, 0, 2000);
> -       return rc;
> +       return usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
> +                              3, /* set pins */
> +                              USB_TYPE_VENDOR|USB_RECIP_INTERFACE|USB_DIR_OUT,
> +                              value, 0, NULL, 0, 2000);
>  }

Again, incorrect use of the usb_control_msg() return value.
