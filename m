Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B467AF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbjAYKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:16:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19541F773;
        Wed, 25 Jan 2023 02:16:40 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:ad6f:c6af:709d:745c] (unknown [IPv6:2a01:e0a:120:3210:ad6f:c6af:709d:745c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B2216602E3B;
        Wed, 25 Jan 2023 10:16:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674641798;
        bh=ZyVJD8SXegxLi3qEwUpYLu3ZwE/l6XInFEYEi6ZpEH0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QpYPEJu8bdnmcvpvf0LEFJABS7N3CKLOuaTam+BgKa4z4+lUyNnNDlMcwrVa1y5V9
         fc2uKmJUVv8Pk7r3mQZAPbK+Hz600vr82xey3ImK3CJm5xNwQdgycYOn8+ZwsdEvN/
         0FyLgWfYWg2UhZLAJa0mJLC/wxgV738dCmYdCjYOMU35yM7E8GxulhkCxE6ktAhtO7
         JE2D9fBGgwGRzvQwjTk7CynRVj5sq0F3hbCvq2A6juBZT+v85e/097ngH+u+BK1q3P
         oEOdqZD/KwrEbzgnHxW1012Uz5Gwf61Qvvcf8ecdjzgRNMLirr9Tw5AX7TqkKE0jyZ
         Mms9YoM6TpA/w==
Message-ID: <106f7d11-a9fb-8755-b2e8-4173b86f0cc4@collabora.com>
Date:   Wed, 25 Jan 2023 11:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 00/13] AV1 stateless decoder for RK3588
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
 <b4553096-330f-2e6e-239b-bee519140810@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <b4553096-330f-2e6e-239b-bee519140810@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 25/01/2023 à 10:54, Hans Verkuil a écrit :
> On 1/11/23 17:59, Benjamin Gaignard wrote:
>> This series implement AV1 stateless decoder for RK3588 SoC.
>> The hardware support 8 and 10 bits bitstreams up to 7680x4320.
>> AV1 feature like film grain or scaling are done by the postprocessor.
>> The driver can produce NV12_4L4, NV12_10LE40_4L4, NV12 and P010 pixels formats.
>> Even if Rockchip have named the hardware VPU981 it looks like a VC9000 but
>> with a different registers mapping.
>>
>> It is based on Daniel's "[PATCH v4] media: Add AV1 uAPI" [1] patches.
>>
>> The full branch can be found here:
>> https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_decoder_v3
>>
>> Fluster score is: 200/239 while testing AV1-TEST-VECTORS with GStreamer-AV1-V4L2SL-Gst1.0.
>> The failing tests are:
>> - the 2 tests with 2 spatial layers: few errors in luma/chroma values
>> - tests with resolution < hardware limit (64x64)
>> - 10bits film grain test: bad macroblocks while decoding, the same 8bits
>>    test is working fine.
>>
>> Changes in v3:
>> - Fix arrays loops limites.
>> - Remove unused field.
>> - Reset raw pixel formats list when bit depth or film grain feature
>>    values change.
>> - Enable post-processor P010 support
>>
>> Changes in v2:
>> - Remove useless +1 in sbs computation.
>> - Describe NV12_10LE40_4L4 pixels format.
>> - Post-processor could generate P010.
>> - Fix comments done on v1.
>> - The last patch make sure that only post-processed formats are used when film
>>    grain feature is enabled.
>>
>> Benjamin
>>
> I have a bunch of sparse errors:
>
> SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:342:17: error: typename in expression
> SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:342:21: error: Expected ; at end of statement
> SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:342:21: error: got bit_depth
> SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:342:17: error: undefined identifier 'int'
> SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:346:47: error: undefined identifier 'bit_depth'
> SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:353:39: error: undefined identifier 'bit_depth'
> SPARSE:drivers/media/platform/verisilicon/hantro_drv.c:354:42: error: undefined identifier 'bit_depth'
>
> Also some smatch errors:
>
> SMATCH:drivers/media/platform/verisilicon/hantro_drv.c:342:17: :error: typename in expression
> SMATCH:drivers/media/platform/verisilicon/hantro_drv.c:342:21: :error: Expected ; at end of statement
> SMATCH:drivers/media/platform/verisilicon/hantro_drv.c:342:21: :error: got bit_depth
> drivers/media/platform/verisilicon/hantro_drv.c:342 hantro_av1_s_ctrl() warn: statement has no effect 3
> drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:227:6: warning: no previous prototype for 'rockchip_vpu981_av1_dec_tiles_free' [-Wmissing-prototypes]
> drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:802:47: warning: variable 'chroma_addr' set but not used [-Wunused-but-set-variable]

I have fix that in v4.
I will send v4 once Hantro bit depth problem will be fixed for HEVC since the root cause are the same.

Thanks,
Benjamin

>
> Regards,
>
> 	Hans
>
>> [1] https://lore.kernel.org/linux-media/20230103154832.6982-1-daniel.almeida@collabora.com/T/#u
>>
>> Benjamin Gaignard (12):
>>    dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
>>    media: Add NV12_10LE40_4L4 pixel format
>>    media: verisilicon: Get bit depth for V4L2_PIX_FMT_NV12_10LE40_4L4
>>    media: verisilicon: Add AV1 decoder mode and controls
>>    media: verisilicon: Save bit depth for AV1 decoder
>>    media: verisilicon: Check AV1 bitstreams bit depth
>>    media: verisilicon: Compute motion vectors size for AV1 frames
>>    media: verisilicon: Add AV1 entropy helpers
>>    media: verisilicon: Add Rockchip AV1 decoder
>>    media: verisilicon: Add film grain feature to AV1 driver
>>    media: verisilicon: Enable AV1 decoder on rk3588
>>    media: verisilicon: Conditionnaly ignore native formats
>>
>> Nicolas Dufresne (1):
>>    v4l2-common: Add support for fractional bpp
>>
>>   .../bindings/media/rockchip-vpu.yaml          |    1 +
>>   .../media/v4l/pixfmt-yuv-planar.rst           |    4 +
>>   drivers/media/platform/verisilicon/Makefile   |    3 +
>>   drivers/media/platform/verisilicon/hantro.h   |    8 +
>>   .../media/platform/verisilicon/hantro_drv.c   |   69 +
>>   .../media/platform/verisilicon/hantro_hw.h    |  102 +
>>   .../platform/verisilicon/hantro_postproc.c    |    7 +
>>   .../media/platform/verisilicon/hantro_v4l2.c  |   22 +-
>>   .../media/platform/verisilicon/hantro_v4l2.h  |    1 +
>>   .../verisilicon/rockchip_av1_entropymode.c    | 4546 +++++++++++++++++
>>   .../verisilicon/rockchip_av1_entropymode.h    |  272 +
>>   .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
>>   .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
>>   .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2278 +++++++++
>>   .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
>>   .../platform/verisilicon/rockchip_vpu_hw.c    |  134 +
>>   drivers/media/v4l2-core/v4l2-common.c         |  149 +-
>>   drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
>>   include/media/v4l2-common.h                   |    2 +
>>   include/uapi/linux/videodev2.h                |    1 +
>>   20 files changed, 8439 insertions(+), 75 deletions(-)
>>   create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.c
>>   create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.h
>>   create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.c
>>   create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.h
>>   create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
>>   create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
>>
