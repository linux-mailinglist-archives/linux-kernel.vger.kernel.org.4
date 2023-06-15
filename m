Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE967323AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjFOXbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjFOXbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:31:08 -0400
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B088B296A;
        Thu, 15 Jun 2023 16:31:03 -0700 (PDT)
Date:   Fri, 16 Jun 2023 07:30:51 +0800
From:   Yixun Lan <dlan@gentoo.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 5/6] tty: serial: meson: Added T7 SOC compatibility
Message-ID: <ZIufK7uK0ZrsVTZ3@ofant>
References: <20230615182938.18487-1-tanure@linux.com>
 <20230615182938.18487-6-tanure@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615182938.18487-6-tanure@linux.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas:

On 19:29 Thu 15 Jun     , Lucas Tanure wrote:
> Make UART driver compatible with T7 SOC UART.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  drivers/tty/serial/meson_uart.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 2501db5a7aaf..0208f9a6ba7e 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -796,6 +796,10 @@ static const struct of_device_id meson_uart_dt_match[] = {
>  		.compatible = "amlogic,meson-s4-uart",
>  		.data = (void *)&meson_g12a_uart_data,
>  	},
> +	{
> +		.compatible = "amlogic,meson-t7-uart",
> +		.data = (void *)&meson_g12a_uart_data,
I think you are trying to follow previous s4 scheme - to introduce a new
compatible string, while I think it's not necessary or even wrong, this will just
make the dt_match_list longer but without obvious benefits..

as Conor already raised this question in previous dt-binding patch[4/6],
how about just using 'amlogic,meson-g12a-uart' which is the first compatible
introduced.

if people agree, we could also drop 'amlogic,meson-s4-uart' since it use same
compatible data as gl12a, anyway it should be separated into another patch..

> +	},
>  	{ /* sentinel */ },


>  };
>  MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
> --
> 2.41.0
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
