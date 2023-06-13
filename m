Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFDD72DE48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbjFMJuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbjFMJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:50:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D855110E4;
        Tue, 13 Jun 2023 02:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 711ED633D2;
        Tue, 13 Jun 2023 09:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FBFC43443;
        Tue, 13 Jun 2023 09:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686649833;
        bh=bwr/4ZICRs3nws483FOAKvRpVtUE0WNqv+BdMmKQ0n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWRsutNA9NSb/QwJ90Z3teu4GBI/jNVutEy+1bjjyXb9yDAUTkMDFqq18NJVJUEni
         zD+59tI/UMa4oOCI1eTUT+jTbCQ1KDNqua5OVhbDUFOUHUJaFOtZ8Jhrf6Sfd0U1kR
         7gyaKqGQ0sip7qmACc02iKCU8+P5rdPQnMJ8S2Jg=
Date:   Tue, 13 Jun 2023 11:50:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonas Blixt <jonas.blixt@actia.se>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: usbip: fix stub_dev hub disconnect
Message-ID: <2023061347-reverse-staleness-e4f3@gregkh>
References: <20230613092918.4191895-1-jonas.blixt@actia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613092918.4191895-1-jonas.blixt@actia.se>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:29:18AM +0200, Jonas Blixt wrote:
> If a hub is disconnected that has device(s) that's attached to the usbip layer
> the disconnect function might fail because it tries to release the port
> on an already disconnected hub.
> 
> Fixes: 6080cd0e9239 ("staging: usbip: claim ports used by shared devices")
> Signed-off-by: Jonas Blixt <jonas.blixt@actia.se>
> ---
>  drivers/usb/usbip/stub_dev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
> index 2305d425e6c9..257861787cdf 100644
> --- a/drivers/usb/usbip/stub_dev.c
> +++ b/drivers/usb/usbip/stub_dev.c
> @@ -427,8 +427,12 @@ static void stub_disconnect(struct usb_device *udev)
>  	/* release port */
>  	rc = usb_hub_release_port(udev->parent, udev->portnum,
>  				  (struct usb_dev_state *) udev);
> -	if (rc) {
> -		dev_dbg(&udev->dev, "unable to release port\n");
> +	/*
> +	 * NOTE: If a HUB disconnect triggered disconnect of the down stream
> +	 * device usb_hub_release_port will return -ENODEV.

How about adding, "so we can safely ignore that error here."

thanks,

greg k-h
