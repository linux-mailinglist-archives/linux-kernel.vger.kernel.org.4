Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A181B74D982
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjGJPFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGJPFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:05:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E3D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC086105A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F8FC433C9;
        Mon, 10 Jul 2023 15:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689001543;
        bh=HFY+t8bQIxdFB9O4v0T1aDs4Q2MuQ+LXdrKENupo/eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OIwy4/J1BD0D0Akpt2r6+AK1SR5c0eFG6zl8jLqBH2eMQmhmnFJTk4umvQXCNtFGA
         skGXR0v68EzG17LYokBRxwpXvxWWR8JgOkqkdM7TaTSbgjgP1SSZca5UNlgV+0vfXv
         I3ntkXrPJmlNtN3kmXFwDHulpotH+sS++f/N7njs=
Date:   Mon, 10 Jul 2023 17:05:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier 
        <JoseJavier.Rodriguez@duagon.com>,
        Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Subject: Re: [PATCH 1/1] mcb: Do not add the mcb_bus_type to the mcb_bus
 itself
Message-ID: <2023071044-deduct-cycle-a918@gregkh>
References: <20230710145752.14285-1-jth@kernel.org>
 <20230710145752.14285-2-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710145752.14285-2-jth@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 04:57:52PM +0200, Johannes Thumshirn wrote:
> From: Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>

This does not match your signed-off-by line.

> 
> When allocating a new mcb_bus the bus_type is added to the mcb_bus
> itself, causing an issue when calling mcb_bus_add_devices().
> This function is not only called for each mcb_device under the
> mcb_bus but for the bus itself.
> 
> This causes a crash when freeing the ida resources as the bus numbering
> gets corrupted due to a wrong cast of structs mcb_bus and mcb_device.
> 
> Make the release of the mcb devices and their mcb bus explicit.
> 
> Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
> Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
> Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
> ---

What commit id does this fix?

>  drivers/mcb/mcb-core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
> index 978fdfc19a06..d4535b8aea1d 100644
> --- a/drivers/mcb/mcb-core.c
> +++ b/drivers/mcb/mcb-core.c
> @@ -251,6 +251,12 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(mcb_device_register, MCB);
>  
> +
> +static void mcb_bus_unregister(struct mcb_bus *bus)
> +{
> +	device_unregister(&bus->dev);
> +}
> +
>  static void mcb_free_bus(struct device *dev)
>  {
>  	struct mcb_bus *bus = to_mcb_bus(dev);
> @@ -286,7 +292,6 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
>  
>  	device_initialize(&bus->dev);
>  	bus->dev.parent = carrier;
> -	bus->dev.bus = &mcb_bus_type;

So what bus type does this device now belong to?


>  	bus->dev.type = &mcb_carrier_device_type;
>  	bus->dev.release = &mcb_free_bus;
>  
> @@ -322,6 +327,7 @@ static void mcb_devices_unregister(struct mcb_bus *bus)
>  void mcb_release_bus(struct mcb_bus *bus)
>  {
>  	mcb_devices_unregister(bus);
> +	mcb_bus_unregister(bus);

thanks.

greg k-h
