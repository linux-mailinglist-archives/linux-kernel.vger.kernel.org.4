Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4FA6789FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjAWVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjAWVvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:51:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E263346D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:51:32 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pK4ia-0004ba-5k; Mon, 23 Jan 2023 22:51:08 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pK4iX-00063k-F7; Mon, 23 Jan 2023 22:51:05 +0100
Date:   Mon, 23 Jan 2023 22:51:05 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     slongerbeam@gmail.com, festevam@gmail.com, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, s.hauer@pengutronix.de,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, mchehab@kernel.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: imx: imx-media-fim: Replace macro icap_enabled()
 with function
Message-ID: <20230123215105.fbfzxueegtnbu4ym@pengutronix.de>
References: <20230123191714.22430-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123191714.22430-1-bpappas@pappasbrent.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thank you for the patch.

On 23-01-23, Brent Pappas wrote:
> Replace the macro icap_enabled() with a static function to comply
> with Linux coding style standards.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
>  drivers/staging/media/imx/imx-media-fim.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
> index fb6590dcfc36..ccb35d098a19 100644
> --- a/drivers/staging/media/imx/imx-media-fim.c
> +++ b/drivers/staging/media/imx/imx-media-fim.c
> @@ -68,7 +68,10 @@ struct imx_media_fim {
>  	bool              stream_on;
>  };
>  
> -#define icap_enabled(fim) ((fim)->icap_flags != IRQ_TYPE_NONE)
> +static bool icap_enabled(struct imx_media_fim *fim)
> +{
> +	return fim->icap_flags != IRQ_TYPE_NONE;
> +}

Nit: I would make it inline but recent compiler may do the job for us.

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Regards,
  Marco

>  static void update_fim_nominal(struct imx_media_fim *fim,
>  			       const struct v4l2_fract *fi)
> -- 
> 2.34.1
> 
> 
> 
