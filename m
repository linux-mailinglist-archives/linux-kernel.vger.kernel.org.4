Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610A77139C0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjE1N4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjE1N4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187CB8;
        Sun, 28 May 2023 06:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AC1C60B09;
        Sun, 28 May 2023 13:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC10C433D2;
        Sun, 28 May 2023 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685282168;
        bh=JT5y3bSqnJBtSO4Uhlu1HHm2FPspPmwBPjGg1IWW6HM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4y0eD/VPD77aBerNR+9ZF+cx0epBIPX8NwlH8igpBL9qDhWgjSIyI3ae2tj8j4uh
         RgqhQqhchTnEWgThs4DdC7zhTNmT30XImMiltRve4tVAs+AEZ0b1sAoyoHEihZwrrb
         AOWj4Kfa/fHwwkipSW4mP5AsFFbikBAgz1q8p4rQ=
Date:   Sun, 28 May 2023 12:56:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 11/11] serial: sc16is7xx: add dump registers function
Message-ID: <2023052837-entree-broken-d7dd@gregkh>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-12-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040324.3773741-12-hugo@hugovil.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 12:03:25AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> With this driver, it is very hard to debug the registers using
> the /sys/kernel/debug/regmap interface.
> 
> The main reason is that bits 0 and 1 of the register address
> correspond to the channels bits, so the register address itself starts
> at bit 2, so we must 'mentally' shift each register address by 2 bits
> to get its offset.
> 
> Also, only channels 0 and 1 are supported, so combinations of bits
> 0 and 1 being 10b and 11b are invalid, and the display of these
> registers is useless.
> 
> For example:
> 
> cat /sys/kernel/debug/regmap/spi0.0/registers
> 04: 10 -> Port 0, register offset 1
> 05: 10 -> Port 1, register offset 1
> 06: 00 -> Port 2, register offset 1 -> invalid
> 07: 00 -> port 3, register offset 1 -> invalid
> ...
> 
> Add a debug module parameter to call a custom dump function for each
> port registers after the probe phase to help debug.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 03d00b144304..693b6cc371f8 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -347,6 +347,10 @@ struct sc16is7xx_port {
>  	struct sc16is7xx_one		p[];
>  };
>  
> +static bool debug;
> +module_param(debug, bool, 0644);
> +MODULE_PARM_DESC(debug, "enable/disable debug messages");

Sorry, but no, use the normal dynamic debugging logic that the whole
rest of the kernel uses.  Do not add random per-driver module parameters
like this, that would be a regression from the existing infrastructure
that we have in place already.

thanks,

greg k-h
