Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF948649A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiLLIvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiLLIu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:50:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B29646D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:50:56 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5D80166016B4;
        Mon, 12 Dec 2022 08:50:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670835055;
        bh=+TCCovkk1aO9l4Twe3DVfO+F8Eil43Bb8teXw9Jn25Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kNTbRx/6pBe0MLj/3uqg2/HpIYonPNdnQclLvjOkSMixhW4qLpr0hb2xLhbF+vnVg
         LWrdXNJf2x6yaLyCij61DZTIUMFk4gBgJXtrTwr6Dz2IcE8HvlpWlF+ykwz/5aTBpF
         floxa8J9GF3sUWHRxIkdc0wcMuSXozbGOMAxzfFwSaVhjFvSfx+pP+Ah25gebsL3aU
         T9upxykE5i1VentgJeX+8m11NrMKek+2Phv5UWCPyUq2CD4Oger40M9ppy1OyiAst7
         pqzIMYakR7Ik/2u2/LNPFXCC2MUqeAFP3qQogF/e/DJB6pvarq/lleT1z06ZRfNcq7
         QFA0twT9kH7Ew==
Message-ID: <2caaf016-c60d-3f4d-cfcc-e34a5629f359@collabora.com>
Date:   Mon, 12 Dec 2022 09:50:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] ASoC: mediatek: mt8195: add sof be ops to check audio
 active
To:     Curtis Malainey <cujomalainey@google.com>,
        YC Hung <yc.hung@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Trevor Wu <trevor.wu@mediatek.com>,
        "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Curtis Malainey <cujomalainey@chromium.org>,
        whalechang@google.com
References: <20221209031053.8444-1-yc.hung@mediatek.com>
 <CAOReqxh=27P7PogzhFr+37XBfRh5Nxu1x46JpdCH=ZRDVhRbeQ@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAOReqxh=27P7PogzhFr+37XBfRh5Nxu1x46JpdCH=ZRDVhRbeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/12/22 19:27, Curtis Malainey ha scritto:
> On Thu, Dec 8, 2022 at 7:11 PM YC Hung <yc.hung@mediatek.com> wrote:
>>
>> In MT8195 SOF design, both DSP and audio driver would access audio
>> registers. Before DSP accesses audio registers, audio power and clock
>> should be enabled. DSP will hang up if DSP access audio register but
>> audio power and clock are disabled. Therefore, we add audio pm runtime
>> active checking before accessing audio registers in SOF BE's callback
>> hw_params function to avoid this situation.
>>
>> Signed-off-by: YC Hung <yc.hung@mediatek.com>
> 
> Acked-by: Curtis Malainey <cujomalainey@chromium.org>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

