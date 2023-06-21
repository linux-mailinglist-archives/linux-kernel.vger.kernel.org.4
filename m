Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48544738766
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFUOoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjFUOoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:44:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A5199D;
        Wed, 21 Jun 2023 07:44:35 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:c623::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F0B46606F96;
        Wed, 21 Jun 2023 15:44:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687358674;
        bh=8HFzaL56gG3Wzf7zrZFg8U3SAyI/UGRw9a2LhNVa630=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m1945OSJr1DSvGu1IGFg1dGoA6/7lOf/X4FocnaCoKz8c5mLFBDZvyEc8tMLFdbFX
         R5d/QXk0ARM1hGHXU9L6KTyDu0K8GsA22mRLkNewd6xikNhvzDlUT8ppuM6vrEfiJy
         ronbcE9SzChNkJk6DqV5SOW57FAWN8i9wKHXGP32Gzigi54lH7Wv/dvJdE+4letZRM
         KM1CwJzgCJgNx+T9KofqeXj65IvK4G7ouIq8jlfUFi4M4pTMOuTSUwoCpSONLgBfW8
         IDAfFMwEmpKhMDJeYNOkQHbiFbyfMIaYqZ/0GhSpGCEGcOzFlHXbzuwkYG5timtI7M
         mghb3GWnUwYYw==
Message-ID: <998e2fcef6c1e8602e25974daf8f5b18cfca7436.camel@collabora.com>
Subject: Re: [PATCH 1/2] media: verisilicon: fix excessive stack usage
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jun 2023 10:44:23 -0400
In-Reply-To: <20230616144854.3818934-1-arnd@kernel.org>
References: <20230616144854.3818934-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks you.

Le vendredi 16 juin 2023 =C3=A0 16:48 +0200, Arnd Bergmann a =C3=A9crit=C2=
=A0:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> In some configurations, gcc decides not to inline the register accessor f=
unctions,
> which in turn leads to lots of temporary hantro_reg structures on the sta=
ck that
> cannot be eliminated because they escape into an uninlined function:
>=20
> drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:1022:1: w=
arning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-lar=
ger-than=3D]
>=20
> Mark all of these as __always_inline so the compiler is able to completel=
y
> eliminate the temporary structures instead, which brings the stack usage
> back down to just the normal local variables.

This is falling into compiler bug territory, though I see no harm in forcin=
g
these to inline, as in the old days these would have been macros anyway.

>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306151506.goHEegOd-lkp@i=
ntel.com/
> Fixes: 727a400686a2c ("media: verisilicon: Add Rockchip AV1 decoder")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks again,

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/verisilicon/hantro.h | 22 ++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/=
platform/verisilicon/hantro.h
> index 6523ffb748812..6c5e56ce5b351 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -370,26 +370,26 @@ extern int hantro_debug;
>  	pr_err("%s:%d: " fmt, __func__, __LINE__, ##args)
> =20
>  /* Structure access helpers. */
> -static inline struct hantro_ctx *fh_to_ctx(struct v4l2_fh *fh)
> +static __always_inline struct hantro_ctx *fh_to_ctx(struct v4l2_fh *fh)
>  {
>  	return container_of(fh, struct hantro_ctx, fh);
>  }
> =20
>  /* Register accessors. */
> -static inline void vepu_write_relaxed(struct hantro_dev *vpu,
> +static __always_inline void vepu_write_relaxed(struct hantro_dev *vpu,
>  				      u32 val, u32 reg)
>  {
>  	vpu_debug(6, "0x%04x =3D 0x%08x\n", reg / 4, val);
>  	writel_relaxed(val, vpu->enc_base + reg);
>  }
> =20
> -static inline void vepu_write(struct hantro_dev *vpu, u32 val, u32 reg)
> +static __always_inline void vepu_write(struct hantro_dev *vpu, u32 val, =
u32 reg)
>  {
>  	vpu_debug(6, "0x%04x =3D 0x%08x\n", reg / 4, val);
>  	writel(val, vpu->enc_base + reg);
>  }
> =20
> -static inline u32 vepu_read(struct hantro_dev *vpu, u32 reg)
> +static __always_inline u32 vepu_read(struct hantro_dev *vpu, u32 reg)
>  {
>  	u32 val =3D readl(vpu->enc_base + reg);
> =20
> @@ -397,27 +397,27 @@ static inline u32 vepu_read(struct hantro_dev *vpu,=
 u32 reg)
>  	return val;
>  }
> =20
> -static inline void vdpu_write_relaxed(struct hantro_dev *vpu,
> +static __always_inline void vdpu_write_relaxed(struct hantro_dev *vpu,
>  				      u32 val, u32 reg)
>  {
>  	vpu_debug(6, "0x%04x =3D 0x%08x\n", reg / 4, val);
>  	writel_relaxed(val, vpu->dec_base + reg);
>  }
> =20
> -static inline void vdpu_write(struct hantro_dev *vpu, u32 val, u32 reg)
> +static __always_inline void vdpu_write(struct hantro_dev *vpu, u32 val, =
u32 reg)
>  {
>  	vpu_debug(6, "0x%04x =3D 0x%08x\n", reg / 4, val);
>  	writel(val, vpu->dec_base + reg);
>  }
> =20
> -static inline void hantro_write_addr(struct hantro_dev *vpu,
> +static __always_inline void hantro_write_addr(struct hantro_dev *vpu,
>  				     unsigned long offset,
>  				     dma_addr_t addr)
>  {
>  	vdpu_write(vpu, addr & 0xffffffff, offset);
>  }
> =20
> -static inline u32 vdpu_read(struct hantro_dev *vpu, u32 reg)
> +static __always_inline u32 vdpu_read(struct hantro_dev *vpu, u32 reg)
>  {
>  	u32 val =3D readl(vpu->dec_base + reg);
> =20
> @@ -425,7 +425,7 @@ static inline u32 vdpu_read(struct hantro_dev *vpu, u=
32 reg)
>  	return val;
>  }
> =20
> -static inline u32 vdpu_read_mask(struct hantro_dev *vpu,
> +static __always_inline u32 vdpu_read_mask(struct hantro_dev *vpu,
>  				 const struct hantro_reg *reg,
>  				 u32 val)
>  {
> @@ -437,14 +437,14 @@ static inline u32 vdpu_read_mask(struct hantro_dev =
*vpu,
>  	return v;
>  }
> =20
> -static inline void hantro_reg_write(struct hantro_dev *vpu,
> +static __always_inline void hantro_reg_write(struct hantro_dev *vpu,
>  				    const struct hantro_reg *reg,
>  				    u32 val)
>  {
>  	vdpu_write_relaxed(vpu, vdpu_read_mask(vpu, reg, val), reg->base);
>  }
> =20
> -static inline void hantro_reg_write_s(struct hantro_dev *vpu,
> +static __always_inline void hantro_reg_write_s(struct hantro_dev *vpu,
>  				      const struct hantro_reg *reg,
>  				      u32 val)
>  {

