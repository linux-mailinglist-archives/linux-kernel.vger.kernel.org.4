Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B009274AB1F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGGGbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGGGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:31:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08A1FF9;
        Thu,  6 Jul 2023 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688711413; x=1689316213; i=deller@gmx.de;
 bh=DdPZOtZVNsdAm2tHjUakaoi2IjUtD9GANS/45KrMaYA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YWqKVDhJ/5QrBSx4epjdd9S6wn4+H9LF7ZRZrFZaHPs+sg8z/piT+ulqT9TqaGi8p7fxz/8
 dk1JlCbT0HHWtQ5jYQOl0pQYuRkSfkCDv5D7IHILsnvJ34BBZ5A9BkYU+DVNNqTC06LB34U6c
 uP4pkMmY7f1Azz0k7SW6J5hCwlV7Pxy7z7wlAIHY1eM7Ta/34HRiWDdTffjaKs8cMWTI1IVFa
 WLo9U7W12qaQOnCuEzymnlqxYwwAJF6FNPz0X/fVRYJAkz3GoyErWjTnjQFqqvv+dn9g6F3xm
 FnV+l+f6skv24bD1BmXpoWxkwOTUeo9oz24PpZBDfYO2ypf3c6Vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.180]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1pytbk3ese-00s5Aw; Fri, 07
 Jul 2023 08:30:13 +0200
Message-ID: <7b51c68e-c716-e510-48a4-5da697e33d05@gmx.de>
Date:   Fri, 7 Jul 2023 08:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fbdev: imxfb: Convert to devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230704093652.18191-1-frank.li@vivo.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230704093652.18191-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z7uLkJkCXWtZ3ZEnT389CW1h6m97XY9J80PvCGh+RRpnGXxKGvy
 Y5Uok2CnRSlO3JhCNIEYMLnAUH8uCfMsIIlgifMJrQfJrprG0Ck4qu8Yz8aSx+wJE4NW7Aa
 X0VZyjUDqgf4+qifqtbwDK44NHFAaf9dLLDNt6pnxaYXk/sIaSXLz4OYSpAKzLuypbWWsDP
 exbh59sYUWBTE2JhTjbhQ==
UI-OutboundReport: notjunk:1;M01:P0:isxEHFQiltc=;bgO/0Xo+1wUaV+mwEQBP8hnhwPl
 4tAxG+7Fhb9ubKHwsgewihLJ6Rmv/J0S7NS+znhlxaQ9SbIBHC8jHiBX/MDB2bfideesnxGxZ
 N71wdqIOZDp1TKCQ3tpj3NzLuK4/frkOQO88IbAz+mcw4pkfiRycVTBGpeOpxXStge7b0bnuZ
 69EP4IaPi5eELdNROeBxRb9gZoAJ44zKtuPn6evtqrukfxJDM5J1fqGM3+9kmzjd/txjIBjxl
 AAgP+eVOpj6X4qxI8XVBMngDAr975gzUZoqugZu2q/XlbU1cdMAtdH9gZ7tHeboFuigYqF8te
 YhsI3Ed9sSJuvQWAwKn+Ayxu/fzkrHX4i+CNPKos9lsgZa85dtOHA8wfab9UPC3qQlanipxWG
 wlNjUHu50EXBDiFHxpuBxRs6OcD54r0l2RwW/MVnuVgF+UFSErnjTitpdjBBiQClufQxG0M4j
 9S8NzLXoZAaKwWqDV/3V68s/fc/Q4DUmKc++rBbOGQSYHD01yMDxDvB6C6Mufnvsr2cl1ZDZx
 oay2RZ2bJoQMx0F20llLMVugs3DCI5iylh5Q4uZye2W5lahiCNAVXmFnWFqne4nIQbqqdRoLd
 y7Wnvhgit7cYGSVBihyh0qCb1Bm1IqCXzOAM4+OxI5JTAlUKXZMPBk7Oji7whun927DGw01Qt
 rK0Yuxfjra1+qAZtciQMUolLHY+E9ge3B1n7yXTXi9CGl2MO00Wl5AzVqDCyqSKx+1KvA97QI
 qJoE4E+LTmgQ8TMKUHV9TzupjT8eo6k6wVU70zobxL7Xp4PV6BsaDc30Q+eimHqYKFN1tvQTn
 f5RQ7mrmMl9RzZJYdsTHZrRZZFRDgzs1/6gVqw+5PH+Zl/V9W5kxavf5zVNrXuIGWEMc8yy+Y
 OgUwzGv1PCQqvUdBeyM1GIl/HtENoXA7DqN+HjEBXuvqaCoHqj4VdJpoHsoWBlbELv/3c3nnq
 +i+msg==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 11:36, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/imxfb.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index adf36690c342..517eb65bbaa6 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -868,7 +868,6 @@ static int imxfb_probe(struct platform_device *pdev)
>   	struct imxfb_info *fbi;
>   	struct lcd_device *lcd;
>   	struct fb_info *info;
> -	struct resource *res;
>   	struct imx_fb_videomode *m;
>   	const struct of_device_id *of_id;
>   	struct device_node *display_np;
> @@ -885,10 +884,6 @@ static int imxfb_probe(struct platform_device *pdev=
)
>   	if (of_id)
>   		pdev->id_entry =3D of_id->data;
>
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENODEV;
> -
>   	info =3D framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
>   	if (!info)
>   		return -ENOMEM;
> @@ -970,7 +965,7 @@ static int imxfb_probe(struct platform_device *pdev)
>   		goto failed_getclock;
>   	}
>
> -	fbi->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +	fbi->regs =3D devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(fbi->regs)) {
>   		ret =3D PTR_ERR(fbi->regs);
>   		goto failed_ioremap;
> @@ -1043,7 +1038,6 @@ static int imxfb_probe(struct platform_device *pde=
v)
>   failed_map:
>   failed_ioremap:
>   failed_getclock:
> -	release_mem_region(res->start, resource_size(res));
>   failed_of_parse:
>   	kfree(info->pseudo_palette);
>   failed_init:

