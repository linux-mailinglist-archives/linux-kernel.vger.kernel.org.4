Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB5722253
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFEJgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFEJgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:36:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB066D3;
        Mon,  5 Jun 2023 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1685957758; x=1686562558; i=deller@gmx.de;
 bh=4aZGFNHaqYts9HJGEBYu/SzlFrcSqs2ONdbIPv8h5ts=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=r+z4B2tupxVHJ63m3lXNOwXDv699zPSioDJ/oxQ5xFu2aTUX5146vaOrLKh47Lp3+qGQUo9
 OpOojKAaC8qwv2KkgOhLsrjAFQl/vLMeXes1RBy1F6zIujFqtvMLpQqSct/9PB9w8mWplGC8z
 m9TAbFcgnV/WRBVm9LA/kRbO+Vv8dZAgMQnEuFWOL6kQDRnzmJBDI3TWeP0Wn0AzvNjSPVt6a
 eN6PS0gxAUrpL3ASnlHToctdozh9CbA6k0+1QHiCc8VvC++HCTcWKcg97Aj1rwMH/8l/AZSXx
 aeSUtl1GS5ALxFhCDmQSPGmC8/ofE6j0jaYb1zae1j/hKB6xq2Lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.56.61] ([109.43.115.72]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1qZxSj0dCJ-00flAb; Mon, 05
 Jun 2023 11:35:58 +0200
Message-ID: <848956d2-cf95-bd6a-1292-272438b0d860@gmx.de>
Date:   Mon, 5 Jun 2023 11:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] video: fbdev: omapfb: lcd_mipid: Fix an error handling
 path in mipid_spi_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Imre Deak <imre.deak@nokia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Helt <krzysztof.h1@wp.pl>,
        Juha Yrjola <juha.yrjola@solidboot.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <f17221571f619c0829db56354f2b74d22f6702a7.1685893329.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <f17221571f619c0829db56354f2b74d22f6702a7.1685893329.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O8jINPdRRRhdW6K/VPuIluO4TUz2RA7GWy7BS61PiwwjuaBm3oe
 xRlo+MX+oafQs54E/0uFtXBCfZw5grNtmkqDxHj6wY9m9btw8xD6T7Olg2so3cLBrN/Zo74
 cCewQOuFiAiYVTs/LQHBGZLCdQtHbocA0NpihSdNtkGutMHBukCis8UDnmtGt9UOLFweO98
 a0PowgyQXZCQkLEk0eJng==
UI-OutboundReport: notjunk:1;M01:P0:v7du267JY28=;ZwxfR0dFKojHp9ugRWseiTBAr+f
 23jU7ZfKH2FbkJvd9851IpoF7wmhSZj80LleRmWrnnMt4/7HyEz8L3a+y9CC4doJl9NGY0epA
 BiOhlf94atBk8WYxMVeBVIijVG3DMRNzPQK0rBevUF5h+VYN/5yQnVAXm+ORvF2NmkKFPYA3Z
 RsisHuM8OaM2mD+C+HD1UyAWdsWFYNyZtEZ6tuY0wNqiyNTBy3FGYuApK0HRM4l/Wlx4DY+/r
 NHsd+z3DN9/oNIWNNF/8SdyaTQqUqNpFcbgs+zD+s6cXbYSaZLo/GMaWnvzQvtTNyMZgInDSr
 4YeeUIyx08aVcXmByeMsErm5Z5PAFw/ZC4/3o2qdAmNVqxRM74O677Vvspzhyg6i7BZ7px1os
 /iGiaCsvKzVunj7ZQx1uMC5Fa1ZDZmSG2JKT0mi55fvEICsd20Ef1kiTtawoAjEz5vxKEQeK0
 76ql7QWVFZk1Fe2lsd7pym7UoE8e3liOFBK/ohkCnRJqdMbmi96Smj3qqkFlcuW/JFCG9qItI
 ZO58VAnaUg0gwQIi9bRo1oV6O618aCdmkbtdGs0xASCK6HYNpq1qCrhxGZP0zxq3QNm1tBspa
 MSDa3Ma6RazZqbSOE/nqKuMurQh75cX6KvRB5K32lpGER5YLkEzuXRh/c1Fdxa8yxLHWW6BjM
 7N2khHDlI5cNnW+6FP79RTBa9/QCPffMZ9SfMiYol0JedxLb/GsfXSfTc/k2daPXxsKqHllxR
 F5blRYIkhnVqAVnQW6tRCqIE4UQbhsYM6MzpLs97eGwMs0J5rqqLpZD4V+Tb/ADTWmiab+rsH
 O23y4a0T0T4kX8kfOOLwO25LTf9ZrogjxGGxXvGcJ4xvdLvrScEdMSYo7KtJdp+G66HP6AIF7
 Pww05UlUo/yqMcikZKE9l/tJY+3daL5vncoQKyoZ44NFGrLL804cs/gwinhUyWfkqLAhitnKK
 g9Tn3r41ZqctGPMTgzZGiZC1++Q=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/23 17:42, Christophe JAILLET wrote:
> If 'mipid_detect()' fails, we must free 'md' to avoid a memory leak.
>
> Fixes: 66d2f99d0bb5 ("omapfb: add support for MIPI-DCS compatible LCDs")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/omap/lcd_mipid.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/=
omap/lcd_mipid.c
> index e4a7f0b824ff..a0fc4570403b 100644
> --- a/drivers/video/fbdev/omap/lcd_mipid.c
> +++ b/drivers/video/fbdev/omap/lcd_mipid.c
> @@ -571,11 +571,15 @@ static int mipid_spi_probe(struct spi_device *spi)
>
>   	r =3D mipid_detect(md);
>   	if (r < 0)
> -		return r;
> +		goto free_md;
>
>   	omapfb_register_panel(&md->panel);
>
>   	return 0;
> +
> +free_md:
> +	kfree(md);
> +	return r;
>   }
>
>   static void mipid_spi_remove(struct spi_device *spi)

