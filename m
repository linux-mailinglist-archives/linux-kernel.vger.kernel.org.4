Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15039715B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjE3KP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjE3KPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:15:22 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36EE10E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:15:19 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-438f80597d8so1430914137.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685441719; x=1688033719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5H+OM4TnsiuKpfJz2aWBvBXWEkbbF/qKmNESlsSE5fA=;
        b=Sz6j91lcjKY2jK21OT3wWr5rVvHU/KeDdCrmr+Ql3+rIcaa8cmCFleJRQrfRm5b9bD
         oP+nXq5ZT1WmXzFpvwEPRCFhl28121sSUqUFXhv4sARR2E8URLUfsTUSakRTxq2fJkhK
         fK+vSL4f48iOrblaZr3t1ihc1cVAVcE4yQoIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685441719; x=1688033719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5H+OM4TnsiuKpfJz2aWBvBXWEkbbF/qKmNESlsSE5fA=;
        b=J8fv6C8rcJORJJzMqDPQxvHkp/twUfXFROD13vzG3aKtFiE75Wsd8GuGmHWf+Zohhh
         SyomaMFwrx1E7tc3O+35cM+p16psENcfQ7SrhRUIsDFILvFx3vzcV93IlUtg7tB0hGY/
         00kIiF/wUAN7aLmAwpcaDF9aXX4wH7xt2pIWwWKWucT2S3SzAWY0oZyRr8oYBjRVv2dR
         NY86vTlYcKLRvjHuMf5O3loL3Tx+q6IZqfkPkrcmu9iK+so6epO6UM+/qC4a09nDQxyS
         q5oqXzALobrDfSk+FCi3cxWtkxyFKpRvl4vNF+1kutnu6LmywC8n45dF1BIipgYZt+/t
         laqA==
X-Gm-Message-State: AC+VfDwfmUOaPdLLsyiKIgcouH8OTbqXBybb4F8cl/5niiIk9kIw/VnP
        HZuI1iRl7UjEKuaKTmE0Nx+WtAj24nvye2LtWZnW+A==
X-Google-Smtp-Source: ACHHUZ58T5/tq/vl8scpFiVOYc5HSsRdNqgSIq8Y4CgGCHhjXslU0dbcvMkH6xW/Gx9F2Zbcj/xuTEttyO6kXmkoLR0=
X-Received: by 2002:a67:ec82:0:b0:434:50e9:164d with SMTP id
 h2-20020a67ec82000000b0043450e9164dmr574854vsp.17.1685441718904; Tue, 30 May
 2023 03:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230525021219.23638-1-yunfei.dong@mediatek.com>
 <20230525021219.23638-9-yunfei.dong@mediatek.com> <f3322e41-1891-a33b-daaa-731ec548ec4e@collabora.com>
In-Reply-To: <f3322e41-1891-a33b-daaa-731ec548ec4e@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 30 May 2023 18:15:07 +0800
Message-ID: <CAGXv+5FFS6cC+drzXfAbtoEq8b_-9sA1Ry4Xb74hndCkCNiSSA@mail.gmail.com>
Subject: Re: [PATCH v5,8/8] media: mediatek: vcodec: Add dbgfs help function
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 6:06=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 25/05/23 04:12, Yunfei Dong ha scritto:
> > Getting dbgfs help information with command "echo -help > vdec".
> >
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > ---
> >   .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 24 ++++++++++++++++++=
-
> >   1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> > index 237d0dc8a1fc..2372fc449b45 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
> > @@ -52,6 +52,23 @@ static void mtk_vdec_dbgfs_get_format_type(struct mt=
k_vcodec_ctx *ctx, char *buf
> >       *used +=3D curr_len;
> >   }
> >
> > +static void mtk_vdec_dbgfs_get_help(char *buf, int *used, int total)
> > +{
> > +     int curr_len;
> > +
> > +     curr_len =3D snprintf(buf + *used, total - *used,
> > +                         "help: (1: echo -'info' > vdec 2: cat vdec)\n=
");
> > +     *used +=3D curr_len;
> > +
> > +     curr_len =3D snprintf(buf + *used, total - *used,
> > +                         "\t-picinfo: get resolution\n");
> > +     *used +=3D curr_len;
> > +
> > +     curr_len =3D snprintf(buf + *used, total - *used,
> > +                         "\t-format: get output & capture queue format=
\n");
> > +     *used +=3D curr_len;
> > +}
> > +
> >   static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __u=
ser *ubuf,
> >                                   size_t count, loff_t *ppos)
> >   {
> > @@ -84,6 +101,11 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *fil=
p, char __user *ubuf,
> >       if (!buf)
> >               return -ENOMEM;
> >
> > +     if (strstr(dbgfs->dbgfs_buf, "-help")) {
>
> I would print the help strings in two conditions:
> 1. -help
> 2. (nothing)
>
> ...so that if you don't echo anything to vdec (no params), you get the he=
lp text.
> Otherwise, you would have to know that "-help" is a parameter that gives =
you help
> text in the first place.
>
> As for this commit "as is", it works as intended and it is useful to retr=
ieve
> the help text; you can either send a followup commit that extends the hel=
p to
> the corner case that I've explained, or send a v6 adding that to this sam=
e commit.
>
> I would prefer to see a v6 -- BUT -- since this series was sent a long ti=
me ago,
> you will get my R-b and I will leave the final choice to Hans.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

The help file could just exist as a separate file. You can then use cleaner
interfaces for it.

ChenYu
