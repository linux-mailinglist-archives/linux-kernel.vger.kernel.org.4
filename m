Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686BE746362
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjGCTgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCTgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:36:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F52AE62;
        Mon,  3 Jul 2023 12:36:13 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:88d9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5C8626606F85;
        Mon,  3 Jul 2023 20:36:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688412972;
        bh=rtxytAtwCKhEGjZPPePBApqg0LwkZFTXWo8ER+5VH+U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z8wiWeboafqA8oM1ClerYqIloeWCii8J2Rkf2U8WmHg/ioHqi4gsxP2OKYtim8sSK
         wBHedDzvN7KYzk33Tboyehs1UztGkpWn0eeh0pNqFBpFSJY/BWXxG1VrULNDhO1q3J
         h4JAsYPjM8rzy99k4m9BB9p1dGeNk3+6lilqKEfCfp/6vVzmTlvkf923OmLEhPkr/0
         mDhXUJroAAd5Y+cAapHfpf2FYJXeM/7YWYrS34dwsNApEg3YfFRsYy/YNAIDTjKN3Z
         4HddTbFYh2mRn7LHVsYorWGUg4hH7APemK6KwGQts0wCnd7Ka3q6zT7YKYWRkKRX3x
         i/JnL9+/gevWw==
Message-ID: <1e51d52aa370f286dd8c53f75f2aabcc257a6093.camel@collabora.com>
Subject: Re: [PATCH v4,05/11] media: mediatek: vcodec: remove the dependency
 of vcodec debug log
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?ISO-8859-1?Q?N=EDcolas?= "F . R . A . Prado" 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Mon, 03 Jul 2023 15:36:02 -0400
In-Reply-To: <20230626035346.30654-6-yunfei.dong@mediatek.com>
References: <20230626035346.30654-1-yunfei.dong@mediatek.com>
         <20230626035346.30654-6-yunfei.dong@mediatek.com>
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

Le lundi 26 juin 2023 =C3=A0 11:53 +0800, Yunfei Dong a =C3=A9crit=C2=A0:
> 'mtk_vcodec_debug' and 'mtk_vcodec_err' depends on 'mtk_vcodec_ctx'
> to get the index of each instance. Define two different macro
> mtk_vdec_debug and mtk_venc_debug for decoder and encoder, and re-write
> macro mtk_vcodec_debug as the common interface which is called
> by mtk_vdec_debug and mtk_venc_debug. The vcodec debug log can be
> separeated by encoder and decoder.
>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../mediatek/vcodec/mtk_vcodec_util.h         |  34 +++--
>  .../vcodec/vdec/vdec_av1_req_lat_if.c         | 123 +++++++++--------
>  .../mediatek/vcodec/vdec/vdec_h264_if.c       |  66 +++++-----
>  .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |  46 +++----
>  .../vcodec/vdec/vdec_h264_req_multi_if.c      | 124 +++++++++---------
>  .../vcodec/vdec/vdec_hevc_req_multi_if.c      |  94 +++++++------
>  .../mediatek/vcodec/vdec/vdec_vp8_if.c        |  47 ++++---
>  .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  66 +++++-----
>  .../mediatek/vcodec/vdec/vdec_vp9_if.c        | 122 ++++++++---------
>  .../vcodec/vdec/vdec_vp9_req_lat_if.c         | 108 +++++++--------
>  .../platform/mediatek/vcodec/vdec_vpu_if.c    |  45 ++++---
>  .../mediatek/vcodec/venc/venc_h264_if.c       |  69 +++++-----
>  .../mediatek/vcodec/venc/venc_vp8_if.c        |  32 ++---
>  .../platform/mediatek/vcodec/venc_vpu_if.c    |  53 ++++----
>  14 files changed, 494 insertions(+), 535 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/d=
rivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> index a356f42362e4..a684a7e4ab6e 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> @@ -31,9 +31,8 @@ struct mtk_vcodec_dev;
>  #define mtk_v4l2_err(fmt, args...)                \
>  	pr_err("[MTK_V4L2][ERROR] " fmt "\n", ##args)
> =20
> -#define mtk_vcodec_err(h, fmt, args...)				\
> -	pr_err("[MTK_VCODEC][ERROR][%d]: " fmt "\n",		\
> -	       ((struct mtk_vcodec_ctx *)(h)->ctx)->id, ##args)
> +#define mtk_vcodec_err(inst_id, plat_dev, fmt, args...)                 =
                \
> +	dev_err(&(plat_dev)->dev, "[MTK_VCODEC][ERROR][%d]: " fmt "\n", inst_id=
, ##args)
> =20
>  #if defined(CONFIG_DEBUG_FS)
>  extern int mtk_v4l2_dbg_level;
> @@ -46,22 +45,31 @@ extern int mtk_vcodec_dbg;
>  				 __func__, __LINE__, ##args);	        \
>  	} while (0)
> =20
> -#define mtk_vcodec_debug(h, fmt, args...)				                      \
> -	do {								                      \
> -		if (mtk_vcodec_dbg)					                      \
> -			dev_dbg(&(((struct mtk_vcodec_ctx *)(h)->ctx)->dev->plat_dev->dev),  =
 \
> -				"[MTK_VCODEC][%d]: %s, %d " fmt "\n",                         \
> -				((struct mtk_vcodec_ctx *)(h)->ctx)->id,                      \
> -				__func__, __LINE__, ##args);                                  \
> +#define mtk_vcodec_debug(inst_id, plat_dev, fmt, args...)               =
                \
> +	do {                                                                   =
         \
> +		if (mtk_vcodec_dbg)                                                   =
  \
> +			dev_dbg(&(plat_dev)->dev, "[MTK_VCODEC][%d]: %s, %d " fmt "\n", \
> +				inst_id, __func__, __LINE__, ##args);                   \
>  	} while (0)
>  #else
>  #define mtk_v4l2_debug(level, fmt, args...) pr_debug(fmt, ##args)
> =20
> -#define mtk_vcodec_debug(h, fmt, args...)			\
> -	pr_debug("[MTK_VCODEC][%d]: " fmt "\n",			\
> -		((struct mtk_vcodec_ctx *)(h)->ctx)->id, ##args)
> +#define mtk_vcodec_debug(inst_id, plat_dev, fmt, args...)			\
> +	dev_dbg(&(plat_dev)->dev, "[MTK_VCODEC][%d]: " fmt "\n", inst_id, ##arg=
s)
>  #endif
> =20
> +#define mtk_vdec_err(ctx, fmt, args...)                               \
> +	mtk_vcodec_err((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> +
> +#define mtk_vdec_debug(ctx, fmt, args...)                             \
> +	mtk_vcodec_debug((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> +
> +#define mtk_venc_err(ctx, fmt, args...)                               \
> +	mtk_vcodec_err((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> +
> +#define mtk_venc_debug(ctx, fmt, args...)                              \
> +	mtk_vcodec_debug((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
> +
>  void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned =
int reg_idx);
>  int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
>  void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat=
_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
> index 404a1a23fd40..dfed8fe7f54c 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
> @@ -778,12 +778,11 @@ static int vdec_av1_slice_init_cdf_table(struct vde=
c_av1_slice_instance *instanc
>  	remote_cdf_table =3D mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler,
>  						     (u32)vsi->cdf_table_addr);
>  	if (IS_ERR(remote_cdf_table)) {
> -		mtk_vcodec_err(instance, "failed to map cdf table\n");
> +		mtk_vdec_err(ctx, "failed to map cdf table\n");
>  		return PTR_ERR(remote_cdf_table);
>  	}
> =20
> -	mtk_vcodec_debug(instance, "map cdf table to 0x%p\n",
> -			 remote_cdf_table);
> +	mtk_vdec_debug(ctx, "map cdf table to 0x%p\n", remote_cdf_table);
> =20
>  	if (instance->cdf_table.va)
>  		mtk_vcodec_mem_free(ctx, &instance->cdf_table);
> @@ -810,11 +809,11 @@ static int vdec_av1_slice_init_iq_table(struct vdec=
_av1_slice_instance *instance
>  	remote_iq_table =3D mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler,
>  						    (u32)vsi->iq_table_addr);
>  	if (IS_ERR(remote_iq_table)) {
> -		mtk_vcodec_err(instance, "failed to map iq table\n");
> +		mtk_vdec_err(ctx, "failed to map iq table\n");
>  		return PTR_ERR(remote_iq_table);
>  	}
> =20
> -	mtk_vcodec_debug(instance, "map iq table to 0x%p\n", remote_iq_table);
> +	mtk_vdec_debug(ctx, "map iq table to 0x%p\n", remote_iq_table);
> =20
>  	if (instance->iq_table.va)
>  		mtk_vcodec_mem_free(ctx, &instance->iq_table);
> @@ -965,8 +964,8 @@ static int vdec_av1_slice_alloc_working_buffer(struct=
 vdec_av1_slice_instance *i
>  	if (level =3D=3D instance->level)
>  		return 0;
> =20
> -	mtk_vcodec_debug(instance, "resolution level changed from %u to %u, %ux=
%u",
> -			 instance->level, level, w, h);
> +	mtk_vdec_debug(ctx, "resolution level changed from %u to %u, %ux%u",
> +		       instance->level, level, w, h);
> =20
>  	max_sb_w =3D DIV_ROUND_UP(max_w, 128);
>  	max_sb_h =3D DIV_ROUND_UP(max_h, 128);
> @@ -1400,17 +1399,17 @@ static int vdec_av1_slice_setup_tile_group(struct=
 vdec_av1_slice_instance *insta
> =20
>  	if (tile_group->num_tiles !=3D tge_size ||
>  	    tile_group->num_tiles > V4L2_AV1_MAX_TILE_COUNT) {
> -		mtk_vcodec_err(instance, "invalid tge_size %d, tile_num:%d\n",
> -			       tge_size, tile_group->num_tiles);
> +		mtk_vdec_err(instance->ctx, "invalid tge_size %d, tile_num:%d\n",
> +			     tge_size, tile_group->num_tiles);
>  		return -EINVAL;
>  	}
> =20
>  	for (i =3D 0; i < tge_size; i++) {
>  		if (i !=3D ctrl_tge[i].tile_row * vsi->frame.uh.tile.tile_cols +
>  		    ctrl_tge[i].tile_col) {
> -			mtk_vcodec_err(instance, "invalid tge info %d, %d %d %d\n",
> -				       i, ctrl_tge[i].tile_row, ctrl_tge[i].tile_col,
> -				       vsi->frame.uh.tile.tile_rows);
> +			mtk_vdec_err(instance->ctx, "invalid tge info %d, %d %d %d\n",
> +				     i, ctrl_tge[i].tile_row, ctrl_tge[i].tile_col,
> +				     vsi->frame.uh.tile.tile_rows);
>  			return -EINVAL;
>  		}
>  		tile_group->tile_size[i] =3D ctrl_tge[i].tile_size;
> @@ -1639,7 +1638,7 @@ static void vdec_av1_slice_setup_seg_buffer(struct =
vdec_av1_slice_instance *inst
> =20
>  	/* reset segment buffer */
>  	if (uh->primary_ref_frame =3D=3D AV1_PRIMARY_REF_NONE || !uh->seg.segme=
ntation_enabled) {
> -		mtk_vcodec_debug(instance, "reset seg %d\n", vsi->slot_id);
> +		mtk_vdec_debug(instance->ctx, "reset seg %d\n", vsi->slot_id);
>  		if (vsi->slot_id !=3D AV1_INVALID_IDX) {
>  			buf =3D &instance->seg[vsi->slot_id];
>  			memset(buf->va, 0, buf->size);
> @@ -1690,18 +1689,18 @@ static void vdec_av1_slice_setup_tile_buffer(stru=
ct vdec_av1_slice_instance *ins
>  		    uh->disable_frame_end_update_cdf =3D=3D 0)
>  			tile_info_buf[tile_info_base + 4] |=3D (1 << 17);
> =20
> -		mtk_vcodec_debug(instance, "// tile buf %d pos(%dx%d) offset 0x%x\n",
> -				 tile_num, tile_row, tile_col, tile_info_base);
> -		mtk_vcodec_debug(instance, "// %08x %08x %08x %08x\n",
> -				 tile_info_buf[tile_info_base + 0],
> -				 tile_info_buf[tile_info_base + 1],
> -				 tile_info_buf[tile_info_base + 2],
> -				 tile_info_buf[tile_info_base + 3]);
> -		mtk_vcodec_debug(instance, "// %08x %08x %08x %08x\n",
> -				 tile_info_buf[tile_info_base + 4],
> -				 tile_info_buf[tile_info_base + 5],
> -				 tile_info_buf[tile_info_base + 6],
> -				 tile_info_buf[tile_info_base + 7]);
> +		mtk_vdec_debug(instance->ctx, "// tile buf %d pos(%dx%d) offset 0x%x\n=
",
> +			       tile_num, tile_row, tile_col, tile_info_base);
> +		mtk_vdec_debug(instance->ctx, "// %08x %08x %08x %08x\n",
> +			       tile_info_buf[tile_info_base + 0],
> +			       tile_info_buf[tile_info_base + 1],
> +			       tile_info_buf[tile_info_base + 2],
> +			       tile_info_buf[tile_info_base + 3]);
> +		mtk_vdec_debug(instance->ctx, "// %08x %08x %08x %08x\n",
> +			       tile_info_buf[tile_info_base + 4],
> +			       tile_info_buf[tile_info_base + 5],
> +			       tile_info_buf[tile_info_base + 6],
> +			       tile_info_buf[tile_info_base + 7]);
>  	}
>  }
> =20
> @@ -1743,8 +1742,8 @@ static int vdec_av1_slice_update_lat(struct vdec_av=
1_slice_instance *instance,
>  	struct vdec_av1_slice_vsi *vsi;
> =20
>  	vsi =3D &pfc->vsi;
> -	mtk_vcodec_debug(instance, "frame %u LAT CRC 0x%08x, output size is %d\=
n",
> -			 pfc->seq, vsi->state.crc[0], vsi->state.out_size);
> +	mtk_vdec_debug(instance->ctx, "frame %u LAT CRC 0x%08x, output size is =
%d\n",
> +		       pfc->seq, vsi->state.crc[0], vsi->state.out_size);
> =20
>  	/* buffer full, need to re-decode */
>  	if (vsi->state.full) {
> @@ -1855,12 +1854,12 @@ static int vdec_av1_slice_update_core(struct vdec=
_av1_slice_instance *instance,
>  {
>  	struct vdec_av1_slice_vsi *vsi =3D instance->core_vsi;
> =20
> -	mtk_vcodec_debug(instance, "frame %u Y_CRC %08x %08x %08x %08x\n",
> -			 pfc->seq, vsi->state.crc[0], vsi->state.crc[1],
> -			 vsi->state.crc[2], vsi->state.crc[3]);
> -	mtk_vcodec_debug(instance, "frame %u C_CRC %08x %08x %08x %08x\n",
> -			 pfc->seq, vsi->state.crc[8], vsi->state.crc[9],
> -			 vsi->state.crc[10], vsi->state.crc[11]);
> +	mtk_vdec_debug(instance->ctx, "frame %u Y_CRC %08x %08x %08x %08x\n",
> +		       pfc->seq, vsi->state.crc[0], vsi->state.crc[1],
> +		       vsi->state.crc[2], vsi->state.crc[3]);
> +	mtk_vdec_debug(instance->ctx, "frame %u C_CRC %08x %08x %08x %08x\n",
> +		       pfc->seq, vsi->state.crc[8], vsi->state.crc[9],
> +		       vsi->state.crc[10], vsi->state.crc[11]);
> =20
>  	return 0;
>  }
> @@ -1883,14 +1882,14 @@ static int vdec_av1_slice_init(struct mtk_vcodec_=
ctx *ctx)
> =20
>  	ret =3D vpu_dec_init(&instance->vpu);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "failed to init vpu dec, ret %d\n", ret);
> +		mtk_vdec_err(ctx, "failed to init vpu dec, ret %d\n", ret);
>  		goto error_vpu_init;
>  	}
> =20
>  	/* init vsi and global flags */
>  	vsi =3D instance->vpu.vsi;
>  	if (!vsi) {
> -		mtk_vcodec_err(instance, "failed to get AV1 vsi\n");
> +		mtk_vdec_err(ctx, "failed to get AV1 vsi\n");
>  		ret =3D -EINVAL;
>  		goto error_vsi;
>  	}
> @@ -1898,20 +1897,20 @@ static int vdec_av1_slice_init(struct mtk_vcodec_=
ctx *ctx)
>  	instance->core_vsi =3D mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler, =
(u32)vsi->core_vsi);
> =20
>  	if (!instance->core_vsi) {
> -		mtk_vcodec_err(instance, "failed to get AV1 core vsi\n");
> +		mtk_vdec_err(ctx, "failed to get AV1 core vsi\n");
>  		ret =3D -EINVAL;
>  		goto error_vsi;
>  	}
> =20
>  	if (vsi->vsi_size !=3D sizeof(struct vdec_av1_slice_vsi))
> -		mtk_vcodec_err(instance, "remote vsi size 0x%x mismatch! expected: 0x%=
zx\n",
> -			       vsi->vsi_size, sizeof(struct vdec_av1_slice_vsi));
> +		mtk_vdec_err(ctx, "remote vsi size 0x%x mismatch! expected: 0x%zx\n",
> +			     vsi->vsi_size, sizeof(struct vdec_av1_slice_vsi));
> =20
>  	instance->irq_enabled =3D 1;
>  	instance->inneracing_mode =3D IS_VDEC_INNER_RACING(instance->ctx->dev->=
dec_capability);
> =20
> -	mtk_vcodec_debug(instance, "vsi 0x%p core_vsi 0x%llx 0x%p, inneracing_m=
ode %d\n",
> -			 vsi, vsi->core_vsi, instance->core_vsi, instance->inneracing_mode);
> +	mtk_vdec_debug(ctx, "vsi 0x%p core_vsi 0x%llx 0x%p, inneracing_mode %d\=
n",
> +		       vsi, vsi->core_vsi, instance->core_vsi, instance->inneracing_mo=
de);
> =20
>  	ret =3D vdec_av1_slice_init_cdf_table(instance);
>  	if (ret)
> @@ -1938,7 +1937,7 @@ static void vdec_av1_slice_deinit(void *h_vdec)
> =20
>  	if (!instance)
>  		return;
> -	mtk_vcodec_debug(instance, "h_vdec 0x%p\n", h_vdec);
> +	mtk_vdec_debug(instance->ctx, "h_vdec 0x%p\n", h_vdec);
>  	vpu_dec_deinit(&instance->vpu);
>  	vdec_av1_slice_free_working_buffer(instance);
>  	vdec_msg_queue_deinit(&instance->ctx->msg_queue, instance->ctx);
> @@ -1951,7 +1950,7 @@ static int vdec_av1_slice_flush(void *h_vdec, struc=
t mtk_vcodec_mem *bs,
>  	struct vdec_av1_slice_instance *instance =3D h_vdec;
>  	int i;
> =20
> -	mtk_vcodec_debug(instance, "flush ...\n");
> +	mtk_vdec_debug(instance->ctx, "flush ...\n");
> =20
>  	vdec_msg_queue_wait_lat_buf_full(&instance->ctx->msg_queue);
> =20
> @@ -1966,7 +1965,7 @@ static void vdec_av1_slice_get_pic_info(struct vdec=
_av1_slice_instance *instance
>  	struct mtk_vcodec_ctx *ctx =3D instance->ctx;
>  	u32 data[3];
> =20
> -	mtk_vcodec_debug(instance, "w %u h %u\n", ctx->picinfo.pic_w, ctx->pici=
nfo.pic_h);
> +	mtk_vdec_debug(ctx, "w %u h %u\n", ctx->picinfo.pic_w, ctx->picinfo.pic=
_h);
> =20
>  	data[0] =3D ctx->picinfo.pic_w;
>  	data[1] =3D ctx->picinfo.pic_h;
> @@ -1996,8 +1995,8 @@ static void vdec_av1_slice_get_crop_info(struct vde=
c_av1_slice_instance *instanc
>  	cr->width =3D ctx->picinfo.pic_w;
>  	cr->height =3D ctx->picinfo.pic_h;
> =20
> -	mtk_vcodec_debug(instance, "l=3D%d, t=3D%d, w=3D%d, h=3D%d\n",
> -			 cr->left, cr->top, cr->width, cr->height);
> +	mtk_vdec_debug(ctx, "l=3D%d, t=3D%d, w=3D%d, h=3D%d\n",
> +		       cr->left, cr->top, cr->width, cr->height);
>  }
> =20
>  static int vdec_av1_slice_get_param(void *h_vdec, enum vdec_get_param_ty=
pe type, void *out)
> @@ -2015,7 +2014,7 @@ static int vdec_av1_slice_get_param(void *h_vdec, e=
num vdec_get_param_type type,
>  		vdec_av1_slice_get_crop_info(instance, out);
>  		break;
>  	default:
> -		mtk_vcodec_err(instance, "invalid get parameter type=3D%d\n", type);
> +		mtk_vdec_err(instance->ctx, "invalid get parameter type=3D%d\n", type)=
;
>  		return -EINVAL;
>  	}
> =20
> @@ -2039,7 +2038,7 @@ static int vdec_av1_slice_lat_decode(void *h_vdec, =
struct mtk_vcodec_mem *bs,
>  	/* init msgQ for the first time */
>  	if (vdec_msg_queue_init(&ctx->msg_queue, ctx,
>  				vdec_av1_slice_core_decode, sizeof(*pfc))) {
> -		mtk_vcodec_err(instance, "failed to init AV1 msg queue\n");
> +		mtk_vdec_err(ctx, "failed to init AV1 msg queue\n");
>  		return -ENOMEM;
>  	}
> =20
> @@ -2049,7 +2048,7 @@ static int vdec_av1_slice_lat_decode(void *h_vdec, =
struct mtk_vcodec_mem *bs,
> =20
>  	lat_buf =3D vdec_msg_queue_dqbuf(&ctx->msg_queue.lat_ctx);
>  	if (!lat_buf) {
> -		mtk_vcodec_err(instance, "failed to get AV1 lat buf\n");
> +		mtk_vdec_err(ctx, "failed to get AV1 lat buf\n");
>  		return -EAGAIN;
>  	}
>  	pfc =3D (struct vdec_av1_slice_pfc *)lat_buf->private_data;
> @@ -2061,14 +2060,14 @@ static int vdec_av1_slice_lat_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs,
> =20
>  	ret =3D vdec_av1_slice_setup_lat(instance, bs, lat_buf, pfc);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "failed to setup AV1 lat ret %d\n", ret);
> +		mtk_vdec_err(ctx, "failed to setup AV1 lat ret %d\n", ret);
>  		goto err_free_fb_out;
>  	}
> =20
>  	vdec_av1_slice_vsi_to_remote(vsi, instance->vsi);
>  	ret =3D vpu_dec_start(&instance->vpu, NULL, 0);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "failed to dec AV1 ret %d\n", ret);
> +		mtk_vdec_err(ctx, "failed to dec AV1 ret %d\n", ret);
>  		goto err_free_fb_out;
>  	}
>  	if (instance->inneracing_mode)
> @@ -2080,7 +2079,7 @@ static int vdec_av1_slice_lat_decode(void *h_vdec, =
struct mtk_vcodec_mem *bs,
>  						   MTK_VDEC_LAT0);
>  		/* update remote vsi if decode timeout */
>  		if (ret) {
> -			mtk_vcodec_err(instance, "AV1 Frame %d decode timeout %d\n", pfc->seq=
, ret);
> +			mtk_vdec_err(ctx, "AV1 Frame %d decode timeout %d\n", pfc->seq, ret);
>  			WRITE_ONCE(instance->vsi->state.timeout, 1);
>  		}
>  		vpu_dec_end(&instance->vpu);
> @@ -2091,7 +2090,7 @@ static int vdec_av1_slice_lat_decode(void *h_vdec, =
struct mtk_vcodec_mem *bs,
> =20
>  	/* LAT trans full, re-decode */
>  	if (ret =3D=3D -EAGAIN) {
> -		mtk_vcodec_err(instance, "AV1 Frame %d trans full\n", pfc->seq);
> +		mtk_vdec_err(ctx, "AV1 Frame %d trans full\n", pfc->seq);
>  		if (!instance->inneracing_mode)
>  			vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
>  		return 0;
> @@ -2099,14 +2098,14 @@ static int vdec_av1_slice_lat_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs,
> =20
>  	/* LAT trans full, no more UBE or decode timeout */
>  	if (ret =3D=3D -ENOMEM || vsi->state.timeout) {
> -		mtk_vcodec_err(instance, "AV1 Frame %d insufficient buffer or timeout\=
n", pfc->seq);
> +		mtk_vdec_err(ctx, "AV1 Frame %d insufficient buffer or timeout\n", pfc=
->seq);
>  		if (!instance->inneracing_mode)
>  			vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
>  		return -EBUSY;
>  	}
>  	vsi->trans.dma_addr_end +=3D ctx->msg_queue.wdma_addr.dma_addr;
> -	mtk_vcodec_debug(instance, "lat dma 1 0x%pad 0x%pad\n",
> -			 &pfc->vsi.trans.dma_addr, &pfc->vsi.trans.dma_addr_end);
> +	mtk_vdec_debug(ctx, "lat dma 1 0x%pad 0x%pad\n",
> +		       &pfc->vsi.trans.dma_addr, &pfc->vsi.trans.dma_addr_end);
> =20
>  	vdec_msg_queue_update_ube_wptr(&ctx->msg_queue, vsi->trans.dma_addr_end=
);
> =20
> @@ -2120,7 +2119,7 @@ static int vdec_av1_slice_lat_decode(void *h_vdec, =
struct mtk_vcodec_mem *bs,
>  	vdec_msg_queue_qbuf(&ctx->msg_queue.lat_ctx, lat_buf);
> =20
>  	if (pfc)
> -		mtk_vcodec_err(instance, "slice dec number: %d err: %d", pfc->seq, ret=
);
> +		mtk_vdec_err(ctx, "slice dec number: %d err: %d", pfc->seq, ret);
> =20
>  	return ret;
>  }
> @@ -2153,13 +2152,13 @@ static int vdec_av1_slice_core_decode(struct vdec=
_lat_buf *lat_buf)
> =20
>  	ret =3D vdec_av1_slice_setup_core(instance, fb, lat_buf, pfc);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "vdec_av1_slice_setup_core\n");
> +		mtk_vdec_err(ctx, "vdec_av1_slice_setup_core\n");
>  		goto err;
>  	}
>  	vdec_av1_slice_vsi_to_remote(&pfc->vsi, instance->core_vsi);
>  	ret =3D vpu_dec_core(&instance->vpu);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "vpu_dec_core\n");
> +		mtk_vdec_err(ctx, "vpu_dec_core\n");
>  		goto err;
>  	}
> =20
> @@ -2169,7 +2168,7 @@ static int vdec_av1_slice_core_decode(struct vdec_l=
at_buf *lat_buf)
>  						   MTK_VDEC_CORE);
>  		/* update remote vsi if decode timeout */
>  		if (ret) {
> -			mtk_vcodec_err(instance, "AV1 frame %d core timeout\n", pfc->seq);
> +			mtk_vdec_err(ctx, "AV1 frame %d core timeout\n", pfc->seq);
>  			WRITE_ONCE(instance->vsi->state.timeout, 1);
>  		}
>  		vpu_dec_core_end(&instance->vpu);
> @@ -2177,12 +2176,12 @@ static int vdec_av1_slice_core_decode(struct vdec=
_lat_buf *lat_buf)
> =20
>  	ret =3D vdec_av1_slice_update_core(instance, lat_buf, pfc);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "vdec_av1_slice_update_core\n");
> +		mtk_vdec_err(ctx, "vdec_av1_slice_update_core\n");
>  		goto err;
>  	}
> =20
> -	mtk_vcodec_debug(instance, "core dma_addr_end 0x%pad\n",
> -			 &instance->core_vsi->trans.dma_addr_end);
> +	mtk_vdec_debug(ctx, "core dma_addr_end 0x%pad\n",
> +		       &instance->core_vsi->trans.dma_addr_end);
>  	vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, instance->core_vsi->tra=
ns.dma_addr_end);
> =20
>  	ctx->dev->vdec_pdata->cap_to_disp(ctx, 0, lat_buf->src_buf_req);
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> index 24312a90afbb..ca5437ae37f6 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
> @@ -144,7 +144,7 @@ static int allocate_predication_buf(struct vdec_h264_=
inst *inst)
>  	inst->pred_buf.size =3D BUF_PREDICTION_SZ;
>  	err =3D mtk_vcodec_mem_alloc(inst->ctx, &inst->pred_buf);
>  	if (err) {
> -		mtk_vcodec_err(inst, "failed to allocate ppl buf");
> +		mtk_vdec_err(inst->ctx, "failed to allocate ppl buf");
>  		return err;
>  	}
> =20
> @@ -176,7 +176,7 @@ static int alloc_mv_buf(struct vdec_h264_inst *inst, =
struct vdec_pic_info *pic)
>  		mem->size =3D buf_sz;
>  		err =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  		if (err) {
> -			mtk_vcodec_err(inst, "failed to allocate mv buf");
> +			mtk_vdec_err(inst->ctx, "failed to allocate mv buf");
>  			return err;
>  		}
>  		inst->vsi->mv_buf_dma[i] =3D mem->dma_addr;
> @@ -207,9 +207,9 @@ static int check_list_validity(struct vdec_h264_inst =
*inst, bool disp_list)
>  	if (list->count > H264_MAX_FB_NUM ||
>  	    list->read_idx >=3D H264_MAX_FB_NUM ||
>  	    list->write_idx >=3D H264_MAX_FB_NUM) {
> -		mtk_vcodec_err(inst, "%s list err: cnt=3D%d r_idx=3D%d w_idx=3D%d",
> -			       disp_list ? "disp" : "free", list->count,
> -			       list->read_idx, list->write_idx);
> +		mtk_vdec_err(inst->ctx, "%s list err: cnt=3D%d r_idx=3D%d w_idx=3D%d",
> +			     disp_list ? "disp" : "free", list->count,
> +			     list->read_idx, list->write_idx);
>  		return -EINVAL;
>  	}
> =20
> @@ -226,12 +226,12 @@ static void put_fb_to_free(struct vdec_h264_inst *i=
nst, struct vdec_fb *fb)
> =20
>  		list =3D &inst->vsi->list_free;
>  		if (list->count =3D=3D H264_MAX_FB_NUM) {
> -			mtk_vcodec_err(inst, "[FB] put fb free_list full");
> +			mtk_vdec_err(inst->ctx, "[FB] put fb free_list full");
>  			return;
>  		}
> =20
> -		mtk_vcodec_debug(inst, "[FB] put fb into free_list @(%p, %llx)",
> -				 fb->base_y.va, (u64)fb->base_y.dma_addr);
> +		mtk_vdec_debug(inst->ctx, "[FB] put fb into free_list @(%p, %llx)",
> +			       fb->base_y.va, (u64)fb->base_y.dma_addr);
> =20
>  		list->fb_list[list->write_idx].vdec_fb_va =3D (u64)(uintptr_t)fb;
>  		list->write_idx =3D (list->write_idx =3D=3D H264_MAX_FB_NUM - 1) ?
> @@ -244,10 +244,9 @@ static void get_pic_info(struct vdec_h264_inst *inst=
,
>  			 struct vdec_pic_info *pic)
>  {
>  	*pic =3D inst->vsi->pic;
> -	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
> -			 pic->pic_w, pic->pic_h, pic->buf_w, pic->buf_h);
> -	mtk_vcodec_debug(inst, "fb size: Y(%d), C(%d)",
> -			 pic->fb_sz[0], pic->fb_sz[1]);
> +	mtk_vdec_debug(inst->ctx, "pic(%d, %d), buf(%d, %d)",
> +		       pic->pic_w, pic->pic_h, pic->buf_w, pic->buf_h);
> +	mtk_vdec_debug(inst->ctx, "fb size: Y(%d), C(%d)", pic->fb_sz[0], pic->=
fb_sz[1]);
>  }
> =20
>  static void get_crop_info(struct vdec_h264_inst *inst, struct v4l2_rect =
*cr)
> @@ -257,14 +256,14 @@ static void get_crop_info(struct vdec_h264_inst *in=
st, struct v4l2_rect *cr)
>  	cr->width =3D inst->vsi->crop.width;
>  	cr->height =3D inst->vsi->crop.height;
> =20
> -	mtk_vcodec_debug(inst, "l=3D%d, t=3D%d, w=3D%d, h=3D%d",
> -			 cr->left, cr->top, cr->width, cr->height);
> +	mtk_vdec_debug(inst->ctx, "l=3D%d, t=3D%d, w=3D%d, h=3D%d", cr->left, c=
r->top,
> +		       cr->width, cr->height);
>  }
> =20
>  static void get_dpb_size(struct vdec_h264_inst *inst, unsigned int *dpb_=
sz)
>  {
>  	*dpb_sz =3D inst->vsi->dec.dpb_sz;
> -	mtk_vcodec_debug(inst, "sz=3D%d", *dpb_sz);
> +	mtk_vdec_debug(inst->ctx, "sz=3D%d", *dpb_sz);
>  }
> =20
>  static int vdec_h264_init(struct mtk_vcodec_ctx *ctx)
> @@ -283,7 +282,7 @@ static int vdec_h264_init(struct mtk_vcodec_ctx *ctx)
> =20
>  	err =3D vpu_dec_init(&inst->vpu);
>  	if (err) {
> -		mtk_vcodec_err(inst, "vdec_h264 init err=3D%d", err);
> +		mtk_vdec_err(ctx, "vdec_h264 init err=3D%d", err);
>  		goto error_free_inst;
>  	}
> =20
> @@ -292,7 +291,7 @@ static int vdec_h264_init(struct mtk_vcodec_ctx *ctx)
>  	if (err)
>  		goto error_deinit;
> =20
> -	mtk_vcodec_debug(inst, "H264 Instance >> %p", inst);
> +	mtk_vdec_debug(ctx, "H264 Instance >> %p", inst);
> =20
>  	ctx->drv_handle =3D inst;
>  	return 0;
> @@ -344,8 +343,8 @@ static int vdec_h264_decode(void *h_vdec, struct mtk_=
vcodec_mem *bs,
>  	uint64_t y_fb_dma =3D fb ? (u64)fb->base_y.dma_addr : 0;
>  	uint64_t c_fb_dma =3D fb ? (u64)fb->base_c.dma_addr : 0;
> =20
> -	mtk_vcodec_debug(inst, "+ [%d] FB y_dma=3D%llx c_dma=3D%llx va=3D%p",
> -			 ++inst->num_nalu, y_fb_dma, c_fb_dma, fb);
> +	mtk_vdec_debug(inst->ctx, "+ [%d] FB y_dma=3D%llx c_dma=3D%llx va=3D%p"=
,
> +		       ++inst->num_nalu, y_fb_dma, c_fb_dma, fb);
> =20
>  	/* bs NULL means flush decoder */
>  	if (bs =3D=3D NULL)
> @@ -355,15 +354,15 @@ static int vdec_h264_decode(void *h_vdec, struct mt=
k_vcodec_mem *bs,
>  	buf_sz =3D bs->size;
>  	nal_start_idx =3D find_start_code(buf, buf_sz);
>  	if (nal_start_idx < 0) {
> -		mtk_vcodec_err(inst, "invalid nal start code");
> +		mtk_vdec_err(inst->ctx, "invalid nal start code");
>  		err =3D -EIO;
>  		goto err_free_fb_out;
>  	}
> =20
>  	nal_start =3D buf[nal_start_idx];
>  	nal_type =3D NAL_TYPE(buf[nal_start_idx]);
> -	mtk_vcodec_debug(inst, "\n + NALU[%d] type %d +\n", inst->num_nalu,
> -			 nal_type);
> +	mtk_vdec_debug(inst->ctx, "\n + NALU[%d] type %d +\n", inst->num_nalu,
> +		       nal_type);
> =20
>  	if (nal_type =3D=3D NAL_H264_PPS) {
>  		buf_sz -=3D nal_start_idx;
> @@ -384,8 +383,7 @@ static int vdec_h264_decode(void *h_vdec, struct mtk_=
vcodec_mem *bs,
>  	err =3D vpu_dec_start(vpu, data, 2);
>  	if (err) {
>  		if (err > 0 && (DEC_ERR_RET(err) =3D=3D H264_ERR_NOT_VALID)) {
> -			mtk_vcodec_err(inst, "- error bitstream - err =3D %d -",
> -				       err);
> +			mtk_vdec_err(inst->ctx, "- error bitstream - err =3D %d -", err);
>  			err =3D -EIO;
>  		}
>  		goto err_free_fb_out;
> @@ -395,7 +393,7 @@ static int vdec_h264_decode(void *h_vdec, struct mtk_=
vcodec_mem *bs,
>  	if (*res_chg) {
>  		struct vdec_pic_info pic;
> =20
> -		mtk_vcodec_debug(inst, "- resolution changed -");
> +		mtk_vdec_debug(inst->ctx, "- resolution changed -");
>  		get_pic_info(inst, &pic);
> =20
>  		if (inst->vsi->dec.realloc_mv_buf) {
> @@ -416,13 +414,12 @@ static int vdec_h264_decode(void *h_vdec, struct mt=
k_vcodec_mem *bs,
>  		vpu_dec_end(vpu);
>  	}
> =20
> -	mtk_vcodec_debug(inst, "\n - NALU[%d] type=3D%d -\n", inst->num_nalu,
> -			 nal_type);
> +	mtk_vdec_debug(inst->ctx, "\n - NALU[%d] type=3D%d -\n", inst->num_nalu=
, nal_type);
>  	return 0;
> =20
>  err_free_fb_out:
>  	put_fb_to_free(inst, fb);
> -	mtk_vcodec_err(inst, "\n - NALU[%d] err=3D%d -\n", inst->num_nalu, err)=
;
> +	mtk_vdec_err(inst->ctx, "\n - NALU[%d] err=3D%d -\n", inst->num_nalu, e=
rr);
>  	return err;
>  }
> =20
> @@ -436,8 +433,7 @@ static void vdec_h264_get_fb(struct vdec_h264_inst *i=
nst,
>  		return;
> =20
>  	if (list->count =3D=3D 0) {
> -		mtk_vcodec_debug(inst, "[FB] there is no %s fb",
> -				 disp_list ? "disp" : "free");
> +		mtk_vdec_debug(inst->ctx, "[FB] there is no %s fb", disp_list ? "disp"=
 : "free");
>  		*out_fb =3D NULL;
>  		return;
>  	}
> @@ -447,10 +443,10 @@ static void vdec_h264_get_fb(struct vdec_h264_inst =
*inst,
>  	fb->status |=3D (disp_list ? FB_ST_DISPLAY : FB_ST_FREE);
> =20
>  	*out_fb =3D fb;
> -	mtk_vcodec_debug(inst, "[FB] get %s fb st=3D%d poc=3D%d %llx",
> -			 disp_list ? "disp" : "free",
> -			 fb->status, list->fb_list[list->read_idx].poc,
> -			 list->fb_list[list->read_idx].vdec_fb_va);
> +	mtk_vdec_debug(inst->ctx, "[FB] get %s fb st=3D%d poc=3D%d %llx",
> +		       disp_list ? "disp" : "free",
> +		       fb->status, list->fb_list[list->read_idx].poc,
> +		       list->fb_list[list->read_idx].vdec_fb_va);
> =20
>  	list->read_idx =3D (list->read_idx =3D=3D H264_MAX_FB_NUM - 1) ?
>  			 0 : list->read_idx + 1;
> @@ -484,7 +480,7 @@ static int vdec_h264_get_param(void *h_vdec, enum vde=
c_get_param_type type,
>  		break;
> =20
>  	default:
> -		mtk_vcodec_err(inst, "invalid get parameter type=3D%d", type);
> +		mtk_vdec_err(inst->ctx, "invalid get parameter type=3D%d", type);
>  		return -EINVAL;
>  	}
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if=
.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> index dc6ee266f232..250746db366b 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
> @@ -162,7 +162,7 @@ static int allocate_predication_buf(struct vdec_h264_=
slice_inst *inst)
>  	inst->pred_buf.size =3D BUF_PREDICTION_SZ;
>  	err =3D mtk_vcodec_mem_alloc(inst->ctx, &inst->pred_buf);
>  	if (err) {
> -		mtk_vcodec_err(inst, "failed to allocate ppl buf");
> +		mtk_vdec_err(inst->ctx, "failed to allocate ppl buf");
>  		return err;
>  	}
> =20
> @@ -195,7 +195,7 @@ static int alloc_mv_buf(struct vdec_h264_slice_inst *=
inst,
>  		mem->size =3D buf_sz;
>  		err =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  		if (err) {
> -			mtk_vcodec_err(inst, "failed to allocate mv buf");
> +			mtk_vdec_err(inst->ctx, "failed to allocate mv buf");
>  			return err;
>  		}
>  		inst->vsi_ctx.mv_buf_dma[i] =3D mem->dma_addr;
> @@ -230,11 +230,11 @@ static void get_pic_info(struct vdec_h264_slice_ins=
t *inst,
>  		ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes;
> =20
>  	*pic =3D ctx->picinfo;
> -	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
> -			 ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> -			 ctx->picinfo.buf_w, ctx->picinfo.buf_h);
> -	mtk_vcodec_debug(inst, "Y/C(%d, %d)", ctx->picinfo.fb_sz[0],
> -			 ctx->picinfo.fb_sz[1]);
> +	mtk_vdec_debug(inst->ctx, "pic(%d, %d), buf(%d, %d)",
> +		       ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> +		       ctx->picinfo.buf_w, ctx->picinfo.buf_h);
> +	mtk_vdec_debug(inst->ctx, "Y/C(%d, %d)", ctx->picinfo.fb_sz[0],
> +		       ctx->picinfo.fb_sz[1]);
> =20
>  	if (ctx->last_decoded_picinfo.pic_w !=3D ctx->picinfo.pic_w ||
>  	    ctx->last_decoded_picinfo.pic_h !=3D ctx->picinfo.pic_h) {
> @@ -259,14 +259,14 @@ static void get_crop_info(struct vdec_h264_slice_in=
st *inst, struct v4l2_rect *c
>  	cr->width =3D inst->vsi_ctx.crop.width;
>  	cr->height =3D inst->vsi_ctx.crop.height;
> =20
> -	mtk_vcodec_debug(inst, "l=3D%d, t=3D%d, w=3D%d, h=3D%d",
> -			 cr->left, cr->top, cr->width, cr->height);
> +	mtk_vdec_debug(inst->ctx, "l=3D%d, t=3D%d, w=3D%d, h=3D%d",
> +		       cr->left, cr->top, cr->width, cr->height);
>  }
> =20
>  static void get_dpb_size(struct vdec_h264_slice_inst *inst, unsigned int=
 *dpb_sz)
>  {
>  	*dpb_sz =3D inst->vsi_ctx.dec.dpb_sz;
> -	mtk_vcodec_debug(inst, "sz=3D%d", *dpb_sz);
> +	mtk_vdec_debug(inst->ctx, "sz=3D%d", *dpb_sz);
>  }
> =20
>  static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
> @@ -285,7 +285,7 @@ static int vdec_h264_slice_init(struct mtk_vcodec_ctx=
 *ctx)
> =20
>  	err =3D vpu_dec_init(&inst->vpu);
>  	if (err) {
> -		mtk_vcodec_err(inst, "vdec_h264 init err=3D%d", err);
> +		mtk_vdec_err(ctx, "vdec_h264 init err=3D%d", err);
>  		goto error_free_inst;
>  	}
> =20
> @@ -297,13 +297,13 @@ static int vdec_h264_slice_init(struct mtk_vcodec_c=
tx *ctx)
>  	if (err)
>  		goto error_deinit;
> =20
> -	mtk_vcodec_debug(inst, "struct size =3D %zu,%zu,%zu,%zu\n",
> -			 sizeof(struct mtk_h264_sps_param),
> -			 sizeof(struct mtk_h264_pps_param),
> -			 sizeof(struct mtk_h264_dec_slice_param),
> -			 sizeof(struct mtk_h264_dpb_info));
> +	mtk_vdec_debug(ctx, "struct size =3D %zu,%zu,%zu,%zu\n",
> +		       sizeof(struct mtk_h264_sps_param),
> +		       sizeof(struct mtk_h264_pps_param),
> +		       sizeof(struct mtk_h264_dec_slice_param),
> +		       sizeof(struct mtk_h264_dpb_info));
> =20
> -	mtk_vcodec_debug(inst, "H264 Instance >> %p", inst);
> +	mtk_vdec_debug(ctx, "H264 Instance >> %p", inst);
> =20
>  	ctx->drv_handle =3D inst;
>  	return 0;
> @@ -354,8 +354,8 @@ static int vdec_h264_slice_decode(void *h_vdec, struc=
t mtk_vcodec_mem *bs,
>  	y_fb_dma =3D fb ? (u64)fb->base_y.dma_addr : 0;
>  	c_fb_dma =3D fb ? (u64)fb->base_c.dma_addr : 0;
> =20
> -	mtk_vcodec_debug(inst, "+ [%d] FB y_dma=3D%llx c_dma=3D%llx va=3D%p",
> -			 inst->num_nalu, y_fb_dma, c_fb_dma, fb);
> +	mtk_vdec_debug(inst->ctx, "+ [%d] FB y_dma=3D%llx c_dma=3D%llx va=3D%p"=
,
> +		       inst->num_nalu, y_fb_dma, c_fb_dma, fb);
> =20
>  	inst->vsi_ctx.dec.bs_dma =3D (uint64_t)bs->dma_addr;
>  	inst->vsi_ctx.dec.y_fb_dma =3D y_fb_dma;
> @@ -380,7 +380,7 @@ static int vdec_h264_slice_decode(void *h_vdec, struc=
t mtk_vcodec_mem *bs,
> =20
>  	*res_chg =3D inst->vsi_ctx.dec.resolution_changed;
>  	if (*res_chg) {
> -		mtk_vcodec_debug(inst, "- resolution changed -");
> +		mtk_vdec_debug(inst->ctx, "- resolution changed -");
>  		if (inst->vsi_ctx.dec.realloc_mv_buf) {
>  			err =3D alloc_mv_buf(inst, &inst->ctx->picinfo);
>  			inst->vsi_ctx.dec.realloc_mv_buf =3D false;
> @@ -404,11 +404,11 @@ static int vdec_h264_slice_decode(void *h_vdec, str=
uct mtk_vcodec_mem *bs,
>  	vpu_dec_end(vpu);
> =20
>  	memcpy(&inst->vsi_ctx, inst->vpu.vsi, sizeof(inst->vsi_ctx));
> -	mtk_vcodec_debug(inst, "\n - NALU[%d]", inst->num_nalu);
> +	mtk_vdec_debug(inst->ctx, "\n - NALU[%d]", inst->num_nalu);
>  	return 0;
> =20
>  err_free_fb_out:
> -	mtk_vcodec_err(inst, "\n - NALU[%d] err=3D%d -\n", inst->num_nalu, err)=
;
> +	mtk_vdec_err(inst->ctx, "\n - NALU[%d] err=3D%d -\n", inst->num_nalu, e=
rr);
>  	return err;
>  }
> =20
> @@ -430,7 +430,7 @@ static int vdec_h264_slice_get_param(void *h_vdec, en=
um vdec_get_param_type type
>  		break;
> =20
>  	default:
> -		mtk_vcodec_err(inst, "invalid get parameter type=3D%d", type);
> +		mtk_vdec_err(inst->ctx, "invalid get parameter type=3D%d", type);
>  		return -EINVAL;
>  	}
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_=
if.c
> index 3cb5b967f48a..2a160dcb5296 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.=
c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.=
c
> @@ -199,7 +199,7 @@ static int vdec_h264_slice_fill_decode_parameters(str=
uct vdec_h264_slice_inst *i
>  		return PTR_ERR(pps);
> =20
>  	if (dec_params->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC) {
> -		mtk_vcodec_err(inst, "No support for H.264 field decoding.");
> +		mtk_vdec_err(inst->ctx, "No support for H.264 field decoding.");
>  		inst->is_field_bitstream =3D true;
>  		return -EINVAL;
>  	}
> @@ -322,7 +322,7 @@ static int vdec_h264_slice_alloc_mv_buf(struct vdec_h=
264_slice_inst *inst,
>  		mem->size =3D buf_sz;
>  		err =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  		if (err) {
> -			mtk_vcodec_err(inst, "failed to allocate mv buf");
> +			mtk_vdec_err(inst->ctx, "failed to allocate mv buf");
>  			return err;
>  		}
>  	}
> @@ -359,11 +359,11 @@ static void vdec_h264_slice_get_pic_info(struct vde=
c_h264_slice_inst *inst)
>  	inst->cap_num_planes =3D
>  		ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes;
> =20
> -	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
> -			 ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> -			 ctx->picinfo.buf_w, ctx->picinfo.buf_h);
> -	mtk_vcodec_debug(inst, "Y/C(%d, %d)", ctx->picinfo.fb_sz[0],
> -			 ctx->picinfo.fb_sz[1]);
> +	mtk_vdec_debug(ctx, "pic(%d, %d), buf(%d, %d)",
> +		       ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> +		       ctx->picinfo.buf_w, ctx->picinfo.buf_h);
> +	mtk_vdec_debug(ctx, "Y/C(%d, %d)", ctx->picinfo.fb_sz[0],
> +		       ctx->picinfo.fb_sz[1]);
> =20
>  	if (ctx->last_decoded_picinfo.pic_w !=3D ctx->picinfo.pic_w ||
>  	    ctx->last_decoded_picinfo.pic_h !=3D ctx->picinfo.pic_h) {
> @@ -389,8 +389,8 @@ static void vdec_h264_slice_get_crop_info(struct vdec=
_h264_slice_inst *inst,
>  	cr->width =3D inst->ctx->picinfo.pic_w;
>  	cr->height =3D inst->ctx->picinfo.pic_h;
> =20
> -	mtk_vcodec_debug(inst, "l=3D%d, t=3D%d, w=3D%d, h=3D%d",
> -			 cr->left, cr->top, cr->width, cr->height);
> +	mtk_vdec_debug(inst->ctx, "l=3D%d, t=3D%d, w=3D%d, h=3D%d",
> +		       cr->left, cr->top, cr->width, cr->height);
>  }
> =20
>  static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
> @@ -412,7 +412,7 @@ static int vdec_h264_slice_init(struct mtk_vcodec_ctx=
 *ctx)
> =20
>  	err =3D vpu_dec_init(&inst->vpu);
>  	if (err) {
> -		mtk_vcodec_err(inst, "vdec_h264 init err=3D%d", err);
> +		mtk_vdec_err(ctx, "vdec_h264 init err=3D%d", err);
>  		goto error_free_inst;
>  	}
> =20
> @@ -423,14 +423,14 @@ static int vdec_h264_slice_init(struct mtk_vcodec_c=
tx *ctx)
>  	inst->resolution_changed =3D true;
>  	inst->realloc_mv_buf =3D true;
> =20
> -	mtk_vcodec_debug(inst, "lat struct size =3D %d,%d,%d,%d vsi: %d\n",
> -			 (int)sizeof(struct mtk_h264_sps_param),
> -			 (int)sizeof(struct mtk_h264_pps_param),
> -			 (int)sizeof(struct vdec_h264_slice_lat_dec_param),
> -			 (int)sizeof(struct mtk_h264_dpb_info),
> -			 vsi_size);
> -	mtk_vcodec_debug(inst, "lat H264 instance >> %p, codec_type =3D 0x%x",
> -			 inst, inst->vpu.codec_type);
> +	mtk_vdec_debug(ctx, "lat struct size =3D %d,%d,%d,%d vsi: %d\n",
> +		       (int)sizeof(struct mtk_h264_sps_param),
> +		       (int)sizeof(struct mtk_h264_pps_param),
> +		       (int)sizeof(struct vdec_h264_slice_lat_dec_param),
> +		       (int)sizeof(struct mtk_h264_dpb_info),
> +		       vsi_size);
> +	mtk_vdec_debug(ctx, "lat H264 instance >> %p, codec_type =3D 0x%x",
> +		       inst, inst->vpu.codec_type);
> =20
>  	ctx->drv_handle =3D inst;
>  	return 0;
> @@ -464,14 +464,14 @@ static int vdec_h264_slice_core_decode(struct vdec_=
lat_buf *lat_buf)
>  	struct mtk_vcodec_mem *mem;
>  	struct vdec_vpu_inst *vpu =3D &inst->vpu;
> =20
> -	mtk_vcodec_debug(inst, "[h264-core] vdec_h264 core decode");
> +	mtk_vdec_debug(ctx, "[h264-core] vdec_h264 core decode");
>  	memcpy(&inst->vsi_core->h264_slice_params, &share_info->h264_slice_para=
ms,
>  	       sizeof(share_info->h264_slice_params));
> =20
>  	fb =3D ctx->dev->vdec_pdata->get_cap_buffer(ctx);
>  	if (!fb) {
>  		err =3D -EBUSY;
> -		mtk_vcodec_err(inst, "fb buffer is NULL");
> +		mtk_vdec_err(ctx, "fb buffer is NULL");
>  		goto vdec_dec_end;
>  	}
> =20
> @@ -483,8 +483,7 @@ static int vdec_h264_slice_core_decode(struct vdec_la=
t_buf *lat_buf)
>  	else
>  		c_fb_dma =3D (u64)fb->base_c.dma_addr;
> =20
> -	mtk_vcodec_debug(inst, "[h264-core] y/c addr =3D 0x%llx 0x%llx", y_fb_d=
ma,
> -			 c_fb_dma);
> +	mtk_vdec_debug(ctx, "[h264-core] y/c addr =3D 0x%llx 0x%llx", y_fb_dma,=
 c_fb_dma);
> =20
>  	inst->vsi_core->dec.y_fb_dma =3D y_fb_dma;
>  	inst->vsi_core->dec.c_fb_dma =3D c_fb_dma;
> @@ -514,7 +513,7 @@ static int vdec_h264_slice_core_decode(struct vdec_la=
t_buf *lat_buf)
> =20
>  	err =3D vpu_dec_core(vpu);
>  	if (err) {
> -		mtk_vcodec_err(inst, "core decode err=3D%d", err);
> +		mtk_vdec_err(ctx, "core decode err=3D%d", err);
>  		goto vdec_dec_end;
>  	}
> =20
> @@ -522,22 +521,21 @@ static int vdec_h264_slice_core_decode(struct vdec_=
lat_buf *lat_buf)
>  	timeout =3D mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIV=
ED,
>  					       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
>  	if (timeout)
> -		mtk_vcodec_err(inst, "core decode timeout: pic_%d",
> -			       ctx->decoded_frame_cnt);
> +		mtk_vdec_err(ctx, "core decode timeout: pic_%d", ctx->decoded_frame_cn=
t);
>  	inst->vsi_core->dec.timeout =3D !!timeout;
> =20
>  	vpu_dec_core_end(vpu);
> -	mtk_vcodec_debug(inst, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x=
 0x%x",
> -			 ctx->decoded_frame_cnt,
> -			 inst->vsi_core->dec.crc[0], inst->vsi_core->dec.crc[1],
> -			 inst->vsi_core->dec.crc[2], inst->vsi_core->dec.crc[3],
> -			 inst->vsi_core->dec.crc[4], inst->vsi_core->dec.crc[5],
> -			 inst->vsi_core->dec.crc[6], inst->vsi_core->dec.crc[7]);
> +	mtk_vdec_debug(ctx, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x=
%x",
> +		       ctx->decoded_frame_cnt,
> +		       inst->vsi_core->dec.crc[0], inst->vsi_core->dec.crc[1],
> +		       inst->vsi_core->dec.crc[2], inst->vsi_core->dec.crc[3],
> +		       inst->vsi_core->dec.crc[4], inst->vsi_core->dec.crc[5],
> +		       inst->vsi_core->dec.crc[6], inst->vsi_core->dec.crc[7]);
> =20
>  vdec_dec_end:
>  	vdec_msg_queue_update_ube_rptr(&lat_buf->ctx->msg_queue, share_info->tr=
ans_end);
>  	ctx->dev->vdec_pdata->cap_to_disp(ctx, !!err, lat_buf->src_buf_req);
> -	mtk_vcodec_debug(inst, "core decode done err=3D%d", err);
> +	mtk_vdec_debug(ctx, "core decode done err=3D%d", err);
>  	ctx->decoded_frame_cnt++;
>  	return 0;
>  }
> @@ -594,7 +592,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, s=
truct mtk_vcodec_mem *bs,
> =20
>  	lat_buf =3D vdec_msg_queue_dqbuf(&inst->ctx->msg_queue.lat_ctx);
>  	if (!lat_buf) {
> -		mtk_vcodec_debug(inst, "failed to get lat buffer");
> +		mtk_vdec_debug(inst->ctx, "failed to get lat buffer");
>  		return -EAGAIN;
>  	}
>  	share_info =3D lat_buf->private_data;
> @@ -623,7 +621,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, s=
truct mtk_vcodec_mem *bs,
> =20
>  	*res_chg =3D inst->resolution_changed;
>  	if (inst->resolution_changed) {
> -		mtk_vcodec_debug(inst, "- resolution changed -");
> +		mtk_vdec_debug(inst->ctx, "- resolution changed -");
>  		if (inst->realloc_mv_buf) {
>  			err =3D vdec_h264_slice_alloc_mv_buf(inst, &inst->ctx->picinfo);
>  			inst->realloc_mv_buf =3D false;
> @@ -646,19 +644,19 @@ static int vdec_h264_slice_lat_decode(void *h_vdec,=
 struct mtk_vcodec_mem *bs,
> =20
>  	inst->vsi->trans_end =3D inst->ctx->msg_queue.wdma_rptr_addr;
>  	inst->vsi->trans_start =3D inst->ctx->msg_queue.wdma_wptr_addr;
> -	mtk_vcodec_debug(inst, "lat:trans(0x%llx 0x%llx) err:0x%llx",
> -			 inst->vsi->wdma_start_addr,
> -			 inst->vsi->wdma_end_addr,
> -			 inst->vsi->wdma_err_addr);
> -
> -	mtk_vcodec_debug(inst, "slice(0x%llx 0x%llx) rprt((0x%llx 0x%llx))",
> -			 inst->vsi->slice_bc_start_addr,
> -			 inst->vsi->slice_bc_end_addr,
> -			 inst->vsi->trans_start,
> -			 inst->vsi->trans_end);
> +	mtk_vdec_debug(inst->ctx, "lat:trans(0x%llx 0x%llx) err:0x%llx",
> +		       inst->vsi->wdma_start_addr,
> +		       inst->vsi->wdma_end_addr,
> +		       inst->vsi->wdma_err_addr);
> +
> +	mtk_vdec_debug(inst->ctx, "slice(0x%llx 0x%llx) rprt((0x%llx 0x%llx))",
> +		       inst->vsi->slice_bc_start_addr,
> +		       inst->vsi->slice_bc_end_addr,
> +		       inst->vsi->trans_start,
> +		       inst->vsi->trans_end);
>  	err =3D vpu_dec_start(vpu, data, 2);
>  	if (err) {
> -		mtk_vcodec_debug(inst, "lat decode err: %d", err);
> +		mtk_vdec_debug(inst->ctx, "lat decode err: %d", err);
>  		goto err_free_fb_out;
>  	}
> =20
> @@ -677,7 +675,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, s=
truct mtk_vcodec_mem *bs,
>  	timeout =3D mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIV=
ED,
>  					       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
>  	if (timeout)
> -		mtk_vcodec_err(inst, "lat decode timeout: pic_%d", inst->slice_dec_num=
);
> +		mtk_vdec_err(inst->ctx, "lat decode timeout: pic_%d", inst->slice_dec_=
num);
>  	inst->vsi->dec.timeout =3D !!timeout;
> =20
>  	err =3D vpu_dec_end(vpu);
> @@ -685,7 +683,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, s=
truct mtk_vcodec_mem *bs,
>  		if (!IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability))
>  			vdec_msg_queue_qbuf(&inst->ctx->msg_queue.lat_ctx, lat_buf);
>  		inst->slice_dec_num++;
> -		mtk_vcodec_err(inst, "lat dec fail: pic_%d err:%d", inst->slice_dec_nu=
m, err);
> +		mtk_vdec_err(inst->ctx, "lat dec fail: pic_%d err:%d", inst->slice_dec=
_num, err);
>  		return -EINVAL;
>  	}
> =20
> @@ -698,14 +696,14 @@ static int vdec_h264_slice_lat_decode(void *h_vdec,=
 struct mtk_vcodec_mem *bs,
>  		       sizeof(share_info->h264_slice_params));
>  		vdec_msg_queue_qbuf(&inst->ctx->msg_queue.core_ctx, lat_buf);
>  	}
> -	mtk_vcodec_debug(inst, "dec num: %d lat crc: 0x%x 0x%x 0x%x", inst->sli=
ce_dec_num,
> -			 inst->vsi->dec.crc[0], inst->vsi->dec.crc[1], inst->vsi->dec.crc[2])=
;
> +	mtk_vdec_debug(inst->ctx, "dec num: %d lat crc: 0x%x 0x%x 0x%x", inst->=
slice_dec_num,
> +		       inst->vsi->dec.crc[0], inst->vsi->dec.crc[1], inst->vsi->dec.cr=
c[2]);
> =20
>  	inst->slice_dec_num++;
>  	return 0;
>  err_free_fb_out:
>  	vdec_msg_queue_qbuf(&inst->ctx->msg_queue.lat_ctx, lat_buf);
> -	mtk_vcodec_err(inst, "slice dec number: %d err: %d", inst->slice_dec_nu=
m, err);
> +	mtk_vdec_err(inst->ctx, "slice dec number: %d err: %d", inst->slice_dec=
_num, err);
>  	return err;
>  }
> =20
> @@ -732,8 +730,8 @@ static int vdec_h264_slice_single_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs
> =20
>  	y_fb_dma =3D fb ? (u64)fb->base_y.dma_addr : 0;
>  	c_fb_dma =3D fb ? (u64)fb->base_c.dma_addr : 0;
> -	mtk_vcodec_debug(inst, "[h264-dec] [%d] y_dma=3D%llx c_dma=3D%llx",
> -			 inst->ctx->decoded_frame_cnt, y_fb_dma, c_fb_dma);
> +	mtk_vdec_debug(inst->ctx, "[h264-dec] [%d] y_dma=3D%llx c_dma=3D%llx",
> +		       inst->ctx->decoded_frame_cnt, y_fb_dma, c_fb_dma);
> =20
>  	inst->vsi_ctx.dec.bs_buf_addr =3D (u64)bs->dma_addr;
>  	inst->vsi_ctx.dec.bs_buf_size =3D bs->size;
> @@ -757,7 +755,7 @@ static int vdec_h264_slice_single_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs
> =20
>  	*res_chg =3D inst->resolution_changed;
>  	if (inst->resolution_changed) {
> -		mtk_vcodec_debug(inst, "- resolution changed -");
> +		mtk_vdec_debug(inst->ctx, "- resolution changed -");
>  		if (inst->realloc_mv_buf) {
>  			err =3D vdec_h264_slice_alloc_mv_buf(inst, &inst->ctx->picinfo);
>  			inst->realloc_mv_buf =3D false;
> @@ -781,8 +779,7 @@ static int vdec_h264_slice_single_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs
>  	err =3D mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIVED,
>  					   WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
>  	if (err)
> -		mtk_vcodec_err(inst, "decode timeout: pic_%d",
> -			       inst->ctx->decoded_frame_cnt);
> +		mtk_vdec_err(inst->ctx, "decode timeout: pic_%d", inst->ctx->decoded_f=
rame_cnt);
> =20
>  	inst->vsi->dec.timeout =3D !!err;
>  	err =3D vpu_dec_end(vpu);
> @@ -790,19 +787,18 @@ static int vdec_h264_slice_single_decode(void *h_vd=
ec, struct mtk_vcodec_mem *bs
>  		goto err_free_fb_out;
> =20
>  	memcpy(&inst->vsi_ctx, inst->vpu.vsi, sizeof(inst->vsi_ctx));
> -	mtk_vcodec_debug(inst, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x=
 0x%x",
> -			 inst->ctx->decoded_frame_cnt,
> -			 inst->vsi_ctx.dec.crc[0], inst->vsi_ctx.dec.crc[1],
> -			 inst->vsi_ctx.dec.crc[2], inst->vsi_ctx.dec.crc[3],
> -			 inst->vsi_ctx.dec.crc[4], inst->vsi_ctx.dec.crc[5],
> -			 inst->vsi_ctx.dec.crc[6], inst->vsi_ctx.dec.crc[7]);
> +	mtk_vdec_debug(inst->ctx, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0=
x%x 0x%x",
> +		       inst->ctx->decoded_frame_cnt,
> +		       inst->vsi_ctx.dec.crc[0], inst->vsi_ctx.dec.crc[1],
> +		       inst->vsi_ctx.dec.crc[2], inst->vsi_ctx.dec.crc[3],
> +		       inst->vsi_ctx.dec.crc[4], inst->vsi_ctx.dec.crc[5],
> +		       inst->vsi_ctx.dec.crc[6], inst->vsi_ctx.dec.crc[7]);
> =20
>  	inst->ctx->decoded_frame_cnt++;
>  	return 0;
> =20
>  err_free_fb_out:
> -	mtk_vcodec_err(inst, "dec frame number: %d err: %d",
> -		       inst->ctx->decoded_frame_cnt, err);
> +	mtk_vdec_err(inst->ctx, "dec frame number: %d err: %d", inst->ctx->deco=
ded_frame_cnt, err);
>  	return err;
>  }
> =20
> @@ -839,7 +835,7 @@ static int vdec_h264_slice_get_param(void *h_vdec, en=
um vdec_get_param_type type
>  		vdec_h264_slice_get_crop_info(inst, out);
>  		break;
>  	default:
> -		mtk_vcodec_err(inst, "invalid get parameter type=3D%d", type);
> +		mtk_vdec_err(inst->ctx, "invalid get parameter type=3D%d", type);
>  		return -EINVAL;
>  	}
>  	return 0;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_mu=
lti_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_=
if.c
> index 0bb5b54578e9..5a864bcfe7ba 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.=
c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.=
c
> @@ -657,7 +657,7 @@ static int vdec_hevc_slice_alloc_mv_buf(struct vdec_h=
evc_slice_inst *inst,
>  		mem->size =3D buf_sz;
>  		err =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  		if (err) {
> -			mtk_vcodec_err(inst, "failed to allocate mv buf");
> +			mtk_vdec_err(inst->ctx, "failed to allocate mv buf");
>  			return err;
>  		}
>  	}
> @@ -694,11 +694,11 @@ static void vdec_hevc_slice_get_pic_info(struct vde=
c_hevc_slice_inst *inst)
>  	inst->cap_num_planes =3D
>  		ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes;
> =20
> -	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
> -			 ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> -			 ctx->picinfo.buf_w, ctx->picinfo.buf_h);
> -	mtk_vcodec_debug(inst, "Y/C(%d, %d)", ctx->picinfo.fb_sz[0],
> -			 ctx->picinfo.fb_sz[1]);
> +	mtk_vdec_debug(ctx, "pic(%d, %d), buf(%d, %d)",
> +		       ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> +		       ctx->picinfo.buf_w, ctx->picinfo.buf_h);
> +	mtk_vdec_debug(ctx, "Y/C(%d, %d)", ctx->picinfo.fb_sz[0],
> +		       ctx->picinfo.fb_sz[1]);
> =20
>  	if (ctx->last_decoded_picinfo.pic_w !=3D ctx->picinfo.pic_w ||
>  	    ctx->last_decoded_picinfo.pic_h !=3D ctx->picinfo.pic_h) {
> @@ -724,8 +724,8 @@ static void vdec_hevc_slice_get_crop_info(struct vdec=
_hevc_slice_inst *inst,
>  	cr->width =3D inst->ctx->picinfo.pic_w;
>  	cr->height =3D inst->ctx->picinfo.pic_h;
> =20
> -	mtk_vcodec_debug(inst, "l=3D%d, t=3D%d, w=3D%d, h=3D%d",
> -			 cr->left, cr->top, cr->width, cr->height);
> +	mtk_vdec_debug(inst->ctx, "l=3D%d, t=3D%d, w=3D%d, h=3D%d",
> +		       cr->left, cr->top, cr->width, cr->height);
>  }
> =20
>  static int vdec_hevc_slice_setup_lat_buffer(struct vdec_hevc_slice_inst =
*inst,
> @@ -747,7 +747,7 @@ static int vdec_hevc_slice_setup_lat_buffer(struct vd=
ec_hevc_slice_inst *inst,
> =20
>  	*res_chg =3D inst->resolution_changed;
>  	if (inst->resolution_changed) {
> -		mtk_vcodec_debug(inst, "- resolution changed -");
> +		mtk_vdec_debug(inst->ctx, "- resolution changed -");
>  		if (inst->realloc_mv_buf) {
>  			err =3D vdec_hevc_slice_alloc_mv_buf(inst, &inst->ctx->picinfo);
>  			inst->realloc_mv_buf =3D false;
> @@ -779,16 +779,16 @@ static int vdec_hevc_slice_setup_lat_buffer(struct =
vdec_hevc_slice_inst *inst,
>  	share_info->trans.dma_addr =3D inst->vsi->trans.dma_addr;
>  	share_info->trans.dma_addr_end =3D inst->vsi->trans.dma_addr_end;
> =20
> -	mtk_vcodec_debug(inst, "lat: ube addr/size(0x%llx 0x%llx) err:0x%llx",
> -			 inst->vsi->ube.buf,
> -			 inst->vsi->ube.padding,
> -			 inst->vsi->err_map.buf);
> +	mtk_vdec_debug(inst->ctx, "lat: ube addr/size(0x%llx 0x%llx) err:0x%llx=
",
> +		       inst->vsi->ube.buf,
> +		       inst->vsi->ube.padding,
> +		       inst->vsi->err_map.buf);
> =20
> -	mtk_vcodec_debug(inst, "slice addr/size(0x%llx 0x%llx) trans start/end(=
(0x%llx 0x%llx))",
> -			 inst->vsi->slice_bc.buf,
> -			 inst->vsi->slice_bc.padding,
> -			 inst->vsi->trans.buf,
> -			 inst->vsi->trans.padding);
> +	mtk_vdec_debug(inst->ctx, "slice addr/size(0x%llx 0x%llx) trans start/e=
nd((0x%llx 0x%llx))",
> +		       inst->vsi->slice_bc.buf,
> +		       inst->vsi->slice_bc.padding,
> +		       inst->vsi->trans.buf,
> +		       inst->vsi->trans.padding);
> =20
>  	return 0;
>  }
> @@ -806,7 +806,7 @@ static int vdec_hevc_slice_setup_core_buffer(struct v=
dec_hevc_slice_inst *inst,
> =20
>  	fb =3D ctx->dev->vdec_pdata->get_cap_buffer(ctx);
>  	if (!fb) {
> -		mtk_vcodec_err(inst, "fb buffer is NULL");
> +		mtk_vdec_err(inst->ctx, "fb buffer is NULL");
>  		return -EBUSY;
>  	}
> =20
> @@ -817,8 +817,7 @@ static int vdec_hevc_slice_setup_core_buffer(struct v=
dec_hevc_slice_inst *inst,
>  	else
>  		c_fb_dma =3D (u64)fb->base_c.dma_addr;
> =20
> -	mtk_vcodec_debug(inst, "[hevc-core] y/c addr =3D 0x%llx 0x%llx", y_fb_d=
ma,
> -			 c_fb_dma);
> +	mtk_vdec_debug(inst->ctx, "[hevc-core] y/c addr =3D 0x%llx 0x%llx", y_f=
b_dma, c_fb_dma);
> =20
>  	inst->vsi_core->fb.y.dma_addr =3D y_fb_dma;
>  	inst->vsi_core->fb.y.size =3D ctx->picinfo.fb_sz[0];
> @@ -874,7 +873,7 @@ static int vdec_hevc_slice_init(struct mtk_vcodec_ctx=
 *ctx)
>  	ctx->drv_handle =3D inst;
>  	err =3D vpu_dec_init(&inst->vpu);
>  	if (err) {
> -		mtk_vcodec_err(inst, "vdec_hevc init err=3D%d", err);
> +		mtk_vdec_err(ctx, "vdec_hevc init err=3D%d", err);
>  		goto error_free_inst;
>  	}
> =20
> @@ -891,14 +890,14 @@ static int vdec_hevc_slice_init(struct mtk_vcodec_c=
tx *ctx)
>  	if (err)
>  		goto error_free_inst;
> =20
> -	mtk_vcodec_debug(inst, "lat struct size =3D %d,%d,%d,%d vsi: %d\n",
> -			 (int)sizeof(struct mtk_hevc_sps_param),
> -			 (int)sizeof(struct mtk_hevc_pps_param),
> -			 (int)sizeof(struct vdec_hevc_slice_lat_dec_param),
> -			 (int)sizeof(struct mtk_hevc_dpb_info),
> +	mtk_vdec_debug(ctx, "lat struct size =3D %d,%d,%d,%d vsi: %d\n",
> +		       (int)sizeof(struct mtk_hevc_sps_param),
> +		       (int)sizeof(struct mtk_hevc_pps_param),
> +		       (int)sizeof(struct vdec_hevc_slice_lat_dec_param),
> +		       (int)sizeof(struct mtk_hevc_dpb_info),
>  			 vsi_size);
> -	mtk_vcodec_debug(inst, "lat hevc instance >> %p, codec_type =3D 0x%x",
> -			 inst, inst->vpu.codec_type);
> +	mtk_vdec_debug(ctx, "lat hevc instance >> %p, codec_type =3D 0x%x",
> +		       inst, inst->vpu.codec_type);
> =20
>  	return 0;
>  error_free_inst:
> @@ -930,7 +929,7 @@ static int vdec_hevc_slice_core_decode(struct vdec_la=
t_buf *lat_buf)
>  	struct vdec_hevc_slice_share_info *share_info =3D lat_buf->private_data=
;
>  	struct vdec_vpu_inst *vpu =3D &inst->vpu;
> =20
> -	mtk_vcodec_debug(inst, "[hevc-core] vdec_hevc core decode");
> +	mtk_vdec_debug(ctx, "[hevc-core] vdec_hevc core decode");
>  	memcpy(&inst->vsi_core->hevc_slice_params, &share_info->hevc_slice_para=
ms,
>  	       sizeof(share_info->hevc_slice_params));
> =20
> @@ -942,7 +941,7 @@ static int vdec_hevc_slice_core_decode(struct vdec_la=
t_buf *lat_buf)
>  					    share_info);
>  	err =3D vpu_dec_core(vpu);
>  	if (err) {
> -		mtk_vcodec_err(inst, "core decode err=3D%d", err);
> +		mtk_vdec_err(ctx, "core decode err=3D%d", err);
>  		goto vdec_dec_end;
>  	}
> =20
> @@ -950,22 +949,21 @@ static int vdec_hevc_slice_core_decode(struct vdec_=
lat_buf *lat_buf)
>  	timeout =3D mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIV=
ED,
>  					       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
>  	if (timeout)
> -		mtk_vcodec_err(inst, "core decode timeout: pic_%d",
> -			       ctx->decoded_frame_cnt);
> +		mtk_vdec_err(ctx, "core decode timeout: pic_%d", ctx->decoded_frame_cn=
t);
>  	inst->vsi_core->dec.timeout =3D !!timeout;
> =20
>  	vpu_dec_core_end(vpu);
> -	mtk_vcodec_debug(inst, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x=
 0x%x",
> -			 ctx->decoded_frame_cnt,
> -			 inst->vsi_core->dec.crc[0], inst->vsi_core->dec.crc[1],
> -			 inst->vsi_core->dec.crc[2], inst->vsi_core->dec.crc[3],
> -			 inst->vsi_core->dec.crc[4], inst->vsi_core->dec.crc[5],
> -			 inst->vsi_core->dec.crc[6], inst->vsi_core->dec.crc[7]);
> +	mtk_vdec_debug(ctx, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x=
%x",
> +		       ctx->decoded_frame_cnt,
> +		       inst->vsi_core->dec.crc[0], inst->vsi_core->dec.crc[1],
> +		       inst->vsi_core->dec.crc[2], inst->vsi_core->dec.crc[3],
> +		       inst->vsi_core->dec.crc[4], inst->vsi_core->dec.crc[5],
> +		       inst->vsi_core->dec.crc[6], inst->vsi_core->dec.crc[7]);
> =20
>  vdec_dec_end:
>  	vdec_msg_queue_update_ube_rptr(&lat_buf->ctx->msg_queue, share_info->tr=
ans.dma_addr_end);
>  	ctx->dev->vdec_pdata->cap_to_disp(ctx, !!err, lat_buf->src_buf_req);
> -	mtk_vcodec_debug(inst, "core decode done err=3D%d", err);
> +	mtk_vdec_debug(ctx, "core decode done err=3D%d", err);
>  	ctx->decoded_frame_cnt++;
>  	return 0;
>  }
> @@ -993,7 +991,7 @@ static int vdec_hevc_slice_lat_decode(void *h_vdec, s=
truct mtk_vcodec_mem *bs,
> =20
>  	lat_buf =3D vdec_msg_queue_dqbuf(&inst->ctx->msg_queue.lat_ctx);
>  	if (!lat_buf) {
> -		mtk_vcodec_debug(inst, "failed to get lat buffer");
> +		mtk_vdec_debug(inst->ctx, "failed to get lat buffer");
>  		return -EAGAIN;
>  	}
> =20
> @@ -1008,7 +1006,7 @@ static int vdec_hevc_slice_lat_decode(void *h_vdec,=
 struct mtk_vcodec_mem *bs,
> =20
>  	err =3D vpu_dec_start(vpu, data, 2);
>  	if (err) {
> -		mtk_vcodec_debug(inst, "lat decode err: %d", err);
> +		mtk_vdec_debug(inst->ctx, "lat decode err: %d", err);
>  		goto err_free_fb_out;
>  	}
> =20
> @@ -1022,7 +1020,7 @@ static int vdec_hevc_slice_lat_decode(void *h_vdec,=
 struct mtk_vcodec_mem *bs,
>  	timeout =3D mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIV=
ED,
>  					       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
>  	if (timeout)
> -		mtk_vcodec_err(inst, "lat decode timeout: pic_%d", inst->slice_dec_num=
);
> +		mtk_vdec_err(inst->ctx, "lat decode timeout: pic_%d", inst->slice_dec_=
num);
>  	inst->vsi->dec.timeout =3D !!timeout;
> =20
>  	err =3D vpu_dec_end(vpu);
> @@ -1030,7 +1028,7 @@ static int vdec_hevc_slice_lat_decode(void *h_vdec,=
 struct mtk_vcodec_mem *bs,
>  		if (!IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability))
>  			vdec_msg_queue_qbuf(&inst->ctx->msg_queue.lat_ctx, lat_buf);
>  		inst->slice_dec_num++;
> -		mtk_vcodec_err(inst, "lat dec fail: pic_%d err:%d", inst->slice_dec_nu=
m, err);
> +		mtk_vdec_err(inst->ctx, "lat dec fail: pic_%d err:%d", inst->slice_dec=
_num, err);
>  		return -EINVAL;
>  	}
> =20
> @@ -1043,14 +1041,14 @@ static int vdec_hevc_slice_lat_decode(void *h_vde=
c, struct mtk_vcodec_mem *bs,
>  		       sizeof(share_info->hevc_slice_params));
>  		vdec_msg_queue_qbuf(&inst->ctx->msg_queue.core_ctx, lat_buf);
>  	}
> -	mtk_vcodec_debug(inst, "dec num: %d lat crc: 0x%x 0x%x 0x%x", inst->sli=
ce_dec_num,
> -			 inst->vsi->dec.crc[0], inst->vsi->dec.crc[1], inst->vsi->dec.crc[2])=
;
> +	mtk_vdec_debug(inst->ctx, "dec num: %d lat crc: 0x%x 0x%x 0x%x", inst->=
slice_dec_num,
> +		       inst->vsi->dec.crc[0], inst->vsi->dec.crc[1], inst->vsi->dec.cr=
c[2]);
> =20
>  	inst->slice_dec_num++;
>  	return 0;
>  err_free_fb_out:
>  	vdec_msg_queue_qbuf(&inst->ctx->msg_queue.lat_ctx, lat_buf);
> -	mtk_vcodec_err(inst, "slice dec number: %d err: %d", inst->slice_dec_nu=
m, err);
> +	mtk_vdec_err(inst->ctx, "slice dec number: %d err: %d", inst->slice_dec=
_num, err);
>  	return err;
>  }
> =20
> @@ -1081,7 +1079,7 @@ static int vdec_hevc_slice_get_param(void *h_vdec, =
enum vdec_get_param_type type
>  		vdec_hevc_slice_get_crop_info(inst, out);
>  		break;
>  	default:
> -		mtk_vcodec_err(inst, "invalid get parameter type=3D%d", type);
> +		mtk_vdec_err(inst->ctx, "invalid get parameter type=3D%d", type);
>  		return -EINVAL;
>  	}
>  	return 0;
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> index fb5bc30b113b..295cb2ee5c4a 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> @@ -284,10 +284,10 @@ static void get_pic_info(struct vdec_vp8_inst *inst=
, struct vdec_pic_info *pic)
>  {
>  	*pic =3D inst->vsi->pic;
> =20
> -	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
> -			 pic->pic_w, pic->pic_h, pic->buf_w, pic->buf_h);
> -	mtk_vcodec_debug(inst, "fb size: Y(%d), C(%d)",
> -			 pic->fb_sz[0], pic->fb_sz[1]);
> +	mtk_vdec_debug(inst->ctx, "pic(%d, %d), buf(%d, %d)",
> +		       pic->pic_w, pic->pic_h, pic->buf_w, pic->buf_h);
> +	mtk_vdec_debug(inst->ctx, "fb size: Y(%d), C(%d)",
> +		       pic->fb_sz[0], pic->fb_sz[1]);
>  }
> =20
>  static void vp8_dec_finish(struct vdec_vp8_inst *inst)
> @@ -295,7 +295,7 @@ static void vp8_dec_finish(struct vdec_vp8_inst *inst=
)
>  	struct vdec_fb_node *node;
>  	uint64_t prev_y_dma =3D inst->vsi->dec.prev_y_dma;
> =20
> -	mtk_vcodec_debug(inst, "prev fb base dma=3D%llx", prev_y_dma);
> +	mtk_vdec_debug(inst->ctx, "prev fb base dma=3D%llx", prev_y_dma);
> =20
>  	/* put last decode ok frame to fb_free_list */
>  	if (prev_y_dma !=3D 0) {
> @@ -370,7 +370,7 @@ static int alloc_working_buf(struct vdec_vp8_inst *in=
st)
>  	mem->size =3D VP8_WORKING_BUF_SZ;
>  	err =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  	if (err) {
> -		mtk_vcodec_err(inst, "Cannot allocate working buffer");
> +		mtk_vdec_err(inst->ctx, "Cannot allocate working buffer");
>  		return err;
>  	}
> =20
> @@ -404,7 +404,7 @@ static int vdec_vp8_init(struct mtk_vcodec_ctx *ctx)
> =20
>  	err =3D vpu_dec_init(&inst->vpu);
>  	if (err) {
> -		mtk_vcodec_err(inst, "vdec_vp8 init err=3D%d", err);
> +		mtk_vdec_err(ctx, "vdec_vp8 init err=3D%d", err);
>  		goto error_free_inst;
>  	}
> =20
> @@ -415,7 +415,7 @@ static int vdec_vp8_init(struct mtk_vcodec_ctx *ctx)
>  		goto error_deinit;
> =20
>  	get_hw_reg_base(inst);
> -	mtk_vcodec_debug(inst, "VP8 Instance >> %p", inst);
> +	mtk_vdec_debug(ctx, "VP8 Instance >> %p", inst);
> =20
>  	ctx->drv_handle =3D inst;
>  	return 0;
> @@ -448,8 +448,8 @@ static int vdec_vp8_decode(void *h_vdec, struct mtk_v=
codec_mem *bs,
>  	y_fb_dma =3D fb ? (u64)fb->base_y.dma_addr : 0;
>  	c_fb_dma =3D fb ? (u64)fb->base_c.dma_addr : 0;
> =20
> -	mtk_vcodec_debug(inst, "+ [%d] FB y_dma=3D%llx c_dma=3D%llx fb=3D%p",
> -			 inst->frm_cnt, y_fb_dma, c_fb_dma, fb);
> +	mtk_vdec_debug(inst->ctx, "+ [%d] FB y_dma=3D%llx c_dma=3D%llx fb=3D%p"=
,
> +		       inst->frm_cnt, y_fb_dma, c_fb_dma, fb);
> =20
>  	inst->cur_fb =3D fb;
>  	dec->bs_dma =3D (unsigned long)bs->dma_addr;
> @@ -457,7 +457,7 @@ static int vdec_vp8_decode(void *h_vdec, struct mtk_v=
codec_mem *bs,
>  	dec->cur_y_fb_dma =3D y_fb_dma;
>  	dec->cur_c_fb_dma =3D c_fb_dma;
> =20
> -	mtk_vcodec_debug(inst, "\n + FRAME[%d] +\n", inst->frm_cnt);
> +	mtk_vdec_debug(inst->ctx, "\n + FRAME[%d] +\n", inst->frm_cnt);
> =20
>  	write_hw_segmentation_data(inst);
>  	enable_hw_rw_function(inst);
> @@ -472,7 +472,7 @@ static int vdec_vp8_decode(void *h_vdec, struct mtk_v=
codec_mem *bs,
>  	if (err) {
>  		add_fb_to_free_list(inst, fb);
>  		if (dec->wait_key_frame) {
> -			mtk_vcodec_debug(inst, "wait key frame !");
> +			mtk_vdec_debug(inst->ctx, "wait key frame !");
>  			return 0;
>  		}
> =20
> @@ -480,7 +480,7 @@ static int vdec_vp8_decode(void *h_vdec, struct mtk_v=
codec_mem *bs,
>  	}
> =20
>  	if (dec->resolution_changed) {
> -		mtk_vcodec_debug(inst, "- resolution_changed -");
> +		mtk_vdec_debug(inst->ctx, "- resolution_changed -");
>  		*res_chg =3D true;
>  		add_fb_to_free_list(inst, fb);
>  		return 0;
> @@ -500,14 +500,13 @@ static int vdec_vp8_decode(void *h_vdec, struct mtk=
_vcodec_mem *bs,
>  	if (err)
>  		goto error;
> =20
> -	mtk_vcodec_debug(inst, "\n - FRAME[%d] - show=3D%d\n", inst->frm_cnt,
> -			 dec->show_frame);
> +	mtk_vdec_debug(inst->ctx, "\n - FRAME[%d] - show=3D%d\n", inst->frm_cnt=
, dec->show_frame);
>  	inst->frm_cnt++;
>  	*res_chg =3D false;
>  	return 0;
> =20
>  error:
> -	mtk_vcodec_err(inst, "\n - FRAME[%d] - err=3D%d\n", inst->frm_cnt, err)=
;
> +	mtk_vdec_err(inst->ctx, "\n - FRAME[%d] - err=3D%d\n", inst->frm_cnt, e=
rr);
>  	return err;
>  }
> =20
> @@ -522,11 +521,10 @@ static void get_disp_fb(struct vdec_vp8_inst *inst,=
 struct vdec_fb **out_fb)
>  		list_move_tail(&node->list, &inst->available_fb_node_list);
>  		fb =3D (struct vdec_fb *)node->fb;
>  		fb->status |=3D FB_ST_DISPLAY;
> -		mtk_vcodec_debug(inst, "[FB] get disp fb %p st=3D%d",
> -				 node->fb, fb->status);
> +		mtk_vdec_debug(inst->ctx, "[FB] get disp fb %p st=3D%d", node->fb, fb-=
>status);
>  	} else {
>  		fb =3D NULL;
> -		mtk_vcodec_debug(inst, "[FB] there is no disp fb");
> +		mtk_vdec_debug(inst->ctx, "[FB] there is no disp fb");
>  	}
> =20
>  	*out_fb =3D fb;
> @@ -543,11 +541,10 @@ static void get_free_fb(struct vdec_vp8_inst *inst,=
 struct vdec_fb **out_fb)
>  		list_move_tail(&node->list, &inst->available_fb_node_list);
>  		fb =3D (struct vdec_fb *)node->fb;
>  		fb->status |=3D FB_ST_FREE;
> -		mtk_vcodec_debug(inst, "[FB] get free fb %p st=3D%d",
> -				 node->fb, fb->status);
> +		mtk_vdec_debug(inst->ctx, "[FB] get free fb %p st=3D%d", node->fb, fb-=
>status);
>  	} else {
>  		fb =3D NULL;
> -		mtk_vcodec_debug(inst, "[FB] there is no free fb");
> +		mtk_vdec_debug(inst->ctx, "[FB] there is no free fb");
>  	}
> =20
>  	*out_fb =3D fb;
> @@ -559,8 +556,8 @@ static void get_crop_info(struct vdec_vp8_inst *inst,=
 struct v4l2_rect *cr)
>  	cr->top =3D 0;
>  	cr->width =3D inst->vsi->pic.pic_w;
>  	cr->height =3D inst->vsi->pic.pic_h;
> -	mtk_vcodec_debug(inst, "get crop info l=3D%d, t=3D%d, w=3D%d, h=3D%d",
> -			 cr->left, cr->top, cr->width, cr->height);
> +	mtk_vdec_debug(inst->ctx, "get crop info l=3D%d, t=3D%d, w=3D%d, h=3D%d=
",
> +		       cr->left, cr->top, cr->width, cr->height);
>  }
> =20
>  static int vdec_vp8_get_param(void *h_vdec, enum vdec_get_param_type typ=
e,
> @@ -590,7 +587,7 @@ static int vdec_vp8_get_param(void *h_vdec, enum vdec=
_get_param_type type,
>  		break;
> =20
>  	default:
> -		mtk_vcodec_err(inst, "invalid get parameter type=3D%d", type);
> +		mtk_vdec_err(inst->ctx, "invalid get parameter type=3D%d", type);
>  		return -EINVAL;
>  	}
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.=
c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> index f7181f4a4d2a..4193fe20bb92 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
> @@ -137,11 +137,11 @@ static void vdec_vp8_slice_get_pic_info(struct vdec=
_vp8_slice_inst *inst)
>  	inst->vsi->pic.buf_h =3D ctx->picinfo.buf_h;
>  	inst->vsi->pic.fb_sz[0] =3D ctx->picinfo.fb_sz[0];
>  	inst->vsi->pic.fb_sz[1] =3D ctx->picinfo.fb_sz[1];
> -	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
> -			 ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> -			 ctx->picinfo.buf_w, ctx->picinfo.buf_h);
> -	mtk_vcodec_debug(inst, "fb size: Y(%d), C(%d)",
> -			 ctx->picinfo.fb_sz[0], ctx->picinfo.fb_sz[1]);
> +	mtk_vdec_debug(inst->ctx, "pic(%d, %d), buf(%d, %d)",
> +		       ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> +		       ctx->picinfo.buf_w, ctx->picinfo.buf_h);
> +	mtk_vdec_debug(inst->ctx, "fb size: Y(%d), C(%d)",
> +		       ctx->picinfo.fb_sz[0], ctx->picinfo.fb_sz[1]);
>  }
> =20
>  static int vdec_vp8_slice_alloc_working_buf(struct vdec_vp8_slice_inst *=
inst)
> @@ -153,7 +153,7 @@ static int vdec_vp8_slice_alloc_working_buf(struct vd=
ec_vp8_slice_inst *inst)
>  	mem->size =3D VP8_SEG_ID_SZ;
>  	err =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  	if (err) {
> -		mtk_vcodec_err(inst, "Cannot allocate working buffer");
> +		mtk_vdec_err(inst->ctx, "Cannot allocate working buffer");
>  		return err;
>  	}
>  	inst->vsi->dec.seg_id_buf_dma =3D (u64)mem->dma_addr;
> @@ -162,7 +162,7 @@ static int vdec_vp8_slice_alloc_working_buf(struct vd=
ec_vp8_slice_inst *inst)
>  	mem->size =3D VP8_PP_WRAPY_SZ;
>  	err =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  	if (err) {
> -		mtk_vcodec_err(inst, "cannot allocate WRAP Y buffer");
> +		mtk_vdec_err(inst->ctx, "cannot allocate WRAP Y buffer");
>  		return err;
>  	}
>  	inst->vsi->dec.wrap_y_dma =3D (u64)mem->dma_addr;
> @@ -171,7 +171,7 @@ static int vdec_vp8_slice_alloc_working_buf(struct vd=
ec_vp8_slice_inst *inst)
>  	mem->size =3D VP8_PP_WRAPC_SZ;
>  	err =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  	if (err) {
> -		mtk_vcodec_err(inst, "cannot allocate WRAP C buffer");
> +		mtk_vdec_err(inst->ctx, "cannot allocate WRAP C buffer");
>  		return err;
>  	}
>  	inst->vsi->dec.wrap_c_dma =3D (u64)mem->dma_addr;
> @@ -180,7 +180,7 @@ static int vdec_vp8_slice_alloc_working_buf(struct vd=
ec_vp8_slice_inst *inst)
>  	mem->size =3D VP8_VLD_PRED_SZ;
>  	err =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  	if (err) {
> -		mtk_vcodec_err(inst, "cannot allocate vld wrapper buffer");
> +		mtk_vdec_err(inst->ctx, "cannot allocate vld wrapper buffer");
>  		return err;
>  	}
>  	inst->vsi->dec.vld_wrapper_dma =3D (u64)mem->dma_addr;
> @@ -249,8 +249,8 @@ static int vdec_vp8_slice_get_decode_parameters(struc=
t vdec_vp8_slice_inst *inst
>  		vb =3D vb2_find_buffer(vq, referenct_ts);
>  		if (!vb) {
>  			if (!V4L2_VP8_FRAME_IS_KEY_FRAME(frame_header))
> -				mtk_vcodec_err(inst, "reference invalid: index(%d) ts(%lld)",
> -					       index, referenct_ts);
> +				mtk_vdec_err(inst->ctx, "reference invalid: index(%d) ts(%lld)",
> +					     index, referenct_ts);
>  			inst->vsi->vp8_dpb_info[index].reference_flag =3D 0;
>  			continue;
>  		}
> @@ -291,7 +291,7 @@ static int vdec_vp8_slice_init(struct mtk_vcodec_ctx =
*ctx)
> =20
>  	err =3D vpu_dec_init(&inst->vpu);
>  	if (err) {
> -		mtk_vcodec_err(inst, "vdec_vp8 init err=3D%d", err);
> +		mtk_vdec_err(ctx, "vdec_vp8 init err=3D%d", err);
>  		goto error_free_inst;
>  	}
> =20
> @@ -300,11 +300,11 @@ static int vdec_vp8_slice_init(struct mtk_vcodec_ct=
x *ctx)
>  	if (err)
>  		goto error_deinit;
> =20
> -	mtk_vcodec_debug(inst, "vp8 struct size =3D %d vsi: %d\n",
> -			 (int)sizeof(struct v4l2_ctrl_vp8_frame),
> -			 (int)sizeof(struct vdec_vp8_slice_vsi));
> -	mtk_vcodec_debug(inst, "vp8:%p, codec_type =3D 0x%x vsi: 0x%p",
> -			 inst, inst->vpu.codec_type, inst->vpu.vsi);
> +	mtk_vdec_debug(ctx, "vp8 struct size =3D %d vsi: %d\n",
> +		       (int)sizeof(struct v4l2_ctrl_vp8_frame),
> +		       (int)sizeof(struct vdec_vp8_slice_vsi));
> +	mtk_vdec_debug(ctx, "vp8:%p, codec_type =3D 0x%x vsi: 0x%p",
> +		       inst, inst->vpu.codec_type, inst->vpu.vsi);
> =20
>  	ctx->drv_handle =3D inst;
>  	return 0;
> @@ -350,10 +350,10 @@ static int vdec_vp8_slice_decode(void *h_vdec, stru=
ct mtk_vcodec_mem *bs,
>  	inst->vsi->dec.cur_y_fb_dma =3D y_fb_dma;
>  	inst->vsi->dec.cur_c_fb_dma =3D c_fb_dma;
> =20
> -	mtk_vcodec_debug(inst, "frame[%d] bs(%zu 0x%llx) y/c(0x%llx 0x%llx)",
> -			 inst->ctx->decoded_frame_cnt,
> -			 bs->size, (u64)bs->dma_addr,
> -			 y_fb_dma, c_fb_dma);
> +	mtk_vdec_debug(inst->ctx, "frame[%d] bs(%zu 0x%llx) y/c(0x%llx 0x%llx)"=
,
> +		       inst->ctx->decoded_frame_cnt,
> +		       bs->size, (u64)bs->dma_addr,
> +		       y_fb_dma, c_fb_dma);
> =20
>  	v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb,
>  				   &dst_buf_info->m2m_buf.vb, true);
> @@ -364,12 +364,12 @@ static int vdec_vp8_slice_decode(void *h_vdec, stru=
ct mtk_vcodec_mem *bs,
> =20
>  	err =3D vpu_dec_start(vpu, &data, 1);
>  	if (err) {
> -		mtk_vcodec_debug(inst, "vp8 dec start err!");
> +		mtk_vdec_debug(inst->ctx, "vp8 dec start err!");
>  		goto error;
>  	}
> =20
>  	if (inst->vsi->dec.resolution_changed) {
> -		mtk_vcodec_debug(inst, "- resolution_changed -");
> +		mtk_vdec_debug(inst->ctx, "- resolution_changed -");
>  		*res_chg =3D true;
>  		return 0;
>  	}
> @@ -380,15 +380,15 @@ static int vdec_vp8_slice_decode(void *h_vdec, stru=
ct mtk_vcodec_mem *bs,
> =20
>  	err =3D vpu_dec_end(vpu);
>  	if (err || timeout)
> -		mtk_vcodec_debug(inst, "vp8 dec error timeout:%d err: %d pic_%d",
> -				 timeout, err, inst->ctx->decoded_frame_cnt);
> +		mtk_vdec_debug(inst->ctx, "vp8 dec error timeout:%d err: %d pic_%d",
> +			       timeout, err, inst->ctx->decoded_frame_cnt);
> =20
> -	mtk_vcodec_debug(inst, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x=
 0x%x",
> -			 inst->ctx->decoded_frame_cnt,
> -			 inst->vsi->dec.crc[0], inst->vsi->dec.crc[1],
> -			 inst->vsi->dec.crc[2], inst->vsi->dec.crc[3],
> -			 inst->vsi->dec.crc[4], inst->vsi->dec.crc[5],
> -			 inst->vsi->dec.crc[6], inst->vsi->dec.crc[7]);
> +	mtk_vdec_debug(inst->ctx, "pic[%d] crc: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0=
x%x 0x%x",
> +		       inst->ctx->decoded_frame_cnt,
> +		       inst->vsi->dec.crc[0], inst->vsi->dec.crc[1],
> +		       inst->vsi->dec.crc[2], inst->vsi->dec.crc[3],
> +		       inst->vsi->dec.crc[4], inst->vsi->dec.crc[5],
> +		       inst->vsi->dec.crc[6], inst->vsi->dec.crc[7]);
> =20
>  	inst->ctx->decoded_frame_cnt++;
>  error:
> @@ -404,13 +404,13 @@ static int vdec_vp8_slice_get_param(void *h_vdec, e=
num vdec_get_param_type type,
>  		vdec_vp8_slice_get_pic_info(inst);
>  		break;
>  	case GET_PARAM_CROP_INFO:
> -		mtk_vcodec_debug(inst, "No need to get vp8 crop information.");
> +		mtk_vdec_debug(inst->ctx, "No need to get vp8 crop information.");
>  		break;
>  	case GET_PARAM_DPB_SIZE:
>  		*((unsigned int *)out) =3D VP8_DPB_SIZE;
>  		break;
>  	default:
> -		mtk_vcodec_err(inst, "invalid get parameter type=3D%d", type);
> +		mtk_vdec_err(inst->ctx, "invalid get parameter type=3D%d", type);
>  		return -EINVAL;
>  	}
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/=
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> index 70b8383f7c8e..62c2b3b021e6 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> @@ -246,7 +246,7 @@ static void vp9_add_to_fb_free_list(struct vdec_vp9_i=
nst *inst,
>  			list_move_tail(&node->list, &inst->fb_free_list);
>  		}
>  	} else {
> -		mtk_vcodec_debug(inst, "No free fb node");
> +		mtk_vdec_debug(inst->ctx, "No free fb node");
>  	}
>  }
> =20
> @@ -330,7 +330,7 @@ static int vp9_get_sf_ref_fb(struct vdec_vp9_inst *in=
st)
>  	}
> =20
>  	if (idx =3D=3D ARRAY_SIZE(vsi->sf_ref_fb)) {
> -		mtk_vcodec_err(inst, "List Full");
> +		mtk_vdec_err(inst->ctx, "List Full");
>  		return -1;
>  	}
> =20
> @@ -339,7 +339,7 @@ static int vp9_get_sf_ref_fb(struct vdec_vp9_inst *in=
st)
>  		vsi->buf_len_sz_y;
> =20
>  	if (mtk_vcodec_mem_alloc(inst->ctx, mem_basy_y)) {
> -		mtk_vcodec_err(inst, "Cannot allocate sf_ref_buf y_buf");
> +		mtk_vdec_err(inst->ctx, "Cannot allocate sf_ref_buf y_buf");
>  		return -1;
>  	}
> =20
> @@ -348,7 +348,7 @@ static int vp9_get_sf_ref_fb(struct vdec_vp9_inst *in=
st)
>  		vsi->buf_len_sz_c;
> =20
>  	if (mtk_vcodec_mem_alloc(inst->ctx, mem_basy_c)) {
> -		mtk_vcodec_err(inst, "Cannot allocate sf_ref_fb c_buf");
> +		mtk_vdec_err(inst->ctx, "Cannot allocate sf_ref_fb c_buf");
>  		return -1;
>  	}
>  	vsi->sf_ref_fb[idx].used =3D 0;
> @@ -377,17 +377,13 @@ static bool vp9_alloc_work_buf(struct vdec_vp9_inst=
 *inst)
> =20
>  	if ((vsi->pic_w > max_pic_w) ||
>  		(vsi->pic_h > max_pic_h)) {
> -		mtk_vcodec_err(inst, "Invalid w/h %d/%d",
> -				vsi->pic_w, vsi->pic_h);
> +		mtk_vdec_err(inst->ctx, "Invalid w/h %d/%d", vsi->pic_w, vsi->pic_h);
>  		return false;
>  	}
> =20
> -	mtk_vcodec_debug(inst, "BUF CHG(%d): w/h/sb_w/sb_h=3D%d/%d/%d/%d",
> -			vsi->resolution_changed,
> -			vsi->pic_w,
> -			vsi->pic_h,
> -			vsi->buf_w,
> -			vsi->buf_h);
> +	mtk_vdec_debug(inst->ctx, "BUF CHG(%d): w/h/sb_w/sb_h=3D%d/%d/%d/%d",
> +		       vsi->resolution_changed, vsi->pic_w,
> +		       vsi->pic_h, vsi->buf_w, vsi->buf_h);
> =20
>  	mem =3D &inst->mv_buf;
>  	if (mem->va)
> @@ -398,7 +394,7 @@ static bool vp9_alloc_work_buf(struct vdec_vp9_inst *=
inst)
>  	result =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  	if (result) {
>  		mem->size =3D 0;
> -		mtk_vcodec_err(inst, "Cannot allocate mv_buf");
> +		mtk_vdec_err(inst->ctx, "Cannot allocate mv_buf");
>  		return false;
>  	}
>  	/* Set the va again */
> @@ -415,7 +411,7 @@ static bool vp9_alloc_work_buf(struct vdec_vp9_inst *=
inst)
>  	result =3D mtk_vcodec_mem_alloc(inst->ctx, mem);
>  	if (result) {
>  		mem->size =3D 0;
> -		mtk_vcodec_err(inst, "Cannot allocate seg_id_buf");
> +		mtk_vdec_err(inst->ctx, "Cannot allocate seg_id_buf");
>  		return false;
>  	}
>  	/* Set the va again */
> @@ -436,7 +432,7 @@ static bool vp9_add_to_fb_disp_list(struct vdec_vp9_i=
nst *inst,
>  	struct vdec_fb_node *node;
> =20
>  	if (!fb) {
> -		mtk_vcodec_err(inst, "fb =3D=3D NULL");
> +		mtk_vdec_err(inst->ctx, "fb =3D=3D NULL");
>  		return false;
>  	}
> =20
> @@ -446,7 +442,7 @@ static bool vp9_add_to_fb_disp_list(struct vdec_vp9_i=
nst *inst,
>  		node->fb =3D fb;
>  		list_move_tail(&node->list, &inst->fb_disp_list);
>  	} else {
> -		mtk_vcodec_err(inst, "No available fb node");
> +		mtk_vdec_err(inst->ctx, "No available fb node");
>  		return false;
>  	}
> =20
> @@ -492,10 +488,10 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst =
*inst)
>  			 * size
>  			 */
>  			if (frm_to_show->fb !=3D NULL)
> -				mtk_vcodec_err(inst,
> -					"inst->cur_fb->base_y.size=3D%zu, frm_to_show->fb.base_y.size=3D%zu=
",
> -					inst->cur_fb->base_y.size,
> -					frm_to_show->fb->base_y.size);
> +				mtk_vdec_err(inst->ctx,
> +					     "base_y.size=3D%zu, frm_to_show: base_y.size=3D%zu",
> +					     inst->cur_fb->base_y.size,
> +					     frm_to_show->fb->base_y.size);
>  		}
>  		if (!vp9_is_sf_ref_fb(inst, inst->cur_fb)) {
>  			if (vsi->show_frame & BIT(0))
> @@ -582,20 +578,19 @@ static bool vp9_decode_end_proc(struct vdec_vp9_ins=
t *inst)
>  	if (!vsi->show_existing_frame) {
>  		ret =3D vp9_wait_dec_end(inst);
>  		if (!ret) {
> -			mtk_vcodec_err(inst, "Decode failed, Decode Timeout @[%d]",
> -				vsi->frm_num);
> +			mtk_vdec_err(inst->ctx, "Decode failed, Decode Timeout @[%d]",
> +				     vsi->frm_num);
>  			return false;
>  		}
> =20
>  		if (vpu_dec_end(&inst->vpu)) {
> -			mtk_vcodec_err(inst, "vp9_dec_vpu_end failed");
> +			mtk_vdec_err(inst->ctx, "vp9_dec_vpu_end failed");
>  			return false;
>  		}
> -		mtk_vcodec_debug(inst, "Decode Ok @%d (%d/%d)", vsi->frm_num,
> -				vsi->pic_w, vsi->pic_h);
> +		mtk_vdec_debug(inst->ctx, "Decode Ok @%d (%d/%d)", vsi->frm_num,
> +			       vsi->pic_w, vsi->pic_h);
>  	} else {
> -		mtk_vcodec_debug(inst, "Decode Ok @%d (show_existing_frame)",
> -				vsi->frm_num);
> +		mtk_vdec_debug(inst->ctx, "Decode Ok @%d (show_existing_frame)", vsi->=
frm_num);
>  	}
> =20
>  	vp9_swap_frm_bufs(inst);
> @@ -624,10 +619,9 @@ static struct vdec_fb *vp9_rm_from_fb_disp_list(stru=
ct vdec_vp9_inst *inst)
>  		fb =3D (struct vdec_fb *)node->fb;
>  		fb->status |=3D FB_ST_DISPLAY;
>  		list_move_tail(&node->list, &inst->available_fb_node_list);
> -		mtk_vcodec_debug(inst, "[FB] get disp fb %p st=3D%d",
> -				 node->fb, fb->status);
> +		mtk_vdec_debug(inst->ctx, "[FB] get disp fb %p st=3D%d", node->fb, fb-=
>status);
>  	} else
> -		mtk_vcodec_debug(inst, "[FB] there is no disp fb");
> +		mtk_vdec_debug(inst->ctx, "[FB] there is no disp fb");
> =20
>  	return fb;
>  }
> @@ -638,7 +632,7 @@ static bool vp9_add_to_fb_use_list(struct vdec_vp9_in=
st *inst,
>  	struct vdec_fb_node *node;
> =20
>  	if (!fb) {
> -		mtk_vcodec_debug(inst, "fb =3D=3D NULL");
> +		mtk_vdec_debug(inst->ctx, "fb =3D=3D NULL");
>  		return false;
>  	}
> =20
> @@ -648,7 +642,7 @@ static bool vp9_add_to_fb_use_list(struct vdec_vp9_in=
st *inst,
>  		node->fb =3D fb;
>  		list_move_tail(&node->list, &inst->fb_use_list);
>  	} else {
> -		mtk_vcodec_err(inst, "No free fb node");
> +		mtk_vdec_err(inst->ctx, "No free fb node");
>  		return false;
>  	}
>  	return true;
> @@ -665,7 +659,7 @@ static void vp9_reset(struct vdec_vp9_inst *inst)
>  	inst->vsi->sf_next_ref_fb_idx =3D vp9_get_sf_ref_fb(inst);
> =20
>  	if (vpu_dec_reset(&inst->vpu))
> -		mtk_vcodec_err(inst, "vp9_dec_vpu_reset failed");
> +		mtk_vdec_err(inst->ctx, "vp9_dec_vpu_reset failed");
> =20
>  	/* Set the va again, since vpu_dec_reset will clear mv_buf in vpu */
>  	inst->vsi->mv_buf.va =3D (unsigned long)inst->mv_buf.va;
> @@ -706,11 +700,9 @@ static void get_pic_info(struct vdec_vp9_inst *inst,=
 struct vdec_pic_info *pic)
>  	pic->buf_w =3D inst->vsi->buf_w;
>  	pic->buf_h =3D inst->vsi->buf_h;
> =20
> -	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
> -		 pic->pic_w, pic->pic_h, pic->buf_w, pic->buf_h);
> -	mtk_vcodec_debug(inst, "fb size: Y(%d), C(%d)",
> -		pic->fb_sz[0],
> -		pic->fb_sz[1]);
> +	mtk_vdec_debug(inst->ctx, "pic(%d, %d), buf(%d, %d)",
> +		       pic->pic_w, pic->pic_h, pic->buf_w, pic->buf_h);
> +	mtk_vdec_debug(inst->ctx, "fb size: Y(%d), C(%d)", pic->fb_sz[0], pic->=
fb_sz[1]);
>  }
> =20
>  static void get_disp_fb(struct vdec_vp9_inst *inst, struct vdec_fb **out=
_fb)
> @@ -732,10 +724,9 @@ static void get_free_fb(struct vdec_vp9_inst *inst, =
struct vdec_fb **out_fb)
>  		list_move_tail(&node->list, &inst->available_fb_node_list);
>  		fb =3D (struct vdec_fb *)node->fb;
>  		fb->status |=3D FB_ST_FREE;
> -		mtk_vcodec_debug(inst, "[FB] get free fb %p st=3D%d",
> -				 node->fb, fb->status);
> +		mtk_vdec_debug(inst->ctx, "[FB] get free fb %p st=3D%d", node->fb, fb-=
>status);
>  	} else {
> -		mtk_vcodec_debug(inst, "[FB] there is no free fb");
> +		mtk_vdec_debug(inst->ctx, "[FB] there is no free fb");
>  	}
> =20
>  	*out_fb =3D fb;
> @@ -744,18 +735,15 @@ static void get_free_fb(struct vdec_vp9_inst *inst,=
 struct vdec_fb **out_fb)
>  static int validate_vsi_array_indexes(struct vdec_vp9_inst *inst,
>  		struct vdec_vp9_vsi *vsi) {
>  	if (vsi->sf_frm_idx >=3D VP9_MAX_FRM_BUF_NUM - 1) {
> -		mtk_vcodec_err(inst, "Invalid vsi->sf_frm_idx=3D%u.",
> -				vsi->sf_frm_idx);
> +		mtk_vdec_err(inst->ctx, "Invalid vsi->sf_frm_idx=3D%u.", vsi->sf_frm_i=
dx);
>  		return -EIO;
>  	}
>  	if (vsi->frm_to_show_idx >=3D VP9_MAX_FRM_BUF_NUM) {
> -		mtk_vcodec_err(inst, "Invalid vsi->frm_to_show_idx=3D%u.",
> -				vsi->frm_to_show_idx);
> +		mtk_vdec_err(inst->ctx, "Invalid vsi->frm_to_show_idx=3D%u.", vsi->frm=
_to_show_idx);
>  		return -EIO;
>  	}
>  	if (vsi->new_fb_idx >=3D VP9_MAX_FRM_BUF_NUM) {
> -		mtk_vcodec_err(inst, "Invalid vsi->new_fb_idx=3D%u.",
> -				vsi->new_fb_idx);
> +		mtk_vdec_err(inst->ctx, "Invalid vsi->new_fb_idx=3D%u.", vsi->new_fb_i=
dx);
>  		return -EIO;
>  	}
>  	return 0;
> @@ -769,7 +757,7 @@ static void vdec_vp9_deinit(void *h_vdec)
> =20
>  	ret =3D vpu_dec_deinit(&inst->vpu);
>  	if (ret)
> -		mtk_vcodec_err(inst, "vpu_dec_deinit failed");
> +		mtk_vdec_err(inst->ctx, "vpu_dec_deinit failed");
> =20
>  	mem =3D &inst->mv_buf;
>  	if (mem->va)
> @@ -798,7 +786,7 @@ static int vdec_vp9_init(struct mtk_vcodec_ctx *ctx)
>  	inst->vpu.ctx =3D ctx;
> =20
>  	if (vpu_dec_init(&inst->vpu)) {
> -		mtk_vcodec_err(inst, "vp9_dec_vpu_init failed");
> +		mtk_vdec_err(inst->ctx, "vp9_dec_vpu_init failed");
>  		goto err_deinit_inst;
>  	}
> =20
> @@ -829,17 +817,17 @@ static int vdec_vp9_decode(void *h_vdec, struct mtk=
_vcodec_mem *bs,
>  	*res_chg =3D false;
> =20
>  	if ((bs =3D=3D NULL) && (fb =3D=3D NULL)) {
> -		mtk_vcodec_debug(inst, "[EOS]");
> +		mtk_vdec_debug(inst->ctx, "[EOS]");
>  		vp9_reset(inst);
>  		return ret;
>  	}
> =20
>  	if (bs =3D=3D NULL) {
> -		mtk_vcodec_err(inst, "bs =3D=3D NULL");
> +		mtk_vdec_err(inst->ctx, "bs =3D=3D NULL");
>  		return -EINVAL;
>  	}
> =20
> -	mtk_vcodec_debug(inst, "Input BS Size =3D %zu", bs->size);
> +	mtk_vdec_debug(inst->ctx, "Input BS Size =3D %zu", bs->size);
> =20
>  	while (1) {
>  		struct vdec_fb *cur_fb =3D NULL;
> @@ -882,7 +870,7 @@ static int vdec_vp9_decode(void *h_vdec, struct mtk_v=
codec_mem *bs,
> =20
>  		ret =3D vpu_dec_start(&inst->vpu, data, 3);
>  		if (ret) {
> -			mtk_vcodec_err(inst, "vpu_dec_start failed");
> +			mtk_vdec_err(inst->ctx, "vpu_dec_start failed");
>  			goto DECODE_ERROR;
>  		}
> =20
> @@ -892,7 +880,7 @@ static int vdec_vp9_decode(void *h_vdec, struct mtk_v=
codec_mem *bs,
>  			if (vsi->show_frame & BIT(2)) {
>  				ret =3D vpu_dec_start(&inst->vpu, NULL, 0);
>  				if (ret) {
> -					mtk_vcodec_err(inst, "vpu trig decoder failed");
> +					mtk_vdec_err(inst->ctx, "vpu trig decoder failed");
>  					goto DECODE_ERROR;
>  				}
>  			}
> @@ -900,7 +888,7 @@ static int vdec_vp9_decode(void *h_vdec, struct mtk_v=
codec_mem *bs,
> =20
>  		ret =3D validate_vsi_array_indexes(inst, vsi);
>  		if (ret) {
> -			mtk_vcodec_err(inst, "Invalid values from VPU.");
> +			mtk_vdec_err(inst->ctx, "Invalid values from VPU.");
>  			goto DECODE_ERROR;
>  		}
> =20
> @@ -926,18 +914,18 @@ static int vdec_vp9_decode(void *h_vdec, struct mtk=
_vcodec_mem *bs,
>  		if (!vp9_is_sf_ref_fb(inst, inst->cur_fb))
>  			vp9_add_to_fb_use_list(inst, inst->cur_fb);
> =20
> -		mtk_vcodec_debug(inst, "[#pic %d]", vsi->frm_num);
> +		mtk_vdec_debug(inst->ctx, "[#pic %d]", vsi->frm_num);
> =20
>  		if (vsi->show_existing_frame)
> -			mtk_vcodec_debug(inst,
> -				"drv->new_fb_idx=3D%d, drv->frm_to_show_idx=3D%d",
> -				vsi->new_fb_idx, vsi->frm_to_show_idx);
> +			mtk_vdec_debug(inst->ctx,
> +				       "drv->new_fb_idx=3D%d, drv->frm_to_show_idx=3D%d",
> +				       vsi->new_fb_idx, vsi->frm_to_show_idx);
> =20
>  		if (vsi->show_existing_frame && (vsi->frm_to_show_idx <
>  					VP9_MAX_FRM_BUF_NUM)) {
> -			mtk_vcodec_debug(inst,
> -				"Skip Decode drv->new_fb_idx=3D%d, drv->frm_to_show_idx=3D%d",
> -				vsi->new_fb_idx, vsi->frm_to_show_idx);
> +			mtk_vdec_debug(inst->ctx,
> +				       "Skip Decode drv->new_fb_idx=3D%d, drv->frm_to_show_idx=3D%d"=
,
> +				       vsi->new_fb_idx, vsi->frm_to_show_idx);
> =20
>  			vp9_ref_cnt_fb(inst, &vsi->new_fb_idx,
>  					vsi->frm_to_show_idx);
> @@ -954,14 +942,14 @@ static int vdec_vp9_decode(void *h_vdec, struct mtk=
_vcodec_mem *bs,
> =20
>  		if (vsi->resolution_changed) {
>  			*res_chg =3D true;
> -			mtk_vcodec_debug(inst, "VDEC_ST_RESOLUTION_CHANGED");
> +			mtk_vdec_debug(inst->ctx, "VDEC_ST_RESOLUTION_CHANGED");
> =20
>  			ret =3D 0;
>  			goto DECODE_ERROR;
>  		}
> =20
>  		if (!vp9_decode_end_proc(inst)) {
> -			mtk_vcodec_err(inst, "vp9_decode_end_proc");
> +			mtk_vdec_err(inst->ctx, "vp9_decode_end_proc");
>  			ret =3D -EINVAL;
>  			goto DECODE_ERROR;
>  		}
> @@ -985,8 +973,8 @@ static void get_crop_info(struct vdec_vp9_inst *inst,=
 struct v4l2_rect *cr)
>  	cr->top =3D 0;
>  	cr->width =3D inst->vsi->pic_w;
>  	cr->height =3D inst->vsi->pic_h;
> -	mtk_vcodec_debug(inst, "get crop info l=3D%d, t=3D%d, w=3D%d, h=3D%d\n"=
,
> -			 cr->left, cr->top, cr->width, cr->height);
> +	mtk_vdec_debug(inst->ctx, "get crop info l=3D%d, t=3D%d, w=3D%d, h=3D%d=
\n",
> +		       cr->left, cr->top, cr->width, cr->height);
>  }
> =20
>  static int vdec_vp9_get_param(void *h_vdec, enum vdec_get_param_type typ=
e,
> @@ -1012,7 +1000,7 @@ static int vdec_vp9_get_param(void *h_vdec, enum vd=
ec_get_param_type type,
>  		get_crop_info(inst, out);
>  		break;
>  	default:
> -		mtk_vcodec_err(inst, "not supported param type %d", type);
> +		mtk_vdec_err(inst->ctx, "not supported param type %d", type);
>  		ret =3D -EINVAL;
>  		break;
>  	}
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat=
_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index c2f90848f498..913077d6e701 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -518,7 +518,7 @@ static int vdec_vp9_slice_init_default_frame_ctx(stru=
ct vdec_vp9_slice_instance
>  	remote_frame_ctx =3D mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler,
>  						     (u32)vsi->default_frame_ctx);
>  	if (!remote_frame_ctx) {
> -		mtk_vcodec_err(instance, "failed to map default frame ctx\n");
> +		mtk_vdec_err(ctx, "failed to map default frame ctx\n");
>  		return -EINVAL;
>  	}
> =20
> @@ -577,8 +577,8 @@ static int vdec_vp9_slice_alloc_working_buffer(struct=
 vdec_vp9_slice_instance *i
>  	if (level =3D=3D instance->level)
>  		return 0;
> =20
> -	mtk_vcodec_debug(instance, "resolution level changed, from %u to %u, %u=
x%u",
> -			 instance->level, level, w, h);
> +	mtk_vdec_debug(ctx, "resolution level changed, from %u to %u, %ux%u",
> +		       instance->level, level, w, h);
> =20
>  	max_sb_w =3D DIV_ROUND_UP(max_w, 64);
>  	max_sb_h =3D DIV_ROUND_UP(max_h, 64);
> @@ -1025,9 +1025,9 @@ static int vdec_vp9_slice_setup_prob_buffer(struct =
vdec_vp9_slice_instance *inst
> =20
>  	uh =3D &vsi->frame.uh;
> =20
> -	mtk_vcodec_debug(instance, "ctx dirty %u idx %d\n",
> -			 instance->dirty[uh->frame_context_idx],
> -			 uh->frame_context_idx);
> +	mtk_vdec_debug(instance->ctx, "ctx dirty %u idx %d\n",
> +		       instance->dirty[uh->frame_context_idx],
> +		       uh->frame_context_idx);
> =20
>  	if (instance->dirty[uh->frame_context_idx])
>  		frame_ctx =3D &instance->frame_ctx[uh->frame_context_idx];
> @@ -1051,7 +1051,7 @@ static void vdec_vp9_slice_setup_seg_buffer(struct =
vdec_vp9_slice_instance *inst
>  	    uh->error_resilient_mode ||
>  	    uh->frame_width !=3D instance->width ||
>  	    uh->frame_height !=3D instance->height) {
> -		mtk_vcodec_debug(instance, "reset seg\n");
> +		mtk_vdec_debug(instance->ctx, "reset seg\n");
>  		memset(buf->va, 0, buf->size);
>  	}
>  }
> @@ -1093,16 +1093,14 @@ static int vdec_vp9_slice_setup_tile_buffer(struc=
t vdec_vp9_slice_instance *inst
>  	cols =3D 1 << cols_log2;
> =20
>  	if (rows > 4 || cols > 64) {
> -		mtk_vcodec_err(instance, "tile_rows %u tile_cols %u\n",
> -			       rows, cols);
> +		mtk_vdec_err(instance->ctx, "tile_rows %u tile_cols %u\n", rows, cols)=
;
>  		return -EINVAL;
>  	}
> =20
>  	offset =3D uh->uncompressed_header_size +
>  		uh->header_size_in_bytes;
>  	if (bs->size <=3D offset) {
> -		mtk_vcodec_err(instance, "bs size %zu tile offset %u\n",
> -			       bs->size, offset);
> +		mtk_vdec_err(instance->ctx, "bs size %zu tile offset %u\n", bs->size, =
offset);
>  		return -EINVAL;
>  	}
> =20
> @@ -1596,14 +1594,12 @@ static int vdec_vp9_slice_update_single(struct vd=
ec_vp9_slice_instance *instance
>  	vsi =3D &pfc->vsi;
>  	memcpy(&pfc->state[0], &vsi->state, sizeof(vsi->state));
> =20
> -	mtk_vcodec_debug(instance, "Frame %u Y_CRC %08x %08x %08x %08x\n",
> -			 pfc->seq,
> -			 vsi->state.crc[0], vsi->state.crc[1],
> -			 vsi->state.crc[2], vsi->state.crc[3]);
> -	mtk_vcodec_debug(instance, "Frame %u C_CRC %08x %08x %08x %08x\n",
> -			 pfc->seq,
> -			 vsi->state.crc[4], vsi->state.crc[5],
> -			 vsi->state.crc[6], vsi->state.crc[7]);
> +	mtk_vdec_debug(instance->ctx, "Frame %u Y_CRC %08x %08x %08x %08x\n",
> +		       pfc->seq, vsi->state.crc[0], vsi->state.crc[1],
> +		       vsi->state.crc[2], vsi->state.crc[3]);
> +	mtk_vdec_debug(instance->ctx, "Frame %u C_CRC %08x %08x %08x %08x\n",
> +		       pfc->seq, vsi->state.crc[4], vsi->state.crc[5],
> +		       vsi->state.crc[6], vsi->state.crc[7]);
> =20
>  	vdec_vp9_slice_update_prob(instance, vsi);
> =20
> @@ -1624,10 +1620,10 @@ static int vdec_vp9_slice_update_lat(struct vdec_=
vp9_slice_instance *instance,
>  	vsi =3D &pfc->vsi;
>  	memcpy(&pfc->state[0], &vsi->state, sizeof(vsi->state));
> =20
> -	mtk_vcodec_debug(instance, "Frame %u LAT CRC 0x%08x %lx %lx\n",
> -			 pfc->seq, vsi->state.crc[0],
> -			 (unsigned long)vsi->trans.dma_addr,
> -			 (unsigned long)vsi->trans.dma_addr_end);
> +	mtk_vdec_debug(instance->ctx, "Frame %u LAT CRC 0x%08x %lx %lx\n",
> +		       pfc->seq, vsi->state.crc[0],
> +		       (unsigned long)vsi->trans.dma_addr,
> +		       (unsigned long)vsi->trans.dma_addr_end);
> =20
>  	/* buffer full, need to re-decode */
>  	if (vsi->state.full) {
> @@ -1844,14 +1840,12 @@ static int vdec_vp9_slice_update_core(struct vdec=
_vp9_slice_instance *instance,
>  	vsi =3D &pfc->vsi;
>  	memcpy(&pfc->state[1], &vsi->state, sizeof(vsi->state));
> =20
> -	mtk_vcodec_debug(instance, "Frame %u Y_CRC %08x %08x %08x %08x\n",
> -			 pfc->seq,
> -			 vsi->state.crc[0], vsi->state.crc[1],
> -			 vsi->state.crc[2], vsi->state.crc[3]);
> -	mtk_vcodec_debug(instance, "Frame %u C_CRC %08x %08x %08x %08x\n",
> -			 pfc->seq,
> -			 vsi->state.crc[4], vsi->state.crc[5],
> -			 vsi->state.crc[6], vsi->state.crc[7]);
> +	mtk_vdec_debug(instance->ctx, "Frame %u Y_CRC %08x %08x %08x %08x\n",
> +		       pfc->seq, vsi->state.crc[0], vsi->state.crc[1],
> +		       vsi->state.crc[2], vsi->state.crc[3]);
> +	mtk_vdec_debug(instance->ctx, "Frame %u C_CRC %08x %08x %08x %08x\n",
> +		       pfc->seq, vsi->state.crc[4], vsi->state.crc[5],
> +		       vsi->state.crc[6], vsi->state.crc[7]);
> =20
>  	return 0;
>  }
> @@ -1874,7 +1868,7 @@ static int vdec_vp9_slice_init(struct mtk_vcodec_ct=
x *ctx)
> =20
>  	ret =3D vpu_dec_init(&instance->vpu);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "failed to init vpu dec, ret %d\n", ret);
> +		mtk_vdec_err(ctx, "failed to init vpu dec, ret %d\n", ret);
>  		goto error_vpu_init;
>  	}
> =20
> @@ -1882,7 +1876,7 @@ static int vdec_vp9_slice_init(struct mtk_vcodec_ct=
x *ctx)
> =20
>  	vsi =3D instance->vpu.vsi;
>  	if (!vsi) {
> -		mtk_vcodec_err(instance, "failed to get VP9 vsi\n");
> +		mtk_vdec_err(ctx, "failed to get VP9 vsi\n");
>  		ret =3D -EINVAL;
>  		goto error_vsi;
>  	}
> @@ -1890,7 +1884,7 @@ static int vdec_vp9_slice_init(struct mtk_vcodec_ct=
x *ctx)
>  	instance->core_vsi =3D mtk_vcodec_fw_map_dm_addr(ctx->dev->fw_handler,
>  						       (u32)vsi->core_vsi);
>  	if (!instance->core_vsi) {
> -		mtk_vcodec_err(instance, "failed to get VP9 core vsi\n");
> +		mtk_vdec_err(ctx, "failed to get VP9 core vsi\n");
>  		ret =3D -EINVAL;
>  		goto error_vsi;
>  	}
> @@ -1931,7 +1925,7 @@ static int vdec_vp9_slice_flush(void *h_vdec, struc=
t mtk_vcodec_mem *bs,
>  {
>  	struct vdec_vp9_slice_instance *instance =3D h_vdec;
> =20
> -	mtk_vcodec_debug(instance, "flush ...\n");
> +	mtk_vdec_debug(instance->ctx, "flush ...\n");
>  	if (instance->ctx->dev->vdec_pdata->hw_arch !=3D MTK_VDEC_PURE_SINGLE_C=
ORE)
>  		vdec_msg_queue_wait_lat_buf_full(&instance->ctx->msg_queue);
>  	return vpu_dec_reset(&instance->vpu);
> @@ -1942,8 +1936,7 @@ static void vdec_vp9_slice_get_pic_info(struct vdec=
_vp9_slice_instance *instance
>  	struct mtk_vcodec_ctx *ctx =3D instance->ctx;
>  	unsigned int data[3];
> =20
> -	mtk_vcodec_debug(instance, "w %u h %u\n",
> -			 ctx->picinfo.pic_w, ctx->picinfo.pic_h);
> +	mtk_vdec_debug(instance->ctx, "w %u h %u\n", ctx->picinfo.pic_w, ctx->p=
icinfo.pic_h);
> =20
>  	data[0] =3D ctx->picinfo.pic_w;
>  	data[1] =3D ctx->picinfo.pic_h;
> @@ -1975,11 +1968,10 @@ static int vdec_vp9_slice_get_param(void *h_vdec,=
 enum vdec_get_param_type type,
>  		vdec_vp9_slice_get_dpb_size(instance, out);
>  		break;
>  	case GET_PARAM_CROP_INFO:
> -		mtk_vcodec_debug(instance, "No need to get vp9 crop information.");
> +		mtk_vdec_debug(instance->ctx, "No need to get vp9 crop information.");
>  		break;
>  	default:
> -		mtk_vcodec_err(instance, "invalid get parameter type=3D%d\n",
> -			       type);
> +		mtk_vdec_err(instance->ctx, "invalid get parameter type=3D%d\n", type)=
;
>  		return -EINVAL;
>  	}
> =20
> @@ -2011,14 +2003,14 @@ static int vdec_vp9_slice_single_decode(void *h_v=
dec, struct mtk_vcodec_mem *bs,
> =20
>  	ret =3D vdec_vp9_slice_setup_single(instance, bs, fb, pfc);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "Failed to setup VP9 single ret %d\n", ret);
> +		mtk_vdec_err(ctx, "Failed to setup VP9 single ret %d\n", ret);
>  		return ret;
>  	}
>  	vdec_vp9_slice_vsi_to_remote(vsi, instance->vsi);
> =20
>  	ret =3D vpu_dec_start(&instance->vpu, NULL, 0);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "Failed to dec VP9 ret %d\n", ret);
> +		mtk_vdec_err(ctx, "Failed to dec VP9 ret %d\n", ret);
>  		return ret;
>  	}
> =20
> @@ -2026,7 +2018,7 @@ static int vdec_vp9_slice_single_decode(void *h_vde=
c, struct mtk_vcodec_mem *bs,
>  					   WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
>  	/* update remote vsi if decode timeout */
>  	if (ret) {
> -		mtk_vcodec_err(instance, "VP9 decode timeout %d\n", ret);
> +		mtk_vdec_err(ctx, "VP9 decode timeout %d\n", ret);
>  		WRITE_ONCE(instance->vsi->state.timeout, 1);
>  	}
> =20
> @@ -2035,7 +2027,7 @@ static int vdec_vp9_slice_single_decode(void *h_vde=
c, struct mtk_vcodec_mem *bs,
>  	vdec_vp9_slice_vsi_from_remote(vsi, instance->vsi, 0);
>  	ret =3D vdec_vp9_slice_update_single(instance, pfc);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "VP9 decode error: %d\n", ret);
> +		mtk_vdec_err(ctx, "VP9 decode error: %d\n", ret);
>  		return ret;
>  	}
> =20
> @@ -2069,7 +2061,7 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, =
struct mtk_vcodec_mem *bs,
> =20
>  	lat_buf =3D vdec_msg_queue_dqbuf(&instance->ctx->msg_queue.lat_ctx);
>  	if (!lat_buf) {
> -		mtk_vcodec_debug(instance, "Failed to get VP9 lat buf\n");
> +		mtk_vdec_debug(ctx, "Failed to get VP9 lat buf\n");
>  		return -EAGAIN;
>  	}
>  	pfc =3D (struct vdec_vp9_slice_pfc *)lat_buf->private_data;
> @@ -2081,14 +2073,14 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs,
> =20
>  	ret =3D vdec_vp9_slice_setup_lat(instance, bs, lat_buf, pfc);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "Failed to setup VP9 lat ret %d\n", ret);
> +		mtk_vdec_err(ctx, "Failed to setup VP9 lat ret %d\n", ret);
>  		goto err_free_fb_out;
>  	}
>  	vdec_vp9_slice_vsi_to_remote(vsi, instance->vsi);
> =20
>  	ret =3D vpu_dec_start(&instance->vpu, NULL, 0);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "Failed to dec VP9 ret %d\n", ret);
> +		mtk_vdec_err(ctx, "Failed to dec VP9 ret %d\n", ret);
>  		goto err_free_fb_out;
>  	}
> =20
> @@ -2097,7 +2089,7 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, =
struct mtk_vcodec_mem *bs,
>  						   WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
>  		/* update remote vsi if decode timeout */
>  		if (ret) {
> -			mtk_vcodec_err(instance, "VP9 decode timeout %d pic %d\n", ret, pfc->=
seq);
> +			mtk_vdec_err(ctx, "VP9 decode timeout %d pic %d\n", ret, pfc->seq);
>  			WRITE_ONCE(instance->vsi->state.timeout, 1);
>  		}
>  		vpu_dec_end(&instance->vpu);
> @@ -2108,13 +2100,13 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs,
> =20
>  	/* LAT trans full, no more UBE or decode timeout */
>  	if (ret) {
> -		mtk_vcodec_err(instance, "VP9 decode error: %d\n", ret);
> +		mtk_vdec_err(ctx, "VP9 decode error: %d\n", ret);
>  		goto err_free_fb_out;
>  	}
> =20
> -	mtk_vcodec_debug(instance, "lat dma addr: 0x%lx 0x%lx\n",
> -			 (unsigned long)pfc->vsi.trans.dma_addr,
> -			 (unsigned long)pfc->vsi.trans.dma_addr_end);
> +	mtk_vdec_debug(ctx, "lat dma addr: 0x%lx 0x%lx\n",
> +		       (unsigned long)pfc->vsi.trans.dma_addr,
> +		       (unsigned long)pfc->vsi.trans.dma_addr_end);
> =20
>  	vdec_msg_queue_update_ube_wptr(&ctx->msg_queue,
>  				       vsi->trans.dma_addr_end +
> @@ -2169,14 +2161,14 @@ static int vdec_vp9_slice_core_decode(struct vdec=
_lat_buf *lat_buf)
> =20
>  	ret =3D vdec_vp9_slice_setup_core(instance, fb, lat_buf, pfc);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "vdec_vp9_slice_setup_core\n");
> +		mtk_vdec_err(ctx, "vdec_vp9_slice_setup_core\n");
>  		goto err;
>  	}
>  	vdec_vp9_slice_vsi_to_remote(&pfc->vsi, instance->core_vsi);
> =20
>  	ret =3D vpu_dec_core(&instance->vpu);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "vpu_dec_core\n");
> +		mtk_vdec_err(ctx, "vpu_dec_core\n");
>  		goto err;
>  	}
> =20
> @@ -2185,7 +2177,7 @@ static int vdec_vp9_slice_core_decode(struct vdec_l=
at_buf *lat_buf)
>  						   WAIT_INTR_TIMEOUT_MS, MTK_VDEC_CORE);
>  		/* update remote vsi if decode timeout */
>  		if (ret) {
> -			mtk_vcodec_err(instance, "VP9 core timeout pic %d\n", pfc->seq);
> +			mtk_vdec_err(ctx, "VP9 core timeout pic %d\n", pfc->seq);
>  			WRITE_ONCE(instance->core_vsi->state.timeout, 1);
>  		}
>  		vpu_dec_core_end(&instance->vpu);
> @@ -2194,13 +2186,13 @@ static int vdec_vp9_slice_core_decode(struct vdec=
_lat_buf *lat_buf)
>  	vdec_vp9_slice_vsi_from_remote(&pfc->vsi, instance->core_vsi, 1);
>  	ret =3D vdec_vp9_slice_update_core(instance, lat_buf, pfc);
>  	if (ret) {
> -		mtk_vcodec_err(instance, "vdec_vp9_slice_update_core\n");
> +		mtk_vdec_err(ctx, "vdec_vp9_slice_update_core\n");
>  		goto err;
>  	}
> =20
>  	pfc->vsi.trans.dma_addr_end +=3D ctx->msg_queue.wdma_addr.dma_addr;
> -	mtk_vcodec_debug(instance, "core dma_addr_end 0x%lx\n",
> -			 (unsigned long)pfc->vsi.trans.dma_addr_end);
> +	mtk_vdec_debug(ctx, "core dma_addr_end 0x%lx\n",
> +		       (unsigned long)pfc->vsi.trans.dma_addr_end);
>  	vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr=
_end);
>  	ctx->dev->vdec_pdata->cap_to_disp(ctx, 0, lat_buf->src_buf_req);
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drive=
rs/media/platform/mediatek/vcodec/vdec_vpu_if.c
> index 60e5b70fa127..ab15ee6e2005 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> @@ -16,7 +16,7 @@ static void handle_init_ack_msg(const struct vdec_vpu_i=
pi_init_ack *msg)
>  	struct vdec_vpu_inst *vpu =3D (struct vdec_vpu_inst *)
>  					(unsigned long)msg->ap_inst_addr;
> =20
> -	mtk_vcodec_debug(vpu, "+ ap_inst_addr =3D 0x%llx", msg->ap_inst_addr);
> +	mtk_vdec_debug(vpu->ctx, "+ ap_inst_addr =3D 0x%llx", msg->ap_inst_addr=
);
> =20
>  	/* mapping VPU address to kernel virtual address */
>  	/* the content in vsi is initialized to 0 in VPU */
> @@ -24,7 +24,7 @@ static void handle_init_ack_msg(const struct vdec_vpu_i=
pi_init_ack *msg)
>  					     msg->vpu_inst_addr);
>  	vpu->inst_addr =3D msg->vpu_inst_addr;
> =20
> -	mtk_vcodec_debug(vpu, "- vpu_inst_addr =3D 0x%x", vpu->inst_addr);
> +	mtk_vdec_debug(vpu->ctx, "- vpu_inst_addr =3D 0x%x", vpu->inst_addr);
> =20
>  	/* Set default ABI version if dealing with unversioned firmware. */
>  	vpu->fw_abi_version =3D 0;
> @@ -40,7 +40,7 @@ static void handle_init_ack_msg(const struct vdec_vpu_i=
pi_init_ack *msg)
> =20
>  	/* Check firmware version. */
>  	vpu->fw_abi_version =3D msg->vdec_abi_version;
> -	mtk_vcodec_debug(vpu, "firmware version 0x%x\n", vpu->fw_abi_version);
> +	mtk_vdec_debug(vpu->ctx, "firmware version 0x%x\n", vpu->fw_abi_version=
);
>  	switch (vpu->fw_abi_version) {
>  	case 1:
>  		break;
> @@ -48,8 +48,7 @@ static void handle_init_ack_msg(const struct vdec_vpu_i=
pi_init_ack *msg)
>  		vpu->inst_id =3D msg->inst_id;
>  		break;
>  	default:
> -		mtk_vcodec_err(vpu, "unhandled firmware version 0x%x\n",
> -			       vpu->fw_abi_version);
> +		mtk_vdec_err(vpu->ctx, "unhandled firmware version 0x%x\n", vpu->fw_ab=
i_version);
>  		vpu->failure =3D 1;
>  		break;
>  	}
> @@ -60,7 +59,7 @@ static void handle_get_param_msg_ack(const struct vdec_=
vpu_ipi_get_param_ack *ms
>  	struct vdec_vpu_inst *vpu =3D (struct vdec_vpu_inst *)
>  					(unsigned long)msg->ap_inst_addr;
> =20
> -	mtk_vcodec_debug(vpu, "+ ap_inst_addr =3D 0x%llx", msg->ap_inst_addr);
> +	mtk_vdec_debug(vpu->ctx, "+ ap_inst_addr =3D 0x%llx", msg->ap_inst_addr=
);
> =20
>  	/* param_type is enum vdec_get_param_type */
>  	switch (msg->param_type) {
> @@ -69,7 +68,7 @@ static void handle_get_param_msg_ack(const struct vdec_=
vpu_ipi_get_param_ack *ms
>  		vpu->fb_sz[1] =3D msg->data[1];
>  		break;
>  	default:
> -		mtk_vcodec_err(vpu, "invalid get param type=3D%d", msg->param_type);
> +		mtk_vdec_err(vpu->ctx, "invalid get param type=3D%d", msg->param_type)=
;
>  		vpu->failure =3D 1;
>  		break;
>  	}
> @@ -96,7 +95,7 @@ static void vpu_dec_ipi_handler(void *data, unsigned in=
t len, void *priv)
>  		return;
>  	}
> =20
> -	mtk_vcodec_debug(vpu, "+ id=3D%X", msg->msg_id);
> +	mtk_vdec_debug(vpu->ctx, "+ id=3D%X", msg->msg_id);
> =20
>  	vpu->failure =3D msg->status;
>  	vpu->signaled =3D 1;
> @@ -119,12 +118,12 @@ static void vpu_dec_ipi_handler(void *data, unsigne=
d int len, void *priv)
>  			handle_get_param_msg_ack(data);
>  			break;
>  		default:
> -			mtk_vcodec_err(vpu, "invalid msg=3D%X", msg->msg_id);
> +			mtk_vdec_err(vpu->ctx, "invalid msg=3D%X", msg->msg_id);
>  			break;
>  		}
>  	}
> =20
> -	mtk_vcodec_debug(vpu, "- id=3D%X", msg->msg_id);
> +	mtk_vdec_debug(vpu->ctx, "- id=3D%X", msg->msg_id);
>  }
> =20
>  static int vcodec_vpu_send_msg(struct vdec_vpu_inst *vpu, void *msg, int=
 len)
> @@ -132,7 +131,7 @@ static int vcodec_vpu_send_msg(struct vdec_vpu_inst *=
vpu, void *msg, int len)
>  	int err, id, msgid;
> =20
>  	msgid =3D *(uint32_t *)msg;
> -	mtk_vcodec_debug(vpu, "id=3D%X", msgid);
> +	mtk_vdec_debug(vpu->ctx, "id=3D%X", msgid);
> =20
>  	vpu->failure =3D 0;
>  	vpu->signaled =3D 0;
> @@ -150,8 +149,8 @@ static int vcodec_vpu_send_msg(struct vdec_vpu_inst *=
vpu, void *msg, int len)
>  	err =3D mtk_vcodec_fw_ipi_send(vpu->ctx->dev->fw_handler, id, msg,
>  				     len, 2000);
>  	if (err) {
> -		mtk_vcodec_err(vpu, "send fail vpu_id=3D%d msg_id=3D%X status=3D%d",
> -			       id, msgid, err);
> +		mtk_vdec_err(vpu->ctx, "send fail vpu_id=3D%d msg_id=3D%X status=3D%d"=
,
> +			     id, msgid, err);
>  		return err;
>  	}
> =20
> @@ -163,7 +162,7 @@ static int vcodec_send_ap_ipi(struct vdec_vpu_inst *v=
pu, unsigned int msg_id)
>  	struct vdec_ap_ipi_cmd msg;
>  	int err =3D 0;
> =20
> -	mtk_vcodec_debug(vpu, "+ id=3D%X", msg_id);
> +	mtk_vdec_debug(vpu->ctx, "+ id=3D%X", msg_id);
> =20
>  	memset(&msg, 0, sizeof(msg));
>  	msg.msg_id =3D msg_id;
> @@ -174,7 +173,7 @@ static int vcodec_send_ap_ipi(struct vdec_vpu_inst *v=
pu, unsigned int msg_id)
>  	msg.codec_type =3D vpu->codec_type;
> =20
>  	err =3D vcodec_vpu_send_msg(vpu, &msg, sizeof(msg));
> -	mtk_vcodec_debug(vpu, "- id=3D%X ret=3D%d", msg_id, err);
> +	mtk_vdec_debug(vpu->ctx, "- id=3D%X ret=3D%d", msg_id, err);
>  	return err;
>  }
> =20
> @@ -189,7 +188,7 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
>  	err =3D mtk_vcodec_fw_ipi_register(vpu->ctx->dev->fw_handler, vpu->id,
>  					 vpu->handler, "vdec", NULL);
>  	if (err) {
> -		mtk_vcodec_err(vpu, "vpu_ipi_register fail status=3D%d", err);
> +		mtk_vdec_err(vpu->ctx, "vpu_ipi_register fail status=3D%d", err);
>  		return err;
>  	}
> =20
> @@ -198,7 +197,7 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
>  						 vpu->core_id, vpu->handler,
>  						 "vdec", NULL);
>  		if (err) {
> -			mtk_vcodec_err(vpu, "vpu_ipi_register core fail status=3D%d", err);
> +			mtk_vdec_err(vpu->ctx, "vpu_ipi_register core fail status=3D%d", err)=
;
>  			return err;
>  		}
>  	}
> @@ -208,10 +207,10 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
>  	msg.ap_inst_addr =3D (unsigned long)vpu;
>  	msg.codec_type =3D vpu->codec_type;
> =20
> -	mtk_vcodec_debug(vpu, "vdec_inst=3D%p", vpu);
> +	mtk_vdec_debug(vpu->ctx, "vdec_inst=3D%p", vpu);
> =20
>  	err =3D vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
> -	mtk_vcodec_debug(vpu, "- ret=3D%d", err);
> +	mtk_vdec_debug(vpu->ctx, "- ret=3D%d", err);
>  	return err;
>  }
> =20
> @@ -222,7 +221,7 @@ int vpu_dec_start(struct vdec_vpu_inst *vpu, uint32_t=
 *data, unsigned int len)
>  	int err =3D 0;
> =20
>  	if (len > ARRAY_SIZE(msg.data)) {
> -		mtk_vcodec_err(vpu, "invalid len =3D %d\n", len);
> +		mtk_vdec_err(vpu->ctx, "invalid len =3D %d\n", len);
>  		return -EINVAL;
>  	}
> =20
> @@ -238,7 +237,7 @@ int vpu_dec_start(struct vdec_vpu_inst *vpu, uint32_t=
 *data, unsigned int len)
>  	msg.codec_type =3D vpu->codec_type;
> =20
>  	err =3D vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
> -	mtk_vcodec_debug(vpu, "- ret=3D%d", err);
> +	mtk_vdec_debug(vpu->ctx, "- ret=3D%d", err);
>  	return err;
>  }
> =20
> @@ -249,7 +248,7 @@ int vpu_dec_get_param(struct vdec_vpu_inst *vpu, uint=
32_t *data,
>  	int err;
> =20
>  	if (len > ARRAY_SIZE(msg.data)) {
> -		mtk_vcodec_err(vpu, "invalid len =3D %d\n", len);
> +		mtk_vdec_err(vpu->ctx, "invalid len =3D %d\n", len);
>  		return -EINVAL;
>  	}
> =20
> @@ -261,7 +260,7 @@ int vpu_dec_get_param(struct vdec_vpu_inst *vpu, uint=
32_t *data,
>  	msg.codec_type =3D vpu->codec_type;
> =20
>  	err =3D vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
> -	mtk_vcodec_debug(vpu, "- ret=3D%d", err);
> +	mtk_vdec_debug(vpu->ctx, "- ret=3D%d", err);
>  	return err;
>  }
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> index c821ed427537..5abc9c4e6d4f 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> @@ -240,13 +240,13 @@ static unsigned int h264_get_profile(struct venc_h2=
64_inst *inst,
>  	case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH:
>  		return 100;
>  	case V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE:
> -		mtk_vcodec_err(inst, "unsupported CONSTRAINED_BASELINE");
> +		mtk_venc_err(inst->ctx, "unsupported CONSTRAINED_BASELINE");
>  		return 0;
>  	case V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED:
> -		mtk_vcodec_err(inst, "unsupported EXTENDED");
> +		mtk_venc_err(inst->ctx, "unsupported EXTENDED");
>  		return 0;
>  	default:
> -		mtk_vcodec_debug(inst, "unsupported profile %d", profile);
> +		mtk_venc_debug(inst->ctx, "unsupported profile %d", profile);
>  		return 100;
>  	}
>  }
> @@ -256,7 +256,7 @@ static unsigned int h264_get_level(struct venc_h264_i=
nst *inst,
>  {
>  	switch (level) {
>  	case V4L2_MPEG_VIDEO_H264_LEVEL_1B:
> -		mtk_vcodec_err(inst, "unsupported 1B");
> +		mtk_venc_err(inst->ctx, "unsupported 1B");
>  		return 0;
>  	case V4L2_MPEG_VIDEO_H264_LEVEL_1_0:
>  		return 10;
> @@ -289,7 +289,7 @@ static unsigned int h264_get_level(struct venc_h264_i=
nst *inst,
>  	case V4L2_MPEG_VIDEO_H264_LEVEL_5_1:
>  		return 51;
>  	default:
> -		mtk_vcodec_debug(inst, "unsupported level %d", level);
> +		mtk_venc_debug(inst->ctx, "unsupported level %d", level);
>  		return 31;
>  	}
>  }
> @@ -360,8 +360,7 @@ static int h264_enc_alloc_work_buf(struct venc_h264_i=
nst *inst, bool is_34bit)
>  			ret =3D mtk_vcodec_mem_alloc(inst->ctx,
>  						   &inst->work_bufs[i]);
>  			if (ret) {
> -				mtk_vcodec_err(inst,
> -					       "cannot allocate buf %d", i);
> +				mtk_venc_err(inst->ctx, "cannot allocate buf %d", i);
>  				goto err_alloc;
>  			}
>  			/*
> @@ -385,18 +384,17 @@ static int h264_enc_alloc_work_buf(struct venc_h264=
_inst *inst, bool is_34bit)
>  		else
>  			wb[i].iova =3D inst->work_bufs[i].dma_addr;
> =20
> -		mtk_vcodec_debug(inst,
> -				 "work_buf[%d] va=3D0x%p iova=3D%pad size=3D%zu",
> -				 i, inst->work_bufs[i].va,
> -				 &inst->work_bufs[i].dma_addr,
> -				 inst->work_bufs[i].size);
> +		mtk_venc_debug(inst->ctx, "work_buf[%d] va=3D0x%p iova=3D%pad size=3D%=
zu",
> +			       i, inst->work_bufs[i].va,
> +			       &inst->work_bufs[i].dma_addr,
> +			       inst->work_bufs[i].size);
>  	}
> =20
>  	/* the pps_buf is used by AP side only */
>  	inst->pps_buf.size =3D 128;
>  	ret =3D mtk_vcodec_mem_alloc(inst->ctx, &inst->pps_buf);
>  	if (ret) {
> -		mtk_vcodec_err(inst, "cannot allocate pps_buf");
> +		mtk_venc_err(inst->ctx, "cannot allocate pps_buf");
>  		goto err_alloc;
>  	}
> =20
> @@ -416,7 +414,7 @@ static unsigned int h264_enc_wait_venc_done(struct ve=
nc_h264_inst *inst)
>  	if (!mtk_vcodec_wait_for_done_ctx(ctx, MTK_INST_IRQ_RECEIVED,
>  					  WAIT_INTR_TIMEOUT_MS, 0)) {
>  		irq_status =3D ctx->irq_status;
> -		mtk_vcodec_debug(inst, "irq_status %x <-", irq_status);
> +		mtk_venc_debug(ctx, "irq_status %x <-", irq_status);
>  	}
>  	return irq_status;
>  }
> @@ -450,13 +448,12 @@ static int h264_encode_sps(struct venc_h264_inst *i=
nst,
> =20
>  	irq_status =3D h264_enc_wait_venc_done(inst);
>  	if (irq_status !=3D MTK_VENC_IRQ_STATUS_SPS) {
> -		mtk_vcodec_err(inst, "expect irq status %d",
> -			       MTK_VENC_IRQ_STATUS_SPS);
> +		mtk_venc_err(inst->ctx, "expect irq status %d", MTK_VENC_IRQ_STATUS_SP=
S);
>  		return -EINVAL;
>  	}
> =20
>  	*bs_size =3D h264_read_reg(inst, VENC_PIC_BITSTREAM_BYTE_CNT);
> -	mtk_vcodec_debug(inst, "bs size %d <-", *bs_size);
> +	mtk_venc_debug(inst->ctx, "bs size %d <-", *bs_size);
> =20
>  	return ret;
>  }
> @@ -474,13 +471,12 @@ static int h264_encode_pps(struct venc_h264_inst *i=
nst,
> =20
>  	irq_status =3D h264_enc_wait_venc_done(inst);
>  	if (irq_status !=3D MTK_VENC_IRQ_STATUS_PPS) {
> -		mtk_vcodec_err(inst, "expect irq status %d",
> -			       MTK_VENC_IRQ_STATUS_PPS);
> +		mtk_venc_err(inst->ctx, "expect irq status %d", MTK_VENC_IRQ_STATUS_PP=
S);
>  		return -EINVAL;
>  	}
> =20
>  	*bs_size =3D h264_read_reg(inst, VENC_PIC_BITSTREAM_BYTE_CNT);
> -	mtk_vcodec_debug(inst, "bs size %d <-", *bs_size);
> +	mtk_venc_debug(inst->ctx, "bs size %d <-", *bs_size);
> =20
>  	return ret;
>  }
> @@ -519,7 +515,7 @@ static int h264_encode_frame(struct venc_h264_inst *i=
nst,
>  	struct venc_frame_info frame_info;
>  	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> =20
> -	mtk_vcodec_debug(inst, "frm_cnt =3D %d\n ", inst->frm_cnt);
> +	mtk_venc_debug(ctx, "frm_cnt =3D %d\n ", inst->frm_cnt);
> =20
>  	if (MTK_ENC_IOVA_IS_34BIT(ctx)) {
>  		gop_size =3D inst->vsi_34->config.gop_size;
> @@ -532,9 +528,9 @@ static int h264_encode_frame(struct venc_h264_inst *i=
nst,
>  	frame_info.skip_frm_count =3D inst->skip_frm_cnt;
>  	frame_info.frm_type =3D h264_frame_type(inst->frm_cnt, gop_size,
>  					      intra_period);
> -	mtk_vcodec_debug(inst, "frm_count =3D %d,skip_frm_count =3D%d,frm_type=
=3D%d.\n",
> -			 frame_info.frm_count, frame_info.skip_frm_count,
> -			 frame_info.frm_type);
> +	mtk_venc_debug(ctx, "frm_count =3D %d,skip_frm_count =3D%d,frm_type=3D%=
d.\n",
> +		       frame_info.frm_count, frame_info.skip_frm_count,
> +		       frame_info.frm_type);
> =20
>  	ret =3D vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_FRAME,
>  			     frm_buf, bs_buf, &frame_info);
> @@ -557,15 +553,15 @@ static int h264_encode_frame(struct venc_h264_inst =
*inst,
> =20
>  	irq_status =3D h264_enc_wait_venc_done(inst);
>  	if (irq_status !=3D MTK_VENC_IRQ_STATUS_FRM) {
> -		mtk_vcodec_err(inst, "irq_status=3D%d failed", irq_status);
> +		mtk_venc_err(ctx, "irq_status=3D%d failed", irq_status);
>  		return -EIO;
>  	}
> =20
>  	*bs_size =3D h264_read_reg(inst, VENC_PIC_BITSTREAM_BYTE_CNT);
> =20
>  	++inst->frm_cnt;
> -	mtk_vcodec_debug(inst, "frm %d bs_size %d key_frm %d <-",
> -			 inst->frm_cnt, *bs_size, inst->vpu_inst.is_key_frm);
> +	mtk_venc_debug(ctx, "frm %d bs_size %d key_frm %d <-",
> +		       inst->frm_cnt, *bs_size, inst->vpu_inst.is_key_frm);
> =20
>  	return 0;
>  }
> @@ -576,7 +572,7 @@ static void h264_encode_filler(struct venc_h264_inst =
*inst, void *buf,
>  	unsigned char *p =3D buf;
> =20
>  	if (size < H264_FILLER_MARKER_SIZE) {
> -		mtk_vcodec_err(inst, "filler size too small %d", size);
> +		mtk_venc_err(inst->ctx, "filler size too small %d", size);
>  		return;
>  	}
> =20
> @@ -626,7 +622,7 @@ static int h264_enc_encode(void *handle,
>  	struct venc_h264_inst *inst =3D (struct venc_h264_inst *)handle;
>  	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
> =20
> -	mtk_vcodec_debug(inst, "opt %d ->", opt);
> +	mtk_venc_debug(ctx, "opt %d ->", opt);
> =20
>  	enable_irq(ctx->dev->enc_irq);
> =20
> @@ -661,7 +657,7 @@ static int h264_enc_encode(void *handle,
>  			break;
>  		}
> =20
> -		mtk_vcodec_debug(inst, "h264_encode_frame prepend SPS/PPS");
> +		mtk_venc_debug(ctx, "h264_encode_frame prepend SPS/PPS");
> =20
>  		ret =3D h264_encode_header(inst, bs_buf, &bs_size_hdr);
>  		if (ret)
> @@ -688,9 +684,8 @@ static int h264_enc_encode(void *handle,
> =20
>  		result->bs_size =3D hdr_sz + filler_sz + bs_size_frm;
> =20
> -		mtk_vcodec_debug(inst, "hdr %d filler %d frame %d bs %d",
> -				 hdr_sz, filler_sz, bs_size_frm,
> -				 result->bs_size);
> +		mtk_venc_debug(ctx, "hdr %d filler %d frame %d bs %d",
> +			       hdr_sz, filler_sz, bs_size_frm, result->bs_size);
> =20
>  		inst->prepend_hdr =3D 0;
>  		result->is_key_frm =3D inst->vpu_inst.is_key_frm;
> @@ -698,7 +693,7 @@ static int h264_enc_encode(void *handle,
>  	}
> =20
>  	default:
> -		mtk_vcodec_err(inst, "venc_start_opt %d not supported", opt);
> +		mtk_venc_err(ctx, "venc_start_opt %d not supported", opt);
>  		ret =3D -EINVAL;
>  		break;
>  	}
> @@ -706,7 +701,7 @@ static int h264_enc_encode(void *handle,
>  encode_err:
> =20
>  	disable_irq(ctx->dev->enc_irq);
> -	mtk_vcodec_debug(inst, "opt %d <-", opt);
> +	mtk_venc_debug(ctx, "opt %d <-", opt);
> =20
>  	return ret;
>  }
> @@ -758,7 +753,7 @@ static int h264_enc_set_param(void *handle,
>  	struct mtk_vcodec_ctx *ctx =3D inst->ctx;
>  	const bool is_34bit =3D MTK_ENC_IOVA_IS_34BIT(ctx);
> =20
> -	mtk_vcodec_debug(inst, "->type=3D%d", type);
> +	mtk_venc_debug(ctx, "->type=3D%d", type);
> =20
>  	switch (type) {
>  	case VENC_SET_PARAM_ENC:
> @@ -781,7 +776,7 @@ static int h264_enc_set_param(void *handle,
> =20
>  	case VENC_SET_PARAM_PREPEND_HEADER:
>  		inst->prepend_hdr =3D 1;
> -		mtk_vcodec_debug(inst, "set prepend header mode");
> +		mtk_venc_debug(ctx, "set prepend header mode");
>  		break;
>  	case VENC_SET_PARAM_FORCE_INTRA:
>  	case VENC_SET_PARAM_GOP_SIZE:
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> index ddcdb565db17..ff54064497f1 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> @@ -171,8 +171,7 @@ static int vp8_enc_alloc_work_buf(struct venc_vp8_ins=
t *inst)
>  		inst->work_bufs[i].size =3D wb[i].size;
>  		ret =3D mtk_vcodec_mem_alloc(inst->ctx, &inst->work_bufs[i]);
>  		if (ret) {
> -			mtk_vcodec_err(inst,
> -				       "cannot alloc work_bufs[%d]", i);
> +			mtk_venc_err(inst->ctx, "cannot alloc work_bufs[%d]", i);
>  			goto err_alloc;
>  		}
>  		/*
> @@ -193,11 +192,10 @@ static int vp8_enc_alloc_work_buf(struct venc_vp8_i=
nst *inst)
>  		}
>  		wb[i].iova =3D inst->work_bufs[i].dma_addr;
> =20
> -		mtk_vcodec_debug(inst,
> -				 "work_bufs[%d] va=3D0x%p,iova=3D%pad,size=3D%zu",
> -				 i, inst->work_bufs[i].va,
> -				 &inst->work_bufs[i].dma_addr,
> -				 inst->work_bufs[i].size);
> +		mtk_venc_debug(inst->ctx, "work_bufs[%d] va=3D0x%p,iova=3D%pad,size=3D=
%zu",
> +			       i, inst->work_bufs[i].va,
> +			       &inst->work_bufs[i].dma_addr,
> +			       inst->work_bufs[i].size);
>  	}
> =20
>  	return ret;
> @@ -216,7 +214,7 @@ static unsigned int vp8_enc_wait_venc_done(struct ven=
c_vp8_inst *inst)
>  	if (!mtk_vcodec_wait_for_done_ctx(ctx, MTK_INST_IRQ_RECEIVED,
>  					  WAIT_INTR_TIMEOUT_MS, 0)) {
>  		irq_status =3D ctx->irq_status;
> -		mtk_vcodec_debug(inst, "isr return %x", irq_status);
> +		mtk_venc_debug(ctx, "isr return %x", irq_status);
>  	}
>  	return irq_status;
>  }
> @@ -261,8 +259,7 @@ static int vp8_enc_compose_one_frame(struct venc_vp8_=
inst *inst,
>  	}
> =20
>  	if (bs_buf->size < bs_hdr_len + bs_frm_size + ac_tag_size) {
> -		mtk_vcodec_err(inst, "bitstream buf size is too small(%zu)",
> -			       bs_buf->size);
> +		mtk_venc_err(inst->ctx, "bitstream buf size is too small(%zu)", bs_buf=
->size);
>  		return -EINVAL;
>  	}
> =20
> @@ -292,7 +289,7 @@ static int vp8_enc_encode_frame(struct venc_vp8_inst =
*inst,
>  	int ret =3D 0;
>  	unsigned int irq_status;
> =20
> -	mtk_vcodec_debug(inst, "->frm_cnt=3D%d", inst->frm_cnt);
> +	mtk_venc_debug(inst->ctx, "->frm_cnt=3D%d", inst->frm_cnt);
> =20
>  	ret =3D vpu_enc_encode(&inst->vpu_inst, 0, frm_buf, bs_buf, NULL);
>  	if (ret)
> @@ -300,18 +297,17 @@ static int vp8_enc_encode_frame(struct venc_vp8_ins=
t *inst,
> =20
>  	irq_status =3D vp8_enc_wait_venc_done(inst);
>  	if (irq_status !=3D MTK_VENC_IRQ_STATUS_FRM) {
> -		mtk_vcodec_err(inst, "irq_status=3D%d failed", irq_status);
> +		mtk_venc_err(inst->ctx, "irq_status=3D%d failed", irq_status);
>  		return -EIO;
>  	}
> =20
>  	if (vp8_enc_compose_one_frame(inst, bs_buf, bs_size)) {
> -		mtk_vcodec_err(inst, "vp8_enc_compose_one_frame failed");
> +		mtk_venc_err(inst->ctx, "vp8_enc_compose_one_frame failed");
>  		return -EINVAL;
>  	}
> =20
>  	inst->frm_cnt++;
> -	mtk_vcodec_debug(inst, "<-size=3D%d key_frm=3D%d", *bs_size,
> -			 inst->vpu_inst.is_key_frm);
> +	mtk_venc_debug(inst->ctx, "<-size=3D%d key_frm=3D%d", *bs_size, inst->v=
pu_inst.is_key_frm);
> =20
>  	return ret;
>  }
> @@ -364,7 +360,7 @@ static int vp8_enc_encode(void *handle,
>  		break;
> =20
>  	default:
> -		mtk_vcodec_err(inst, "opt not support:%d", opt);
> +		mtk_venc_err(ctx, "opt not support:%d", opt);
>  		ret =3D -EINVAL;
>  		break;
>  	}
> @@ -382,7 +378,7 @@ static int vp8_enc_set_param(void *handle,
>  	int ret =3D 0;
>  	struct venc_vp8_inst *inst =3D (struct venc_vp8_inst *)handle;
> =20
> -	mtk_vcodec_debug(inst, "->type=3D%d", type);
> +	mtk_venc_debug(inst->ctx, "->type=3D%d", type);
> =20
>  	switch (type) {
>  	case VENC_SET_PARAM_ENC:
> @@ -413,7 +409,7 @@ static int vp8_enc_set_param(void *handle,
>  	 */
>  	case VENC_SET_PARAM_TS_MODE:
>  		inst->ts_mode =3D 1;
> -		mtk_vcodec_debug(inst, "set ts_mode");
> +		mtk_venc_debug(inst->ctx, "set ts_mode");
>  		break;
> =20
>  	default:
> diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drive=
rs/media/platform/mediatek/vcodec/venc_vpu_if.c
> index 63ebab28242c..c69f66b6d341 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> @@ -22,14 +22,13 @@ static void handle_enc_init_msg(struct venc_vpu_inst =
*vpu, const void *data)
>  		return;
> =20
>  	/* Check firmware version. */
> -	mtk_vcodec_debug(vpu, "firmware version: 0x%x\n",
> -			 msg->venc_abi_version);
> +	mtk_venc_debug(vpu->ctx, "firmware version: 0x%x\n", msg->venc_abi_vers=
ion);
>  	switch (msg->venc_abi_version) {
>  	case 1:
>  		break;
>  	default:
> -		mtk_vcodec_err(vpu, "unhandled firmware version 0x%x\n",
> -			       msg->venc_abi_version);
> +		mtk_venc_err(vpu->ctx, "unhandled firmware version 0x%x\n",
> +			     msg->venc_abi_version);
>  		vpu->failure =3D 1;
>  		break;
>  	}
> @@ -50,13 +49,12 @@ static void vpu_enc_ipi_handler(void *data, unsigned =
int len, void *priv)
>  	struct venc_vpu_inst *vpu =3D
>  		(struct venc_vpu_inst *)(unsigned long)msg->venc_inst;
> =20
> -	mtk_vcodec_debug(vpu, "msg_id %x inst %p status %d",
> -			 msg->msg_id, vpu, msg->status);
> +	mtk_venc_debug(vpu->ctx, "msg_id %x inst %p status %d", msg->msg_id, vp=
u, msg->status);
> =20
>  	vpu->signaled =3D 1;
>  	vpu->failure =3D (msg->status !=3D VENC_IPI_MSG_STATUS_OK);
>  	if (vpu->failure) {
> -		mtk_vcodec_err(vpu, "vpu enc status failure %d", vpu->failure);
> +		mtk_venc_err(vpu->ctx, "vpu enc status failure %d", vpu->failure);
>  		return;
>  	}
> =20
> @@ -72,7 +70,7 @@ static void vpu_enc_ipi_handler(void *data, unsigned in=
t len, void *priv)
>  	case VPU_IPIMSG_ENC_DEINIT_DONE:
>  		break;
>  	default:
> -		mtk_vcodec_err(vpu, "unknown msg id %x", msg->msg_id);
> +		mtk_venc_err(vpu->ctx, "unknown msg id %x", msg->msg_id);
>  		break;
>  	}
>  }
> @@ -83,15 +81,15 @@ static int vpu_enc_send_msg(struct venc_vpu_inst *vpu=
, void *msg,
>  	int status;
> =20
>  	if (!vpu->ctx->dev->fw_handler) {
> -		mtk_vcodec_err(vpu, "inst dev is NULL");
> +		mtk_venc_err(vpu->ctx, "inst dev is NULL");
>  		return -EINVAL;
>  	}
> =20
>  	status =3D mtk_vcodec_fw_ipi_send(vpu->ctx->dev->fw_handler, vpu->id, m=
sg,
>  					len, 2000);
>  	if (status) {
> -		mtk_vcodec_err(vpu, "vpu_ipi_send msg_id %x len %d fail %d",
> -			       *(uint32_t *)msg, len, status);
> +		mtk_venc_err(vpu->ctx, "vpu_ipi_send msg_id %x len %d fail %d",
> +			     *(uint32_t *)msg, len, status);
>  		return -EINVAL;
>  	}
>  	if (vpu->failure)
> @@ -113,7 +111,7 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
>  					    vpu_enc_ipi_handler, "venc", NULL);
> =20
>  	if (status) {
> -		mtk_vcodec_err(vpu, "vpu_ipi_register fail %d", status);
> +		mtk_venc_err(vpu->ctx, "vpu_ipi_register fail %d", status);
>  		return -EINVAL;
>  	}
> =20
> @@ -121,7 +119,7 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
>  	out.msg_id =3D AP_IPIMSG_ENC_INIT;
>  	out.venc_inst =3D (unsigned long)vpu;
>  	if (vpu_enc_send_msg(vpu, &out, sizeof(out))) {
> -		mtk_vcodec_err(vpu, "AP_IPIMSG_ENC_INIT fail");
> +		mtk_venc_err(vpu->ctx, "AP_IPIMSG_ENC_INIT fail");
>  		return -EINVAL;
>  	}
> =20
> @@ -157,7 +155,7 @@ int vpu_enc_set_param(struct venc_vpu_inst *vpu,
>  		sizeof(struct venc_ap_ipi_msg_set_param);
>  	struct venc_ap_ipi_msg_set_param_ext out;
> =20
> -	mtk_vcodec_debug(vpu, "id %d ->", id);
> +	mtk_venc_debug(vpu->ctx, "id %d ->", id);
> =20
>  	memset(&out, 0, sizeof(out));
>  	out.base.msg_id =3D AP_IPIMSG_ENC_SET_PARAM;
> @@ -199,16 +197,15 @@ int vpu_enc_set_param(struct venc_vpu_inst *vpu,
>  		out.base.data_item =3D 0;
>  		break;
>  	default:
> -		mtk_vcodec_err(vpu, "id %d not supported", id);
> +		mtk_venc_err(vpu->ctx, "id %d not supported", id);
>  		return -EINVAL;
>  	}
>  	if (vpu_enc_send_msg(vpu, &out, msg_size)) {
> -		mtk_vcodec_err(vpu,
> -			       "AP_IPIMSG_ENC_SET_PARAM %d fail", id);
> +		mtk_venc_err(vpu->ctx, "AP_IPIMSG_ENC_SET_PARAM %d fail", id);
>  		return -EINVAL;
>  	}
> =20
> -	mtk_vcodec_debug(vpu, "id %d <-", id);
> +	mtk_venc_debug(vpu->ctx, "id %d <-", id);
> =20
>  	return 0;
>  }
> @@ -225,7 +222,7 @@ static int vpu_enc_encode_32bits(struct venc_vpu_inst=
 *vpu,
>  		sizeof(struct venc_ap_ipi_msg_enc);
>  	struct venc_ap_ipi_msg_enc_ext out;
> =20
> -	mtk_vcodec_debug(vpu, "bs_mode %d ->", bs_mode);
> +	mtk_venc_debug(vpu->ctx, "bs_mode %d ->", bs_mode);
> =20
>  	memset(&out, 0, sizeof(out));
>  	out.base.msg_id =3D AP_IPIMSG_ENC_ENCODE;
> @@ -239,7 +236,7 @@ static int vpu_enc_encode_32bits(struct venc_vpu_inst=
 *vpu,
>  			out.base.input_addr[1] =3D frm_buf->fb_addr[1].dma_addr;
>  			out.base.input_addr[2] =3D frm_buf->fb_addr[2].dma_addr;
>  		} else {
> -			mtk_vcodec_err(vpu, "dma_addr not align to 16");
> +			mtk_venc_err(vpu->ctx, "dma_addr not align to 16");
>  			return -EINVAL;
>  		}
>  	}
> @@ -254,8 +251,7 @@ static int vpu_enc_encode_32bits(struct venc_vpu_inst=
 *vpu,
>  		out.data[2] =3D frame_info->frm_type;
>  	}
>  	if (vpu_enc_send_msg(vpu, &out, msg_size)) {
> -		mtk_vcodec_err(vpu, "AP_IPIMSG_ENC_ENCODE %d fail",
> -			       bs_mode);
> +		mtk_venc_err(vpu->ctx, "AP_IPIMSG_ENC_ENCODE %d fail", bs_mode);
>  		return -EINVAL;
>  	}
> =20
> @@ -271,7 +267,7 @@ static int vpu_enc_encode_34bits(struct venc_vpu_inst=
 *vpu,
>  	struct venc_ap_ipi_msg_enc_ext_34 out;
>  	size_t msg_size =3D sizeof(struct venc_ap_ipi_msg_enc_ext_34);
> =20
> -	mtk_vcodec_debug(vpu, "bs_mode %d ->", bs_mode);
> +	mtk_venc_debug(vpu->ctx, "bs_mode %d ->", bs_mode);
> =20
>  	memset(&out, 0, sizeof(out));
>  	out.msg_id =3D AP_IPIMSG_ENC_ENCODE;
> @@ -286,7 +282,7 @@ static int vpu_enc_encode_34bits(struct venc_vpu_inst=
 *vpu,
>  			out.input_addr[1] =3D frm_buf->fb_addr[1].dma_addr;
>  			out.input_addr[2] =3D frm_buf->fb_addr[2].dma_addr;
>  		} else {
> -			mtk_vcodec_err(vpu, "dma_addr not align to 16");
> +			mtk_venc_err(vpu->ctx, "dma_addr not align to 16");
>  			return -EINVAL;
>  		}
>  	}
> @@ -301,8 +297,7 @@ static int vpu_enc_encode_34bits(struct venc_vpu_inst=
 *vpu,
>  		out.data[2] =3D frame_info->frm_type;
>  	}
>  	if (vpu_enc_send_msg(vpu, &out, msg_size)) {
> -		mtk_vcodec_err(vpu, "AP_IPIMSG_ENC_ENCODE %d fail",
> -			       bs_mode);
> +		mtk_venc_err(vpu->ctx, "AP_IPIMSG_ENC_ENCODE %d fail", bs_mode);
>  		return -EINVAL;
>  	}
> =20
> @@ -326,8 +321,8 @@ int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigne=
d int bs_mode,
>  	if (ret)
>  		return ret;
> =20
> -	mtk_vcodec_debug(vpu, "bs_mode %d state %d size %d key_frm %d <-",
> -			 bs_mode, vpu->state, vpu->bs_size, vpu->is_key_frm);
> +	mtk_venc_debug(vpu->ctx, "bs_mode %d state %d size %d key_frm %d <-",
> +		       bs_mode, vpu->state, vpu->bs_size, vpu->is_key_frm);
> =20
>  	return 0;
>  }
> @@ -340,7 +335,7 @@ int vpu_enc_deinit(struct venc_vpu_inst *vpu)
>  	out.msg_id =3D AP_IPIMSG_ENC_DEINIT;
>  	out.vpu_inst_addr =3D vpu->inst_addr;
>  	if (vpu_enc_send_msg(vpu, &out, sizeof(out))) {
> -		mtk_vcodec_err(vpu, "AP_IPIMSG_ENC_DEINIT fail");
> +		mtk_venc_err(vpu->ctx, "AP_IPIMSG_ENC_DEINIT fail");
>  		return -EINVAL;
>  	}
> =20

