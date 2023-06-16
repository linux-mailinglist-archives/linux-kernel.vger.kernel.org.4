Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC10273311B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbjFPMYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjFPMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:24:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925A1FCC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:24:01 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qA8UR-0005J5-Fp; Fri, 16 Jun 2023 14:23:43 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qA8UQ-0000Wd-FC; Fri, 16 Jun 2023 14:23:42 +0200
Date:   Fri, 16 Jun 2023 14:23:42 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl, olteanv@gmail.com,
        javierm@redhat.com, sakari.ailus@linux.intel.com,
        srinivas.pandruvada@linux.intel.com,
        u.kleine-koenig@pengutronix.de, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: tvp5150: check return value of
 devm_kasprintf()
Message-ID: <20230616122342.bc2fgwfek6gl6577@pengutronix.de>
References: <20230615103030.582531-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615103030.582531-1-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-06-15, Claudiu Beznea wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).

lgtm

> Fixes: 0556f1d580d4 ("media: tvp5150: add input source selection of_graph support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
> 
> Hi,
> 
> This has been addressed using kmerr.cocci script proposed for update
> at [1].
> 
> Thank you,
> Claudiu Beznea
> 
> [1] https://lore.kernel.org/all/20230530074044.1603426-1-claudiu.beznea@microchip.com/
> 
>  drivers/media/i2c/tvp5150.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
> index 859f1cb2fa74..84f87c016f9b 100644
> --- a/drivers/media/i2c/tvp5150.c
> +++ b/drivers/media/i2c/tvp5150.c
> @@ -2068,6 +2068,10 @@ static int tvp5150_parse_dt(struct tvp5150 *decoder, struct device_node *np)
>  		tvpc->ent.name = devm_kasprintf(dev, GFP_KERNEL, "%s %s",
>  						v4l2c->name, v4l2c->label ?
>  						v4l2c->label : "");
> +		if (!tvpc->ent.name) {
> +			ret = -ENOMEM;
> +			goto err_free;
> +		}
>  	}
>  
>  	ep_np = of_graph_get_endpoint_by_regs(np, TVP5150_PAD_VID_OUT, 0);
> -- 
> 2.34.1
> 
> 
