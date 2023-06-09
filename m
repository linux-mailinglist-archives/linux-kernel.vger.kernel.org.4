Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E71729150
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbjFIHiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbjFIHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:37:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB4F30D0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:37:38 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A03186606F22;
        Fri,  9 Jun 2023 08:37:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686296257;
        bh=nv3+VZ+nnLOqcVjviYsmHpsvTnWxCSfjsc5IBhYXT1Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PCWvFIrzIN+XpN/Vq0x86j0/3TfonqRrg6pxLZyyXg8fwOtMCP2OVRtvGi+r6h6Vy
         6DMmDVMGSvr8MDzaDlC6yxw4BamffBmaxzQ7KpwzYl841EK1LrPndyyj46LFlrbQrB
         WySANsG7/gIZJhvKPBFvNHY4+2p795s2EGQCa2S+tC8fg8duHTPrzA6bsnUCoXqZxB
         +uebjZDx8pOGPRJgdQBT7M4QD7tnxoEktitlUZNln85ZmTA0Ar0eJTeZ9oto9RYXpc
         vlkfzhIg1GX3NRJmv5yCBIKps1JE2l5asXqihKFvIYIf4VurtKGtVU7xIAJLf6vVRZ
         CrmFb0jxDODiw==
Message-ID: <1bb65d99-d1dc-7a73-12c0-e7f4cba3525a@collabora.com>
Date:   Fri, 9 Jun 2023 09:37:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] Revert "ASoC: mediatek: mt8192-mt6359: Remove " Jack"
 from Headphone pin name"
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230608221050.217968-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230608221050.217968-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/06/23 00:10, Nícolas F. R. A. Prado ha scritto:
> This reverts commit cbbc0ec6dea09c815f1d1ef0abaf3f2ec89ff11f. That
> commit removed the " Jack" suffix with the reasoning that it is
> automatically added to the name of the kcontrol created, which is true,
> but this name is also used to look for the DAPM widget that will be
> toggled when the jack status is updated. Since the widget is still
> called "Headphone Jack" the jack can't link to the widget and the
> following error is shown:
> 
> mt8192_mt6359 sound: ASoC: DAPM unknown pin Headphone
> 
> It is not possible to also rename the headphone DAPM widget because its
> name is used by a switch kcontrol, "Headphone Jack Switch", both to link
> to the headphone widget and to assemble its name. This switch's name is
> referenced in the upstream UCM file, so renaming it would break
> userspace. Since the original commit didn't bring any benefit, besides
> sparing a few CPU cycles, simply revert it.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

That commit is made to bring consistency in naming across MediaTek (with
other) sound card drivers.. I'm not sure whether the right solution would
be to revert this one, or to make a small change in the UCM, counting that
we'd be able to add more shared names around, finally reducing the config
length by sharing actual configurations across various SoCs.

Any opinion?

Thanks,
Angelo

> ---
> 
>   sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> index 4e0d5bf12b47..5e163e23a207 100644
> --- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> +++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
> @@ -46,7 +46,7 @@ struct mt8192_mt6359_priv {
>   /* Headset jack detection DAPM pins */
>   static struct snd_soc_jack_pin mt8192_jack_pins[] = {
>   	{
> -		.pin = "Headphone",
> +		.pin = "Headphone Jack",
>   		.mask = SND_JACK_HEADPHONE,
>   	},
>   	{

