Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33CD68D5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjBGLtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBGLtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:49:22 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F722019;
        Tue,  7 Feb 2023 03:49:21 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3173S6Nm007675;
        Tue, 7 Feb 2023 05:48:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=CEQoKeIqdAwiQ6wPnUjUCRHwSd68NoFwTD35rQ5ARaQ=;
 b=PjvypHyI81Cn6voAhebOX1tVAM3KH1vk52YT8li7P94QFH8zuPUKM4d8ElI5OVMBlXQs
 wYsIymPlbgRaD+fJYnztCTlQN9VX98/GDhTkkDwm6zvEYhA6UGE/zwle86EI/8iFm42n
 5FkCV3q4EvTC5hQXFiunsdfVBc0nPhlIhhgCQWVPfrC3qVvXuDL7n0jB8aOkUJiNoqI7
 +njN4dowHGhhxAIlXAFotBLJYN7ZEaOC0O6g0rCjnh7YUKp4lNf5GLTsKOvRVlbz6cCu
 IcBNrEn1uSlBzIq29IWeGb1ps9EM4W4Al8q8O5+9pSbpqk+BOc/4hv/gyEIt25uGgLH2 Ug== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3nhnn7v1jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 05:48:57 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 7 Feb
 2023 05:48:55 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Tue, 7 Feb 2023 05:48:55 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0414015A0;
        Tue,  7 Feb 2023 11:48:55 +0000 (UTC)
Date:   Tue, 7 Feb 2023 11:48:55 +0000
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
Subject: Re: [PATCH 1/2] ALSA: cs35l41: Add shared boost feature
Message-ID: <20230207114855.GC36097@ediswmail.ad.cirrus.com>
References: <20230207104021.2842-1-lucas.tanure@collabora.com>
 <20230207104021.2842-2-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230207104021.2842-2-lucas.tanure@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: LT0ClOeyo46aHiFsO2O_O1aKjOTwlnE9
X-Proofpoint-ORIG-GUID: LT0ClOeyo46aHiFsO2O_O1aKjOTwlnE9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 10:40:20AM +0000, Lucas Tanure wrote:
> Shared boost allows two amplifiers to share a single boost
> circuit by communicating on the MDSYNC bus.
> The passive amplifier does not control the boost and receives
> data from the active amplifier.
> 
> Shared Boost is not supported in HDA Systems.
> 

Probably would be nice to put at least a note to say based on
David's patches.

> +static const struct reg_sequence cs35l41_shd_boost_seq[] = {
> +	{CS35L41_PWR_CTRL3,	0x01000110},

This will blat whatever the user set in the DRE switch.
Technically blats the CLASS H enable from the DAPM widget too,
but as that always turns on should be a no-op. Probably should
either not register the DRE switch or have setting it return an
error for these boost modes.

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
> +		if (ret == 0)
> +			ret = -ETIMEDOUT;

This feels kinda scary, in that you are relying on a 1 to 1
correspondence between this code running and getting a PLL lock
signal. The datasheet is helpfully completely vague on when PLL
locks are triggered.

The PLL enable seems to be set through set_sysclk, which could
be called multiple times, per DAPM power up.  Does the PLL
lock only go once global enable has been set? Can't help
but wonder if a reinit_completion should probably go somewhere
to ensure we are getting this lock of the PLL not a past one.

> @@ -483,6 +483,11 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
>  		ret = IRQ_HANDLED;
>  	}
>  
> +	if (status[2] & CS35L41_PLL_LOCK) {
> +		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS3, CS35L41_PLL_LOCK);
> +		complete(&cs35l41->pll_lock);
> +	}
> +

If you fall into any of the error cases in this IRQ handler above
this, it will blat values you don't want into BST_EN although, to
be fair that does look currently broken for external boost as
well.

Thanks,
Charles
