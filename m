Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD366DFAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDLQMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjDLQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:12:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703F283E3;
        Wed, 12 Apr 2023 09:12:19 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:c2e:89bd:4b8e:9e98] (unknown [IPv6:2a01:e0a:120:3210:c2e:89bd:4b8e:9e98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6762D66031CF;
        Wed, 12 Apr 2023 17:12:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681315937;
        bh=sljFgeJSEl1a5wZlSuoj6eGYS3/XpL+Et55uwIHQTzs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HBzMikhOJS6LR1FuBZEitjqCWsIIyU6lE2tZ6kEULw5NsMAa1UvVEKoCh/nW1Kkqz
         ASX2Ynd6mienD4GXBH22H/rMBCCbdJq1PZPobJhsD+7DQdFUfYba+YRJZo9PkTX5sl
         MnYxAKnYIRycpkhGag/ARC0/FMpe0GJ9rhS0zYreIiL7bmyoVo9ARQKs9zhavBtAFA
         v4G7ugyQOij25vg5NG+0roCDFhnhKqcX6Bnaw1JSZchzABZqYji/7EOr6u0fhlYp7P
         4JkhX6N7j8/GC60n/AtkggrQurFQWocyKansJchWboeTDXBG0vlhoIyy3ARXeon6L+
         Uj4+4KKzhlDOg==
Message-ID: <acb095f7-5d77-d053-95f2-9800c61add34@collabora.com>
Date:   Wed, 12 Apr 2023 18:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 12/13] media: verisilicon: Enable AV1 decoder on rk3588
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230412115652.403949-1-benjamin.gaignard@collabora.com>
 <20230412115652.403949-13-benjamin.gaignard@collabora.com>
 <2f946887-6d4b-782b-d186-13b184207be3@xs4all.nl>
 <0dbdaef5940481b52ec33dacb6a1fe9ad4d0271c.camel@collabora.com>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <0dbdaef5940481b52ec33dacb6a1fe9ad4d0271c.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 12/04/2023 à 17:50, Nicolas Dufresne a écrit :
> Le mercredi 12 avril 2023 à 14:43 +0200, Hans Verkuil a écrit :
>> Hi Benjamin,
>>
>> On 12/04/2023 13:56, Benjamin Gaignard wrote:
>>> Add rk3588 AV1 decoder to Hantro variant.
>>> The hardware support image from 64x64 up to 7680x4320
>>> by steps of 16 pixels.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> Nicolas reviewed this patch in v5. Is there a reason that tag was dropped,
>> or did you just forget? If it is the latter, then I can add it back.
>>
>>
> I see that NV12_10LE40_4L4 is now NV15_4L4 as agreed, and don't see any other
> changes.

I have forgot the previous tag from Nicolas, sorry.
The only change in NV12_10LE40_4L4 -> NV15_4L4.

Regards,
Benjamin

>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>
>> Just checking.
>>
>> This series now passes my tests.
>>
>> Regards,
>>
>> 	Hans
>>
>>> ---
>>>   .../media/platform/verisilicon/hantro_drv.c   |   1 +
>>>   .../media/platform/verisilicon/hantro_hw.h    |   6 +
>>>   .../platform/verisilicon/rockchip_vpu_hw.c    | 134 ++++++++++++++++++
>>>   3 files changed, 141 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>>> index 71bd68e63859..aef1de20fc5e 100644
>>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>>> @@ -713,6 +713,7 @@ static const struct of_device_id of_hantro_match[] = {
>>>   	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
>>>   	{ .compatible = "rockchip,rk3568-vepu", .data = &rk3568_vepu_variant, },
>>>   	{ .compatible = "rockchip,rk3568-vpu", .data = &rk3568_vpu_variant, },
>>> +	{ .compatible = "rockchip,rk3588-av1-vpu", .data = &rk3588_vpu981_variant, },
>>>   #endif
>>>   #ifdef CONFIG_VIDEO_HANTRO_IMX8M
>>>   	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
>>> index e3d303cea7f6..7f33f7b07ce4 100644
>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
>>> @@ -403,11 +403,13 @@ extern const struct hantro_variant rk3328_vpu_variant;
>>>   extern const struct hantro_variant rk3399_vpu_variant;
>>>   extern const struct hantro_variant rk3568_vepu_variant;
>>>   extern const struct hantro_variant rk3568_vpu_variant;
>>> +extern const struct hantro_variant rk3588_vpu981_variant;
>>>   extern const struct hantro_variant sama5d4_vdec_variant;
>>>   extern const struct hantro_variant sunxi_vpu_variant;
>>>   
>>>   extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
>>>   extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
>>> +extern const struct hantro_postproc_ops rockchip_vpu981_postproc_ops;
>>>   
>>>   extern const u32 hantro_vp8_dec_mc_filter[8][6];
>>>   
>>> @@ -444,6 +446,10 @@ void hantro_hevc_ref_init(struct hantro_ctx *ctx);
>>>   dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
>>>   int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
>>>   
>>> +int rockchip_vpu981_av1_dec_init(struct hantro_ctx *ctx);
>>> +void rockchip_vpu981_av1_dec_exit(struct hantro_ctx *ctx);
>>> +int rockchip_vpu981_av1_dec_run(struct hantro_ctx *ctx);
>>> +void rockchip_vpu981_av1_dec_done(struct hantro_ctx *ctx);
>>>   
>>>   static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension)
>>>   {
>>> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
>>> index 8de6fd2e8eef..816ffa905a4b 100644
>>> --- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
>>> +++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
>>> @@ -13,9 +13,13 @@
>>>   #include "hantro_g1_regs.h"
>>>   #include "hantro_h1_regs.h"
>>>   #include "rockchip_vpu2_regs.h"
>>> +#include "rockchip_vpu981_regs.h"
>>>   
>>>   #define RK3066_ACLK_MAX_FREQ (300 * 1000 * 1000)
>>>   #define RK3288_ACLK_MAX_FREQ (400 * 1000 * 1000)
>>> +#define RK3588_ACLK_MAX_FREQ (300 * 1000 * 1000)
>>> +
>>> +#define ROCKCHIP_VPU981_MIN_SIZE 64
>>>   
>>>   /*
>>>    * Supported formats.
>>> @@ -74,6 +78,37 @@ static const struct hantro_fmt rockchip_vpu1_postproc_fmts[] = {
>>>   	},
>>>   };
>>>   
>>> +static const struct hantro_fmt rockchip_vpu981_postproc_fmts[] = {
>>> +	{
>>> +		.fourcc = V4L2_PIX_FMT_NV12,
>>> +		.codec_mode = HANTRO_MODE_NONE,
>>> +		.match_depth = true,
>>> +		.postprocessed = true,
>>> +		.frmsize = {
>>> +			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
>>> +			.max_width = FMT_UHD_WIDTH,
>>> +			.step_width = MB_DIM,
>>> +			.min_height = ROCKCHIP_VPU981_MIN_SIZE,
>>> +			.max_height = FMT_UHD_HEIGHT,
>>> +			.step_height = MB_DIM,
>>> +		},
>>> +	},
>>> +	{
>>> +		.fourcc = V4L2_PIX_FMT_P010,
>>> +		.codec_mode = HANTRO_MODE_NONE,
>>> +		.match_depth = true,
>>> +		.postprocessed = true,
>>> +		.frmsize = {
>>> +			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
>>> +			.max_width = FMT_UHD_WIDTH,
>>> +			.step_width = MB_DIM,
>>> +			.min_height = ROCKCHIP_VPU981_MIN_SIZE,
>>> +			.max_height = FMT_UHD_HEIGHT,
>>> +			.step_height = MB_DIM,
>>> +		},
>>> +	},
>>> +};
>>> +
>>>   static const struct hantro_fmt rk3066_vpu_dec_fmts[] = {
>>>   	{
>>>   		.fourcc = V4L2_PIX_FMT_NV12,
>>> @@ -277,6 +312,48 @@ static const struct hantro_fmt rk3399_vpu_dec_fmts[] = {
>>>   	},
>>>   };
>>>   
>>> +static const struct hantro_fmt rockchip_vpu981_dec_fmts[] = {
>>> +	{
>>> +		.fourcc = V4L2_PIX_FMT_NV12_4L4,
>>> +		.codec_mode = HANTRO_MODE_NONE,
>>> +		.match_depth = true,
>>> +		.frmsize = {
>>> +			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
>>> +			.max_width = FMT_UHD_WIDTH,
>>> +			.step_width = MB_DIM,
>>> +			.min_height = ROCKCHIP_VPU981_MIN_SIZE,
>>> +			.max_height = FMT_UHD_HEIGHT,
>>> +			.step_height = MB_DIM,
>>> +		},
>>> +	},
>>> +	{
>>> +		.fourcc = V4L2_PIX_FMT_NV15_4L4,
>>> +		.codec_mode = HANTRO_MODE_NONE,
>>> +		.match_depth = true,
>>> +		.frmsize = {
>>> +			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
>>> +			.max_width = FMT_UHD_WIDTH,
>>> +			.step_width = MB_DIM,
>>> +			.min_height = ROCKCHIP_VPU981_MIN_SIZE,
>>> +			.max_height = FMT_UHD_HEIGHT,
>>> +			.step_height = MB_DIM,
>>> +		},
>>> +	},
>>> +	{
>>> +		.fourcc = V4L2_PIX_FMT_AV1_FRAME,
>>> +		.codec_mode = HANTRO_MODE_AV1_DEC,
>>> +		.max_depth = 2,
>>> +		.frmsize = {
>>> +			.min_width = ROCKCHIP_VPU981_MIN_SIZE,
>>> +			.max_width = FMT_UHD_WIDTH,
>>> +			.step_width = MB_DIM,
>>> +			.min_height = ROCKCHIP_VPU981_MIN_SIZE,
>>> +			.max_height = FMT_UHD_HEIGHT,
>>> +			.step_height = MB_DIM,
>>> +		},
>>> +	},
>>> +};
>>> +
>>>   static irqreturn_t rockchip_vpu1_vepu_irq(int irq, void *dev_id)
>>>   {
>>>   	struct hantro_dev *vpu = dev_id;
>>> @@ -331,6 +408,24 @@ static irqreturn_t rockchip_vpu2_vepu_irq(int irq, void *dev_id)
>>>   	return IRQ_HANDLED;
>>>   }
>>>   
>>> +static irqreturn_t rk3588_vpu981_irq(int irq, void *dev_id)
>>> +{
>>> +	struct hantro_dev *vpu = dev_id;
>>> +	enum vb2_buffer_state state;
>>> +	u32 status;
>>> +
>>> +	status = vdpu_read(vpu, AV1_REG_INTERRUPT);
>>> +	state = (status & AV1_REG_INTERRUPT_DEC_RDY_INT) ?
>>> +		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
>>> +
>>> +	vdpu_write(vpu, 0, AV1_REG_INTERRUPT);
>>> +	vdpu_write(vpu, AV1_REG_CONFIG_DEC_CLK_GATE_E, AV1_REG_CONFIG);
>>> +
>>> +	hantro_irq_done(vpu, state);
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>>   static int rk3036_vpu_hw_init(struct hantro_dev *vpu)
>>>   {
>>>   	/* Bump ACLK to max. possible freq. to improve performance. */
>>> @@ -346,6 +441,13 @@ static int rk3066_vpu_hw_init(struct hantro_dev *vpu)
>>>   	return 0;
>>>   }
>>>   
>>> +static int rk3588_vpu981_hw_init(struct hantro_dev *vpu)
>>> +{
>>> +	/* Bump ACLKs to max. possible freq. to improve performance. */
>>> +	clk_set_rate(vpu->clocks[0].clk, RK3588_ACLK_MAX_FREQ);
>>> +	return 0;
>>> +}
>>> +
>>>   static int rockchip_vpu_hw_init(struct hantro_dev *vpu)
>>>   {
>>>   	/* Bump ACLK to max. possible freq. to improve performance. */
>>> @@ -498,6 +600,14 @@ static const struct hantro_codec_ops rk3568_vepu_codec_ops[] = {
>>>   	},
>>>   };
>>>   
>>> +static const struct hantro_codec_ops rk3588_vpu981_codec_ops[] = {
>>> +	[HANTRO_MODE_AV1_DEC] = {
>>> +		.run = rockchip_vpu981_av1_dec_run,
>>> +		.init = rockchip_vpu981_av1_dec_init,
>>> +		.exit = rockchip_vpu981_av1_dec_exit,
>>> +		.done = rockchip_vpu981_av1_dec_done,
>>> +	},
>>> +};
>>>   /*
>>>    * VPU variant.
>>>    */
>>> @@ -529,10 +639,18 @@ static const char * const rk3066_vpu_clk_names[] = {
>>>   	"aclk_vepu", "hclk_vepu"
>>>   };
>>>   
>>> +static const struct hantro_irq rk3588_vpu981_irqs[] = {
>>> +	{ "vdpu", rk3588_vpu981_irq },
>>> +};
>>> +
>>>   static const char * const rockchip_vpu_clk_names[] = {
>>>   	"aclk", "hclk"
>>>   };
>>>   
>>> +static const char * const rk3588_vpu981_vpu_clk_names[] = {
>>> +	"aclk", "hclk", "aclk_vdpu_root", "hclk_vdpu_root"
>>> +};
>>> +
>>>   /* VDPU1/VEPU1 */
>>>   
>>>   const struct hantro_variant rk3036_vpu_variant = {
>>> @@ -678,3 +796,19 @@ const struct hantro_variant px30_vpu_variant = {
>>>   	.clk_names = rockchip_vpu_clk_names,
>>>   	.num_clocks = ARRAY_SIZE(rockchip_vpu_clk_names)
>>>   };
>>> +
>>> +const struct hantro_variant rk3588_vpu981_variant = {
>>> +	.dec_offset = 0x0,
>>> +	.dec_fmts = rockchip_vpu981_dec_fmts,
>>> +	.num_dec_fmts = ARRAY_SIZE(rockchip_vpu981_dec_fmts),
>>> +	.postproc_fmts = rockchip_vpu981_postproc_fmts,
>>> +	.num_postproc_fmts = ARRAY_SIZE(rockchip_vpu981_postproc_fmts),
>>> +	.postproc_ops = &rockchip_vpu981_postproc_ops,
>>> +	.codec = HANTRO_AV1_DECODER,
>>> +	.codec_ops = rk3588_vpu981_codec_ops,
>>> +	.irqs = rk3588_vpu981_irqs,
>>> +	.num_irqs = ARRAY_SIZE(rk3588_vpu981_irqs),
>>> +	.init = rk3588_vpu981_hw_init,
>>> +	.clk_names = rk3588_vpu981_vpu_clk_names,
>>> +	.num_clocks = ARRAY_SIZE(rk3588_vpu981_vpu_clk_names)
>>> +};
>>
