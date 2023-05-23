Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A0070E03F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbjEWPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbjEWPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:19:03 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B50818B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:18:49 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-335394455ecso6863245ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684855128; x=1687447128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjyn+WTl4LbVMkNNCokMveD7xNAakP9qnkKqL3vwETo=;
        b=DvPI8gg5hq1vkC+t7ecoxjYXYOwjdo1b5OHHOMFEmQPq2gaQdw9jvvEYMWz1Lmd8uh
         LaEo2pdjq5di13xvQ3PpP/aXcRrVUgiRzAgzdU+22cE8vmY5YTSmAi4+h8uWo0Qsd2Sq
         MGz0CgN1AQrG5u7daIXmDLyG3TJUCSgExx72k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855128; x=1687447128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjyn+WTl4LbVMkNNCokMveD7xNAakP9qnkKqL3vwETo=;
        b=jgy4lvjgTj7aZR7v2O6B3KdWO+qr8Ja+r9KpBS0gm3YJ5EYBTzdhfOaxKTa4R3Z/7T
         WMK6FXE+fXHiFS8iJ7Fct6SOUo/fljM27SFq2aaQSDm4RQIn279T4NG04gY8AlzJrasP
         sGmFyBFKa8ihSel1TrugnwtU9ip7rowdaAu8Ljt/84nL0th/PmlcnsPQiH+yvWriIuU2
         URjWr9jBkbSlFJ7fz4NvkBbZz5IjK5l9s7ki/hyIyt4uGEtiOJ/58qomBRCY+sLlXGjL
         JJz9Zq8OHYwtrOu2YJvEyKmyVOC5uPv7hYi8Oi9pEk54dIPcatoI0erQm4MG8bS0SqRk
         nbZQ==
X-Gm-Message-State: AC+VfDxbWpkrM4AHymFBiXQVj6UJcC9wVVEQf5oyce8SI06fOyhASni5
        7TGSBXHrTM2yUEbIpvfWV/15Al61PGlh1RpAHyU=
X-Google-Smtp-Source: ACHHUZ5vB4XXPFfM8exN8gfWxyJSCZUMOAYV1eWDKafLJWGU4RjZ3H1Tu6a8CQR5jNDIHzuW3i8GGg==
X-Received: by 2002:a92:4a0c:0:b0:339:24a7:f5aa with SMTP id m12-20020a924a0c000000b0033924a7f5aamr7052465ilf.8.1684855128464;
        Tue, 23 May 2023 08:18:48 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id y11-20020a92d20b000000b0033355fa5440sm2477980ily.37.2023.05.23.08.18.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 08:18:47 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-76fe43b85e4so345224939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:18:46 -0700 (PDT)
X-Received: by 2002:a5d:9942:0:b0:76c:62ab:5d96 with SMTP id
 v2-20020a5d9942000000b0076c62ab5d96mr11928374ios.19.1684855126148; Tue, 23
 May 2023 08:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230515141610.v2.1.I0d1657be3fea5870f797e975a7aa490291e17993@changeid>
 <b5799dfe-f17b-a838-0916-645ba83307d2@xs4all.nl> <2f1bf798-49c3-13d7-96e5-b29e7df73bd1@xs4all.nl>
In-Reply-To: <2f1bf798-49c3-13d7-96e5-b29e7df73bd1@xs4all.nl>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 23 May 2023 23:18:10 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngKqJfTh8Dnjv2yYLG0r44Yx6pw5DsRnArsJu2okoKJUA@mail.gmail.com>
Message-ID: <CAC=S1ngKqJfTh8Dnjv2yYLG0r44Yx6pw5DsRnArsJu2okoKJUA@mail.gmail.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: mtk_vcodec_dec_hw: Use devm_pm_runtime_enable()
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, fshao@chromium.org
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 8:28=E2=80=AFPM Hans Verkuil <hverkuil-cisco@xs4all=
.nl> wrote:
>
> On 23/05/2023 13:42, Hans Verkuil wrote:
> > On 15/05/2023 08:16, Fei Shao wrote:
> >> Convert pm_runtime_enable() to the managed version, and clean up error
> >> handling and unnecessary .remove() callback accordingly.
> >
> > This patch no longer applies. Can you make a v3?
>
> Sorry, you can ignore this. I now realize that this was a v2 of
>
> https://patchwork.linuxtv.org/project/linux-media/patch/20230510233117.1.=
I7047714f92ef7569bd21f118ae6aee20b3175a92@changeid/
>
> I had that v1 applied, so obviously this v2 would fail to apply. After dr=
opping
> that v1 patch it now applies cleanly.

Ack, many thanks.
BTW, besides the review tags (appreciation to all), would you mind
adding this tag also as I missed it in the beginning?

Suggested-by: Chen-Yu Tsai <wenst@chromium.org>

Regards,
Fei





>
> Regards,
>
>         Hans
>
> >
> > Regards,
> >
> >       Hans
> >
> >>
> >> Signed-off-by: Fei Shao <fshao@chromium.org>
> >>
> >> ---
> >>
> >> Changes in v2:
> >> Use devm_pm_runtime_enable() per suggestion from the previous thread:
> >> https://lore.kernel.org/lkml/20230510164330.z2ygkl7vws6fci75@pengutron=
ix.de/T/#m25be91afe3e9554600e859a8a59128ca234fc63d
> >>
> >>  .../mediatek/vcodec/mtk_vcodec_dec_hw.c       | 26 ++++++------------=
-
> >>  1 file changed, 8 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.=
c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> >> index b753bf54ebd9..e1cb2f8dca33 100644
> >> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> >> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> >> @@ -148,20 +148,21 @@ static int mtk_vdec_hw_probe(struct platform_dev=
ice *pdev)
> >>      ret =3D mtk_vcodec_init_dec_clk(pdev, &subdev_dev->pm);
> >>      if (ret)
> >>              return ret;
> >> -    pm_runtime_enable(&pdev->dev);
> >> +
> >> +    ret =3D devm_pm_runtime_enable(&pdev->dev);
> >> +    if (ret)
> >> +            return ret;
> >>
> >>      of_id =3D of_match_device(mtk_vdec_hw_match, dev);
> >>      if (!of_id) {
> >>              dev_err(dev, "Can't get vdec subdev id.\n");
> >> -            ret =3D -EINVAL;
> >> -            goto err;
> >> +            return -EINVAL;
> >>      }
> >>
> >>      hw_idx =3D (enum mtk_vdec_hw_id)(uintptr_t)of_id->data;
> >>      if (hw_idx >=3D MTK_VDEC_HW_MAX) {
> >>              dev_err(dev, "Hardware index %d not correct.\n", hw_idx);
> >> -            ret =3D -EINVAL;
> >> -            goto err;
> >> +            return -EINVAL;
> >>      }
> >>
> >>      main_dev->subdev_dev[hw_idx] =3D subdev_dev;
> >> @@ -173,36 +174,25 @@ static int mtk_vdec_hw_probe(struct platform_dev=
ice *pdev)
> >>      if (IS_SUPPORT_VDEC_HW_IRQ(hw_idx)) {
> >>              ret =3D mtk_vdec_hw_init_irq(subdev_dev);
> >>              if (ret)
> >> -                    goto err;
> >> +                    return ret;
> >>      }
> >>
> >>      subdev_dev->reg_base[VDEC_HW_MISC] =3D
> >>              devm_platform_ioremap_resource(pdev, 0);
> >>      if (IS_ERR((__force void *)subdev_dev->reg_base[VDEC_HW_MISC])) {
> >>              ret =3D PTR_ERR((__force void *)subdev_dev->reg_base[VDEC=
_HW_MISC]);
> >> -            goto err;
> >> +            return ret;
> >>      }
> >>
> >>      if (!main_dev->subdev_prob_done)
> >>              main_dev->subdev_prob_done =3D mtk_vdec_hw_prob_done;
> >>
> >>      platform_set_drvdata(pdev, subdev_dev);
> >> -    return 0;
> >> -err:
> >> -    pm_runtime_disable(subdev_dev->pm.dev);
> >> -    return ret;
> >> -}
> >> -
> >> -static int mtk_vdec_hw_remove(struct platform_device *pdev)
> >> -{
> >> -    pm_runtime_disable(&pdev->dev);
> >> -
> >>      return 0;
> >>  }
> >>
> >>  static struct platform_driver mtk_vdec_driver =3D {
> >>      .probe  =3D mtk_vdec_hw_probe,
> >> -    .remove =3D mtk_vdec_hw_remove,
> >>      .driver =3D {
> >>              .name   =3D "mtk-vdec-comp",
> >>              .of_match_table =3D mtk_vdec_hw_match,
> >
>
