Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7077B62D5D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiKQJF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiKQJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:05:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56045A6C2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:05:09 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8068E6602A93;
        Thu, 17 Nov 2022 09:05:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668675908;
        bh=p6YpsqupWmMHDs3TaSsKpSsAZEWOlE0sLkaMc79YVaE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g5ZXiea3ZGKBuoVs9zj0Rf5EhnQuDlkfxJIZKTGzw3IvJFcvNCC/wICgyioYV6Kt+
         CvYvfE7CmLT6Q4hvLlKz9ClEJlnqlsYxYSq8THGwPZxoB9SRTdleneqhPJonethBH8
         IKiJWY9jveo83vlK6g8cfp8pyVQD9FhqL8Y6esPLu/Hf3qt8Hvx9Bt+pTXuWUAUBr2
         9Une+RQrDAxPaGQunszWowtuP+mzN6YLYSYTPkfa2K4jky4yIqTqq3jfHLyLkmnjIM
         RFlCdbYh5fFXpqxs5nWXa7qJPf83Y+Rype0QfhY7s3QA+dezySHuh6wj9JXsDv6SYd
         KQqZbTc/s194g==
Message-ID: <b221328c-4a06-a0b7-d96f-58b9804212d6@collabora.com>
Date:   Thu, 17 Nov 2022 10:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [Sound-open-firmware] [PATCH 3/4] ASoC: SOF: Adding amd HS
 functionality to the sof core
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Daniel Baluta <daniel.baluta@nxp.com>, Sunil-kumar.Dommati@amd.com,
        ssabakar@amd.com, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        venkataprasad.potturu@amd.com,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Basavaraj.Hiregoudar@amd.com, Chen-Yu Tsai <wenst@chromium.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        YC Hung <yc.hung@mediatek.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Vijendar.Mukunda@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>
References: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
 <20220913144319.1055302-4-Vsujithkumar.Reddy@amd.com>
 <36a45c7a-820a-7675-d740-c0e83ae2c417@collabora.com>
 <a8bc9284-c0c2-79aa-fee6-40101fc34f96@linux.intel.com>
 <02c2643f-bd32-c3db-51a1-d7773b60c655@collabora.com>
 <d7b32cb5-7fec-0c2a-d2c7-6934a1eb932b@linux.intel.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d7b32cb5-7fec-0c2a-d2c7-6934a1eb932b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/11/22 17:55, Pierre-Louis Bossart ha scritto:
> 
> 
> On 11/16/22 10:33, AngeloGioacchino Del Regno wrote:
>> Il 16/11/22 16:04, Pierre-Louis Bossart ha scritto:
>>>
>>>>> diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
>>>>> index 21d98f31a9ca..83fd81c82e4c 100644
>>>>> --- a/include/sound/sof/dai.h
>>>>> +++ b/include/sound/sof/dai.h
>>>>> @@ -84,6 +84,7 @@ enum sof_ipc_dai_type {
>>>>>         SOF_DAI_AMD_BT,            /**< AMD ACP BT*/
>>>>>         SOF_DAI_AMD_SP,            /**< AMD ACP SP */
>>>>>         SOF_DAI_AMD_DMIC,        /**< AMD ACP DMIC */
>>>>> +    SOF_DAI_AMD_HS,            /**< Amd HS */
>>>>>         SOF_DAI_MEDIATEK_AFE,        /**< Mediatek AFE */
>>>>
>>>> Adding SOF_DAI_AMD_HS before SOF_DAI_MEDIATEK_AFE desynced this
>>>> enumeration
>>>> so the DAI type is now 11 and not 10 anymore, leading to a failure in
>>>> firmware
>>>> at IPC3 helper function `dai_get()`, as when `dai_find_type()` is
>>>> called, the
>>>> DAI type that the firmware expects doesn't match with the one that gets
>>>> sent
>>>> in the request message from the kernel.
>>>>
>>>> As a local test, I tried moving SOF_DAI_AMD_HS after
>>>> SOF_DAI_MEDIATEK_AFE and
>>>> this has restored full functionality on my MT8195 platform (Tomato
>>>> Chromebook).
>>>>
>>>> If SOF is supposed to guarantee backwards compatibility (and I believe
>>>> it is),
>>>> this commit breaks that.
>>>>
>>>> I would be tempted to send a commit that moves SOF_DAI_AMD_HS to the
>>>> end, but
>>>> that would break the already compiled firmware for AMD platforms, so I
>>>> am not
>>>> sure how to proceed.
>>>
>>> D'oh. Yes this breaks backwards-compatibility and this is a clear
>>> mistake. I think your suggestion to add the AMD_HS at the end is the
>>> only practical solution indeed - this would need to be done for both
>>> kernel and SOF version of dai.h.
>>>
>>
>> Okay, I will send a commit tomorrow :-)
> 
> I sent those two GitHub pull requests already:
> 
> https://github.com/thesofproject/linux/pull/4017
> https://github.com/thesofproject/sof/pull/6616
> 

Thanks for the fast action.

Regards,
Angelo
