Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11BF7359DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjFSOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFSOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:41:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C2EA0;
        Mon, 19 Jun 2023 07:41:31 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:c623::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF50766003B0;
        Mon, 19 Jun 2023 15:41:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687185690;
        bh=bcT+FUOyCCJiCPzg14oHY8Ywv+HBklrEGs40i6TF2xY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AyWK+LOjmnPIPsG3d7SkdRNoF/0Bn0+DmYPq/Wv493u7FX+kO0bZj/FEifFHkcG5m
         14igAaYZt+KKr5tDUR1N9OFop2PbFp5upv64sXrwFHanfag8fvX2NoDfekZCp+edoH
         E2yzQ0dJVkW8fgedCceiz+6Wv/eaWE6ydL3l9imwR4KBPJS/REMvAF4U1DXVQxIHGs
         H7u3k3APT7Dob7RTWMQIE9Kps9z3wjYCAkY9qWLTmzrwvtkxAbIGZETVRzr3HkVwAi
         2vWOAwFv1Hmj5IlKmctEHNGjCo5Ogc8eDiFy04WMbuXxk/5slAAMmKVlzFHJVzwaDI
         EYraxJK6XtYTw==
Message-ID: <e264ac3a15e0f115aa7e941a77eb312429b8f65e.camel@collabora.com>
Subject: Re: [PATCH 2/2] media: verisilicon: change confusingly named
 relaxed register access
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Jun 2023 10:41:19 -0400
In-Reply-To: <20230616144854.3818934-2-arnd@kernel.org>
References: <20230616144854.3818934-1-arnd@kernel.org>
         <20230616144854.3818934-2-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Le vendredi 16 juin 2023 =C3=A0 16:48 +0200, Arnd Bergmann a =C3=A9crit=C2=
=A0:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The register abstraction has wrappers around both the normal writel()
> and its writel_relaxed() counterpart, but this has led to a lot of users
> ending up with the relaxed version.
>=20
> There is sometimes a need to intentionally pick the relaxed accessor for
> performance critical functions, but I noticed that each hantro_reg_write(=
)
> call also contains a non-relaxed readl(), which is typically much more
> expensive than a writel, so there is little benefit here but an added
> risk of missing a serialization against DMA.
>=20
> To make this behave like other interfaces, use the normal accessor by
> default and only provide the relaxed version as an alternative for
> performance critical code. hantro_postproc.c is the only place that
> used both the relaxed and normal writel, but this does not seem
> cricital either, so change it all to the normal ones.

In this text you spoke about potential performance side effects of existing=
 code
and your changes, but its left all very vague and theoretical. Have you don=
e any
measurement ? Do you need help with the manner ?

regards,
Nicolas

>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I did not look whether there is an actual bug here, just noticed this
> when I debugged the excessive stack usage.
> ---
>  drivers/media/platform/verisilicon/hantro.h          |  6 +++---
>  drivers/media/platform/verisilicon/hantro_postproc.c | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/=
platform/verisilicon/hantro.h
> index 6c5e56ce5b351..a481d957fef93 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -441,14 +441,14 @@ static __always_inline void hantro_reg_write(struct=
 hantro_dev *vpu,
>  				    const struct hantro_reg *reg,
>  				    u32 val)
>  {
> -	vdpu_write_relaxed(vpu, vdpu_read_mask(vpu, reg, val), reg->base);
> +	vdpu_write(vpu, vdpu_read_mask(vpu, reg, val), reg->base);
>  }
> =20
> -static __always_inline void hantro_reg_write_s(struct hantro_dev *vpu,
> +static __always_inline void hantro_reg_write_relaxed(struct hantro_dev *=
vpu,
>  				      const struct hantro_reg *reg,
>  				      u32 val)
>  {
> -	vdpu_write(vpu, vdpu_read_mask(vpu, reg, val), reg->base);
> +	vdpu_write_relaxed(vpu, vdpu_read_mask(vpu, reg, val), reg->base);
>  }
> =20
>  void *hantro_get_ctrl(struct hantro_ctx *ctx, u32 id);
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drive=
rs/media/platform/verisilicon/hantro_postproc.c
> index c977d64105b18..0224ff68ab3fc 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -21,11 +21,11 @@
>  			 val); \
>  }
> =20
> -#define HANTRO_PP_REG_WRITE_S(vpu, reg_name, val) \
> +#define HANTRO_PP_REG_WRITE_RELAXED(vpu, reg_name, val) \
>  { \
> -	hantro_reg_write_s(vpu, \
> -			   &hantro_g1_postproc_regs.reg_name, \
> -			   val); \
> +	hantro_reg_write_relaxed(vpu, \
> +				 &hantro_g1_postproc_regs.reg_name, \
> +				 val); \
>  }
> =20
>  #define VPU_PP_IN_YUYV			0x0
> @@ -72,7 +72,7 @@ static void hantro_postproc_g1_enable(struct hantro_ctx=
 *ctx)
>  	dma_addr_t dst_dma;
> =20
>  	/* Turn on pipeline mode. Must be done first. */
> -	HANTRO_PP_REG_WRITE_S(vpu, pipeline_en, 0x1);
> +	HANTRO_PP_REG_WRITE(vpu, pipeline_en, 0x1);
> =20
>  	src_pp_fmt =3D VPU_PP_IN_NV12;
> =20
> @@ -242,7 +242,7 @@ static void hantro_postproc_g1_disable(struct hantro_=
ctx *ctx)
>  {
>  	struct hantro_dev *vpu =3D ctx->dev;
> =20
> -	HANTRO_PP_REG_WRITE_S(vpu, pipeline_en, 0x0);
> +	HANTRO_PP_REG_WRITE(vpu, pipeline_en, 0x0);
>  }
> =20
>  static void hantro_postproc_g2_disable(struct hantro_ctx *ctx)

