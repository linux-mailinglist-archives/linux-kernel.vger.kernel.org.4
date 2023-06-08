Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461DE727C56
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjFHKHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjFHKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:07:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170EA1FDF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:07:51 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C56256606F15;
        Thu,  8 Jun 2023 11:07:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686218869;
        bh=kTirSk7klKbmof6mTprY1BidGMbSjx0FDTUI2y5uxbI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aKlx9zY32oJUfPcHhRgNz3XOnyGvkSc3DKlfrNhMWTBeQ05YZYiMLC9QiEQ4uB0gB
         UvtiqowiYgQwEYpD7aUIOo7mUWD4BPQuphxMN+RbrVbPCkLbilixPjthLBI9+tftpA
         /1n9QbLHQ8fGsYPKY+5Lg7OJOz5rgXkXAYQmQnOl9srVNbjEUw0jwGfReDAbWQQjqT
         NIKNAB7VeMH/x2wb2PWT2Y7z0O2Y9Nu4lLt2eWUK4Tl/gOdtvbeCOmZg6KEVeIiZq9
         tiR/hDeG3uhOHfO7vZKaVP4mEORGBj4FFnq4MDq0ish1VZ0u4Xsq5FpAXlZk+lAEly
         DrfAMI1s1RLLg==
Message-ID: <169f78a9-179d-deee-df98-d22e82604432@collabora.com>
Date:   Thu, 8 Jun 2023 12:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 5/5] ASoC: mediatek: mt8188-mt6359: Use bitfield macros
 for registers
Content-Language: en-US
To:     =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
 <20230608084727.74403-6-angelogioacchino.delregno@collabora.com>
 <c05be93415b3a04db2bc0f86010e14a286ecded2.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c05be93415b3a04db2bc0f86010e14a286ecded2.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/06/23 12:03, Trevor Wu (吳文良) ha scritto:
> On Thu, 2023-06-08 at 10:47 +0200, AngeloGioacchino Del Regno wrote:
> 
>>   Replace open coded instances of FIELD_GET() with it, move register
>> definitions at the top of the file and also replace magic numbers
>> with register definitions.
>>
>> While at it, also change a regmap_update_bits() call to
>> regmap_write()
>> because the top 29 bits of AUD_TOP_CFG (31:3) are reserved (unused).
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   sound/soc/mediatek/mt8188/mt8188-mt6359.c | 32 ++++++++++++++-------
>> --
>>   1 file changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>> b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>> index 5b2660139421..ac69c23e0da1 100644
>> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>> @@ -6,6 +6,7 @@
>>    * Author: Trevor Wu <trevor.wu@mediatek.com>
>>    */
>>   
>> +#include <linux/bitfield.h>
>>   #include <linux/input.h>
>>   #include <linux/module.h>
>>   #include <linux/of_device.h>
>> @@ -19,6 +20,15 @@
>>   #include "../common/mtk-afe-platform-driver.h"
>>   #include "../common/mtk-soundcard-driver.h"
>>   
>> +#define CKSYS_AUD_TOP_CFG	0x032c
>> + #define RG_TEST_ON		BIT(0)
>> + #define RG_TEST_TYPE		BIT(2)
>> +#define CKSYS_AUD_TOP_MON	0x0330
>> + #define TEST_MISO_COUNT_1	GENMASK(3, 0)
>> + #define TEST_MISO_COUNT_2	GENMASK(7, 4)
>> + #define TEST_MISO_DONE_1	BIT(28)
>> + #define TEST_MISO_DONE_2	BIT(29)
>> +
>>   #define NAU8825_HS_PRESENT	BIT(0)
>>   
>>   /*
>> @@ -251,9 +261,6 @@ static const struct snd_kcontrol_new
>> mt8188_nau8825_controls[] = {
>>   	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
>>   };
>>   
>> -#define CKSYS_AUD_TOP_CFG 0x032c
>> -#define CKSYS_AUD_TOP_MON 0x0330
>> -
>>   static int mt8188_mt6359_mtkaif_calibration(struct
>> snd_soc_pcm_runtime *rtd)
>>   {
>>   	struct snd_soc_component *cmpnt_afe =
>> @@ -265,13 +272,13 @@ static int
>> mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
>>   	struct mtkaif_param *param;
>>   	int chosen_phase_1, chosen_phase_2;
>>   	int prev_cycle_1, prev_cycle_2;
>> -	int test_done_1, test_done_2;
>> +	u8 test_done_1, test_done_2;
>>   	int cycle_1, cycle_2;
>>   	int mtkaif_chosen_phase[MT8188_MTKAIF_MISO_NUM];
>>   	int mtkaif_phase_cycle[MT8188_MTKAIF_MISO_NUM];
>>   	int mtkaif_calibration_num_phase;
>>   	bool mtkaif_calibration_ok;
>> -	unsigned int monitor = 0;
>> +	u32 monitor = 0;
>>   	int counter;
>>   	int phase;
>>   	int i;
>> @@ -303,8 +310,7 @@ static int
>> mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
>>   	mt6359_mtkaif_calibration_enable(cmpnt_codec);
>>   
>>   	/* set test type to synchronizer pulse */
>> -	regmap_update_bits(afe_priv->topckgen,
>> -			   CKSYS_AUD_TOP_CFG, 0xffff, 0x4);
>> +	regmap_write(afe_priv->topckgen, CKSYS_AUD_TOP_CFG,
>> RG_TEST_TYPE);
> 
> Hi Angelo,
> 
> Because CKSYS_AUD_TOP_CFG is a 32bit register, it should be better to
> use regmap_set_bits instead.
> 
> regmap_set_bits(afe_priv->topckgen, CKSYS_AUD_TOP_CFG, RG_TEST_TYPE);
> 

The previous call to regmap_update_bits() was unsetting RG_TEST_ON and RE_SW_RESET
while setting RG_TEST_TYPE: using regmap_write() ensures that we do exactly the
same, without the overhead of performing the additional register read and bit
swapping operations.

Using the proposed regmap_set_bits() would change the behavior of this flow, which
may result in unexpected hardware behavior, as we wouldn't be unsetting the
previously mentioned two bits.

Regards,
Angelo

> Thanks,
> Trevor
> 
> 
>>    	mtkaif_calibration_num_phase = 42;	/* mt6359: 0 ~ 42 */
>>   	mtkaif_calibration_ok = true;
>>   
>> @@ -314,7 +320,7 @@ static int
>> mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
>>   		mt6359_set_mtkaif_calibration_phase(cmpnt_codec,
>>   						    phase, phase,
>> phase);
>>   
>> -		regmap_set_bits(afe_priv->topckgen, CKSYS_AUD_TOP_CFG,
>> 0x1);
>> +		regmap_set_bits(afe_priv->topckgen, CKSYS_AUD_TOP_CFG,
>> RG_TEST_ON);
>>   
>>   		test_done_1 = 0;
>>   		test_done_2 = 0;
>> @@ -326,14 +332,14 @@ static int
>> mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
>>   		while (!(test_done_1 & test_done_2)) {
>>   			regmap_read(afe_priv->topckgen,
>>   				    CKSYS_AUD_TOP_MON, &monitor);
>> -			test_done_1 = (monitor >> 28) & 0x1;
>> -			test_done_2 = (monitor >> 29) & 0x1;
>> +			test_done_1 = FIELD_GET(TEST_MISO_DONE_1,
>> monitor);
>> +			test_done_2 = FIELD_GET(TEST_MISO_DONE_2,
>> monitor);
>>   
>>   			if (test_done_1 == 1)
>> -				cycle_1 = monitor & 0xf;
>> +				cycle_1 = FIELD_GET(TEST_MISO_COUNT_1,
>> monitor);
>>   
>>   			if (test_done_2 == 1)
>> -				cycle_2 = (monitor >> 4) & 0xf;
>> +				cycle_2 = FIELD_GET(TEST_MISO_COUNT_2,
>> monitor);
>>   
>>   			/* handle if never test done */
>>   			if (++counter > 10000) {
>> @@ -361,7 +367,7 @@ static int
>> mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
>>   			mtkaif_phase_cycle[MT8188_MTKAIF_MISO_1] =
>> prev_cycle_2;
>>   		}
>>   
>> -		regmap_clear_bits(afe_priv->topckgen,
>> CKSYS_AUD_TOP_CFG, 0x1);
>> +		regmap_clear_bits(afe_priv->topckgen,
>> CKSYS_AUD_TOP_CFG, RG_TEST_ON);
>>   
>>   		if (mtkaif_chosen_phase[MT8188_MTKAIF_MISO_0] >= 0 &&
>>   		    mtkaif_chosen_phase[MT8188_MTKAIF_MISO_1] >= 0)
>> -- 
>> 2.40.1



