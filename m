Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1073FBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjF0M2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjF0M21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:28:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D72706;
        Tue, 27 Jun 2023 05:28:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98e39784a85so464370566b.1;
        Tue, 27 Jun 2023 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687868902; x=1690460902;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tATW33xeNVNgsfO7kNHXzZcJ0gMJZAgbl6N8NUDs/RE=;
        b=nTgRcX6rj9m25biFDQ+GiAvKhgT0s6sBGS6wrujE1mq8fwQT6kRc2XDapu/rPo8fL8
         TOxxqyYuW83myTjNO2zsFHsxnECDbWMByunXlwhcMgJ9OWBYvSjR/cR+spB2ID7evDH1
         OLEXKUcNvl3nZanq1vBw4Dw032wAvP8JN0Mr/KQd6Xp/uDnD8rN9ALfDHFKZVkS+0qQQ
         jhw9/ZSEcTDcsYy2cuplY3aXpxsr0PCAIo5d/c+XC+z5mViBhOmNOWtX5FsseQrN0mcT
         mArBBcgKnUNZEatu5TFYez+CL5SvlNlpE1JaDwwhaqb/+KaT30faRv1G8OU5CMqcoebv
         aOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687868902; x=1690460902;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tATW33xeNVNgsfO7kNHXzZcJ0gMJZAgbl6N8NUDs/RE=;
        b=Nlft5zqcHq8OM9afHRv3pDTltvAa546WZt46MN7EkqDXEkJ6SGetleOQGNJz185de9
         sb91EH4tJSBzoZHlFio55q+h/mrE56Hx2SgShf7FDrsXDsGG85RzUN2yK9q/pBWjXpZz
         6LO2CrwRFiIyMYiu+Q6OfJbEycxSKIDdmlL2GFicfZd11fKrquFoU0BPyLHaYZX0ZYR3
         5JuJ/X/0Rrnuyc7orMJa98Bj3h57iP53v7tajVcfPVykfLg9J0sXOJwnrjGJUQjTAALE
         8DFD463U1rK9R0soWuhZPzeRKJDa8jieDSljQQyTWfs5KG8igCh2iKYCwREWg6Qq/dW3
         pz8Q==
X-Gm-Message-State: AC+VfDy90bczbj7NrAFo8mFJkgt+YMtSOVahwgx1SlcGxkhJA7aDNxeO
        OuEK5XF5A5WjED/G/x1/tD3UBlKlucpoR2Qtd+Q=
X-Google-Smtp-Source: ACHHUZ5ApV7cvX4Q3CRArtLi2hrH4sXtiyypn8GcRYX+zEVHohR2QS2IdF+C/5GXLK6stLqSbf/y7TRXavlF2dEF0ug=
X-Received: by 2002:a17:907:7ba5:b0:982:4b35:c0b6 with SMTP id
 ne37-20020a1709077ba500b009824b35c0b6mr31461984ejc.1.1687868902416; Tue, 27
 Jun 2023 05:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230627081002.1768990-1-yqsun1997@gmail.com> <20230627104237.GA3601890@gnbcxd0016.gnb.st.com>
In-Reply-To: <20230627104237.GA3601890@gnbcxd0016.gnb.st.com>
From:   sun yq <yqsun1997@gmail.com>
Date:   Tue, 27 Jun 2023 20:28:11 +0800
Message-ID: <CAA0BgY_bKg4qXmtmWqHQW+EOvfXUG0FqRtAJ7A8C40uL1v8qVA@mail.gmail.com>
Subject: Re: [PATCH] OOB read and write in mtk multiple places
To:     yqsun1997@gmail.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 499671216@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE, the number of planes is
controlled by the user. Only checking the oob at the function may miss
other functions, so it is appropriate to change the size of the macro.
You can refer to other functions, such as
mtk_dip_vb2_video_queue_setup, the max plane size of this module is 8


On Tue, Jun 27, 2023 at 6:42=E2=80=AFPM Alain Volmat <alain.volmat@foss.st.=
com> wrote:
>
> Hi,
>
> I had a look at some places where this macro MTK_VCODEC_MAX_PLANES
> is being used, such as q_data->bytesperline etc.
> This patch seems to be increasing the table size from 3 to 8 but,
> if my understanding is correct doesn't solve the issue that
> (taking the example you give in vidioc_venc_g_fmt) the table
> bytesperline is accessed taking into account a num_planes values which
> is unchecked if appropriate for this driver.
>
> What are the 8 planes you are referring to ?
>
> While increasing the table to 8 might also be necessary, it seems to me
> that the real OOB access issue should be solved by checking the num of
> planes value.
>
> Regards,
> Alain
>
> On Tue, Jun 27, 2023 at 04:10:02PM +0800, yqsun1997@gmail.com wrote:
> > From: yqsun1997 <yqsun1997@gmail.com>
> >
> > The num_planes max index is 8,
> > but bytesperline and bytesperline in struct mtk_q_data,
> > The max index is MTK_VCODEC_MAX_PLANES =3D=3D 3,
> > so will cause OOB read and write in multiple places.like vidioc_venc_g_=
fmt
> > same as commit 8fbcf730
> >
> > Signed-off-by: yqsun1997 <yqsun1997@gmail.com>
> > ---
> >  drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/=
drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > index 9acab54fd..c2c157675 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > @@ -22,7 +22,7 @@
> >  #define MTK_VCODEC_DEC_NAME  "mtk-vcodec-dec"
> >  #define MTK_VCODEC_ENC_NAME  "mtk-vcodec-enc"
> >
> > -#define MTK_VCODEC_MAX_PLANES        3
> > +#define MTK_VCODEC_MAX_PLANES        8
> >  #define MTK_V4L2_BENCHMARK   0
> >  #define WAIT_INTR_TIMEOUT_MS 1000
> >  #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >=3D MTK_VDEC_LAT_SINGLE_=
CORE)
> > --
> > 2.39.2
> >
