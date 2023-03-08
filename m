Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234D96B14BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCHWGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHWGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:06:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC51EC78F9;
        Wed,  8 Mar 2023 14:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678313154; i=deller@gmx.de;
        bh=KiCVvUYymv3ZDP5Dqv97SnkeHUGlZBmYwTatTeIiUko=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gRY81qv5Foi33FJWYnebdkpevVbHXg4100pUIu2LIyHygMxZTIFsBpgeXL/T/W35e
         uryUpTAAmqswaPthJ3atVJjuGEId90rDTkMi7Y8Av0G0pugj1HnFLAueuFmk8O6zMZ
         l6YBxWiEsVuxjTo+ajCoOwGaxjG3tIlSVRlAj2IUOR39At795eW3HS1GQsvfSn4MjV
         XmK6Of2ukPYnwIwc2ZRxixi+zogUgBvQ43zKWFHGspzaq/78LjiOU3E/TMzqMQD5Nm
         P/osPbECNrno/tBWTDKPmTYre01MDMQ4Rzotrg08s5AuFHSAxnNtdEwSZ7JAakhjMn
         ZtAotrzarC7yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.151.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHAH-1qBreD3FIR-00gmWh; Wed, 08
 Mar 2023 23:05:54 +0100
Message-ID: <123a52d8-baf0-e32b-3262-1e8619b1c3ad@gmx.de>
Date:   Wed, 8 Mar 2023 23:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] fbdev: tgafb: Fix potential divide by zero
Content-Language: en-US
To:     harperchen <harperchen1110@gmail.com>
Cc:     javierm@redhat.com, tzimmermann@suse.de,
        wsa+renesas@sang-engineering.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230307130856.2295182-1-harperchen1110@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230307130856.2295182-1-harperchen1110@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IdUOlwZoj5bhTPGnl9poGNK8wqEf95a3RUGpT3QzZH6Y04qhfaU
 VKPgXLA942WRURGMySDpqHMlIV8FWkRfnkGbcwTe0eV3GnycTqCFrM6fN3cKfjHFdIm7sJx
 PX8cq+l4uUdmJ7evOd2QHlaUpTJ+Xf5O505MlnpdVd0SWZptr8LvG+fwlmHCYrZEZ54GfLd
 5egDILNkIqIPk2EGzDnRQ==
UI-OutboundReport: notjunk:1;M01:P0:i15z1BQTo40=;Nnoeww3xvEHJ7JdrpRvKGdo54vG
 ggP3lJnH9ihek46GgmRojfByeMJoPNQ5kNs2AB42895D8CPAaXieAG4MrFqY3SCnphwirO6sc
 UKUj6D7H0c5OeGrRZ6aPlYiviHwbapsCV8dmEdFER2+UpTJ8a0B+hdI5kAczey022Aydx3pUz
 K9dyIQERQgbeiKr0q8WajbH4zAOtH8O3G/FPRy5oEsWnO7bc8bDeaimi6u+pXQ3JLG3Yvts7J
 Kk2CvhwPrf5deZ69mHLxfB70ps67iTw96nSeuRxZmqWZ9XzTtcWOssCaNN83vx2qp1kRUaYqy
 RLSzi/xhZGrRk7UtGsLZ9TnErsxNzLzzVOvd1gc+UvaDD8M0jEoiDTm1bCi+w8LYgRsHbp17F
 EdtwpkfqpCpY4FYEYkPc3+Y3+MrnoPFUYV5/pqDxGo0mPhVAe9M7NzG1sdz4vG0bLgXDxkoF7
 3DbqeEat8TyMBy9zyvtYVI49do+U3FGiOwwQC+xSIbh4c9cYA0tC5F3M5FHiUqzVD2Nq9MhTw
 jtwpd6nRJeYulYT52jR6G3V9sQrokS1i6a8UDMlm8ccnR1vqwRm7UbyG1IlwVIww7LPINwKYt
 NdmXTdx+seP2LqTB+fIw+e6gf0yQqmsv3OryVuDC7WVM6DEpNa86ccszNMvFi8O374nsPC6Ve
 Sf4S2WId5qkrYJ871c0wm9h3xG79z/q/REf/fPch+dz/Bdc53YnOuUG5V3EnfMzXBUQAdhNNk
 0Ad/3XOT2h1LZsSNYGlRA9/syLrcQuDRTOZKD9xXOMprouORp8SDMBtkV6p3JII/7p1DlPtrl
 nDOI00W6iLeF5DWV7XVZGGH42jrdfKstspOyn/sEbStF5SlcbMecBlmdLhf+z/YUTS2hgMI2Y
 W7s3IZUfrR9y3vObkY5cUtnAQ+di4V2AN5RTfevKiMGEigZyMMvtz13MY7Z4YiTpm5k0rJrh8
 yg78aDgiYCztvklWUW20lmO66sw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 14:08, harperchen wrote:
> fb_set_var would by called when user invokes ioctl with cmd
> FBIOPUT_VSCREENINFO. User-provided data would finally reach
> tgafb_check_var. In case var->pixclock is assigned to zero,
> divide by zero would occur when checking whether reciprocal
> of var->pixclock is too high.
>
> Similar crashes have happened in other fbdev drivers. There
> is no check and modification on var->pixclock along the call
> chain to tgafb_check_var. We believe it could also be triggered
> in driver tgafb from user site.
>
> Signed-off-by: harperchen <harperchen1110@gmail.com>

Could you provide a real name?
Otherwise applied to fbdev git tree.

Thanks!
Helge

> ---
>   drivers/video/fbdev/tgafb.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
> index 14d37c49633c..b44004880f0d 100644
> --- a/drivers/video/fbdev/tgafb.c
> +++ b/drivers/video/fbdev/tgafb.c
> @@ -173,6 +173,9 @@ tgafb_check_var(struct fb_var_screeninfo *var, struc=
t fb_info *info)
>   {
>   	struct tga_par *par =3D (struct tga_par *)info->par;
>
> +	if (!var->pixclock)
> +		return -EINVAL;
> +
>   	if (par->tga_type =3D=3D TGA_TYPE_8PLANE) {
>   		if (var->bits_per_pixel !=3D 8)
>   			return -EINVAL;

