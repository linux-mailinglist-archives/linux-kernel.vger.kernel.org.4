Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204476FEB69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbjEKFuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEKFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:50:36 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104952726
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:50:35 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-44fd3c2300dso2953127e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683784234; x=1686376234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TZUTUOuw8gS3YY4QfM/+qXEJz2gQxAmQCsDAHLbmhU=;
        b=cmQ4baQnxQ6OJaWyiKd9TwKrwVLa3z9moGFNjZHUpOJdcpGwRAgzMMUDJZMnfbWv8J
         QGiI7irEoRuJrTYfRvNNvXnt4McMMkn6LRHsWtp6fbJHSE0OkTfKZBk9uWpVHzEP7euO
         N/kNcWjhR6aHrPQP8chTmD6UOlmnRpa+cAmiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683784234; x=1686376234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TZUTUOuw8gS3YY4QfM/+qXEJz2gQxAmQCsDAHLbmhU=;
        b=YfZYGnZKUxUqwATSnXvDHNovcE8eCagFgvA6Q+l4j4akkW65fhm0N0/DgOjJMMF88u
         us15NY1z1JTygfQI2FeHRxoH+2hv3i8dqq9y+fUARj89YKh9SziLZFToUeTRkhAppPSr
         yCPGesTUBHOpG58mhotpdQo0yPYyLGGWJXrARPlO1zTCNtPX89+fCDalOMQyooU/Y3K5
         mxHEfXSFy+l/zfP98A7Z+pS0Q+mbl1Det9qOpvOr3nW6gb6w9BZMT9X8UiWW5Cu+cJll
         SKC2WEeFxZyEYzQOVvvZXv+pKTtzk4oOn2BtfBgxPSSFEgJxnRxOldilqhhpj3tWYnDb
         sGPg==
X-Gm-Message-State: AC+VfDxhJM5k8Hgj/2R3LaHfGwJtz3DDGjcui5lSe9Zdwg107pHrU/am
        S0oQIb6asv0tWucBT99QsI1hbSy4R3N3mbkzxHZugA==
X-Google-Smtp-Source: ACHHUZ7fGE4nB3zdLHbvSnPzibOTMUdkLYtLPvJiu7zEMVz/OES4+wnOovyGzoWDL0QKVJZH9Czbi0nR2DM+Cg67Ouk=
X-Received: by 2002:a1f:3f8a:0:b0:44f:a64b:479b with SMTP id
 m132-20020a1f3f8a000000b0044fa64b479bmr6002540vka.6.1683784234113; Wed, 10
 May 2023 22:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230510233117.1.I7047714f92ef7569bd21f118ae6aee20b3175a92@changeid>
 <20230510164330.z2ygkl7vws6fci75@pengutronix.de>
In-Reply-To: <20230510164330.z2ygkl7vws6fci75@pengutronix.de>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 11 May 2023 13:50:23 +0800
Message-ID: <CAGXv+5HBM+eksJaxL2GqLfqSmK8vsQx5NXHfhe075HkOK3vjHw@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Convert mtk_vcodec_dec_hw
 platform remove callback
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fei Shao <fshao@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 12:43=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> [expanding the audience a bit for more expertise]
>
> Hello,
>
> On Wed, May 10, 2023 at 11:31:35PM +0800, Fei Shao wrote:
> > This aligns with [1] and converts the platform remove callback to
> > .remove_new(), which returns void.
> >
> > [1]: commit a3afc5b10661 ("media: mtk_vcodec_dec_drv: Convert to
> >      platform remove callback returning void")
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> >
> > ---
> >
> >  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c=
 b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> > index b753bf54ebd9..bd5743723da6 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> > @@ -193,16 +193,14 @@ static int mtk_vdec_hw_probe(struct platform_devi=
ce *pdev)
> >       return ret;
> >  }
> >
> > -static int mtk_vdec_hw_remove(struct platform_device *pdev)
> > +static void mtk_vdec_hw_remove(struct platform_device *pdev)
> >  {
> >       pm_runtime_disable(&pdev->dev);
> > -
> > -     return 0;
> >  }
> >
> >  static struct platform_driver mtk_vdec_driver =3D {
> >       .probe  =3D mtk_vdec_hw_probe,
> > -     .remove =3D mtk_vdec_hw_remove,
> > +     .remove_new =3D mtk_vdec_hw_remove,
> >       .driver =3D {
> >               .name   =3D "mtk-vdec-comp",
> >               .of_match_table =3D mtk_vdec_hw_match,
>
> While the patch looks fine, I wonder if having a remove callback just to
> do pm_runtime_disable() is worth keeping it. Doesn't the core care for
> things like that? I grepped a bit around, device_unbind_cleanup() is
> called after device_remove() which calls pm_runtime_reinit(). Does that
> mean calling pm_runtime_disable in .remove() is useless? In that case,
> you could just drop the .remove() callback.

Maybe just switch to devm_pm_runtime_enable() on the enable side?

ChenYu
