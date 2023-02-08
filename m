Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3068EC69
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjBHKKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBHKKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:10:30 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FE845BF0;
        Wed,  8 Feb 2023 02:09:46 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3187LPI7011275;
        Wed, 8 Feb 2023 04:09:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=YjlP7CxcFGqTbmdNeDv7aSY9o6RNVPpadtjJ59E+x+A=;
 b=mOUuu8Hj9IAR+LNmLdlHT5O9yunCPYWayLCZPU+AXC62DZgwbcoV1Di9jMhVox70WNne
 Lz6qULdlbeGm/lB3BLmgZ4Hd7zj8UObeY4W607r8S6LJIt8uIr1GYZgc8J5zoBA9amE9
 Ll6/7tBUreBRmf6K3lUM+DYfvxL6ANUS71DuTZRCjYIdddbtBv+/uv+ud41bDJNbDsj2
 ON7XG4r12VePpkSd67KtAQgUCICGXs0B6+lhV4fIu1DG1zWbrUwlu41zdl1Ug6pzefIu
 sBSRegDd4TtJuvz/M9Mj+6dDN4qUFuRlesQE4Jod5Nqbi9P2aIobjldRAy/1WjJof4mR tg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3nhnn7wsxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 04:09:30 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 8 Feb
 2023 04:09:28 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Wed, 8 Feb 2023 04:09:28 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EB3A211C7;
        Wed,  8 Feb 2023 10:09:27 +0000 (UTC)
Date:   Wed, 8 Feb 2023 10:09:27 +0000
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
Subject: Re: [PATCH v2 3/5] ALSA: cs35l41: Add shared boost feature
Message-ID: <20230208100927.GF36097@ediswmail.ad.cirrus.com>
References: <20230207162526.1024286-1-lucas.tanure@collabora.com>
 <20230207162526.1024286-4-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230207162526.1024286-4-lucas.tanure@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: jwiGlv1wx0IC9PFOxp8CzH1odc8hpYji
X-Proofpoint-ORIG-GUID: jwiGlv1wx0IC9PFOxp8CzH1odc8hpYji
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 04:25:24PM +0000, Lucas Tanure wrote:
> Shared boost allows two amplifiers to share a single boost
> circuit by communicating on the MDSYNC bus.
> The passive amplifier does not control the boost and receives
> data from the active amplifier.
> 
> Shared Boost is not supported in HDA Systems.
> Based on David Rhodes shared boost patches.
> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---
> -int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable)
> +int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable,
> +			  struct completion *pll_lock)
>  {
>  	int ret;
> +	unsigned int gpio1;
>  
>  	switch (b_type) {
> +	case CS35L41_SHD_BOOST_ACTV:
> +	case CS35L41_SHD_BOOST_PASS:
> +		regmap_update_bits(regmap, CS35L41_PWR_CTRL3, CS35L41_SYNC_EN_MASK, 0);
> +
> +		gpio1 = enable ? CS35L41_GPIO1_MDSYNC : CS35L41_GPIO1_HIZ;
> +		regmap_update_bits(regmap, CS35L41_GPIO_PAD_CONTROL, CS35L41_GPIO1_CTRL_MASK,
> +				   gpio1 << CS35L41_GPIO1_CTRL_SHIFT);
> +
> +		ret = regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
> +					 enable << CS35L41_GLOBAL_EN_SHIFT);
> +		usleep_range(3000, 3100);
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
> +			regmap_update_bits(regmap, CS35L41_PWR_CTRL3, CS35L41_SYNC_EN_MASK, 0);
> +			regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
> +								 0 << CS35L41_GLOBAL_EN_SHIFT);
> +			usleep_range(3000, 3100);
> +			regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
> +								 1 << CS35L41_GLOBAL_EN_SHIFT);
> +			usleep_range(3000, 3100);
> +		}

This approach also makes me nervous, I was somewhat imagining the
usage of regmap_multi_reg_write for this sequence was because it
was very important that no other register writes could interleave
in between these writes. But I don't know, so it could also have
just been a random design choice. So we probably need David to
confirm if that was the reason for the original code here.

Thanks,
Charles
