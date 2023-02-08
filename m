Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0057668EEF3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjBHM1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjBHM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:27:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3076A2B2A4;
        Wed,  8 Feb 2023 04:27:06 -0800 (PST)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F900660035A;
        Wed,  8 Feb 2023 12:27:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675859224;
        bh=iV+AM+Qjlq6gPk6voNgE7TgfODcmLF9iwWU3tk0to9M=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=bH45ycggeKNoWexvNDCxbui6Q4EaRmM0KdDBmXGYoiSZQjDxRvRSfwlVre6BLSado
         vGt8IuvLBbd8YVgKQvjv9234pZMvHSlXTUHRKhOvQPybW89bvNzxmWcVfkETYjYBAZ
         qvTIicaOUB+fTDYfM2lNtegpeQYuNj6MZvlwilHDO87K0TDvgaV+H7T+AEpBpCY3U0
         unkqctBUAX8HOoon2BU9onW+EhlRSlijM01rMrDAU5ynyuLx9BxwEwKWWRvtdOFK8L
         kMQW6Dvj3rv+ZWOn6w7lXiGbx8oyS9/22mnBW9ntoa3KREZg5YS3mEDil/8V6H9mbm
         wmJpzuzFN2QNQ==
Message-ID: <9d3181ff-5c08-697d-43fa-65bdc9544a26@collabora.com>
Date:   Wed, 8 Feb 2023 12:27:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   lucas.tanure@collabora.com
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/5] ALSA: cs35l41: Add shared boost feature
References: <20230207162526.1024286-1-lucas.tanure@collabora.com>
 <20230207162526.1024286-4-lucas.tanure@collabora.com>
 <20230208100927.GF36097@ediswmail.ad.cirrus.com>
In-Reply-To: <20230208100927.GF36097@ediswmail.ad.cirrus.com>
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

On 2/8/23 10:09 AM, Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> On Tue, Feb 07, 2023 at 04:25:24PM +0000, Lucas Tanure wrote:
> > Shared boost allows two amplifiers to share a single boost
> > circuit by communicating on the MDSYNC bus.
> > The passive amplifier does not control the boost and receives
> > data from the active amplifier.
> >
> > Shared Boost is not supported in HDA Systems.
> > Based on David Rhodes shared boost patches.
> >
> > Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> > ---
> > -int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable)
> > +int cs35l41_global_enable(struct regmap *regmap, enum cs35l41_boost_type b_type, int enable,
> > +			  struct completion *pll_lock)
> >   {
> >   	int ret;
> > +	unsigned int gpio1;
> >   
> >   	switch (b_type) {
> > +	case CS35L41_SHD_BOOST_ACTV:
> > +	case CS35L41_SHD_BOOST_PASS:
> > +		regmap_update_bits(regmap, CS35L41_PWR_CTRL3, CS35L41_SYNC_EN_MASK, 0);
> > +
> > +		gpio1 = enable ? CS35L41_GPIO1_MDSYNC : CS35L41_GPIO1_HIZ;
> > +		regmap_update_bits(regmap, CS35L41_GPIO_PAD_CONTROL, CS35L41_GPIO1_CTRL_MASK,
> > +				   gpio1 << CS35L41_GPIO1_CTRL_SHIFT);
> > +
> > +		ret = regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
> > +					 enable << CS35L41_GLOBAL_EN_SHIFT);
> > +		usleep_range(3000, 3100);
> > +		if (!enable)
> > +			break;
> > +
> > +		if (!pll_lock)
> > +			return -EINVAL;
> > +
> > +		ret = wait_for_completion_timeout(pll_lock, msecs_to_jiffies(1000));
> > +		if (ret == 0) {
> > +			ret = -ETIMEDOUT;
> > +		} else {
> > +			regmap_update_bits(regmap, CS35L41_PWR_CTRL3, CS35L41_SYNC_EN_MASK, 0);
Its wrong here. Should be enabling it not disable.
I will send v3. 

> > +			regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
> > +								 0 << CS35L41_GLOBAL_EN_SHIFT);
> > +			usleep_range(3000, 3100);
> > +			regmap_update_bits(regmap, CS35L41_PWR_CTRL1, CS35L41_GLOBAL_EN_MASK,
> > +								 1 << CS35L41_GLOBAL_EN_SHIFT);
> > +			usleep_range(3000, 3100);
> > +		}
> 
> This approach also makes me nervous, I was somewhat imagining the
> usage of regmap_multi_reg_write for this sequence was because it
> was very important that no other register writes could interleave
> in between these writes. But I don't know, so it could also have
> just been a random design choice. So we probably need David to
> confirm if that was the reason for the original code here.
> 
> Thanks,
> Charles
> 

