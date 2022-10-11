Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81885FACF5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJKGjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJKGi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:38:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB36525D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:38:56 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:ae63:39ed:8275:38f4] (unknown [IPv6:2a01:e0a:120:3210:ae63:39ed:8275:38f4])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 833AF6602343;
        Tue, 11 Oct 2022 07:38:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665470334;
        bh=4OqSDwAWB/8lJv+0r9Z1nmJEkUKrOhG1b7aYoMOaaZc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d+xhUNiy8Vzv2upP0uDiAboiLyyvfkBeLdHocQtqCCGQycYHsF+MKIL0xZy6REvWx
         dNHJTODHtmr+dYlaC9Af0P5O01ofQt+mNiN6OMAem6jMaXooU3q8EQG6v4221rBdfi
         sl5biSu57db0Ci50HrP2LyimzLVzpC0ZvduXqGiKLfZiBJKe/aigPAENw4WxQ5R1Mi
         MWt6qOjDDKjMrlIfWP+O7AONNPHQ0hjyhwd3HPyYxdngjhS7JUPG19ievePYiRt5Ud
         VwrMjl28ywFzfq4R39Ofww5HO5yoYn4g0zpBDAL6QWJlYtj6fcVBbwvlLXqfC8ryXx
         Rkl5pmAfb2Bmg==
Message-ID: <bdfacbcc-c4e2-e1f2-1b83-082306170952@collabora.com>
Date:   Tue, 11 Oct 2022 08:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd
 is not yet ready
Content-Language: en-US
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220919121302.597993-1-benjamin.gaignard@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20220919121302.597993-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 19/09/2022 à 14:13, Benjamin Gaignard a écrit :
> Depending of the boot sequence 'bus' genpd could be probed after imx8m-blk-ctrl
> which led driver probe to fail. Change the returned error to allow
> to defer the probe in this case.

Gentle reminder about this patch.

Thanks,
Benjamin

>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> v3:
> - only return -EPROBE_DEFER if 'bus' device hasn't be found.
>
> v2:
> - keep dev_err_probe only change the return value.
>
>   drivers/soc/imx/imx8m-blk-ctrl.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index dff7529268e4..1c195e9e8895 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -214,9 +214,14 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
> -	if (IS_ERR(bc->bus_power_dev))
> -		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
> -				     "failed to attach power domain \"bus\"\n");
> +	if (IS_ERR(bc->bus_power_dev)) {
> +		if (PTR_ERR(bc->bus_power_dev) == -ENODEV)
> +			return dev_err_probe(dev, -EPROBE_DEFER,
> +					     "failed to attach power domain \"bus\"\n");
> +		else
> +			return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
> +					     "failed to attach power domain \"bus\"\n");
> +	}
>   
>   	for (i = 0; i < bc_data->num_domains; i++) {
>   		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
