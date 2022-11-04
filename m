Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5422F61931F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKDJGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiKDJGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:06:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3492A42A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:06:02 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oqse9-0008PK-MH; Fri, 04 Nov 2022 10:05:53 +0100
Message-ID: <b1d90113-c69a-108c-7142-6a47db001a96@pengutronix.de>
Date:   Fri, 4 Nov 2022 10:05:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] crypto: caam: blob_gen.c: warn if key is insecure
Content-Language: en-US
To:     Nikolaus Voss <nv@vosn.de>, Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Gstir <david@sigma-star.at>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019144108.48E1B1B0E@mail.steuer-voss.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20221019144108.48E1B1B0E@mail.steuer-voss.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nikolaus,

On 19.10.22 14:44, Nikolaus Voss wrote:
> If CAAM is not in "trusted" or "secure" state, a fixed non-volatile key
> is used instead of the unique device key. This is the default mode of
> operation without secure boot (HAB). In this scenario, CAAM encrypted
> blobs should be used only for testing but not in a production
> environment, so issue a warning.

Thanks for your patch.

> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> ---
>  drivers/crypto/caam/blob_gen.c | 8 ++++++++
>  drivers/crypto/caam/regs.h     | 3 +++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
> index 6345c7269eb0..f3e741393f65 100644
> --- a/drivers/crypto/caam/blob_gen.c
> +++ b/drivers/crypto/caam/blob_gen.c
> @@ -6,6 +6,7 @@
>  
>  #define pr_fmt(fmt) "caam blob_gen: " fmt
>  
> +#include <linux/bitfield.h>
>  #include <linux/device.h>
>  #include <soc/fsl/caam-blob.h>
>  
> @@ -62,11 +63,13 @@ int caam_process_blob(struct caam_blob_priv *priv,
>  		      struct caam_blob_info *info, bool encap)

I agree with Herbert that this may not be the best place. I think
a single warning during caam_blob_gen_init() would suffice.

>  {
>  	struct caam_blob_job_result testres;
> +	const struct caam_drv_private *ctrlpriv;
>  	struct device *jrdev = &priv->jrdev;
>  	dma_addr_t dma_in, dma_out;
>  	int op = OP_PCLID_BLOB;
>  	size_t output_len;
>  	u32 *desc;
> +	u32 moo;
>  	int ret;
>  
>  	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
> @@ -100,6 +103,11 @@ int caam_process_blob(struct caam_blob_priv *priv,
>  		goto out_unmap_in;
>  	}
>  
> +	ctrlpriv = dev_get_drvdata(jrdev->parent);
> +	moo = FIELD_GET(CSTA_MOO, ctrlpriv->ctrl->perfmon.status);
> +	if (moo != CSTA_MOO_SECURE && moo != CSTA_MOO_TRUSTED)
> +		dev_warn(jrdev, "using insecure test key!\n");

I'd make the warning a bit more verbose, e.g.

  "device not configured for trusted/secure mode: using insecure test key!"

> +
>  	/*
>  	 * A data blob is encrypted using a blob key (BK); a random number.
>  	 * The BK is used as an AES-CCM key. The initial block (B0) and the
> diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
> index 66d6dad841bb..b7de5fb5e056 100644
> --- a/drivers/crypto/caam/regs.h
> +++ b/drivers/crypto/caam/regs.h
> @@ -426,6 +426,9 @@ struct caam_perfmon {
>  	u32 rsvd2;
>  #define CSTA_PLEND		BIT(10)
>  #define CSTA_ALT_PLEND		BIT(18)
> +#define CSTA_MOO		GENMASK(9, 8)
> +#define CSTA_MOO_SECURE	1
> +#define CSTA_MOO_TRUSTED	3

I just checked the i.MX6 and LS1046 security reference manuals and both
have Trusted as 2 (10b). 3 is fail. Does you SoC differ? Either way, please
note what SoC you were testing on in the commit message.

>  	u32 status;		/* CSTA - CAAM Status */
>  	u64 rsvd3;
>  


Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

