Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A10737D16
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFUIIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjFUIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:07:57 -0400
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 01:07:34 PDT
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504D110F1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:07:34 -0700 (PDT)
Message-ID: <55b17217-306d-4694-a320-f5f0c225aa20@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1687334487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2ODbWnKnrz7VqAOo8kWtxW1Ol0VtHtIEnAOqPMBGOo=;
        b=g65jaJmxrn+XErzLCS0LE2rS2XjxbzuhPh5GMcrB6x/4qrlvxVARxogYqk4TZc2vIQqaRu
        9BM0Ouuk1buIEKixaAthPm4H10li3jdxUXMZHZ6g+ujr8v+HbfzlN8AACDeT6tbBpuOxv7
        YqXQHENnXa6zo11tY9N6hafr8IU9IaVG32CmWhHaBslZYDCssUzdCBCLEfbXXHETukAgiY
        h8CnMMfgSFlr1HErVGsZltP+0JgC0Zy5oaqYpwT61i0W6SZSVHKlIlRM7pDtaOYXuMomDE
        /qD+ayg0owjvY7olFnydU+zKyhjk/Edw8YIGdCRW3L2446PYos9NbW2GI0B9Gw==
Date:   Wed, 21 Jun 2023 10:01:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirks for Asus ROG Ally handheld
 using CS35L41
Content-Language: en-US
To:     Matthew Anderson <ruinairas1992@gmail.com>, tiwai@suse.com
Cc:     perex@perex.cz, luke@ljones.dev, sbinding@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20230620235509.35608-1-ruinairas1992@gmail.com>
From:   =?UTF-8?Q?Philip_M=c3=bcller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20230620235509.35608-1-ruinairas1992@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.23 01:55, Matthew Anderson wrote:
> This requires a patched ACPI table or a firmware from ASUS to work because
> the system does not come with the _DSD field for the CSC3551.
> 
> Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
> ---
>   sound/pci/hda/patch_realtek.c | 46 +++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 308ec7034cc9..b918b0046144 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -7120,6 +7120,10 @@ enum {
>   	ALC294_FIXUP_ASUS_DUAL_SPK,
>   	ALC285_FIXUP_THINKPAD_X1_GEN7,
>   	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
> +	ALC294_FIXUP_ASUS_ALLY,
> +	ALC294_FIXUP_ASUS_ALLY_PINS,
> +	ALC294_FIXUP_ASUS_ALLY_VERBS,
> +	ALC294_FIXUP_ASUS_ALLY_SPEAKER,
>   	ALC294_FIXUP_ASUS_HPE,
>   	ALC294_FIXUP_ASUS_COEF_1B,
>   	ALC294_FIXUP_ASUS_GX502_HP,
> @@ -8432,6 +8436,47 @@ static const struct hda_fixup alc269_fixups[] = {
>   		.chained = true,
>   		.chain_id = ALC294_FIXUP_SPK2_TO_DAC1
>   	},
> +	[ALC294_FIXUP_ASUS_ALLY] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = cs35l41_fixup_i2c_two,
> +		.chained = true,
> +		.chain_id = ALC294_FIXUP_ASUS_ALLY_PINS
> +	},
> +	[ALC294_FIXUP_ASUS_ALLY_PINS] = {
> +		.type = HDA_FIXUP_PINS,
> +		.v.pins = (const struct hda_pintbl[]) {
> +						{ 0x19, 0x03a11050 },
> +						{ 0x1a, 0x03a11C30 },
> +						{ 0x21, 0x03211420 },
> +						{ }
> +				},
> +		.chained = true,
> +		.chain_id = ALC294_FIXUP_ASUS_ALLY_VERBS
> +	},
> +	[ALC294_FIXUP_ASUS_ALLY_VERBS] = {
> +		.type = HDA_FIXUP_VERBS,
> +		.v.verbs = (const struct hda_verb[]) {
> +						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
> +						{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
> +						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x46 },
> +						{ 0x20, AC_VERB_SET_PROC_COEF, 0x0004 },
> +						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x47 },
> +						{ 0x20, AC_VERB_SET_PROC_COEF, 0xA47A },
> +						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x49 },
> +						{ 0x20, AC_VERB_SET_PROC_COEF, 0x0049},
> +						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4A },
> +						{ 0x20, AC_VERB_SET_PROC_COEF, 0x201B },
> +						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x6B },
> +						{ 0x20, AC_VERB_SET_PROC_COEF, 0x4278},
> +						{ }
> +				},
> +				.chained = true,
> +				.chain_id = ALC294_FIXUP_ASUS_ALLY_SPEAKER
> +		},
> +	[ALC294_FIXUP_ASUS_ALLY_SPEAKER] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc285_fixup_speaker2_to_dac1,
> +	},
>   	[ALC285_FIXUP_THINKPAD_X1_GEN7] = {
>   		.type = HDA_FIXUP_FUNC,
>   		.v.func = alc285_fixup_thinkpad_x1_gen7,
> @@ -9596,6 +9641,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x10ec, 0x1254, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
>   	SND_PCI_QUIRK(0x10ec, 0x12cc, "Intel Reference board", ALC225_FIXUP_HEADSET_JACK),
>   	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
> +	SND_PCI_QUIRK(0x1043, 0x17F3, "ROG Ally RC71L_RC71L", ALC294_FIXUP_ASUS_ALLY),
>   	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
>   	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
>   	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_AMP),

Tested-by: Philip Mueller <philm@manjaro.org>

