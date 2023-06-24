Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BB373CCA1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 21:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjFXT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 15:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjFXTz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 15:55:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6471BDF;
        Sat, 24 Jun 2023 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687636550; x=1688241350; i=deller@gmx.de;
 bh=/Jy/sFDkn/FMoUAdBvQLhq+kBJ8hJfRSlwh0/b8ionU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=I9UAL9zv3+1qubpUKzY1NNBvcvwFyrZEd0yOy0vKPLLcdBMYwYLdKWTNbMnVIFZ47/F2ydi
 5ruFV0HsIaQs87F6dLyTtdNo4P21eBIQeHVwFxFGBo1FYxktoFA8hHdA1tWKrd7awh9RNFvfo
 Sdrm42q2LUfB/qa3Y6+GJeywMU0hsgs+SJlF/jNq+xmoffTCkz6FueLt5qoILWKrno1FbHGtZ
 ZQcCt90OVXPEyEDtNvfmOOkY/hXBq9wjd2CQAzTqIOS3vOHlILEhkxzLK17cZM10i//t8RWe3
 3s54g/mS9VSoCS6y8JcZ/dlCC6RQd4Z8uAWtjvpYgvNbKJSxKOLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.156.152]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1q04V40uXI-014BNp; Sat, 24
 Jun 2023 21:55:50 +0200
Message-ID: <bd436365-300c-a73c-7452-d874d7a279a6@gmx.de>
Date:   Sat, 24 Jun 2023 21:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] video: fbdev: fix potential OOB read in fast_imageblit()
Content-Language: en-US
To:     Zhang Shurong <zhang_shurong@foxmail.com>, daniel@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_72AB00ACD94346E10E954A42FBC6A3567E05@qq.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <tencent_72AB00ACD94346E10E954A42FBC6A3567E05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZFzdGXzQJyDkDBgdCPz4lCyWJp793REJrqk2POWCMC6OfZvNtrb
 KaH2VD/asP7C/cpMNy9XVHf3n0KkmL7Ql6QC+QkwI4GaXZusKiuv5+wtIF1faV5mr53rsY6
 AdG83D+/eKYLNYWNIF3+FaPl28rcecIBp7tZUSlHYBGkRTOPDmmyUEVOfw6DQDAD6Y0kumU
 HDlQ0EGGdpkPcSBaR/I/Q==
UI-OutboundReport: notjunk:1;M01:P0:Oi4NTdrW1BI=;1GK4eOF/eeUU09C0pNKKBkhVlhN
 nnDV4LFCNVOrGCb/SEchYVrbYKk0/pfCWkX9tQjZSRP2vV1EVY8PzpXysqW9wCLz48zIXup6c
 4QphGUMzmvTM0tcVvv6CS1gnD4N/9maOS6s7zbkcMH54NMRwjPtAT3b3VNjqVD3Uwg/HMCFKm
 XPozSYfSYEkIxTTiOry3NN2Twvei4YJLsWgiyk5gRIlmJcPbUquYaQVkK0DYfdyAMVWGLrsy+
 0Y+g84Xqm9B3G17/zz1sOgczIrep5HgKqpqLx2p/BEBmk7JFgHehmBVnouzo9AQfX5JMJ+8XN
 TRKzIkTpTroTNlAEd3Ma0kCY9BFmtKuUtXli/yeZD9fBQHxDIY5b/CakzoyseFTX5gQrbYJsr
 tlMGLoYKfdOql2UphoFh/lAR4UAdYHWGkyF6hfsc7YRNmPPA50jkVO4PnnLtruGBPZDJgjNry
 bTfweeF2sqinPHnv5f6coDSjKEoML53PdienHKhEul458yhMppTadBffgjnd8bsrKEMaJEHhn
 sXAGbPaWh0PjIoshLI0J+tD9CLkZN+qZqLXv0guMIKIYLTGz/nYDxSllSB32Tbo+c0QZ1Dbvi
 QTaibOWc/R3kpPBdUtPJ3GIhXZs0UrV1eoasgcoX7NYNIMEbap7lZ4z+OzzzGZXZ242rl3+sm
 XRxwFvdUfSGaqwEvXQzuvW5/cb4EStmePSB+arCMdMOMq3hs0LWP0HPJEWXsxmbs0NjhCx/Nn
 dbtK6duYbk1aHKhnDthF7qB+UQ0gHeyz/ouUV6j4eiU2kKch9c2v1KNdxS0HvwjA6kHBsBhm1
 0wrhXo7Fmlf3nWn0JE4YZpMsVyibZ5EjrKJXmC2ozMCQUxdh8z8jBQ04QX4HgQYLLsL9YKyN0
 UV/ha/QZ3CrzlUhuDfr6XY0w/SxS2lw3bcloszLD+bRrDnU9PUVdwZLb1iP5yqI9hsMnhrgbO
 deW2zw==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 18:16, Zhang Shurong wrote:
> There is a potential OOB read at fast_imageblit, for
> "colortab[(*src >> 4)]" can become a negative value due to
> "const char *s =3D image->data, *src".
> This change makes sure the index for colortab always positive
> or zero.
>
> Similar commit:
> https://patchwork.kernel.org/patch/11746067
>
> Potential bug report:
> https://groups.google.com/g/syzkaller-bugs/c/9ubBXKeKXf4/m/k-QXy4UgAAAJ
>
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/core/sysimgblt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/core/sysimgblt.c b/drivers/video/fbdev/=
core/sysimgblt.c
> index 335e92b813fc..665ef7a0a249 100644
> --- a/drivers/video/fbdev/core/sysimgblt.c
> +++ b/drivers/video/fbdev/core/sysimgblt.c
> @@ -189,7 +189,7 @@ static void fast_imageblit(const struct fb_image *im=
age, struct fb_info *p,
>   	u32 fgx =3D fgcolor, bgx =3D bgcolor, bpp =3D p->var.bits_per_pixel;
>   	u32 ppw =3D 32/bpp, spitch =3D (image->width + 7)/8;
>   	u32 bit_mask, eorx, shift;
> -	const char *s =3D image->data, *src;
> +	const u8 *s =3D image->data, *src;
>   	u32 *dst;
>   	const u32 *tab;
>   	size_t tablen;

