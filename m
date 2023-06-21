Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281D6739076
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjFUT5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFUT52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:57:28 -0400
Received: from smtpng1.i.mail.ru (smtpng1.i.mail.ru [94.100.181.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DAA1712
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=bcL/HisA15ROV00UPLpaNhcgop48RVvGoapFSQJwhJk=;
        t=1687377443;x=1687467443; 
        b=SOIE98atrz5ZNmcpvkFgcBF3TI2sNtZlqI5U7yL1hklT73cgPLjzN88TEXgV7QPFf+j4E/HtIzDtHxN8yT+n0yB6eEyxjqwxySRF1oJdRmz83SnZHqL2SSla4BCxyBNvTlPtGbPSMLCZKkVHav6h0sYBL5tEPAd/6cSjCa7DU4uYv9wF/GHTL0ijwdzVQA4Aehqx3hdeOpZNWuo3T15AEwszh/2g8fWN9JN9nHT/cu1lOEU7S8TMbphUUXofrTrNhvz8wVZkBhN1MRNBIu4iSPKTyw/HGrD8OSfoXwNfYi/Hx/OEM21xOEpJd7fBbYt+LDEvJ0vEMZ8bqb/+tIipyQ==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qC3x9-0006mt-4f; Wed, 21 Jun 2023 22:57:20 +0300
Message-ID: <08fb24b9-ab7d-da27-5ab7-e1d3270c8b43@inbox.ru>
Date:   Wed, 21 Jun 2023 22:57:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] ASoC: codecs: max98090: Allow dsp_a mode
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
References: <20230621115328.156457-1-fido_max@inbox.ru>
 <3805dc65-113f-453a-90a9-2ae6204004ba@sirena.org.uk>
 <e6be75f6-054f-6c3b-00b4-a5e112bcefc3@inbox.ru>
 <b763d08e-f751-480c-96b6-339a53856768@sirena.org.uk>
 <ed9606a4-4be6-7403-6e32-1c045ac0bdf6@inbox.ru>
 <adbe1b82-9478-4462-ace9-968723a6ce3f@sirena.org.uk>
 <0ada8334-4006-438f-8461-5c4c8e13f65d@inbox.ru>
 <c054b036-d5fd-482b-adc4-913edbcd007c@sirena.org.uk>
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <c054b036-d5fd-482b-adc4-913edbcd007c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtpng1.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDC426F77D841B18B42694044EA105F6AAD182A05F538085040E50E8AF63D50D6E9ACA42FC6FD2F12630800E321C0D64DA4D4567A9AAA701CE1
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C3AD35F3BF810D7EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370FDF1CE57EA9D07C8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86050EB323F829BD29BBBE32D365F930C6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7CCEADDFEB1F9DC069FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18CB629EEF1311BF91D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BC7A3838EBC35966AA471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CB24F08513AFFAC7943847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5270329DC7FEE85A9A9C986496F94F15D04B28CBA6BDF5D96F87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B35CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFDB6D52BA270A76D4B021ADE8E339388C2D35A89486E6E99BB9BF384ADFC36C64A8F268452FA2DF71B05B57073EAFDF9736BE06A957287FCA31AD209F9CF35CD921BEC6C0C71ED4F84C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojw7uTMtz3/lxfEX3zCzvrMQ==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986BB594CEEDE2C4989BFD1F3EA53A75570098CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.06.2023 17:35, Mark Brown wrote:
> To repeat:
> 
>>>> I'm saying there should be some interlock between these two settings, if
>>>> nothing else setting DSP A mode should force TDM mode with automatically
>>>> configured slot sizes.

Ok. How about that:
---
  sound/soc/codecs/max98090.c | 52 ++++++++++++++++++++-----------------
  sound/soc/codecs/max98090.h |  2 ++
  2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 142083b13ac3..c30305269514 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1582,7 +1582,7 @@ static int max98090_dai_set_fmt(struct snd_soc_dai *codec_dai,
  	struct snd_soc_component *component = codec_dai->component;
  	struct max98090_priv *max98090 = snd_soc_component_get_drvdata(component);
  	struct max98090_cdata *cdata;
-	u8 regval;
+	u8 regval, tdm_regval;

  	max98090->dai_fmt = fmt;
  	cdata = &max98090->dai[0];
@@ -1591,6 +1591,7 @@ static int max98090_dai_set_fmt(struct snd_soc_dai *codec_dai,
  		cdata->fmt = fmt;

  		regval = 0;
+		tdm_regval = 0;
  		switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
  		case SND_SOC_DAIFMT_CBC_CFC:
  			/* Set to consumer mode PLL - MAS mode off */
@@ -1636,7 +1637,8 @@ static int max98090_dai_set_fmt(struct snd_soc_dai *codec_dai,
  			regval |= M98090_RJ_MASK;
  			break;
  		case SND_SOC_DAIFMT_DSP_A:
-			/* Not supported mode */
+			tdm_regval |= M98090_TDM_MASK;
+			break;
  		default:
  			dev_err(component->dev, "DAI format unsupported");
  			return -EINVAL;
@@ -1665,11 +1667,20 @@ static int max98090_dai_set_fmt(struct snd_soc_dai *codec_dai,
  		 * seen for the case of TDM mode. The remaining cases have
  		 * normal logic.
  		 */
-		if (max98090->tdm_slots > 1)
+		if (tdm_regval)
  			regval ^= M98090_BCI_MASK;

  		snd_soc_component_write(component,
  			M98090_REG_INTERFACE_FORMAT, regval);
+
+		regval = 0;
+		if (tdm_regval)
+			regval = max98090->tdm_lslot << M98090_TDM_SLOTL_SHIFT |
+				 max98090->tdm_rslot << M98090_TDM_SLOTR_SHIFT |
+				 0 << M98090_TDM_SLOTDLY_SHIFT;
+
+		snd_soc_component_write(component, M98090_REG_TDM_FORMAT, regval);
+		snd_soc_component_write(component, M98090_REG_TDM_CONTROL, tdm_regval);
  	}

  	return 0;
@@ -1680,33 +1691,23 @@ static int max98090_set_tdm_slot(struct snd_soc_dai *codec_dai,
  {
  	struct snd_soc_component *component = codec_dai->component;
  	struct max98090_priv *max98090 = snd_soc_component_get_drvdata(component);
-	struct max98090_cdata *cdata;
-	cdata = &max98090->dai[0];

  	if (slots < 0 || slots > 4)
  		return -EINVAL;

-	max98090->tdm_slots = slots;
-	max98090->tdm_width = slot_width;
+	if (slot_width != 16)
+		return -EINVAL;

-	if (max98090->tdm_slots > 1) {
-		/* SLOTL SLOTR SLOTDLY */
-		snd_soc_component_write(component, M98090_REG_TDM_FORMAT,
-			0 << M98090_TDM_SLOTL_SHIFT |
-			1 << M98090_TDM_SLOTR_SHIFT |
-			0 << M98090_TDM_SLOTDLY_SHIFT);
-
-		/* FSW TDM */
-		snd_soc_component_update_bits(component, M98090_REG_TDM_CONTROL,
-			M98090_TDM_MASK,
-			M98090_TDM_MASK);
-	}
+	if (rx_mask != tx_mask)
+		return -EINVAL;

-	/*
-	 * Normally advisable to set TDM first, but this permits either order
-	 */
-	cdata->fmt = 0;
-	max98090_dai_set_fmt(codec_dai, max98090->dai_fmt);
+	if (!rx_mask)
+		return -EINVAL;
+
+	max98090->tdm_slots = slots;
+	max98090->tdm_width = slot_width;
+	max98090->tdm_lslot = ffs(rx_mask) - 1;
+	max98090->tdm_rslot = fls(rx_mask) - 1;

  	return 0;
  }
@@ -2411,6 +2412,9 @@ static int max98090_probe(struct snd_soc_component *component)
  	max98090->pa1en = 0;
  	max98090->pa2en = 0;

+	max98090->tdm_lslot = 0;
+	max98090->tdm_rslot = 1;
+
  	ret = snd_soc_component_read(component, M98090_REG_REVISION_ID);
  	if (ret < 0) {
  		dev_err(component->dev, "Failed to read device revision: %d\n",
diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index a197114b0dad..2d2971acd150 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -1534,6 +1534,8 @@ struct max98090_priv {
  	unsigned int dai_fmt;
  	int tdm_slots;
  	int tdm_width;
+	int tdm_lslot;
+	int tdm_rslot;
  	u8 lin_state;
  	unsigned int pa1en;
  	unsigned int pa2en;
-- 
2.40.1
