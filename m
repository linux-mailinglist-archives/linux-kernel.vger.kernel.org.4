Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91567B29F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjAYMdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYMdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:33:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F3C37F25;
        Wed, 25 Jan 2023 04:33:36 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:ad6f:c6af:709d:745c] (unknown [IPv6:2a01:e0a:120:3210:ad6f:c6af:709d:745c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 074506602E4D;
        Wed, 25 Jan 2023 12:33:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674650015;
        bh=wbGoK1o2eU5FvrL+eiWslaavv5CmrlF7NOK/RPHLfuI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hjh1O7Xt9onkcuXKjuxQPjZX5J3YuwzWmAY8xySkdJLem38dk5niaKyo0gMqufUV1
         dIVmsnX6gtDxkhXRYQmLY3QvavL+jZEUjXjjyg160jnR7G7hMuw/L8E29OW9TInfys
         YAvAxRXgKPHQK7A9IdMRAEZaSdJVbynMG4wfGmWZ/F1In8/p7j1tVEW/DlI9GA6MI0
         D4+M20ZKx/jnuqr5fbqx7L79Fv9SJh4zkjfjxX1ZAniv9eOyz02dbqiVfpgWfb+/bb
         Uhl5YZzSmvssOYdI0CQfuoTEH9sgGETDlcoX96PHdaRXO0UbejYOSyTXFllfDDHOGl
         aXQ0JVeaN1X8Q==
Message-ID: <233727f0-6298-6eb8-7bd2-2f269dcfd031@collabora.com>
Date:   Wed, 25 Jan 2023 13:33:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 09/13] media: verisilicon: Add AV1 entropy helpers
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230111165931.753763-1-benjamin.gaignard@collabora.com>
 <20230111165931.753763-10-benjamin.gaignard@collabora.com>
 <48ac2eb8-42e8-4faf-edd6-8b4dd590ded4@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <48ac2eb8-42e8-4faf-edd6-8b4dd590ded4@xs4all.nl>
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


Le 25/01/2023 à 13:18, Hans Verkuil a écrit :
> Some review comments:
>
> On 1/11/23 17:59, Benjamin Gaignard wrote:
>> AV1 hardware decoder needs entropy parameters to decode frames.
>> They are computed from various arrays defined in AV1 section
>> "9.4. Default CDF tables".
>>
>> Add helpers functions to init, store and get these parameters.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/platform/verisilicon/Makefile   |    1 +
>>   drivers/media/platform/verisilicon/hantro.h   |    2 +
>>   .../media/platform/verisilicon/hantro_hw.h    |   20 +
>>   .../verisilicon/rockchip_av1_entropymode.c    | 4546 +++++++++++++++++
>>   .../verisilicon/rockchip_av1_entropymode.h    |  272 +
>>   5 files changed, 4841 insertions(+)
>>   create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.c
>>   create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.h
>>
>> diff --git a/drivers/media/platform/verisilicon/Makefile b/drivers/media/platform/verisilicon/Makefile
>> index ebd5ede7bef7..d2b2679c00eb 100644
>> --- a/drivers/media/platform/verisilicon/Makefile
>> +++ b/drivers/media/platform/verisilicon/Makefile
>> @@ -18,6 +18,7 @@ hantro-vpu-y += \
>>   		rockchip_vpu2_hw_h264_dec.o \
>>   		rockchip_vpu2_hw_mpeg2_dec.o \
>>   		rockchip_vpu2_hw_vp8_dec.o \
>> +		rockchip_av1_entropymode.o \
>>   		hantro_jpeg.o \
>>   		hantro_h264.o \
>>   		hantro_hevc.o \
>> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
>> index 61480825b856..a98cb40a8d3b 100644
>> --- a/drivers/media/platform/verisilicon/hantro.h
>> +++ b/drivers/media/platform/verisilicon/hantro.h
>> @@ -240,6 +240,7 @@ struct hantro_dev {
>>    * @vp8_dec:		VP8-decoding context.
>>    * @hevc_dec:		HEVC-decoding context.
>>    * @vp9_dec:		VP9-decoding context.
>> + * @av1_dec:		AV1-decoding context.
>>    */
>>   struct hantro_ctx {
>>   	struct hantro_dev *dev;
>> @@ -268,6 +269,7 @@ struct hantro_ctx {
>>   		struct hantro_vp8_dec_hw_ctx vp8_dec;
>>   		struct hantro_hevc_dec_hw_ctx hevc_dec;
>>   		struct hantro_vp9_dec_hw_ctx vp9_dec;
>> +		struct hantro_av1_dec_hw_ctx av1_dec;
>>   	};
>>   };
>>   
>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
>> index 201f8679ca11..c7438e197d85 100644
>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
>> @@ -15,6 +15,8 @@
>>   #include <media/v4l2-vp9.h>
>>   #include <media/videobuf2-core.h>
>>   
>> +#include "rockchip_av1_entropymode.h"
>> +
>>   #define DEC_8190_ALIGN_MASK	0x07U
>>   
>>   #define MB_DIM			16
>> @@ -247,6 +249,24 @@ struct hantro_vp9_dec_hw_ctx {
>>   	s16 feature_data[8][4];
>>   };
>>   
>> +/**
>> + * hantro_av1_dec_hw_ctx
>> + * @cdfs:		current probabilities structure
>> + * @cdfs_ndvc:		current mv probabilities structure
>> + * @default_cdfs:	default probabilities structure
>> + * @default_cdfs_ndvc:	default mv probabilties structure
>> + * @cdfs_last:		stored probabilities structures
>> + * @cdfs_last_ndvc:	stored mv probabilities structures
>> + */
>> +struct hantro_av1_dec_hw_ctx {
>> +	struct av1cdfs *cdfs;
>> +	struct mvcdfs  *cdfs_ndvc;
>> +	struct av1cdfs default_cdfs;
>> +	struct mvcdfs  default_cdfs_ndvc;
>> +	struct av1cdfs cdfs_last[NUM_REF_FRAMES];
>> +	struct mvcdfs  cdfs_last_ndvc[NUM_REF_FRAMES];
>> +};
>> +
>>   /**
>>    * struct hantro_postproc_ctx
>>    *
>> diff --git a/drivers/media/platform/verisilicon/rockchip_av1_entropymode.c b/drivers/media/platform/verisilicon/rockchip_av1_entropymode.c
>> new file mode 100644
>> index 000000000000..2b5499a6d995
>> --- /dev/null
>> +++ b/drivers/media/platform/verisilicon/rockchip_av1_entropymode.c
>> @@ -0,0 +1,4546 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> Is 'GPL-2.0-only' correct?

In their proprietary MPP code rockchip claims the copyright but Nicolas notices
it originally comes from AOM.
The correct license shoud be BSD-2-Clause, I will fix that in v4.

>
>> +/*
>> + * Copyright (c) 2016, Alliance for Open Media. All rights reserved
>> + *
>> + * This source code is subject to the terms of the BSD 2 Clause License and
>> + * the Alliance for Open Media Patent License 1.0. If the BSD 2 Clause License
> There is no mention of GPL here.
>
>> + * was not distributed with this source code in the LICENSE file, you can
>> + * obtain it at www.aomedia.org/license/software. If the Alliance for Open
>> + * Media Patent License 1.0 was not distributed with this source code in the
>> + * PATENTS file, you can obtain it at www.aomedia.org/license/patent.
>> + */
>> +
>> +#include "hantro.h"
>> +#include "rockchip_av1_entropymode.h"
>> +
>> +#define AOM_ICDF ICDF
>> +#define AOM_CDF2(a0) AOM_ICDF(a0)
>> +#define AOM_CDF3(a0, a1) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1)
>> +#define AOM_CDF4(a0, a1, a2) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2)
>> +#define AOM_CDF5(a0, a1, a2, a3) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), AOM_ICDF(a3)
>> +#define AOM_CDF6(a0, a1, a2, a3, a4) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), AOM_ICDF(a3), AOM_ICDF(a4)
>> +#define AOM_CDF7(a0, a1, a2, a3, a4, a5) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), \
>> +	AOM_ICDF(a3), AOM_ICDF(a4), AOM_ICDF(a5)
>> +#define AOM_CDF8(a0, a1, a2, a3, a4, a5, a6) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), \
>> +	AOM_ICDF(a3), AOM_ICDF(a4), AOM_ICDF(a5), AOM_ICDF(a6)
>> +#define AOM_CDF9(a0, a1, a2, a3, a4, a5, a6, a7) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), AOM_ICDF(a3), \
>> +	AOM_ICDF(a4), AOM_ICDF(a5), AOM_ICDF(a6), AOM_ICDF(a7)
>> +#define AOM_CDF10(a0, a1, a2, a3, a4, a5, a6, a7, a8) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), AOM_ICDF(a3), \
>> +	AOM_ICDF(a4), AOM_ICDF(a5), AOM_ICDF(a6), AOM_ICDF(a7), AOM_ICDF(a8)
>> +#define AOM_CDF11(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), AOM_ICDF(a3), AOM_ICDF(a4), \
>> +	AOM_ICDF(a5), AOM_ICDF(a6), AOM_ICDF(a7), AOM_ICDF(a8), AOM_ICDF(a9)
>> +#define AOM_CDF12(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), AOM_ICDF(a3), AOM_ICDF(a4), AOM_ICDF(a5), \
>> +	AOM_ICDF(a6), AOM_ICDF(a7), AOM_ICDF(a8), AOM_ICDF(a9), AOM_ICDF(a10)
>> +#define AOM_CDF13(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), AOM_ICDF(a3), AOM_ICDF(a4), AOM_ICDF(a5), \
>> +	AOM_ICDF(a6), AOM_ICDF(a7), AOM_ICDF(a8), AOM_ICDF(a9), AOM_ICDF(a10), AOM_ICDF(a11)
>> +#define AOM_CDF14(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), AOM_ICDF(a3), AOM_ICDF(a4), \
>> +	AOM_ICDF(a5), AOM_ICDF(a6), AOM_ICDF(a7), AOM_ICDF(a8), AOM_ICDF(a9), \
>> +	AOM_ICDF(a10), AOM_ICDF(a11), AOM_ICDF(a12)
>> +#define AOM_CDF15(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), AOM_ICDF(a3), AOM_ICDF(a4), \
>> +	AOM_ICDF(a5), AOM_ICDF(a6), AOM_ICDF(a7), AOM_ICDF(a8), AOM_ICDF(a9), \
>> +	AOM_ICDF(a10), AOM_ICDF(a11), AOM_ICDF(a12), AOM_ICDF(a13)
>> +#define AOM_CDF16(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14) \
>> +	AOM_ICDF(a0), AOM_ICDF(a1), AOM_ICDF(a2), AOM_ICDF(a3), AOM_ICDF(a4), \
>> +	AOM_ICDF(a5), AOM_ICDF(a6), AOM_ICDF(a7), AOM_ICDF(a8), AOM_ICDF(a9), \
>> +	AOM_ICDF(a10), AOM_ICDF(a11), AOM_ICDF(a12), AOM_ICDF(a13), AOM_ICDF(a14)
>> +
>> +const uint8_t av1_partition_probs[NUM_FRAME_TYPES][NUM_PARTITION_CONTEXTS][PARTITION_TYPES] = {
> Weird, this doesn't seem to be used. I would expect this to be static as well.
>
>> +	/* 1 byte padding */
>> +	{
>> +		/* frame_type = keyframe */
>> +		/* 8x8 -> 4x4 */
>> +		{ 158, 97, 94, 0} /* a/l both not split */,
>> +		{ 93, 24, 99, 0} /* a split, l not split */,
>> +		{ 85, 119, 44, 0} /* l split, a not split */,
>> +		{ 62, 59, 67, 0} /* a/l both split */,
>> +		/* 16x16 -> 8x8 */
>> +		{ 149, 53, 53, 0} /* a/l both not split */,
>> +		{ 94, 20, 48, 0} /* a split, l not split */,
>> +		{ 83, 53, 24, 0} /* l split, a not split */,
>> +		{ 52, 18, 18, 0} /* a/l both split */,
>> +		/* 32x32 -> 16x16 */
>> +		{ 150, 40, 39, 0} /* a/l both not split */,
>> +		{ 78, 12, 26, 0} /* a split, l not split */,
>> +		{ 67, 33, 11, 0} /* l split, a not split */,
>> +		{ 24, 7, 5, 0} /* a/l both split */,
>> +		/* 64x64 -> 32x32 */
>> +		{ 174, 35, 49, 0} /* a/l both not split */,
>> +		{ 68, 11, 27, 0} /* a split, l not split */,
>> +		{ 57, 15, 9, 0} /* l split, a not split */,
>> +		{ 12, 3, 3, 0} /* a/l both split */
>> +	},
>> +	{
>> +		/* frame_type = interframe */
>> +		/* 8x8 -> 4x4 */
>> +		{ 199, 122, 141, 0} /* a/l both not split */,
>> +		{ 147, 63, 159, 0} /* a split, l not split */,
>> +		{ 148, 133, 118, 0} /* l split, a not split */,
>> +		{ 121, 104, 114, 0} /* a/l both split */,
>> +		/* 16x16 -> 8x8 */
>> +		{ 174, 73, 87, 0} /* a/l both not split */,
>> +		{ 92, 41, 83, 0} /* a split, l not split */,
>> +		{ 82, 99, 50, 0} /* l split, a not split */,
>> +		{ 53, 39, 39, 0} /* a/l both split */,
>> +		/* 32x32 -> 16x16 */
>> +		{ 177, 58, 59, 0} /* a/l both not split */,
>> +		{ 68, 26, 63, 0} /* a split, l not split */,
>> +		{ 52, 79, 25, 0} /* l split, a not split */,
>> +		{ 17, 14, 12, 0} /* a/l both split */,
>> +		/* 64x64 -> 32x32 */
>> +		{ 222, 34, 30, 0} /* a/l both not split */,
>> +		{ 72, 16, 44, 0} /* a split, l not split */,
>> +		{ 58, 32, 12, 0} /* l split, a not split */,
>> +		{ 10, 7, 6, 0} /* a/l both split */
>> +	}
>> +};
>> +
>> +/* Array indices are identical to previously-existing INTRAMODECONTEXTNODES. */
>> +const int8_t av1hwd_intra_mode_tree[] = {
> Ditto.
>
>> +	-DC_PRED,
>> +	2,			/* 0 = DC_NODE */
>> +	-TM_PRED_AV1,
>> +	4,			/* 1 = TM_NODE */
>> +	-V_PRED,
>> +	6,			/* 2 = V_NODE */
>> +	8,
>> +	12,			/* 3 = COM_NODE */
>> +	-H_PRED,
>> +	10,			/* 4 = H_NODE */
>> +	-D135_PRED,
>> +	-D117_PRED,		/* 5 = D135_NODE */
>> +	-D45_PRED,
>> +	14,			/* 6 = D45_NODE */
>> +	-D63_PRED,
>> +	16,			/* 7 = D63_NODE */
>> +	-D153_PRED,
>> +	-D27_PRED		/* 8 = D153_NODE */
>> +};
>> +
>> +const int8_t av1_sb_mv_ref_tree[6] = {
>> +	-ZEROMV, 2, -NEARESTMV,
>> +	4, -NEARMV, -NEWMV
>> +};
>> +
>> +const int8_t av1hwd_partition_tree[6] = {
>> +	-PARTITION_NONE, 2, -PARTITION_HORZ,
>> +	4, -PARTITION_VERT, -PARTITION_SPLIT
>> +};
>> +
>> +const int8_t av1_segment_tree[2 * MAX_MB_SEGMENTS - 2] = {
>> +	2, 4, 6, 8, 10, 12, 0, -1, -2, -3, -4, -5, -6, -7
>> +};
>> +
>> +const uint8_t av1_default_tx_probs_32x32p[TX_SIZE_CONTEXTS][TX_SIZE_MAX_SB - 1] = {
>> +	{ 3, 136, 37, },
>> +	{ 5, 52, 13, },
>> +};
>> +
>> +const uint8_t av1_default_tx_probs_16x16p[TX_SIZE_CONTEXTS][TX_SIZE_MAX_SB - 2] = {
>> +	{ 20, 152, },
>> +	{ 15, 101, },
>> +};
>> +
>> +const uint8_t av1_default_tx_probs_8x8p[TX_SIZE_CONTEXTS][TX_SIZE_MAX_SB - 3] = {
>> +	{ 100, },
>> +	{ 66, },
>> +};
>> +
>> +const uint8_t av1_default_mbskip_probs[MBSKIP_CONTEXTS] = { 192, 128, 64};
>> +
>> +const uint8_t av1_default_intra_ext_tx_prob[EXT_TX_SIZES][TX_TYPES][TX_TYPES - 1] = {
>> +	{ { 240, 85, 128}, { 4, 1, 248}, { 4, 1, 8}, { 4, 248, 128} },
>> +	{ { 244, 85, 128}, { 8, 2, 248}, { 8, 2, 8}, { 8, 248, 128} },
>> +	{ { 248, 85, 128}, { 16, 4, 248}, { 16, 4, 8}, { 16, 248, 128} },
>> +};
>> +
>> +const uint8_t av1_default_inter_ext_tx_prob[EXT_TX_SIZES][TX_TYPES - 1] = {
>> +	{ 160, 85, 128 },
>> +	{ 176, 85, 128 },
>> +	{ 192, 85, 128 },
>> +};
>> +
>> +const uint8_t av1_default_motion_mode_prob[MOTION_MODE_CONTEXTS][MOTION_MODE_COUNT - 1] = {
>> +	{ 151 }, { 153 }, { 144 }, { 178 },
>> +	{ 165 }, { 160 }, { 207 }, { 195 },
>> +	{ 168 }, { 244 }
>> +};
> Same for (I think) all these non-static arrays above.
>
> What's going on with that?

I thought I have remove all unused arrays but obviously I have miss some.
The original file contains all the arrays from AV1 specifications but the
hardware/driver don't need all of them.
That will be fix in v4.

Regards,
Benjamin

>
> Regards,
>
> 	Hans
