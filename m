Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349396D23E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjCaPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCaPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:20:14 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83F030DB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:20:12 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id m6so16679766qvq.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112; t=1680276012;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cwobtvlu1ApCEa1mWvDaiiIx0D8/aosKTXPfSOE5S6o=;
        b=QJSPoywaO0m7h68iu3eDbeHedBVSgLj+mDP5AeRmUcQQBFoA1dRd8/32uNuU5OQoYw
         APXYxRRawaw/eWkf40t+JgcrS6Pngh3q1jAmNC31QF0yiKmLo/S/MoAO3V+TyxS50/uO
         qoDM5EeuK6iZDK0ZefkIuyyh66Lp7idbaP/tDSwOHkQxLplswBqrAmuEKbu1hJhIJ1w4
         X7zpq4C9qnPM2JlRTfzaKjYF7GYQWEz6E0d2xJiLtwuP46VYvO2XyRSJpNbDTHp7B/eQ
         3wuBes6k2WJ9mQuuih8+dzN4rQlbbuV5SNe7qAm+J8j4P9uvE7ib/HX3G6XB3tuAlqSh
         z3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680276012;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwobtvlu1ApCEa1mWvDaiiIx0D8/aosKTXPfSOE5S6o=;
        b=kWuZGSopT7wgZknZvYmiXyFu1FfHz+9AMQ3wG5T4ByYa0tv3Xv22uQk8LDutQnolJP
         YarhRwOgzGVcQJ+vv9ooOoeEwZgtRanxBg10dzBxMssSJ5qpy4+N/4OyHpDf45qzCe7U
         ZIJgCFIRoWTDd7/mvZ5BfcWR0AjfBTj8LM1KVsmxPJhWJhzqpKGdl3zwdTJ+t79nDuVC
         p+OzIj1czt076sHEsBeJhdWD43qEmyVm0SpFQ50vfAq+VDbUSUZAYIpZBiGKlQzaFKC5
         WNLegdy/zH/UtMgU4Y8AD7B8L44KRbqRjsSn7FqBYP5f/NoMFtQoY1ZQIieJAzZIif2r
         X8Sg==
X-Gm-Message-State: AAQBX9d92Sj6E47IA6OngyCzC54hXlMXCa3vee1EFl1FQmE+Ho+L/Ei3
        Ai2EDLdtEePgSFXJFWZm+EMGaw==
X-Google-Smtp-Source: AKy350ZLa5XcprT/+Eis3sIfxUEgg4anw3KcRdAqzKFKQ+/JzSzTBaKU52DQJgcOf72oHNOKmWeACA==
X-Received: by 2002:a05:6214:27e5:b0:5df:44f2:e97d with SMTP id jt5-20020a05621427e500b005df44f2e97dmr15254434qvb.19.1680276012017;
        Fri, 31 Mar 2023 08:20:12 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:a07e::580])
        by smtp.gmail.com with ESMTPSA id ml11-20020a056214584b00b005dd8b9345aasm653254qvb.66.2023.03.31.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 08:20:11 -0700 (PDT)
Message-ID: <df3e49a5f8c03cf9b67698d008cd1b99578835a2.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mediatek: vcodec: Fix potential array
 out-of-bounds in decoder queue_setup
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Wei Chen <harperchen1110@gmail.com>, tiffany.lin@mediatek.com
Cc:     andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Fri, 31 Mar 2023 11:20:10 -0400
In-Reply-To: <20230328100951.536955-1-harperchen1110@gmail.com>
References: <20230328100951.536955-1-harperchen1110@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 28 mars 2023 =C3=A0 10:09 +0000, Wei Chen a =C3=A9crit=C2=A0:
> variable *nplanes is provided by user via system call argument. The
> possible value of q_data->fmt->num_planes is 1-3, while the value
> of *nplanes can be 1-8. The array access by index i can cause array
> out-of-bounds.
>=20
> Fix this bug by checking *nplanes against the array size.
>=20
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> index 641f533c417f..cae34cc7c807 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> @@ -753,6 +753,13 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, un=
signed int *nbuffers,
>  	}
> =20
>  	if (*nplanes) {
> +		if (vq->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +			if (*nplanes !=3D q_data->fmt->num_planes)
> +				return -EINVAL;
> +		else
> +			if (*nplanes !=3D 1)
> +				return -EINVAL;
> +
>  		for (i =3D 0; i < *nplanes; i++) {
>  			if (sizes[i] < q_data->sizeimage[i])
>  				return -EINVAL;


A bit of context, *nplanes is non zero only when called from VIDIOC_CREATE_=
BUFS.
I think this highlights a bigger problem around the format in
VIDIOC_CREATE_BUFS. The format should be validated through TRY_FMT in some =
ways,
notably to apply the HW required alignment, but also to avoid having to val=
idate
that lower in the stack.

Nicolas

