Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F96266176B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbjAHR1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjAHR06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:26:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0104CE12;
        Sun,  8 Jan 2023 09:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673198777; bh=7v/7zj2Ysz+/w95b1kVq+oD2bzqjczc2L3mL7k87WRA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mSEqKLllgfaugEUfwK1DpPrKag9byMTMLILVvzboSZPDzN7DwyzMSecpRQMcjBYxj
         pj0rdSo5U+fSPsljmVc1C0LFpIrSqT5w6GQQEg6m4+o2U+egvvGryWEidj9Z/drf/H
         guX99U+MmRRs1DE6MyCFachtRZamU6Can45Erl7Smo9trEl/NAdVk+l2hGvseDGxWv
         /M95xPilavrfcFC9obqbWatVy3RU29HQJA0QvQp6dbs8gwmdoRcNfNxZwWPiwgEfYu
         ca8AHIT5Aev1OAO29txxakpsD1NwmxZ6ZTlt+dRXHASiC7ZTMP/+PeeBVO1v5rH3Y7
         tDSPYx2XGQBjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.135.194]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1ogbfA2j3d-00amNL; Sun, 08
 Jan 2023 18:26:17 +0100
Message-ID: <811a392a-d634-5557-dd58-57f1580e28f2@gmx.de>
Date:   Sun, 8 Jan 2023 18:26:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 01/15] video: fbdev: atmel_lcdfb: Rework backlight
 handling
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>, Stephen Kitt <steve@sk2.org>
Cc:     Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-1-1bd9bafb351f@ravnborg.org>
 <553AE999-CAF1-4E59-9F3F-68591ED192DE@sk2.org>
 <Y7nb2q6SDota/rTU@ravnborg.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Y7nb2q6SDota/rTU@ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T9uileinKOrfmfXULyUKIEJ7Q5sw2pWalYogfbz1gtzJSOq1Nnk
 V1Zd+9ekAM/oEwNZj1ns1vPVvUAvy44ZTl/BH109UTdaVmWLFROcAvtyBj2aiXsnhpoNIYK
 f6LsM16mV7xk2n5D7VSkS/fvq9QrFB+Qsr4JdY1dEhwACqZ+EY+1G3NYsfmX6ypM+wH5gFE
 /7WyOoTkU98Aw7Eoh7DaA==
UI-OutboundReport: notjunk:1;M01:P0:6EvwsDxHCUk=;/ufhnGN+zI+oDWZwCc4k4w2CiV6
 QrBtAZx6984DADkmIhmphyAOMnO+EsKjlmNqXIClAaw7V8tj9JPpHNARsM246kng951NRk2oi
 /byMbKSDYi8rsJz7nXc/8KdnxSv+1burzS9rBLLQM/SSTUMuQUByG7DylwBo981H4z994LqZg
 KLx+5Rc+JTjZRTHm7FAkEiXfexyhIuoMWuFoc8+oJtEX8HPb5zhB5OYNiVjMNrPqGx2C+3K7v
 sAZWfQ7gadJK+ycK0a+DF6ZK6q1LsCz+1WRS2kTIc9PJ8/LSLnFu85kOu+o+9tCNP4DY5zQ5p
 NhGfVTn5bxnME9Sfjeg+9Tr9u6dO9obRYORwJqPjaDTe9+CZNal/yd1ZwaAro20jGQk4TVyDa
 LkGBCsyMdaLmZYKdXXuZBayAMT8PyJ9HI4w/2Y3jeySKFTrrCPt2MgKeLt5Cqy6vUEvLdAXC6
 y0Ril9BxeR4vpeFvuNrwd4GuHDQngvSxVPqvMgf9aMfVU/HTZ0ND9Ff0zHT5k+CYIfU9ozKXw
 WAJ9oQAhGTIpHa1DGlP6FNxdU0ewRRtrxDez7r0n0fX2Zesqdwb93PvYFJUz/NaUPU2MoemBZ
 PtnNHPXybe5g2TGiVP5ruaDYkd/2yG87qwT269V9l+B2aBIckWPR8RiFPdO+VgqKSSRILZAvu
 Xcsx1fp/7/gviRZ9yGN1JlA8f+Dfko5WDu+R0kGU1IgSRGJ3aNB9IlxTKhDshTXZ446gME2//
 HQlzmCrV6kWA+h8ISQpNIPgwhV/sb1/m7HSHW3yfdftuO+AaZA0FhJ/kKMk+6QHaigTShvBIA
 dfiV4QG0v6WifGj7P5cbgofBhvUlZ3ZDqiloZyOB5ccr4M3sIufP2OCBfjm0AXFsWAIChC2Cg
 bC7QBlhaNveFAmYsdFSSPtz2++nCIfoAnf+6cNmVDXN3eAGT4HtkCZDEmS/w+OGm4ZNZAzGPW
 BztdIqZ4VB6gHHWaPzjmxy5jaag=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/23 21:53, Sam Ravnborg wrote:
> Hi Stephen.
>
> On Sat, Jan 07, 2023 at 09:36:47PM +0100, Stephen Kitt wrote:
>> On 7 January 2023 19:26:15 CET, Sam Ravnborg via B4 Submission Endpoint=
 <devnull+sam.ravnborg.org@kernel.org> wrote:
>>> From: Sam Ravnborg <sam@ravnborg.org>
>>>
>>> The atmel_lcdfb had code to save/restore power state.
>>> This is not needed so drop it.
>>>
>>> Introduce backlight_is_brightness() to make logic simpler.
>>>
>>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>>> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
>>> Cc: linux-fbdev@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> ---
>>> drivers/video/fbdev/atmel_lcdfb.c | 24 +++---------------------
>>> 1 file changed, 3 insertions(+), 21 deletions(-)
> ...
>>
>> Hi Sam,
>>
>> I=E2=80=99d submitted quite a few more of these previously (and you=E2=
=80=99d reviewed them), see e.g. the thread starting at https://lkml.org/l=
kml/2022/6/7/4365, and yesterday, https://lkml.org/lkml/2023/1/6/520, http=
s://lkml.org/lkml/2023/1/6/656, https://lkml.org/lkml/2023/1/6/970, https:=
//lkml.org/lkml/2023/1/6/643, and https://lkml.org/lkml/2023/1/6/680. Ther=
e are a few more, I can find them if it=E2=80=99s any use.
>
> The patches from yesterday was what triggered me to resurrect an old
> branch of mine where I had done something similar. I had lost all
> memory of reviewing similar patches from you.
>
>
> Helge - could you pick the reviewed patches from:
> https://lore.kernel.org/all/20220607192335.1137249-1-steve@sk2.org/
> [This is the same mail as Stephen refer to above - looked up via lore].

I just pulled those 7 patches into fbdev/for-next.
If you need more, please let me know,

Thanks!
Helge


>
> Stephen - I expect Daniel/Lee to take care of the patches from yesterday=
.
> If you can look up other pending patches from you please do so, so we
> can have them applied.
> Preferably with links to lore - as this makes it easier to apply them.
>
> Review of what is unique in this set would be appreciated.
>
> 	Sam

