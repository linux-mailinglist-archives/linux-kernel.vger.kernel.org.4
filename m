Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBEF61EF8F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiKGJtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiKGJtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:49:20 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E8126D5;
        Mon,  7 Nov 2022 01:49:19 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C93F81BF20B;
        Mon,  7 Nov 2022 09:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667814558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=suAWhiMbN3vVsVIvCvbfabSCT4Xo/QXzr+vevpFsMds=;
        b=T1w1LK54EqHBS2sNA+9bpJ2n2BiREChSZ5BAQwPQSkvIafyXCZYaOZAtEHOdWjJHv4Ih/M
        /zwJj0vPJz3lw1I8rqTUsdDso3xyEdIWcIeGLDaTWm0oDQLaCSMv7q4fTDHc1p/R2izvkg
        gXnugYgu01OHMUN0pOKXzRjakrCT8m9wsjNXW/wLQdnSNhO1M2HlbVxFS52uErVDKNz+vj
        cbNMts1tmrQPi6pjvJm/1yWMUPDizpq8ujkNwWPgAJpCkH/6wvFp8k3+/LmPWPuw+yvAw+
        fyHg6LKS/f6wPcLFDouy6gHB4ZyH0HysqJMOEwt31T4kwXXlg5sHeTF//TLpkw==
Date:   Mon, 7 Nov 2022 10:49:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     zys.zljxml@gmail.com
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        michel.pollet@bp.renesas.com, linux-rtc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH] rtc: rzn1: Check return value in rzn1_rtc_probe
Message-ID: <20221107104916.64dc26d4@xps-13>
In-Reply-To: <20221107092544.3721053-1-zys.zljxml@gmail.com>
References: <20221107092544.3721053-1-zys.zljxml@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

zys.zljxml@gmail.com wrote on Mon,  7 Nov 2022 17:25:44 +0800:

> From: Yushan Zhou <katrinzhou@tencent.com>
>=20
> The rzn1_rtc_probe() function utilizes devm_pm_runtime_enable()
> but wasn't checking the return value. Fix it by adding missing
> check.
>=20
> Fixes: deeb4b5393e1 ("rtc: rzn1: Add new RTC driver")
>=20
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> ---
>  drivers/rtc/rtc-rzn1.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index ac788799c8e3..0d36bc50197c 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -355,7 +355,9 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
>  	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
>  	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
> =20
> -	devm_pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_pm_runtime_enable(&pdev->dev);
> +	if (ret < 0)
> +		return ret;
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret < 0)
>  		return ret;

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
