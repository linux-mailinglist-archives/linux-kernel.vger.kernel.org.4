Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0262E047
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiKQPtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiKQPtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:49:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9EE701A2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668700183; x=1700236183;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sw4yYEEitdgh67dZoiR7fLc/Wn1QelhfDuaGlN30eMA=;
  b=Z+NCC4TH0EFw7FRUm4iA+1VFj7w9AZHJEYeUvPUudad9Lh5uAZQdLM6I
   7lvDEWWxOhip5F/m+xwpKsygilDr3kFdRj2MuO9aWPm7Q9/f10nse6Vml
   skngAMJj4iziuGXJ+OtAmpvl9ipC0k5vVuLYU27aQThMij5uMPs4ab+9t
   6/l8olbDhWKN9Jk7TCEFa9NaStB3PG9SuZy5iqLxeymAe7Wk+TLHAEyMe
   EBvnmVjlklNnhDKwjV29bbLWOEZTX7cFGmEwYwxojOzQRKNFM/YHQ8vbw
   wxr8T+Aief84KCzEAj1dkJAehtwQ71mINk0BQqdW/gVQAPRkIK5YtUJP0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296247454"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296247454"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:49:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="782263242"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="782263242"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 17 Nov 2022 07:49:41 -0800
Received: from maurocar-mobl2 (smckenn1-MOBL.ger.corp.intel.com [10.252.19.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 32EE7580DFD;
        Thu, 17 Nov 2022 07:49:30 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:49:28 +0100
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 18/19] drm/vc4: vec: Add support for more analog TV
 standards
Message-ID: <20221117164928.200b3a1a@maurocar-mobl2>
In-Reply-To: <20220728-rpi-analog-tv-properties-v10-18-256dad125326@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v10-0-256dad125326@cerno.tech>
        <20220728-rpi-analog-tv-properties-v10-18-256dad125326@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 10:29:01 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

> From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
>=20
> Add support for the following composite output modes (all of them are
> somewhat more obscure than the previously defined ones):
>=20
> - NTSC_443 - NTSC-style signal with the chroma subcarrier shifted to
>   4.43361875 MHz (the PAL subcarrier frequency). Never used for
>   broadcasting, but sometimes used as a hack to play NTSC content in PAL
>   regions (e.g. on VCRs).

> - PAL_N - PAL with alternative chroma subcarrier frequency,
>   3.58205625 MHz. Used as a broadcast standard in Argentina, Paraguay
>   and Uruguay to fit 576i50 with colour in 6 MHz channel raster.

That's not right. Argentina uses a different standard than Paraguay and
Uruguai.

See, there are two variants of PAL/N. The original one and PAL/N' - also
called PAL/NC or PAL/CN (Combination N). Some of the timings are=20
different on /NC variant.

As far as I'm aware, PAL/Nc is used in Argentina, while
PAL/N is used in Paraguai and Uruguai, but I may be wrong on that,
as it has been a long time since had to touch on this.

> - PAL60 - 480i60 signal with PAL-style color at normal European PAL
>   frequency. Another non-standard, non-broadcast mode, used in similar
>   contexts as NTSC_443. Some displays support one but not the other.

> - SECAM - French frequency-modulated analog color standard; also have
>   been broadcast in Eastern Europe and various parts of Africa and Asia.
>   Uses the same 576i50 timings as PAL.

This is also wrong. just like PAL, there are several variants of SECAM,
one used in France, and a different one in France overseas and on
previous France colonies in Africa and Asia. Eastern Europe also used
different variants of SECAM.

>=20
> Also added some comments explaining color subcarrier frequency
> registers.
>=20
> Acked-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Signed-off-by: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> Tested-by: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> ---
> Changes in v6:
> - Support PAL60 again
> ---
>  drivers/gpu/drm/vc4/vc4_vec.c | 111 ++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 107 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
> index a828fc6fb776..d23dbad3cbf6 100644
> --- a/drivers/gpu/drm/vc4/vc4_vec.c
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> @@ -46,6 +46,7 @@
>  #define VEC_CONFIG0_YDEL(x)		((x) << 26)
>  #define VEC_CONFIG0_CDEL_MASK		GENMASK(25, 24)
>  #define VEC_CONFIG0_CDEL(x)		((x) << 24)
> +#define VEC_CONFIG0_SECAM_STD		BIT(21)
>  #define VEC_CONFIG0_PBPR_FIL		BIT(18)
>  #define VEC_CONFIG0_CHROMA_GAIN_MASK	GENMASK(17, 16)
>  #define VEC_CONFIG0_CHROMA_GAIN_UNITY	(0 << 16)
> @@ -76,6 +77,27 @@
>  #define VEC_SOFT_RESET			0x10c
>  #define VEC_CLMP0_START			0x144
>  #define VEC_CLMP0_END			0x148
> +
> +/*
> + * These set the color subcarrier frequency
> + * if VEC_CONFIG1_CUSTOM_FREQ is enabled.
> + *
> + * VEC_FREQ1_0 contains the most significant 16-bit half-word,
> + * VEC_FREQ3_2 contains the least significant 16-bit half-word.
> + * 0x80000000 seems to be equivalent to the pixel clock
> + * (which itself is the VEC clock divided by 8).
> + *
> + * Reference values (with the default pixel clock of 13.5 MHz):
> + *
> + * NTSC  (3579545.[45] Hz)     - 0x21F07C1F
> + * PAL   (4433618.75 Hz)       - 0x2A098ACB
> + * PAL-M (3575611.[888111] Hz) - 0x21E6EFE3
> + * PAL-N (3582056.25 Hz)       - 0x21F69446
> + *
> + * NOTE: For SECAM, it is used as the Dr center frequency,
> + * regardless of whether VEC_CONFIG1_CUSTOM_FREQ is enabled or not;
> + * that is specified as 4406250 Hz, which corresponds to 0x29C71C72.
> + */
>  #define VEC_FREQ3_2			0x180
>  #define VEC_FREQ1_0			0x184
> =20
> @@ -118,6 +140,14 @@
> =20
>  #define VEC_INTERRUPT_CONTROL		0x190
>  #define VEC_INTERRUPT_STATUS		0x194
> +
> +/*
> + * Db center frequency for SECAM; the clock for this is the same as for
> + * VEC_FREQ3_2/VEC_FREQ1_0, which is used for Dr center frequency.
> + *
> + * This is specified as 4250000 Hz, which corresponds to 0x284BDA13.
> + * That is also the default value, so no need to set it explicitly.
> + */
>  #define VEC_FCW_SECAM_B			0x198
>  #define VEC_SECAM_GAIN_VAL		0x19c
> =20
> @@ -197,10 +227,15 @@ enum vc4_vec_tv_mode_id {
>  	VC4_VEC_TV_MODE_NTSC_J,
>  	VC4_VEC_TV_MODE_PAL,
>  	VC4_VEC_TV_MODE_PAL_M,
> +	VC4_VEC_TV_MODE_NTSC_443,
> +	VC4_VEC_TV_MODE_PAL_60,
> +	VC4_VEC_TV_MODE_PAL_N,
> +	VC4_VEC_TV_MODE_SECAM,
>  };
> =20
>  struct vc4_vec_tv_mode {
>  	unsigned int mode;
> +	u16 expected_htotal;
>  	u32 config0;
>  	u32 config1;
>  	u32 custom_freq;
> @@ -236,35 +271,68 @@ static const struct debugfs_reg32 vec_regs[] =3D {
>  static const struct vc4_vec_tv_mode vc4_vec_tv_modes[] =3D {
>  	{
>  		.mode =3D DRM_MODE_TV_MODE_NTSC,
> +		.expected_htotal =3D 858,
>  		.config0 =3D VEC_CONFIG0_NTSC_STD | VEC_CONFIG0_PDEN,
>  		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,
>  	},
> +	{
> +		.mode =3D DRM_MODE_TV_MODE_NTSC_443,
> +		.expected_htotal =3D 858,
> +		.config0 =3D VEC_CONFIG0_NTSC_STD,
> +		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS | VEC_CONFIG1_CUSTOM_FREQ,
> +		.custom_freq =3D 0x2a098acb,
> +	},
>  	{
>  		.mode =3D DRM_MODE_TV_MODE_NTSC_J,
> +		.expected_htotal =3D 858,
>  		.config0 =3D VEC_CONFIG0_NTSC_STD,
>  		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,
>  	},
>  	{
>  		.mode =3D DRM_MODE_TV_MODE_PAL,
> +		.expected_htotal =3D 864,
>  		.config0 =3D VEC_CONFIG0_PAL_BDGHI_STD,
>  		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,
>  	},
> +	{
> +		/* PAL-60 */
> +		.mode =3D DRM_MODE_TV_MODE_PAL,
> +		.expected_htotal =3D 858,
> +		.config0 =3D VEC_CONFIG0_PAL_M_STD,
> +		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS | VEC_CONFIG1_CUSTOM_FREQ,
> +		.custom_freq =3D 0x2a098acb,
> +	},
>  	{
>  		.mode =3D DRM_MODE_TV_MODE_PAL_M,
> +		.expected_htotal =3D 858,
>  		.config0 =3D VEC_CONFIG0_PAL_M_STD,
>  		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,
>  	},
> +	{
> +		.mode =3D DRM_MODE_TV_MODE_PAL_N,
> +		.expected_htotal =3D 864,
> +		.config0 =3D VEC_CONFIG0_PAL_N_STD,
> +		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,
> +	},
> +	{
> +		.mode =3D DRM_MODE_TV_MODE_SECAM,
> +		.expected_htotal =3D 864,
> +		.config0 =3D VEC_CONFIG0_SECAM_STD,
> +		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,
> +		.custom_freq =3D 0x29c71c72,
> +	},
>  };
> =20
>  static inline const struct vc4_vec_tv_mode *
> -vc4_vec_tv_mode_lookup(unsigned int mode)
> +vc4_vec_tv_mode_lookup(unsigned int mode, u16 htotal)
>  {
>  	unsigned int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(vc4_vec_tv_modes); i++) {
>  		const struct vc4_vec_tv_mode *tv_mode =3D &vc4_vec_tv_modes[i];
> =20
> -		if (tv_mode->mode =3D=3D mode)
> +		if (tv_mode->mode =3D=3D mode &&
> +		    tv_mode->expected_htotal =3D=3D htotal)
>  			return tv_mode;
>  	}
> =20
> @@ -273,9 +341,13 @@ vc4_vec_tv_mode_lookup(unsigned int mode)
> =20
>  static const struct drm_prop_enum_list legacy_tv_mode_names[] =3D {
>  	{ VC4_VEC_TV_MODE_NTSC, "NTSC", },
> +	{ VC4_VEC_TV_MODE_NTSC_443, "NTSC-443", },
>  	{ VC4_VEC_TV_MODE_NTSC_J, "NTSC-J", },
>  	{ VC4_VEC_TV_MODE_PAL, "PAL", },
> +	{ VC4_VEC_TV_MODE_PAL_60, "PAL-60", },
>  	{ VC4_VEC_TV_MODE_PAL_M, "PAL-M", },
> +	{ VC4_VEC_TV_MODE_PAL_N, "PAL-N", },
> +	{ VC4_VEC_TV_MODE_SECAM, "SECAM", },
>  };
> =20
>  static enum drm_connector_status
> @@ -306,11 +378,16 @@ vc4_vec_connector_set_property(struct drm_connector=
 *connector,
>  		state->tv.mode =3D DRM_MODE_TV_MODE_NTSC;
>  		break;
> =20
> +	case VC4_VEC_TV_MODE_NTSC_443:
> +		state->tv.mode =3D DRM_MODE_TV_MODE_NTSC_443;
> +		break;
> +
>  	case VC4_VEC_TV_MODE_NTSC_J:
>  		state->tv.mode =3D DRM_MODE_TV_MODE_NTSC_J;
>  		break;
> =20
>  	case VC4_VEC_TV_MODE_PAL:
> +	case VC4_VEC_TV_MODE_PAL_60:
>  		state->tv.mode =3D DRM_MODE_TV_MODE_PAL;
>  		break;
> =20
> @@ -318,6 +395,14 @@ vc4_vec_connector_set_property(struct drm_connector =
*connector,
>  		state->tv.mode =3D DRM_MODE_TV_MODE_PAL_M;
>  		break;
> =20
> +	case VC4_VEC_TV_MODE_PAL_N:
> +		state->tv.mode =3D DRM_MODE_TV_MODE_PAL_N;
> +		break;
> +
> +	case VC4_VEC_TV_MODE_SECAM:
> +		state->tv.mode =3D DRM_MODE_TV_MODE_SECAM;
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -341,6 +426,10 @@ vc4_vec_connector_get_property(struct drm_connector =
*connector,
>  		*val =3D VC4_VEC_TV_MODE_NTSC;
>  		break;
> =20
> +	case DRM_MODE_TV_MODE_NTSC_443:
> +		*val =3D VC4_VEC_TV_MODE_NTSC_443;
> +		break;
> +
>  	case DRM_MODE_TV_MODE_NTSC_J:
>  		*val =3D VC4_VEC_TV_MODE_NTSC_J;
>  		break;
> @@ -353,6 +442,14 @@ vc4_vec_connector_get_property(struct drm_connector =
*connector,
>  		*val =3D VC4_VEC_TV_MODE_PAL_M;
>  		break;
> =20
> +	case DRM_MODE_TV_MODE_PAL_N:
> +		*val =3D VC4_VEC_TV_MODE_PAL_N;
> +		break;
> +
> +	case DRM_MODE_TV_MODE_SECAM:
> +		*val =3D VC4_VEC_TV_MODE_SECAM;
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -448,13 +545,16 @@ static void vc4_vec_encoder_enable(struct drm_encod=
er *encoder,
>  	struct drm_connector *connector =3D &vec->connector;
>  	struct drm_connector_state *conn_state =3D
>  		drm_atomic_get_new_connector_state(state, connector);
> +	struct drm_display_mode *adjusted_mode =3D
> +		&encoder->crtc->state->adjusted_mode;
>  	const struct vc4_vec_tv_mode *tv_mode;
>  	int idx, ret;
> =20
>  	if (!drm_dev_enter(drm, &idx))
>  		return;
> =20
> -	tv_mode =3D vc4_vec_tv_mode_lookup(conn_state->tv.mode);
> +	tv_mode =3D vc4_vec_tv_mode_lookup(conn_state->tv.mode,
> +					 adjusted_mode->htotal);
>  	if (!tv_mode)
>  		goto err_dev_exit;
> =20
> @@ -648,9 +748,12 @@ static int vc4_vec_bind(struct device *dev, struct d=
evice *master, void *data)
> =20
>  	ret =3D drm_mode_create_tv_properties(drm,
>  					    BIT(DRM_MODE_TV_MODE_NTSC) |
> +					    BIT(DRM_MODE_TV_MODE_NTSC_443) |
>  					    BIT(DRM_MODE_TV_MODE_NTSC_J) |
>  					    BIT(DRM_MODE_TV_MODE_PAL) |
> -					    BIT(DRM_MODE_TV_MODE_PAL_M));
> +					    BIT(DRM_MODE_TV_MODE_PAL_M) |
> +					    BIT(DRM_MODE_TV_MODE_PAL_N) |
> +					    BIT(DRM_MODE_TV_MODE_SECAM));
>  	if (ret)
>  		return ret;
> =20
>=20
