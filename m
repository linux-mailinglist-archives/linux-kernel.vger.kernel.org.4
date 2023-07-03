Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DAB745D26
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGCN0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGCN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:26:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8769E70;
        Mon,  3 Jul 2023 06:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B3EC60EE0;
        Mon,  3 Jul 2023 13:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197ADC433C9;
        Mon,  3 Jul 2023 13:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688390767;
        bh=lOto3+2FBgpgZYTbSv5jQU8R2gXWk1bZIPsTI/IYNIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jR0vzl0SnAnlH9AL2mHlfOw7ml7dux3qyyJCHrzNVWXX8mXNomw2vrfuqRd/fPs7J
         FX731LoZbOcq0kJ8EudGvauceZ0xT6soX/7XeWdGr0QuOBx5ebSCrQ1z9ErA+1xIfx
         6Wn/4RFXqMKebtYuaBKN/PPgppDxI74arIK/jifM=
Date:   Mon, 3 Jul 2023 15:25:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: ili9341: use macro
 FBTFT_REGISTER_SPI_DRIVER
Message-ID: <2023070312-pasty-divisive-fa22@gregkh>
References: <20230702080324.120137-1-rgallaispou@gmail.com>
 <2023070254-embark-subplot-4dd4@gregkh>
 <ae400e28-0cd4-cdf8-811d-843e62cd4a95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae400e28-0cd4-cdf8-811d-843e62cd4a95@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 03:05:25PM +0200, Raphaël Gallais-Pou wrote:
> Hi,
> 
> Le 02/07/2023 à 14:02, Greg Kroah-Hartman a écrit :
> > On Sun, Jul 02, 2023 at 10:03:24AM +0200, Raphael Gallais-Pou wrote:
> > > Using FBTFT_REGISTER_DRIVER resolves to a NULL struct spi_device_id. This
> > > ultimately causes the module to an early exit at probe time.
> > 
> > So this doesn't work at all today?  Has it ever worked?  What commit
> > does thi fix?
> 
> I tested again with only a tweak in my device-tree. The early exit in the
> driver's code is caused by a missing field. So regarding this particular
> driver the macro works.
> 
> It resolves to set spi_driver.id_table = NULL, which yields a warning in
> __spi_register_driver(). So I guess this patch only fixes a warning.

Ok, please fix the changelog text when you resend this.

> > > In addition the MODULE_ALIASes can be dropped.
> > 
> > Why?  When you say "also" or "in addition", that's a huge hint it should
> > be a separate patch.
> I did not find any reference to those aliases in the kernel, which led me to
> remove those.

Aliases are used by userspace, not the kernel.

> If you think they are still necessary, I'll split them in an upcoming v2.

Please document why they are not needed in order to be able to be
removed.

thanks,

greg k-h
