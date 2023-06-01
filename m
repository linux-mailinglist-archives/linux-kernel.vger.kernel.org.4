Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B071F13B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjFAR60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFAR6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:58:23 -0400
X-Greylist: delayed 1804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 10:58:20 PDT
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DFF13D;
        Thu,  1 Jun 2023 10:58:19 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 9.4.2) with ESMTPA;
        Thu, 1 Jun 2023 19:28:01 +0200
MIME-Version: 1.0
Date:   Thu, 01 Jun 2023 19:28:01 +0200
From:   m.brock@vanmierlo.com
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v5 3/9] serial: sc16is7xx: refactor GPIO controller
 registration
In-Reply-To: <20230601163113.2785657-4-hugo@hugovil.com>
References: <20230601163113.2785657-1-hugo@hugovil.com>
 <20230601163113.2785657-4-hugo@hugovil.com>
Message-ID: <c5c2879e55102a6d517245e6d251290d@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugo Villeneuve schreef op 2023-06-01 18:31:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> In preparation for upcoming patch "fix regression with GPIO
> configuration". To facilitate review and make code more modular.
> 
> Cc: <stable@vger.kernel.org> # 6.1.x
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 39 ++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c 
> b/drivers/tty/serial/sc16is7xx.c
> index 0c903d44429c..279d7dcb1447 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1349,6 +1349,26 @@ static int
> sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
> 
>  	return 0;
>  }
> +
> +static int sc16is7xx_setup_gpio_chip(struct device *dev)

Only one parameter, but...

> +	ret = sc16is7xx_setup_gpio_chip(dev, mctrl_mask);

called with two.

Maarten

