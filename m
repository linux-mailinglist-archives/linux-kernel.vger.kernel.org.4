Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FE1736371
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjFTGOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjFTGOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEAA10F9;
        Mon, 19 Jun 2023 23:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 642C660FD7;
        Tue, 20 Jun 2023 06:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED06C433C8;
        Tue, 20 Jun 2023 06:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687241661;
        bh=nrq0IjkxMUy98tG4sKvGO/xFKexns8OJc6XXvAJ5QsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oA6z3x9pGifLfF2EGZCu+yxLPciOp0BNXT9IivkLP2LxHcseJpuMiK6CBnQUeZOe9
         jj4NYHyo8Hml61a6qtKOHTFE/nNvRCe/RsIj13veiALDtkRViWCWfiO1uajIVT4uhi
         LHAzyMq8OO9OjYmE5KOFCRvcnIkr29gKYMU/j6SRG5Mib7/AKJVwdUGb8trF4rMM08
         6LIVqNn6HUGgiof3rBc7XfkmPvYOWqMVghjedCP3aVh/moeqXjEriqtLNtXGP6N2Ws
         ftUspgQO4bDf7YYcQbThISa+NUlckVowQxy+76e4fuwCSCgOxjU0YjHtL1pXGQeY5h
         YPKn0SXcOJirQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBUdA-0006OK-Pw; Tue, 20 Jun 2023 08:14:21 +0200
Date:   Tue, 20 Jun 2023 08:14:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaufmann Automotive GmbH <info@kaufmann-automotive.ch>
Subject: Re: [PATCH] USB: serial-simple: adding Kaufmann RKS+CAN VCP
Message-ID: <ZJFDvJh6TRJhyKFe@hovoldconsulting.com>
References: <20230613093351.3383-1-oneukum@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613093351.3383-1-oneukum@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:33:51AM +0200, Oliver Neukum wrote:
> Adding the device and product ID

Can you say something more about the product here (e.g. to indicate that
this is indeed a custom firmware that requires a simple driver)?

> Reported-by: Kaufmann Automotive GmbH <info@kaufmann-automotive.ch>
> Tested-by: Kaufmann Automotive GmbH <info@kaufmann-automotive.ch>
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/usb/serial/usb-serial-simple.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
> index 4c6747889a19..3612031030bb 100644
> --- a/drivers/usb/serial/usb-serial-simple.c
> +++ b/drivers/usb/serial/usb-serial-simple.c
> @@ -117,6 +117,11 @@ DEVICE(suunto, SUUNTO_IDS);
>  	{ USB_DEVICE(0x908, 0x0004) }
>  DEVICE(siemens_mpi, SIEMENS_IDS);
>  
> +/* KAUFMANN RKS+CAN VCP */
> +#define KAUFMANN_IDS()			\
> +	{ USB_DEVICE(0x16d0, 0x0870) }
> +DEVICE(kaufmann, KAUFMANN_IDS);

Can you add this one after GOOGLE_IDS() to approximate some ordering?

I'll try to move the rest in place later.

> +
>  /* All of the above structures mushed into two lists */
>  static struct usb_serial_driver * const serial_drivers[] = {
>  	&carelink_device,
> @@ -133,6 +138,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  	&hp4x_device,
>  	&suunto_device,
>  	&siemens_mpi_device,
> +	&kaufmann_device,
>  	NULL
>  };
>  
> @@ -151,6 +157,7 @@ static const struct usb_device_id id_table[] = {
>  	HP4X_IDS(),
>  	SUUNTO_IDS(),
>  	SIEMENS_IDS(),
> +	KAUFMANN_IDS(),
>  	{ },
>  };

Similar in these two arrays.

Johan
