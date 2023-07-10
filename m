Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C6E74D254
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGJJzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjGJJyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:54:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E283C16;
        Mon, 10 Jul 2023 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688982585; x=1689587385; i=deller@gmx.de;
 bh=3Fhk4S+KBpOnob+kEitQvs6om2f8v6w/tRZ9oWyic+g=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=rIlLn6b29I6Ct09EJYNArofs8uticSLQ2GcOTXsnKAeI6CQINWrD1HXivM2tQE/C5UV12by
 AQDPgK3+wxn4PTHC8aWrPGrT66vKg0N7td+r7Ay4g8FRqb0XdysywzBag0LMrVWUuGMbzfmKT
 8hidQ58vTDCgYFTb2MVnOKjcODlF6EEwQMgqzaJ9/Hc5PHJv6KbN2v+vV1Wkb6SA8KM4pz4xc
 jzR78KXrL2MoFMEP6qr/GF0BrY6x7H94xwBKkB4OKez9VYdIZ5Qupd0Cdwj2/9LDindQIrGHC
 qYkFsD5akq/hyqqEPs+un2jHdBJKHtHEiUolQtG2zJrsY14x/nTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.196]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1qXJbP3tlb-00KeCK; Mon, 10
 Jul 2023 11:49:44 +0200
Message-ID: <375f48de-8093-a540-b78c-e90d57cfbf27@gmx.de>
Date:   Mon, 10 Jul 2023 11:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fbdev: imxfb: Convert to devm_platform_ioremap_resource()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20230704093652.18191-1-frank.li@vivo.com>
 <CAMuHMdWrBY1+JDuwODyqLrwJJivt=ewCOKfK41xq+0Hpaf8akQ@mail.gmail.com>
 <da543602-f88e-45ee-d7fd-8fddd0b0ac56@vivo.com>
 <CAMuHMdVa3RmtFouTYk_rPoxO1EswGzTtt855-eFcvtTYObgUCA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAMuHMdVa3RmtFouTYk_rPoxO1EswGzTtt855-eFcvtTYObgUCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DsiWJcWkamKBqNIa2GdiC72CIgoQwSWSK1m6aAfAC0vch6GdTrs
 sIlHka91R5JbhbzUUBAz4dIpvs2cEIwaJ7AjNg3TXv8DKpvFtgG0rYeBi+nt7DmrP/w4YN8
 ptwjV0czdgK0UCysI0BBunVyxZmKdcqtv5R28Kr+2S+vAmkI48AinyiE+7dfxAJK3lI/02W
 cdX7VM8QtUSYk6ybr8QZQ==
UI-OutboundReport: notjunk:1;M01:P0:U8Djpdcbr3g=;4HQKtk8oZRgrTXuEqs9zKM185TG
 5Z5uiyYmJ5ytgCE0KzhutdG/0FUntlRUmL6/sI2rPnnWjatXIlRg7Y76OpQ73DtRSEtxU7x33
 uHMzzgkZU3kS9Ju5RoFnp+8WYxYqjLahlyBsf96t6j5J+cnolZ8qrlQM/sNc1PEvZVtn6prbG
 SBdHmco1xtupqjNhS+aavds4wCo92wCmrMYricknDdRRjsAvYHdUNWgczOBXnJO12afy9Zjw2
 p+2ab4rMVBPQDeqDO1yV6vFj55ENdRyJ7V+5gXwzusQ5NBRItzH5bC+u8H0mLtgZy7npvxaZG
 kTfJBUJEOJ7jaOaettIrmrycb0tQgdenFLUhlsDpuqPf2KqXqoU+xDFPlvaNraRLkRMbp3J7B
 IZtqOBOSXiAmJTsPjUezdbtPWnjybhkBy3lVeKEh6+1gyRodoZV9IzU6YDvyv4hbKKS927XLe
 4mhFi9qXGLQtPObX/977jTC+CSBlTKJakIj/y0r1E0cImnFrE97ZzX7raJu30Eiiz7483yzzi
 gto/HS7DpKMIGDhNAIuCR8SdggZT6qImvp8GK4MNzwmJx5PP1reIj61TGqxPfWMpjvx812NgD
 T6MpdT0DGMgh12y8jQt2rAfMv/3ckMknXLfWk0BnF8wYytd45EebwsljhI31TdcBGq0XBlz7v
 PDXiysDMV9Tb+T7YiiGSncTFS7bzPb2Kzwa6uoN4dChrcoZ3aCV53KAB/2/8MJse4QFBdGNcP
 7GVeQXlmBHdv0Mp6teTuGzc6dTdNY/HRTEZWjVTFHGUqiIPCmGmzRVUhu6+GfrgNsxGy7914E
 g5w2OzPdDFGxBvqCjDR3LZBo+NWHMm87B+6okXQDwfIo5xI1GAz0y6pY1Pn9+hRT/FNLKwpHs
 hQeTZwgK2Joc7p7Q+zRYP3BynyXKBzuyCEeS67Bi+z4FUHZUT2Rp4MEXK7poQQTKc9YLM0k/M
 WktucR0nhQtfV5WFJ4fJ1HxoJlk=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 09:41, Geert Uytterhoeven wrote:
> Hi Yangtao,
>
> On Mon, Jul 10, 2023 at 9:25=E2=80=AFAM Yangtao Li <frank.li@vivo.com> w=
rote:
>> On 2023/7/10 15:10, Geert Uytterhoeven wrote:
>>> [=E4=BD=A0=E9=80=9A=E5=B8=B8=E4=B8=8D=E4=BC=9A=E6=94=B6=E5=88=B0=E6=9D=
=A5=E8=87=AA geert@linux-m68k.org =E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=
=BB=B6=E3=80=82=E8=AF=B7=E8=AE=BF=E9=97=AE https://aka.ms/LearnAboutSender=
Identification=EF=BC=8C=E4=BB=A5=E4=BA=86=E8=A7=A3=E8=BF=99=E4=B8=80=E7=82=
=B9=E4=B8=BA=E4=BB=80=E4=B9=88=E5=BE=88=E9=87=8D=E8=A6=81]
>>> On Tue, Jul 4, 2023 at 11:38=E2=80=AFAM Yangtao Li <frank.li@vivo.com>=
 wrote:
>>>> Use devm_platform_ioremap_resource() to simplify code.
>>>>
>>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> Thanks for your patch, which is now commit c1cd7a7a231a26c6 ("fbdev:
>>> imxfb: Convert to devm_platform_ioremap_resource()") in fbdev/for-next
>>>
>>>> --- a/drivers/video/fbdev/imxfb.c
>>>> +++ b/drivers/video/fbdev/imxfb.c
>>>> @@ -868,7 +868,6 @@ static int imxfb_probe(struct platform_device *pd=
ev)
>>>>           struct imxfb_info *fbi;
>>>>           struct lcd_device *lcd;
>>>>           struct fb_info *info;
>>>> -       struct resource *res;
>>>>           struct imx_fb_videomode *m;
>>>>           const struct of_device_id *of_id;
>>>>           struct device_node *display_np;
>>>> @@ -885,10 +884,6 @@ static int imxfb_probe(struct platform_device *p=
dev)
>>>>           if (of_id)
>>>>                   pdev->id_entry =3D of_id->data;
>>>>
>>>> -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> -       if (!res)
>>>> -               return -ENODEV;
>>>> -
>>>>           info =3D framebuffer_alloc(sizeof(struct imxfb_info), &pdev=
->dev);
>>>>           if (!info)
>>>>                   return -ENOMEM;
>>>> @@ -970,7 +965,7 @@ static int imxfb_probe(struct platform_device *pd=
ev)
>>>>                   goto failed_getclock;
>>>>           }
>>>>
>>>> -       fbi->regs =3D devm_ioremap_resource(&pdev->dev, res);
>>>> +       fbi->regs =3D devm_platform_ioremap_resource(pdev, 0);
>>>>           if (IS_ERR(fbi->regs)) {
>>>>                   ret =3D PTR_ERR(fbi->regs);
>>>>                   goto failed_ioremap;
>>>> @@ -1043,7 +1038,6 @@ static int imxfb_probe(struct platform_device *=
pdev)
>>>>    failed_map:
>>>>    failed_ioremap:
>>>>    failed_getclock:
>>>> -       release_mem_region(res->start, resource_size(res));
>>> This part is not directly related, but a bug fix for commit
>>> b083c22d51148f3d ("video: fbdev: imxfb: Convert request_mem_region +
>>> ioremap to devm_ioremap_resource") in v6.0.
>>
>>
>> IIUC, split this patch into two, remove release_mem_region in one and
>>
>> mark it as Fixes: b083c22d51148f3d ("video: fbdev: imxfb: Convert
>> request_mem_region +
>>
>> ioremap to devm_ioremap_resource")?
>
> Exactly.  But as Helge has already applied this patch to his tree, we ha=
ve
> to check with him if this is still feasible...

Sure. Just send them to the list and I apply those patches instead.

Thanks!
Helge

