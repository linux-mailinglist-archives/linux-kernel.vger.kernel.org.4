Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69369E1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjBUNsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBUNr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:47:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF144481;
        Tue, 21 Feb 2023 05:47:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAE0E61024;
        Tue, 21 Feb 2023 13:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C991CC433EF;
        Tue, 21 Feb 2023 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676987272;
        bh=kpxjgpaaaRf2zMk0yeRbw+GgXWLONOewym7s4Jab0ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdfMbIIQntXwdBTJbkAtGZoBjKHLEBaFw6uYvN4AeJ39CdoWc8pMWm7hs7N8kkOB2
         JfRQddA4nTsWvfolX6jh3dZSs7dxB7/gf7asgt6LzhqFabvsjsOoacVmFoVwVWP48D
         0VwaroPXM1/3GQ9pDp+4QngL5wTFPDR+fHB59iwQ=
Date:   Tue, 21 Feb 2023 14:47:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] driver core: bus: Handle early calls to bus_to_subsys()
Message-ID: <Y/TLhUewwDJ+RGXd@kroah.com>
References: <0a92979f6e790737544638e8a4c19b0564e660a2.1676983596.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a92979f6e790737544638e8a4c19b0564e660a2.1676983596.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:53:51PM +0100, Geert Uytterhoeven wrote:
> When calling soc_device_match() from early_initcall(), bus_kset is still
> NULL, causing a crash:
> 
>     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
>     ...
>     Call trace:
>      __lock_acquire+0x530/0x20f0
>      lock_acquire.part.0+0xc8/0x210
>      lock_acquire+0x64/0x80
>      _raw_spin_lock+0x4c/0x60
>      bus_to_subsys+0x24/0xac
>      bus_for_each_dev+0x30/0xcc
>      soc_device_match+0x4c/0xe0
>      r8a7795_sysc_init+0x18/0x60
>      rcar_sysc_pd_init+0xb0/0x33c
>      do_one_initcall+0x128/0x2bc
> 
> Before, bus_for_each_dev() handled this gracefully by checking that
> the back-pointer to the private structure was valid.
> 
> Fix this by adding a NULL check for bus_kset to bus_to_subsys().
> 
> Fixes: 83b9148df2c95e23 ("driver core: bus: bus iterator cleanups")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index cfe8615d5106f030..dd4b82d7510f68fb 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -62,7 +62,7 @@ static struct subsys_private *bus_to_subsys(const struct bus_type *bus)
>  	struct subsys_private *sp = NULL;
>  	struct kobject *kobj;
>  
> -	if (!bus)
> +	if (!bus || !bus_kset)
>  		return NULL;
>  
>  	spin_lock(&bus_kset->list_lock);

Thanks for this, I'll queue it up after my patches get sent to Linus.

greg k-h
