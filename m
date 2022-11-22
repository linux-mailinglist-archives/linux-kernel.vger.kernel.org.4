Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78970633140
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKVAUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiKVAUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:20:36 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F879AC8B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=OAzB8I2tTwLyGBq73vdy7J6qBtfQjMwcJ1th7CwFohY=; b=uJgBYK0K8+A5Wga+o75EPm0L9e
        mMkCxGpo+6VsBCHMPZIphjXWmj5oz/+PPQqSlSIq92SqlmJutad3Hc2lCk3tsS+9p0HMLCPCBC/0Q
        BUImHbGSyPDkJbmL7XTkCW3WFkpq43kuHK++frlNeHlFomrfWC65awbvf6trKWIK3Gz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oxH0j-0034Ah-0c; Tue, 22 Nov 2022 01:19:37 +0100
Date:   Tue, 22 Nov 2022 01:19:36 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Li zeming <zeming@nfschina.com>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mach-mvebu: coherency: Judgment after pointer p
 increases allocation
Message-ID: <Y3wVmPQFVesgmpxN@lunn.ch>
References: <20221121100122.36528-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121100122.36528-1-zeming@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:01:22PM +0800, Li zeming wrote:
> Add judgment statements at the position after pointer p allocates memory
> to avoid the abnormal impact of low probability allocation failure.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  arch/arm/mach-mvebu/coherency.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index a6b621ff0b87..2bc69dd059d6 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -191,8 +191,10 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
>  		struct property *p;
>  
>  		p = kzalloc(sizeof(*p), GFP_KERNEL);
> -		p->name = kstrdup("arm,io-coherent", GFP_KERNEL);
> -		of_add_property(cache_dn, p);
> +		if (p) {
> +			p->name = kstrdup("arm,io-coherent", GFP_KERNEL);
> +			of_add_property(cache_dn, p);
> +		}

The comment before this says:
	/*
	 * Add the PL310 property "arm,io-coherent". This makes sure the
	 * outer sync operation is not used, which allows to
	 * workaround the system erratum that causes deadlocks when
	 * doing PCIe in an SMP situation on Armada 375 and Armada
	 * 38x.
	 */

Skipping adding the property because we are out of memory is probably
not a good idea, it is going to cause very hard to find deadlocks.
Actually being out of memory so early in the boot indicates something
very bad is going on anyway. So i think dereferencing the NULL pointer
is the least of our worries.

If you really want to do some sort of check here, BUG_ON(!p);

   Andrew
