Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB85364065A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiLBMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiLBMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:05:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049B22288
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:05:44 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1p14nO-0006vf-Jk; Fri, 02 Dec 2022 13:05:34 +0100
Message-ID: <94f5f20b-f7c9-b9b5-1b49-3c4366b47370@pengutronix.de>
Date:   Fri, 2 Dec 2022 13:05:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] crypto: caam: blob_gen.c: warn if key is insecure
Content-Language: en-US
To:     Nikolaus Voss <nikolaus.voss@haag-streit.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Gstir <david@sigma-star.at>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Nikolaus Voss <nv@vosn.de>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121141929.2E36427E9@mail.steuer-voss.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20221121141929.2E36427E9@mail.steuer-voss.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21.11.22 15:12, Nikolaus Voss wrote:
> +	ctrlpriv = dev_get_drvdata(jrdev->parent);
> +	moo = FIELD_GET(CSTA_MOO, ioread32(&ctrlpriv->ctrl->perfmon.status));

Sorry for not having spotted this the first time, but ioread32 is not
completely correct here as the CAAM may be big endian while the CPU is
little endian.

You should be using rd_reg32 here.

Cheers,
Ahmad

> +	if (moo != CSTA_MOO_SECURE && moo != CSTA_MOO_TRUSTED)
> +		dev_warn(jrdev,
> +			 "using insecure test key, enable HAB to use unique device key!\n");
> +
>  	/*
>  	 * A data blob is encrypted using a blob key (BK); a random number.
>  	 * The BK is used as an AES-CCM key. The initial block (B0) and the
> diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
> index 66d6dad841bb2..66928f8a0c4b1 100644
> --- a/drivers/crypto/caam/regs.h
> +++ b/drivers/crypto/caam/regs.h
> @@ -426,6 +426,9 @@ struct caam_perfmon {
>  	u32 rsvd2;
>  #define CSTA_PLEND		BIT(10)
>  #define CSTA_ALT_PLEND		BIT(18)
> +#define CSTA_MOO		GENMASK(9, 8)
> +#define CSTA_MOO_SECURE	1
> +#define CSTA_MOO_TRUSTED	2
>  	u32 status;		/* CSTA - CAAM Status */
>  	u64 rsvd3;
>  

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

