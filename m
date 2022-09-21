Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692D15BFDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiIUMX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIUMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:23:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362F18A7F9;
        Wed, 21 Sep 2022 05:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBB81B82E1B;
        Wed, 21 Sep 2022 12:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9AEC433C1;
        Wed, 21 Sep 2022 12:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663763000;
        bh=F2DToXHLBPuGXbyvTDD1yhZllTEXTzgULyTMtjkYCnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XoGISdZD7nfVQdAmCJdsJ+tgj6f8hY3ImR/qbAThRDNjfYz6gjI3NAXV9WsdoRCWV
         7dvWbIkXNfNF2mZujCz0xNlvkIjwVFtc6Hc82Q1QtyAyBMAgDUC5vVlvS1T9uTtitf
         D6wjJiYwt0kS7gebb0xSnB3yPCRSyg+dj1A2F5iA=
Date:   Wed, 21 Sep 2022 14:23:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] arm: dts: imx7-colibri: remove spurious debounce
 property
Message-ID: <YysCNT2/qOi/BUC4@kroah.com>
References: <20220920092227.286306-1-marcel@ziswiler.com>
 <20220920092227.286306-5-marcel@ziswiler.com>
 <20220921121505.GA41442@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921121505.GA41442@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 02:15:05PM +0200, Francesco Dolcini wrote:
> +Greg, to get an opinion on the fixes tag.
> 
> On Tue, Sep 20, 2022 at 11:22:27AM +0200, Marcel Ziswiler wrote:
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > Remove spurious debounce property from linux,extcon-usb-gpio.
> > 
> > Note that debouncing is hard-coded to 20 ms (USB_GPIO_DEBOUNCE_MS
> > define).
> > 
> > Fixes: 0ef1969ea569 ("ARM: dts: imx7-colibri: move aliases, chosen, extcon and gpio-keys")
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Hello all,
> we did have some (internal) discussion if this patch should have the
> fixes tag or not.
> 
> I do personally think it should not have it and should not be backported
> to stable tree, since this is not fixing a real bug, it's just a
> cleanup.

If it's not a real bug, why would you have a Fixes: tag on the commit?

> On the other hand the original patch was not correct, and this change is
> making it right.

Ah, so it is a bugfix.

> What is the general opinion on this topic? What do the stable kernel
> maintainers would expect?

It's up to you, but what is the problem with it being backported?

> Documentation/process/stable-kernel-rules.rst is about rules for
> backporting, it does not really talk about the fixes tag, but today this
> is used to decide if a patch should be backported or not.

We use Fixes: as a signal from maintainers and developers that do not
normally use the cc: stable@ as documented to pick up things that look
like fixes but someone forgot to ask to be backported.

It's not a guarantee it will be backported, like cc: stable will be, but
it is a hint to us that maybe it should be looked at.

thanks,

greg k-h
