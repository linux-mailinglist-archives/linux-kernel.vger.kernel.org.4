Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4570F47A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjEXKpb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjEXKp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:45:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105DE19C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:45:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1q1lzS-0007w7-5i; Wed, 24 May 2023 12:45:10 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1q1lzO-002Sr9-C7; Wed, 24 May 2023 12:45:06 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1q1lzM-0005pO-Dd; Wed, 24 May 2023 12:45:04 +0200
Message-ID: <b33cf92691afaa158c6282703128dfb8da4fe242.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] crypto: hisilicon - Add HiSilicon ADVCA Subsystem
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     David Yang <mmyangfl@gmail.com>, linux-crypto@vger.kernel.org
Cc:     Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 May 2023 12:45:04 +0200
In-Reply-To: <20230513074339.266879-2-mmyangfl@gmail.com>
References: <20230513074339.266879-1-mmyangfl@gmail.com>
         <20230513074339.266879-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sa, 2023-05-13 at 15:43 +0800, David Yang wrote:
> HiSilicon ADVCA Subsystem contains various cryptographic devices, including
> symmetric key ciphers, hash functions, RSA algorithms, as well as key
> ladder and OTP memory.
> 
> This patch adds symmetric key cipher driver.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/crypto/hisilicon/Kconfig              |    8 +
>  drivers/crypto/hisilicon/Makefile             |    1 +
>  drivers/crypto/hisilicon/advca/Makefile       |    1 +
>  .../crypto/hisilicon/advca/hisi-advca-muc.c   | 1527 +++++++++++++++++
>  4 files changed, 1537 insertions(+)
>  create mode 100644 drivers/crypto/hisilicon/advca/Makefile
>  create mode 100644 drivers/crypto/hisilicon/advca/hisi-advca-muc.c
> 
[...]
> diff --git a/drivers/crypto/hisilicon/advca/hisi-advca-muc.c b/drivers/crypto/hisilicon/advca/hisi-advca-muc.c
> new file mode 100644
> index 000000000000..362596a91e19
> --- /dev/null
> +++ b/drivers/crypto/hisilicon/advca/hisi-advca-muc.c
> @@ -0,0 +1,1527 @@
[...]
> +static int hica_muc_probe(struct platform_device *pdev)
> +{
[...]
> +	priv->rst = devm_reset_control_get_optional(dev, NULL);

Please use devm_reset_control_get_optional_exclusive() directly.

Since priv->rst is only ever used in hica_muc_probe(), it could be
stored in a local variable instead.

> +	if (IS_ERR(priv->rst))
> +		return PTR_ERR(priv->rst);
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +	priv->irqs[0] = ret;
> +	priv->irqs[1] = platform_get_irq_optional(pdev, 1);
> +
> +	priv->algs_num = ARRAY_SIZE(hica_muc_tmpls);
> +	priv->algs = devm_kmalloc_array(dev, priv->algs_num,
> +					sizeof(priv->algs[0]), GFP_KERNEL);
> +	if (!priv->algs)
> +		return -ENOMEM;
> +
> +	init_completion(&priv->cond);
> +
> +	priv->dev = dev;
> +	platform_set_drvdata(pdev, priv);
> +	dev_set_drvdata(dev, priv);
> +
> +	/* bring up device */
> +	ret = reset_control_assert(priv->rst) ?:
> +	      clk_bulk_prepare_enable(priv->clks_num, priv->clks) ?:
> +	      reset_control_deassert(priv->rst);

Using the ternary operator like this is a bit unconventional. Here, the
clocks are kept enabled if the reset_control_deassert() fails.

It would be good to add an error path that disables the clocks.

> +	if (ret)
> +		return ret;
> +
> +	if (!(readl(priv->base + MUC_RST_STATUS) & MUC_STATE_VALID)) {
> +		msleep(20);
> +		if (!(readl(priv->base + MUC_RST_STATUS) & MUC_STATE_VALID)) {
> +			dev_err(dev, "cannot bring up device\n");
> +			return -ENODEV;

This also leaves the clocks enabled. There are some more return
statements with the same issue below.

regards
Philipp
