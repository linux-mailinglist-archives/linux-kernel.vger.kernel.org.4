Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4E06341F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiKVQ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKVQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:56:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EBC716D8;
        Tue, 22 Nov 2022 08:56:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D43BC617E1;
        Tue, 22 Nov 2022 16:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B9AC433C1;
        Tue, 22 Nov 2022 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669136175;
        bh=AzNW9zTbmS3x9Fv0bzmeAyny0Blhg8zkFcHqFx5TgsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aqe+8IB1dK9H5o3Oa8iUvdGlTxD/ncdHHWBFzNqMgviKVDxmaZqMAq19TjXeO9IcI
         RZv8iLO3XFVOdqLVMF2E4i192/UqEzG8Nzek++KmacWDfZAd0JzUM/2s6+kJW0Cf6L
         iExeHzXRoN5o9Y2N+n55nyp0+hInSEAyMcc0kd7Y=
Date:   Tue, 22 Nov 2022 17:56:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     jirislaby@kernel.org, michael@walle.cc, jingchang.lu@freescale.com,
        tomonori.sakita@sord.co.jp, atsushi.nemoto@sord.co.jp,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V2 1/5] tty: serial: fsl_lpuart: only enable Idle Line
 Interrupt for non-dma case
Message-ID: <Y3z/K0NI/fw0DPYI@kroah.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
 <20221110081728.10172-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110081728.10172-2-sherry.sun@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:17:24PM +0800, Sherry Sun wrote:
> For the lpuart driver, the Idle Line Interrupt Enable now is only needed
> for the CPU mode, so enable the UARTCTRL_ILIE at the correct place, and
> clear it when shutdown.
> 
> Also need to configure the suitable UARTCTRL_IDLECFG, now the value is
> 0x7, represent 128 idle characters will trigger the Idle Line Interrupt.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
> Changes in V2:
> 1. Use FIELD_PREP() and GENMASK() for easy access to UARTCTRL_IDLECFG
> fields as suggested by Ilpo.
> ---
>  drivers/tty/serial/fsl_lpuart.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

This commit breaks the build for me as FIELD_PREP() does not seem to be
included properly :(

Please fix up and resend.

thanks,

greg k-h
