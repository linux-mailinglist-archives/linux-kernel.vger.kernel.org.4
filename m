Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9854968DD4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjBGPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjBGPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:49:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1403C3E;
        Tue,  7 Feb 2023 07:49:32 -0800 (PST)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0E3DE6602086;
        Tue,  7 Feb 2023 15:49:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675784971;
        bh=cfvcfREHPh+IggvFYU/1ryO6SCNcrW7aAlVSVH/ZGNQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CeR53vBJRzwPjXGUbYyL6Oqi6B9zBJGFT2gHfCaC67eoPDJq3DTT0n1mUCNdEpRAp
         bILX7Qq0QU7ek5QOtvnMdsO7Up22uzZsWNpQByGkZwd88WEZvaWfETwUTrYFRVuPPd
         KJHBw/oS+BLqlYyYVPsZci/lbZDuaY1MN++Cb5ObSr5N5ohZ5l4I2qPMuktyG49scq
         W5YrmFVI+cppp2Xr6C6jRGNwEJUpYre4/nZZ1NertMnLJj4bIFvPoKHzzh24ljxXgb
         mNFmMitYeZTziWVGmOXa+XxSp0X4mIHM49dEsobi8ZS1EGaRTxINdtLfwIcfp8b5f1
         R5AWl8kcZopcg==
Message-ID: <dd1bad2b-a56a-c4d2-cc28-6703febdc475@collabora.com>
Date:   Tue, 7 Feb 2023 15:49:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] ALSA: cs35l41: Add shared boost feature
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230207104021.2842-1-lucas.tanure@collabora.com>
 <20230207104021.2842-2-lucas.tanure@collabora.com>
 <20230207114855.GC36097@ediswmail.ad.cirrus.com>
From:   Lucas Tanure <lucas.tanure@collabora.com>
In-Reply-To: <20230207114855.GC36097@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-2023 11:48, Charles Keepax wrote:
> On Tue, Feb 07, 2023 at 10:40:20AM +0000, Lucas Tanure wrote:
>> Shared boost allows two amplifiers to share a single boost
>> circuit by communicating on the MDSYNC bus.
>> The passive amplifier does not control the boost and receives
>> data from the active amplifier.
>>
>> Shared Boost is not supported in HDA Systems.
>>
> 
> Probably would be nice to put at least a note to say based on
> David's patches.
ack
> 
>> +static const struct reg_sequence cs35l41_shd_boost_seq[] = {
>> +	{CS35L41_PWR_CTRL3,	0x01000110},
> 
> This will blat whatever the user set in the DRE switch.
> Technically blats the CLASS H enable from the DAPM widget too,
> but as that always turns on should be a no-op. Probably should
> either not register the DRE switch or have setting it return an
> error for these boost modes.
Fixed in v2.
Changed to regmap_update_bits.
> 
>> +int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable,
>> +			  struct completion *pll_lock)
>>   {
>>   	int ret;
>> +	unsigned int gpio1;
>>   
>>   	switch (b_type) {
>> +	case CS35L41_SHD_BOOST_ACTV:
>> +	case CS35L41_SHD_BOOST_PASS:
>> +		regmap_update_bits(regmap, CS35L41_PWR_CTRL3, CS35L41_SYNC_EN_MASK, 0);
>> +
>> +		gpio1 = enable ? CS35L41_GPIO1_MDSYNC : CS35L41_GPIO1_HIZ;
>> +		regmap_update_bits(regmap, CS35L41_GPIO_PAD_CONTROL, CS35L41_GPIO1_CTRL_MASK,
>> +				   gpio1 << CS35L41_GPIO1_CTRL_SHIFT);
>> +
>> +		ret = regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
>> +					 enable << CS35L41_GLOBAL_EN_SHIFT);
>> +		usleep_range(3000, 3100);
>> +		if (!enable)
>> +			break;
>> +
>> +		if (!pll_lock)
>> +			return -EINVAL;
>> +
>> +		ret = wait_for_completion_timeout(pll_lock, msecs_to_jiffies(1000));
>> +		if (ret == 0)
>> +			ret = -ETIMEDOUT;
> 
> This feels kinda scary, in that you are relying on a 1 to 1
> correspondence between this code running and getting a PLL lock
> signal. The datasheet is helpfully completely vague on when PLL
> locks are triggered.
> 
> The PLL enable seems to be set through set_sysclk, which could
> be called multiple times, per DAPM power up.  Does the PLL
> lock only go once global enable has been set? Can't help
> but wonder if a reinit_completion should probably go somewhere
> to ensure we are getting this lock of the PLL not a past one.
Added a reinit_completion at cs35l41_pcm_startup

> 
>> @@ -483,6 +483,11 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
>>   		ret = IRQ_HANDLED;
>>   	}
>>   
>> +	if (status[2] & CS35L41_PLL_LOCK) {
>> +		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS3, CS35L41_PLL_LOCK);
>> +		complete(&cs35l41->pll_lock);
>> +	}
>> +
> 
> If you fall into any of the error cases in this IRQ handler above
> this, it will blat values you don't want into BST_EN although, to
> be fair that does look currently broken for external boost as
> well.
Fixed with a new patch in v2 series.

> 
> Thanks,
> Charles
> 

