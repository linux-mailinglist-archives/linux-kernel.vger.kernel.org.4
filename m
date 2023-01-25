Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0467AEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjAYJyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjAYJyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:54:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C83A88;
        Wed, 25 Jan 2023 01:54:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FB64B81903;
        Wed, 25 Jan 2023 09:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4C9C433D2;
        Wed, 25 Jan 2023 09:54:42 +0000 (UTC)
Message-ID: <b4553096-330f-2e6e-239b-bee519140810@xs4all.nl>
Date:   Wed, 25 Jan 2023 10:54:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 00/13] AV1 stateless decoder for RK3588
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 17:59, Benjamin Gaignard wrote:
> This series implement AV1 stateless decoder for RK3588 SoC.
> The hardware support 8 and 10 bits bitstreams up to 7680x4320.
> AV1 feature like film grain or scaling are done by the postprocessor.
> The driver can produce NV12_4L4, NV12_10LE40_4L4, NV12 and P010 pixels formats.
> Even if Rockchip have named the hardware VPU981 it looks like a VC9000 but 
> with a different registers mapping.
> 
> It is based on Daniel's "[PATCH v4] media: Add AV1 uAPI" [1] patches.
> 
> The full branch can be found here:
> https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_decoder_v3
> 
> Fluster score is: 200/239 while testing AV1-TEST-VECTORS with GStreamer-AV1-V4L2SL-Gst1.0.
> The failing tests are:
> - the 2 tests with 2 spatial layers: few errors in luma/chroma values
> - tests with resolution < hardware limit (64x64)
> - 10bits film grain test: bad macroblocks while decoding, the same 8bits
>   test is working fine.
> 
> Changes in v3:
> - Fix arrays loops limites.
> - Remove unused field.
> - Reset raw pixel formats list when bit depth or film grain feature
>   values change.
> - Enable post-processor P010 support
> 
> Changes in v2:
> - Remove useless +1 in sbs computation. 
> - Describe NV12_10LE40_4L4 pixels format.
> - Post-processor could generate P010.
> - Fix comments done on v1.
> - The last patch make sure that only post-processed formats are used when film
>   grain feature is enabled.
> 
> Benjamin
> 

I have a bunch of sparse errors:

SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:342:17: error: typename in expression
SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:342:21: error: Expected ; at end of statement
SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:342:21: error: got bit_depth
SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:342:17: error: undefined identifier 'int'
SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:346:47: error: undefined identifier 'bit_depth'
SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:353:39: error: undefined identifier 'bit_depth'
SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:354:42: error: undefined identifier 'bit_depth'

Also some smatch errors:

SMATCH:drivers/media/platform/verisilicon/hantro_drv.c:342:17: :error: typename in expression
SMATCH:drivers/media/platform/verisilicon/hantro_drv.c:342:21: :error: Expected ; at end of statement
SMATCH:drivers/media/platform/verisilicon/hantro_drv.c:342:21: :error: got bit_depth
drivers/media/platform/verisilicon/hantro_drv.c:342 hantro_av1_s_ctrl() warn: statement has no effect 3
drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:227:6: warning: no previous prototype for 'rockchip_vpu981_av1_dec_tiles_free' [-Wmissing-prototypes]
drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:802:47: warning: variable 'chroma_addr' set but not used [-Wunused-but-set-variable]

Regards,

	Hans

> [1] https://lore.kernel.org/linux-media/20230103154832.6982-1-daniel.almeida@collabora.com/T/#u
> 
> Benjamin Gaignard (12):
>   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
>   media: Add NV12_10LE40_4L4 pixel format
>   media: verisilicon: Get bit depth for V4L2_PIX_FMT_NV12_10LE40_4L4
>   media: verisilicon: Add AV1 decoder mode and controls
>   media: verisilicon: Save bit depth for AV1 decoder
>   media: verisilicon: Check AV1 bitstreams bit depth
>   media: verisilicon: Compute motion vectors size for AV1 frames
>   media: verisilicon: Add AV1 entropy helpers
>   media: verisilicon: Add Rockchip AV1 decoder
>   media: verisilicon: Add film grain feature to AV1 driver
>   media: verisilicon: Enable AV1 decoder on rk3588
>   media: verisilicon: Conditionnaly ignore native formats
> 
> Nicolas Dufresne (1):
>   v4l2-common: Add support for fractional bpp
> 
>  .../bindings/media/rockchip-vpu.yaml          |    1 +
>  .../media/v4l/pixfmt-yuv-planar.rst           |    4 +
>  drivers/media/platform/verisilicon/Makefile   |    3 +
>  drivers/media/platform/verisilicon/hantro.h   |    8 +
>  .../media/platform/verisilicon/hantro_drv.c   |   69 +
>  .../media/platform/verisilicon/hantro_hw.h    |  102 +
>  .../platform/verisilicon/hantro_postproc.c    |    7 +
>  .../media/platform/verisilicon/hantro_v4l2.c  |   22 +-
>  .../media/platform/verisilicon/hantro_v4l2.h  |    1 +
>  .../verisilicon/rockchip_av1_entropymode.c    | 4546 +++++++++++++++++
>  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
>  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
>  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
>  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2278 +++++++++
>  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
>  .../platform/verisilicon/rockchip_vpu_hw.c    |  134 +
>  drivers/media/v4l2-core/v4l2-common.c         |  149 +-
>  drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>  include/media/v4l2-common.h                   |    2 +
>  include/uapi/linux/videodev2.h                |    1 +
>  20 files changed, 8439 insertions(+), 75 deletions(-)
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.h
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.h
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
> 

