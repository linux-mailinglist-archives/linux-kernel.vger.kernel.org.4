Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64AA719796
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjFAJr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjFAJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:47:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3EA198;
        Thu,  1 Jun 2023 02:47:39 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7512D6600358;
        Thu,  1 Jun 2023 10:47:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685612858;
        bh=JYyBmMQDgj01wREtM7fhSO4WWw1sKItx2GCq0YBxbFU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lPZH4wwKcGpjXe94WyuJ9xBaU/RINBeTsHqvn9b3jIZW8GtCu1j88CYaBXs+5LnXX
         42Bq7U4qGbUI6VmDK/G2/4x1ir1uC8BtzCJFnWYNTDoKPDHkzJ8Vrh55+bH8bube6o
         1kHQYk7VjGmqnarVxNcouuERrjjXBUJ0KRxmVfTTKSnn+pNOANyNuwCTi0ujX7IocP
         s8TttjWccVnLGBgqSVDorpFTTKtS2zlJ/6RaaMZfiXh3hw/1q8M3dWrO0wOPtsTFG5
         6fQODklTOFhHPv3Py4ObE6QUbeRDAXDiUsqLcGZP1ITV2mO1Qhhba3pc4xiFm0+UHb
         PdRhdPIfPRSwA==
Message-ID: <c0d27ac1-eda8-b4e9-95f1-edab6eef40b1@collabora.com>
Date:   Thu, 1 Jun 2023 11:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6/8] mediatek: vcodec: separate struct mtk_vcodec_dev
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230601030256.29875-1-yunfei.dong@mediatek.com>
 <20230601030256.29875-7-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230601030256.29875-7-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/06/23 05:02, Yunfei Dong ha scritto:
> Adding different dev struct for encoder and decoder, remove
> 'struct mtk_vcodec_dev'.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../mediatek/vcodec/mtk_vcodec_com_drv.h      |  71 +++++
>   .../mediatek/vcodec/mtk_vcodec_dbgfs.c        |  51 ++-
>   .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  14 +-
>   .../platform/mediatek/vcodec/mtk_vcodec_dec.c |   4 +-
>   .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  19 +-
>   .../mediatek/vcodec/mtk_vcodec_dec_drv.h      | 168 +++++++++-
>   .../mediatek/vcodec/mtk_vcodec_dec_hw.c       |   5 +-
>   .../mediatek/vcodec/mtk_vcodec_dec_hw.h       |   4 +-
>   .../mediatek/vcodec/mtk_vcodec_dec_pm.c       |  10 +-
>   .../mediatek/vcodec/mtk_vcodec_dec_pm.h       |   2 +-
>   .../mediatek/vcodec/mtk_vcodec_dec_stateful.c |   3 +-
>   .../vcodec/mtk_vcodec_dec_stateless.c         |   5 +-
>   .../platform/mediatek/vcodec/mtk_vcodec_drv.h | 295 ------------------
>   .../platform/mediatek/vcodec/mtk_vcodec_enc.c |   5 +-
>   .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  15 +-
>   .../mediatek/vcodec/mtk_vcodec_enc_drv.h      |  89 +++++-
>   .../mediatek/vcodec/mtk_vcodec_enc_pm.c       |   4 +-
>   .../mediatek/vcodec/mtk_vcodec_enc_pm.h       |   4 +-
>   .../platform/mediatek/vcodec/mtk_vcodec_fw.c  |   4 +-
>   .../platform/mediatek/vcodec/mtk_vcodec_fw.h  |   3 +-
>   .../mediatek/vcodec/mtk_vcodec_fw_priv.h      |   3 +-
>   .../mediatek/vcodec/mtk_vcodec_fw_scp.c       |  11 +-
>   .../mediatek/vcodec/mtk_vcodec_fw_vpu.c       |  16 +-
>   .../mediatek/vcodec/mtk_vcodec_intr.c         |   4 +-
>   .../mediatek/vcodec/mtk_vcodec_util.c         |  10 +-
>   .../mediatek/vcodec/mtk_vcodec_util.h         |   8 +-
>   .../vcodec/vdec/vdec_h264_req_common.h        |   2 +-
>   .../vcodec/vdec/vdec_h264_req_multi_if.c      |   2 +-
>   .../platform/mediatek/vcodec/vdec_drv_if.h    |   1 -
>   .../platform/mediatek/vcodec/vdec_msg_queue.c |   4 +-
>   .../platform/mediatek/vcodec/vdec_msg_queue.h |   2 +-
>   .../platform/mediatek/vcodec/vdec_vpu_if.c    |   3 +-
>   .../mediatek/vcodec/venc/venc_h264_if.c       |   2 +-
>   .../mediatek/vcodec/venc/venc_vp8_if.c        |   2 +-
>   .../platform/mediatek/vcodec/venc_drv_base.h  |   2 +-
>   .../platform/mediatek/vcodec/venc_drv_if.c    |   4 +-
>   .../platform/mediatek/vcodec/venc_drv_if.h    |   3 +-
>   .../platform/mediatek/vcodec/venc_vpu_if.c    |   2 +-
>   38 files changed, 441 insertions(+), 415 deletions(-)
>   delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> 

..snip..

> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
> index 94870b651919..b664d0733466 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
> @@ -8,9 +8,49 @@
>   #define _MTK_VCODEC_DEC_DRV_H_
>   
>   #include "mtk_vcodec_com_drv.h"
> +#include "mtk_vcodec_dbgfs.h"
>   #include "mtk_vcodec_fw_priv.h"
> +#include "mtk_vcodec_util.h"
>   #include "vdec_msg_queue.h"
>   
> +#define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
> +
> +#define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
> +#define IS_VDEC_INNER_RACING(capability) ((capability) & MTK_VCODEC_INNER_RACING)
> +
> +/*
> + * struct mtk_vdec_format_types - Structure used to get supported

This is not a struct, it's an enumeration..... please fix the typo

> + *		  format types according to decoder capability
> + */
> +enum mtk_vdec_format_types {
> +	MTK_VDEC_FORMAT_MM21 = 0x20,
> +	MTK_VDEC_FORMAT_MT21C = 0x40,
> +	MTK_VDEC_FORMAT_H264_SLICE = 0x100,
> +	MTK_VDEC_FORMAT_VP8_FRAME = 0x200,
> +	MTK_VDEC_FORMAT_VP9_FRAME = 0x400,
> +	MTK_VDEC_FORMAT_AV1_FRAME = 0x800,
> +	MTK_VDEC_FORMAT_HEVC_FRAME = 0x1000,
> +	MTK_VCODEC_INNER_RACING = 0x20000,
> +};
> +
> +/*
> + * enum mtk_vdec_hw_count - Supported hardware count
> + */
> +enum mtk_vdec_hw_count {
> +	MTK_VDEC_NO_HW = 0,
> +	MTK_VDEC_ONE_CORE,
> +	MTK_VDEC_ONE_LAT_ONE_CORE,
> +	MTK_VDEC_MAX_HW_COUNT,
> +};
> +
> +/*
> + * enum mtk_vdec_hw_arch - Used to separate different hardware architecture
> + */
> +enum mtk_vdec_hw_arch {
> +	MTK_VDEC_PURE_SINGLE_CORE,
> +	MTK_VDEC_LAT_SINGLE_CORE,
> +};
> +
>   /**
>    * struct vdec_pic_info  - picture size information
>    * @pic_w: picture width
> @@ -33,16 +73,46 @@ struct vdec_pic_info {
>   	unsigned int reserved;
>   };
>   
> -/*
> - * enum mtk_vdec_hw_id - Hardware index used to separate
> - *                         different hardware
> +/**
> + * struct mtk_vcodec_dec_pdata - compatible data for each IC
> + * @init_vdec_params: init vdec params
> + * @ctrls_setup: init vcodec dec ctrls
> + * @worker: worker to start a decode job
> + * @flush_decoder: function that flushes the decoder
> + * @get_cap_buffer: get capture buffer from capture queue
> + * @cap_to_disp: put capture buffer to disp list for lat and core arch
> + * @vdec_vb2_ops: struct vb2_ops
> + *
> + * @vdec_formats: supported video decoder formats
> + * @num_formats: count of video decoder formats
> + * @default_out_fmt: default output buffer format
> + * @default_cap_fmt: default capture buffer format
> + *
> + * @hw_arch: hardware arch is used to separate pure_sin_core and lat_sin_core
> + *
> + * @is_subdev_supported: whether support parent-node architecture(subdev)
> + * @uses_stateless_api: whether the decoder uses the stateless API with requests
>    */
> -enum mtk_vdec_hw_id {
> -	MTK_VDEC_CORE,
> -	MTK_VDEC_LAT0,
> -	MTK_VDEC_LAT1,
> -	MTK_VDEC_LAT_SOC,
> -	MTK_VDEC_HW_MAX,
> +struct mtk_vcodec_dec_pdata {
> +	void (*init_vdec_params)(struct mtk_vcodec_dec_ctx *ctx);
> +	int (*ctrls_setup)(struct mtk_vcodec_dec_ctx *ctx);
> +	void (*worker)(struct work_struct *work);
> +	int (*flush_decoder)(struct mtk_vcodec_dec_ctx *ctx);
> +	struct vdec_fb *(*get_cap_buffer)(struct mtk_vcodec_dec_ctx *ctx);
> +	void (*cap_to_disp)(struct mtk_vcodec_dec_ctx *ctx, int error,
> +			    struct media_request *src_buf_req);
> +
> +	struct vb2_ops *vdec_vb2_ops;
> +
> +	const struct mtk_video_fmt *vdec_formats;
> +	const int *num_formats;
> +	const struct mtk_video_fmt *default_out_fmt;
> +	const struct mtk_video_fmt *default_cap_fmt;
> +
> +	enum mtk_vdec_hw_arch hw_arch;
> +
> +	bool is_subdev_supported;
> +	bool uses_stateless_api;
>   };
>   
>   /**
> @@ -95,7 +165,7 @@ enum mtk_vdec_hw_id {
>    */
>   struct mtk_vcodec_dec_ctx {
>   	enum mtk_instance_type type;
> -	struct mtk_vcodec_dev *dev;
> +	struct mtk_vcodec_dec_dev *dev;
>   	struct list_head list;
>   
>   	struct v4l2_fh fh;
> @@ -136,6 +206,84 @@ struct mtk_vcodec_dec_ctx {
>   	struct vdec_msg_queue msg_queue;
>   };
>   
> +/**
> + * struct mtk_vcodec_dec_dev - driver data
> + * @v4l2_dev: V4L2 device to register video devices for.
> + * @vfd_dec: Video device for decoder
> + * @mdev_dec: Media device for decoder
> + *
> + * @m2m_dev_dec: m2m device for decoder
> + * @plat_dev: platform device
> + * @ctx_list: list of struct mtk_vcodec_ctx
> + * @curr_ctx: The context that is waiting for codec hardware
> + *
> + * @reg_base: Mapped address of MTK Vcodec registers.
> + * @vdec_pdata: decoder IC-specific data
> + *
> + * @fw_handler: used to communicate with the firmware.
> + * @id_counter: used to identify current opened instance
> + *
> + * @dec_mutex: decoder hardware lock
> + * @dev_mutex: video_device lock
> + * @decode_workqueue: decode work queue
> + *
> + * @irqlock: protect data access by irq handler and work thread
> + * @dec_irq: decoder irq resource
> + *
> + * @pm: power management control
> + * @dec_capability: used to identify decode capability, ex: 4k
> + *
> + * @core_workqueue: queue used for core hardware decode
> + *
> + * @subdev_dev: subdev hardware device
> + * @subdev_prob_done: check whether all used hw device is prob done
> + * @subdev_bitmap: used to record hardware is ready or not
> + *
> + * @dec_active_cnt: used to mark whether need to record register value
> + * @vdec_racing_info: record register value
> + * @dec_racing_info_mutex: mutex lock used for inner racing mode
> + * @dbgfs: debug log related information
> + */
> +struct mtk_vcodec_dec_dev {
> +	struct v4l2_device v4l2_dev;
> +	struct video_device *vfd_dec;
> +	struct media_device mdev_dec;
> +
> +	struct v4l2_m2m_dev *m2m_dev_dec;
> +	struct platform_device *plat_dev;
> +	struct list_head ctx_list;
> +	struct mtk_vcodec_dec_ctx *curr_ctx;
> +
> +	void __iomem *reg_base[NUM_MAX_VCODEC_REG_BASE];
> +	const struct mtk_vcodec_dec_pdata *vdec_pdata;
> +
> +	struct mtk_vcodec_fw *fw_handler;
> +	unsigned long id_counter;

Does id_counter need to be 64 bits or 32 bits?

Please change that to a fixed size type, so that we also increase the
reliability of this driver :-)

> +
> +	/* decoder hardware mutex lock */
> +	struct mutex dec_mutex[MTK_VDEC_HW_MAX];
> +	struct mutex dev_mutex;
> +	struct workqueue_struct *decode_workqueue;
> +
> +	spinlock_t irqlock;
> +	int dec_irq;
> +
> +	struct mtk_vcodec_pm pm;
> +	unsigned int dec_capability;
> +
> +	struct workqueue_struct *core_workqueue;
> +
> +	void *subdev_dev[MTK_VDEC_HW_MAX];
> +	int (*subdev_prob_done)(struct mtk_vcodec_dec_dev *vdec_dev);
> +	DECLARE_BITMAP(subdev_bitmap, MTK_VDEC_HW_MAX);
> +
> +	atomic_t dec_active_cnt;
> +	u32 vdec_racing_info[132];
> +	/* Protects access to vdec_racing_info data */
> +	struct mutex dec_racing_info_mutex;
> +	struct mtk_vcodec_dbgfs dbgfs;
> +};
> +
>   static inline struct mtk_vcodec_dec_ctx *fh_to_dec_ctx(struct v4l2_fh *fh)
>   {
>   	return container_of(fh, struct mtk_vcodec_dec_ctx, fh);

..snip..

> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
> index 6aa4afe5b796..0dc1957b147e 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
> @@ -8,7 +8,39 @@
>   #define _MTK_VCODEC_ENC_DRV_H_
>   
>   #include "mtk_vcodec_com_drv.h"
> +#include "mtk_vcodec_dbgfs.h"
>   #include "mtk_vcodec_fw_priv.h"
> +#include "mtk_vcodec_util.h"
> +
> +#define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
> +
> +#define MTK_ENC_CTX_IS_EXT(ctx) ((ctx)->dev->venc_pdata->uses_ext)
> +#define MTK_ENC_IOVA_IS_34BIT(ctx) ((ctx)->dev->venc_pdata->uses_34bit)
> +
> +/**
> + * struct mtk_vcodec_enc_pdata - compatible data for each IC
> + *
> + * @uses_ext: whether the encoder uses the extended firmware messaging format
> + * @min_bitrate: minimum supported encoding bitrate
> + * @max_bitrate: maximum supported encoding bitrate
> + * @capture_formats: array of supported capture formats
> + * @num_capture_formats: number of entries in capture_formats
> + * @output_formats: array of supported output formats
> + * @num_output_formats: number of entries in output_formats
> + * @core_id: stand for h264 or vp8 encode index
> + * @uses_34bit: whether the encoder uses 34-bit iova
> + */
> +struct mtk_vcodec_enc_pdata {
> +	bool uses_ext;
> +	unsigned long min_bitrate;
> +	unsigned long max_bitrate;

Fixed size types for min/max bitrate please (u64?)

> +	const struct mtk_video_fmt *capture_formats;
> +	size_t num_capture_formats;
> +	const struct mtk_video_fmt *output_formats;
> +	size_t num_output_formats;
> +	int core_id;

Besides, I think that core_id can be u8 as we'll never see more than
255 cores :-)

> +	bool uses_34bit;
> +};
>   
>   /*
>    * enum mtk_encode_param - General encoding parameters type
> @@ -101,7 +133,7 @@ struct mtk_enc_params {
>    */
>   struct mtk_vcodec_enc_ctx {
>   	enum mtk_instance_type type;
> -	struct mtk_vcodec_dev *dev;
> +	struct mtk_vcodec_enc_dev *dev;
>   	struct list_head list;
>   
>   	struct v4l2_fh fh;
> @@ -136,6 +168,61 @@ struct mtk_vcodec_enc_ctx {
>   	struct mutex q_mutex;
>   };
>   
> +/**
> + * struct mtk_vcodec_enc_dev - driver data
> + * @v4l2_dev: V4L2 device to register video devices for.
> + * @vfd_enc: Video device for encoder.
> + *
> + * @m2m_dev_enc: m2m device for encoder.
> + * @plat_dev: platform device
> + * @ctx_list: list of struct mtk_vcodec_ctx
> + * @curr_ctx: The context that is waiting for codec hardware
> + *
> + * @reg_base: Mapped address of MTK Vcodec registers.
> + * @venc_pdata: encoder IC-specific data
> + *
> + * @fw_handler: used to communicate with the firmware.
> + * @id_counter: used to identify current opened instance
> + *
> + * @enc_mutex: encoder hardware lock.
> + * @dev_mutex: video_device lock
> + * @encode_workqueue: encode work queue
> + *
> + * @enc_irq: h264 encoder irq resource
> + * @irqlock: protect data access by irq handler and work thread
> + *
> + * @pm: power management control
> + * @enc_capability: used to identify encode capability
> + * @dbgfs: debug log related information
> + */
> +struct mtk_vcodec_enc_dev {
> +	struct v4l2_device v4l2_dev;
> +	struct video_device *vfd_enc;
> +
> +	struct v4l2_m2m_dev *m2m_dev_enc;
> +	struct platform_device *plat_dev;
> +	struct list_head ctx_list;
> +	struct mtk_vcodec_enc_ctx *curr_ctx;
> +
> +	void __iomem *reg_base[NUM_MAX_VCODEC_REG_BASE];
> +	const struct mtk_vcodec_enc_pdata *venc_pdata;
> +
> +	struct mtk_vcodec_fw *fw_handler;
> +	unsigned long id_counter;

u64 id_counter ?

> +
> +	/* encoder hardware mutex lock */
> +	struct mutex enc_mutex;
> +	struct mutex dev_mutex;
> +	struct workqueue_struct *encode_workqueue;
> +
> +	int enc_irq;
> +	spinlock_t irqlock;
> +
> +	struct mtk_vcodec_pm pm;
> +	unsigned int enc_capability;
> +	struct mtk_vcodec_dbgfs dbgfs;
> +};
> +
>   static inline struct mtk_vcodec_enc_ctx *fh_to_enc_ctx(struct v4l2_fh *fh)
>   {
>   	return container_of(fh, struct mtk_vcodec_enc_ctx, fh);

..snip..

> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
> index 9a2472442c6f..eda63f4262a9 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
> @@ -1,8 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> +#include "mtk_vcodec_dec_drv.h"
> +#include "mtk_vcodec_enc_drv.h"
>   #include "mtk_vcodec_fw_priv.h"
> -#include "mtk_vcodec_util.h"
> -#include "mtk_vcodec_drv.h"
>   
>   static int mtk_vcodec_scp_load_firmware(struct mtk_vcodec_fw *fw)
>   {
> @@ -56,11 +56,14 @@ static const struct mtk_vcodec_fw_ops mtk_vcodec_rproc_msg = {
>   struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use fw_use)
>   {
>   	struct mtk_vcodec_fw *fw;
> -	struct mtk_vcodec_dev *dev = priv;
>   	struct platform_device *plat_dev;
>   	struct mtk_scp *scp;
>   
> -	plat_dev = dev->plat_dev;
> +	if (fw_use == DECODER)
> +		plat_dev = ((struct mtk_vcodec_dec_dev *)priv)->plat_dev;

Hmm.. I don't really like this one's readability.
Perhaps we can do...

	if (fw_use == DECODER) {
		struct mtk_vcodec_dec_dev *dev = priv;
		plat_dev = priv->plat_dev;
		break;
	} else if (fw_use == ENCODER) {
		struct mtk_vcodec_enc_dev *dev = priv;
		plat_dev = priv->plat_dev;
		break;
	} else {
		pr_err("Invalid fw_use %d (use a better message here)", fw_use);
		return PTR_ERR(-EINVAL);
	}


> +	else
> +		plat_dev = ((struct mtk_vcodec_enc_dev *)priv)->plat_dev;
> +
>   	scp = scp_get(plat_dev);
>   	if (!scp) {
>   		mtk_v4l2_err("could not get vdec scp handle");
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> index 65562a36788f..52720a93b56a 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
> @@ -1,8 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> +#include "mtk_vcodec_dec_drv.h"
> +#include "mtk_vcodec_enc_drv.h"
>   #include "mtk_vcodec_fw_priv.h"
> -#include "mtk_vcodec_util.h"
> -#include "mtk_vcodec_drv.h"
>   
>   static int mtk_vcodec_vpu_load_firmware(struct mtk_vcodec_fw *fw)
>   {
> @@ -53,7 +53,7 @@ static void mtk_vcodec_vpu_release(struct mtk_vcodec_fw *fw)
>   
>   static void mtk_vcodec_vpu_reset_dec_handler(void *priv)
>   {
> -	struct mtk_vcodec_dev *dev = priv;
> +	struct mtk_vcodec_dec_dev *dev = priv;
>   	struct mtk_vcodec_dec_ctx *ctx;
>   
>   	mtk_v4l2_err("Watchdog timeout!!");
> @@ -69,7 +69,7 @@ static void mtk_vcodec_vpu_reset_dec_handler(void *priv)
>   
>   static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
>   {
> -	struct mtk_vcodec_dev *dev = priv;
> +	struct mtk_vcodec_enc_dev *dev = priv;
>   	struct mtk_vcodec_enc_ctx *ctx;
>   
>   	mtk_v4l2_err("Watchdog timeout!!");
> @@ -96,7 +96,6 @@ static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_msg = {
>   struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use fw_use)
>   {
>   	struct platform_device *fw_pdev;
> -	struct mtk_vcodec_dev *dev = priv;
>   	struct platform_device *plat_dev;
>   	struct mtk_vcodec_fw *fw;
>   	enum rst_id rst_id;
> @@ -104,14 +103,15 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use
>   	switch (fw_use) {
>   	case ENCODER:
>   		rst_id = VPU_RST_ENC;
> +		plat_dev = ((struct mtk_vcodec_enc_dev *)priv)->plat_dev;

same comment from before.. :-)

Regards,
Angelo
