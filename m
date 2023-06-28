Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B553074137E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjF1OPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjF1OO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:14:57 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A7B2947
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:14:56 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7654e1d83e8so479160685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1687961695; x=1690553695;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M4HXk/V1OnfOeEnFiFE7tfKo/Y5HRGL+Y21Pg98YmeI=;
        b=L2ctDOtKykoZXduo+Q/ZHOZ3nofYRgYz42iBKbQRAZC4+lLFM/4eH8PZ8+MR4l2Il6
         nKq13lwON2VER/QH/m4IHEw2/8jlvYSsBPOLRyiKhQGa87xhILL6nTo6tX2HoJyJQ+PO
         6prHC7HQOLq+kQRwbVA2RzV+LT2we7KoSKCNzBdQUuffUE8JjcWKtqVapDjoooXnvqld
         tQk7vtDv+Zr4AB7elJUTyvuilGypLCyBWal5zpXWB18x6xZ07D6kxhFudCrof/nXIEBB
         SQXi152Ywx9EaAymkr/xEWPSzdAo+LA78PumXc74RBQLkWEdX4MrsmadSf7JFOFYNVbu
         e83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687961695; x=1690553695;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4HXk/V1OnfOeEnFiFE7tfKo/Y5HRGL+Y21Pg98YmeI=;
        b=Z5pGgILO39ClGWBY8sw5ljMSjc/9JWiwDeGOJj0/CvR7ZiAvaII8ioUvWgaHTFlt6p
         4osygUgE1EHGENzGrTVJHPU5MxshLmLvvwGwf14KIdomMVTo6E/62JLjYZBAkWXaRZ8y
         kmHGlC5EZo8Y3Immu0P08dq33xPMS6kiOI5R91RTq3hJIQQubt0pjoCOTdhEeSQlRE9X
         nGs8+lHUqNDf2B1TGC0+m+uLqbz+QLn+yFw/y9w701++4NbqYqndQrKbVVwWFJ/Fr/Ji
         AIUwx8qLSU8IbkgTH6f2QQ/0P8Y4czs9MfWYkllDIbOMdH+TtJZ5Aa27fVap+aAmys7J
         /7Pg==
X-Gm-Message-State: AC+VfDyuERpWy6Xmk/5A1ns0H6ayNKM4oAJwLvLwAIzTrdoHGxLvUF8U
        zjcivbNdQ8OeXpgSvaay32aHWQ==
X-Google-Smtp-Source: ACHHUZ6ed4myxYLDN5CdzCuRp7Jj0zkGdk90IsdEk+YubiN2Cliq+QVCIpr4EnKNIeV5xqdX8bJXrQ==
X-Received: by 2002:a05:620a:190f:b0:767:a33:a9e6 with SMTP id bj15-20020a05620a190f00b007670a33a9e6mr5626575qkb.52.1687961695584;
        Wed, 28 Jun 2023 07:14:55 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:c623::7a9])
        by smtp.gmail.com with ESMTPSA id z22-20020ae9c116000000b0075c9e048b19sm5117285qki.29.2023.06.28.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:14:55 -0700 (PDT)
Message-ID: <f4d8a22dfc36abff1b4cd1e6ff7c03107dcfb4eb.camel@ndufresne.ca>
Subject: Re: [PATCH] media: amphion: reinit vpu if reqbufs output 0
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 28 Jun 2023 10:14:54 -0400
In-Reply-To: <20230613074846.25964-1-ming.qian@nxp.com>
References: <20230613074846.25964-1-ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 13 juin 2023 =C3=A0 15:48 +0800, Ming Qian a =C3=A9crit=C2=A0:
> according to v4l2 stateful decoder document 4.5.1.3. State Machine,
> the state should change from seek to initialization
> if call VIDIOC_REQBUFS(OUTPUT, 0).
>=20
> so reinit the vpu decoder if reqbufs output 0
>=20
> Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful d=
river")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>=20

No regressions seen with this change so far.

Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

And also:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

thanks,
Nicolas
=20
> ---
>  drivers/media/platform/amphion/vdec.c     | 2 --
>  drivers/media/platform/amphion/vpu_v4l2.c | 7 ++++++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platfo=
rm/amphion/vdec.c
> index 6515f3cdb7a7..56c4deea4494 100644
> --- a/drivers/media/platform/amphion/vdec.c
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -1453,9 +1453,7 @@ static void vdec_release(struct vpu_inst *inst)
>  {
>  	if (inst->id !=3D VPU_INST_NULL_ID)
>  		vpu_trace(inst->dev, "[%d]\n", inst->id);
> -	vpu_inst_lock(inst);
>  	vdec_stop(inst, true);
> -	vpu_inst_unlock(inst);
>  }
> =20
>  static void vdec_cleanup(struct vpu_inst *inst)
> diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/pl=
atform/amphion/vpu_v4l2.c
> index 810e93d2c954..8c9028df3bf4 100644
> --- a/drivers/media/platform/amphion/vpu_v4l2.c
> +++ b/drivers/media/platform/amphion/vpu_v4l2.c
> @@ -489,6 +489,11 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
>  	for (i =3D 0; i < cur_fmt->mem_planes; i++)
>  		psize[i] =3D vpu_get_fmt_plane_size(cur_fmt, i);
> =20
> +	if (V4L2_TYPE_IS_OUTPUT(vq->type) && inst->state =3D=3D VPU_CODEC_STATE=
_SEEK) {
> +		vpu_trace(inst->dev, "reinit when VIDIOC_REQBUFS(OUTPUT, 0)\n");
> +		call_void_vop(inst, release);
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -773,9 +778,9 @@ int vpu_v4l2_close(struct file *file)
>  		v4l2_m2m_ctx_release(inst->fh.m2m_ctx);
>  		inst->fh.m2m_ctx =3D NULL;
>  	}
> +	call_void_vop(inst, release);
>  	vpu_inst_unlock(inst);
> =20
> -	call_void_vop(inst, release);
>  	vpu_inst_unregister(inst);
>  	vpu_inst_put(inst);
> =20

