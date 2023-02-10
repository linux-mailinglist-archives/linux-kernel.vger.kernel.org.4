Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A56C691FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjBJNoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjBJNoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:44:15 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D1D73953;
        Fri, 10 Feb 2023 05:44:12 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A7aoKl020067;
        Fri, 10 Feb 2023 07:43:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=/2qgvSwdT4zkmxpfqAeRfM31AgVNMAuCCdf8kIRZeuk=;
 b=B6+AaBkbxVZWIXCRsCt8nJBfnWrRNOwBhLEj0g7Vh7OBaW/XtlB4JLoAVAMcH5nD9l4f
 wcvp06XpwSNIq7CP71G/OZk5sKC0NypGWFvgd54XE95G8BgEEHZzDnKKEpxwQUFdtSnJ
 OK2LB4I/Zr/ReiUnIdiWeF1IpsKs5AEgB3xhJNHrVcJkaz/squ/Ad6cYS1D/nnBKtcx2
 G0SEe6Wnl/vt+j6H4nZVx36rXL/N0pT+zTv+vKqZfdhh+eSCD/0dSktAXuuCFYdh4q+F
 h7ujh88CMu9Kp2BWHILeU/tZehVoYyQMJ7blvq5a9SDVPvvRtlXrA8LRQIgmS+BQ2zZ/ iA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nhmnv1esf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 07:43:43 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 10 Feb
 2023 07:43:41 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Fri, 10 Feb 2023 07:43:41 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 72BD145;
        Fri, 10 Feb 2023 13:43:41 +0000 (UTC)
Date:   Fri, 10 Feb 2023 13:43:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <lucas.tanure@collabora.com>
CC:     David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH v5 3/4] ALSA: cs35l41: Add shared boost feature
Message-ID: <20230210134341.GF68926@ediswmail.ad.cirrus.com>
References: <20230210091942.10866-1-lucas.tanure@collabora.com>
 <20230210091942.10866-4-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230210091942.10866-4-lucas.tanure@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: TYkW6cCZkE6aXkFUZTp5B498hGU-k32i
X-Proofpoint-ORIG-GUID: TYkW6cCZkE6aXkFUZTp5B498hGU-k32i
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 09:19:41AM +0000, Lucas Tanure wrote:
> Shared boost allows two amplifiers to share a single boost circuit by
> communicating on the MDSYNC bus.
> The passive amplifier does not control the boost and receives data from
> the active amplifier.
> 
> Shared Boost is not supported in HDA Systems.
> Based on David Rhodes shared boost patches.
> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---

Ok I found a copy of David's internal patch which helps a litte.

> --- a/sound/soc/codecs/cs35l41-lib.c
> +++ b/sound/soc/codecs/cs35l41-lib.c
> @@ -1114,12 +1114,31 @@ static const struct reg_sequence cs35l41_reset_to_safe[] = {
>  	{ 0x00000040,			0x00000033 },
>  };
>  
> +static const struct reg_sequence cs35l41_actv_seq[] = {
> +	/* SYNC_BST_CTL_RX_EN = 0; SYNC_BST_CTL_TX_EN = 1 */
> +	{CS35L41_MDSYNC_EN,        0x00001000},

David's internal patch appears to set 0x3000 on the active side,
not sure where that difference snuck in, or which is the correct
value. Your settings appear to make logical sense to me though, TX
on the active side, RX on the passive side.

> +	/* BST_CTL_SEL = CLASSH */
> +	{CS35L41_BSTCVRT_VCTRL2,    0x00000001},

BST_CTL_SEL is in BSTCVRT_VCTRL1 (or BOOST_VOLTAGE_CFG, as it
is called in the datasheet, yay us for using the same names).
That does not mean this write is wrong, could just be the
comment, but what this does write is a bit odd so I would like
David to confirm this isn't some typo in his original patch.

> +};
> +
> +static const struct reg_sequence cs35l41_pass_seq[] = {
> +	/* SYNC_BST_CTL_RX_EN = 1; SYNC_BST_CTL_TX_EN = 0 */
> +	{CS35L41_MDSYNC_EN,        0x00002000},
> +	/* BST_EN = 0 */
> +	{CS35L41_PWR_CTRL2,        0x00003300},
> +	/* BST_CTL_SEL = MDSYNC */
> +	{CS35L41_BSTCVRT_VCTRL2,    0x00000002},

Ditto here, comment doesn't match the write.

> -int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable)
> +int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable,
> +			  struct completion *pll_lock)
>  {
>  	int ret;
> +	unsigned int gpio1_func, pad_control, pwr_ctrl1, pwr_ctrl3;
> +	struct reg_sequence cs35l41_mdsync_down_seq[] = {
> +		{CS35L41_PWR_CTRL3,		0},
> +		{CS35L41_GPIO_PAD_CONTROL,	0},
> +		{CS35L41_PWR_CTRL1,		0, 3000},
> +	};
> +	struct reg_sequence cs35l41_mdsync_up_seq[] = {
> +		{CS35L41_PWR_CTRL3,	0},
> +		{CS35L41_PWR_CTRL1,	0x00000000, 3000},
> +		{CS35L41_PWR_CTRL1,	0x00000001, 3000},
> +	};
>  
>  	switch (b_type) {
> +	case CS35L41_SHD_BOOST_ACTV:
> +	case CS35L41_SHD_BOOST_PASS:
> +		regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
> +		regmap_read(regmap, CS35L41_GPIO_PAD_CONTROL, &pad_control);
> +
> +		pwr_ctrl3 &= ~CS35L41_SYNC_EN_MASK;
> +		pwr_ctrl1 = enable << CS35L41_GLOBAL_EN_SHIFT;

Are you sure this is what you want? In the case of powering up,
the sequence would end up being:

mdsync_down
 -> sets GLOBAL_EN on
mdsync_up
 -> sets GLOBAL_EN off
 -> sets GLOBAL_EN on

Feels like mdsync_down should always turn global_enable off? But
again I don't know for sure. But then I guess why is there the
extra write to turn it off in mdsync_up? I can't see any sign of
GLOBAL_EN bouncing in David's internal patch.

> +
> +		gpio1_func = enable ? CS35L41_GPIO1_MDSYNC : CS35L41_GPIO1_HIZ;
> +		gpio1_func <<= CS35L41_GPIO1_CTRL_SHIFT;

Hm... this is a good point, probably would be nice to return an
error if the user sets a shared boost mode and a specific function
for the GPIO1 pin.

> +		pad_control &= ~CS35L41_GPIO1_CTRL_MASK;
> +		pad_control |= gpio1_func & CS35L41_GPIO1_CTRL_MASK;
> +
> +		cs35l41_mdsync_down_seq[0].def = pwr_ctrl3;
> +		cs35l41_mdsync_down_seq[1].def = pad_control;
> +		cs35l41_mdsync_down_seq[2].def = pwr_ctrl1;
> +		ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_down_seq,
> +					     ARRAY_SIZE(cs35l41_mdsync_down_seq));
> +		if (!enable)
> +			break;
> +
> +		if (!pll_lock)
> +			return -EINVAL;
> +
> +		ret = wait_for_completion_timeout(pll_lock, msecs_to_jiffies(1000));
> +		if (ret == 0) {
> +			ret = -ETIMEDOUT;
> +		} else {
> +			regmap_read(regmap, CS35L41_PWR_CTRL3, &pwr_ctrl3);
> +			pwr_ctrl3 |= CS35L41_SYNC_EN_MASK;
> +			cs35l41_mdsync_up_seq[0].def = pwr_ctrl3;
> +			ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_up_seq,
> +						     ARRAY_SIZE(cs35l41_mdsync_up_seq));
> +		}
> +		break;

Thanks,
Charles
