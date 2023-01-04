Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC41965D51A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbjADOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbjADOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:07:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD839FAB;
        Wed,  4 Jan 2023 06:06:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7975061745;
        Wed,  4 Jan 2023 14:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1B7C433D2;
        Wed,  4 Jan 2023 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672841192;
        bh=cwpGS7Bw9s81lrsx/RuMUVoc1/fcxSSEIg/xfnjs7pQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIwVT+c3e8jOOPymXuffzPby3iBeTGQ/SO1BTx2mE01EpipA6fTRyJbPErPCGfHVe
         MtG4Sva44btExBvO/wwlPJaXLTb9CYTtKpQi2AQMaqaUXGEgpMKj9Ocsxp+ofp0hyt
         VNQJjruU+waUR6YOi1uupggH7+NfUQLVzEXfcDq0=
Date:   Wed, 4 Jan 2023 15:03:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/3] bus: add Wiegand bus driver
Message-ID: <Y7WHPuhIurGHDqIE@kroah.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-3-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104133414.39305-3-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:34:13PM +0100, Martin Zaťovič wrote:
> Add a bus driver for Wiegand protocol. The bus driver handles
> Wiegand controller and Wiegand device managemement and driver
> matching. The bus driver defines the structures for Wiegand
> controllers and Wiegand devices. Wiegand controller structure
> contains the format and payload_len fields to add support for
> different format messages. This should be handled by the
> controller driver.
> 
> Each Wiegand controller should be associated with one Wiegand
> device, as Wiegand is typically a point-to-point bus.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  MAINTAINERS             |   2 +
>  drivers/bus/Kconfig     |   5 +
>  drivers/bus/Makefile    |   1 +
>  drivers/bus/wiegand.c   | 768 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/wiegand.h | 228 ++++++++++++
>  5 files changed, 1004 insertions(+)
>  create mode 100644 drivers/bus/wiegand.c
>  create mode 100644 include/linux/wiegand.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index db9624d93af0..b6e68e92f0e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22432,6 +22432,8 @@ WIEGAND BUS DRIVER
>  M:	Martin Zaťovič <m.zatovic1@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> +F:	drivers/bus/wiegand.c
> +F:	include/linux/wiegand.h
>  
>  WILOCITY WIL6210 WIRELESS DRIVER
>  L:	linux-wireless@vger.kernel.org
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 7bfe998f3514..360e55abc311 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -241,6 +241,11 @@ config VEXPRESS_CONFIG
>  	  Platform configuration infrastructure for the ARM Ltd.
>  	  Versatile Express.
>  
> +config WIEGAND
> +        tristate "Wiegand Bus driver"
> +        help
> +          Driver for low-level 2-wire serial protocol communication.

We need more information here in the help text please.

thanks,

greg k-h
