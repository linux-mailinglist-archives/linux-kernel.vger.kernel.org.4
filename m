Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A173262C17E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiKPO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiKPOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:55:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A641EBE3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:55:53 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E340E660038D;
        Wed, 16 Nov 2022 14:55:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668610551;
        bh=QlP42Fx/JuwOmRdSTtwWZ3hAH4WFE+BQsR2c4PKpqZY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q1owE4mjt4uoDXCVZqesuCU329WJhBtJfFeWuRjzkBwtbVWTFbs8PXXL3EA0G+rM3
         NvQ0SFmYZb5WmEMhglFUuNvxJfHzFrnND6Vw9gJjfDFEncvRofsxNavdcI+ZZSu6rt
         4YR0rTeYAqz4Tkl/SCWgOarlDfHdRwvEfBAVgOgpsoO2B3d91d4D4U7mIin9g56Flr
         F/j9NuPyoav8G+9VdH6GluMig2+Souuo3z7ODtXzWgm1pbgGGBpbujt90Zv3VHXtOv
         2OfDhRtVJLCC8rgvaWGr9mcJGyHLIv/QQqUsfLbR44L0M6EvNTI68OGSKoVvq0jObN
         kH6cZNLOS8dwQ==
Message-ID: <36a45c7a-820a-7675-d740-c0e83ae2c417@collabora.com>
Date:   Wed, 16 Nov 2022 15:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 3/4] ASoC: SOF: Adding amd HS functionality to the sof
 core
Content-Language: en-US
To:     V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        venkataprasad.potturu@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Basavaraj.Hiregoudar@amd.com, YC Hung <yc.hung@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Vijendar.Mukunda@amd.com,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20220913144319.1055302-1-Vsujithkumar.Reddy@amd.com>
 <20220913144319.1055302-4-Vsujithkumar.Reddy@amd.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220913144319.1055302-4-Vsujithkumar.Reddy@amd.com>
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

Il 13/09/22 16:43, V sujith kumar Reddy ha scritto:
> Add I2S HS control instance to the sof core.
> This will help the amd topology to use the I2S HS Dai.
> 
> Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>

Hello,

Since this patch was merged, SoundOpenFirmware stopped working on MediaTek MT8195,
as it fails on DAI component creation (firmware side)... check below...

> ---
>   include/sound/sof/dai.h       |  2 ++
>   sound/soc/sof/ipc3-pcm.c      |  9 +++++++++
>   sound/soc/sof/ipc3-topology.c | 33 +++++++++++++++++++++++++++++++++
>   sound/soc/sof/topology.c      |  1 +
>   4 files changed, 45 insertions(+)
> 
> diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
> index 21d98f31a9ca..83fd81c82e4c 100644
> --- a/include/sound/sof/dai.h
> +++ b/include/sound/sof/dai.h
> @@ -84,6 +84,7 @@ enum sof_ipc_dai_type {
>   	SOF_DAI_AMD_BT,			/**< AMD ACP BT*/
>   	SOF_DAI_AMD_SP,			/**< AMD ACP SP */
>   	SOF_DAI_AMD_DMIC,		/**< AMD ACP DMIC */
> +	SOF_DAI_AMD_HS,			/**< Amd HS */
>   	SOF_DAI_MEDIATEK_AFE,		/**< Mediatek AFE */

Adding SOF_DAI_AMD_HS before SOF_DAI_MEDIATEK_AFE desynced this enumeration
so the DAI type is now 11 and not 10 anymore, leading to a failure in firmware
at IPC3 helper function `dai_get()`, as when `dai_find_type()` is called, the
DAI type that the firmware expects doesn't match with the one that gets sent
in the request message from the kernel.

As a local test, I tried moving SOF_DAI_AMD_HS after SOF_DAI_MEDIATEK_AFE and
this has restored full functionality on my MT8195 platform (Tomato Chromebook).

If SOF is supposed to guarantee backwards compatibility (and I believe it is),
this commit breaks that.

I would be tempted to send a commit that moves SOF_DAI_AMD_HS to the end, but
that would break the already compiled firmware for AMD platforms, so I am not
sure how to proceed.

So... how can we solve that?
Any ideas?

P.S.: Sharing some logs at the end of this email, just for completeness.

Best regards,
Angelo




.. Relevant firmware and kernel trace/debug log lines ..

Log from Xtensa DSP:
[      828266.737921] (           3.125000) c0 ipc 
src/ipc/ipc3/handler.c:1579 INFO ipc: new cmd 0x30010000
[      828273.404587] (           6.666667) c0 component 
src/ipc/ipc3/helper.c:296  INFO comp new dai <c2b00d27-ffbc-4150-a51a-245c79c5e54b> 
type 2 id 4.22
[      828284.342087] (          10.937500) c0 dai 
src/audio/dai.c:177  ERROR dai_new(): dai_get() failed to create DAI.
[      828291.321253] (           6.979167) c0 dai 
src/ipc/ipc3/helper.c:303  ERROR comp_new(): unable to create the new component
[      828295.383753] (           4.062500) c0 ipc 
src/ipc/ipc3/helper.c:624  ERROR ipc_comp_new(): component cd = NULL
[      828299.654586] (           4.270833) c0 ipc 
src/ipc/ipc3/handler.c:1248 ERROR ipc: pipe 4 comp 22 creation failed -22


Kernel log:
[   15.011677] sof-audio-of-mt8195 10803000.dsp: request_firmware 
mediatek/sof/sof-mt8195.ri successful
...............
[   15.021452] sof-audio-of-mt8195 10803000.dsp: Firmware info: version 2:0:0-df141
[   15.039661] sof-audio-of-mt8195 10803000.dsp: Firmware: ABI 3:21:0 Kernel ABI 3:23:0
[   15.039663] sof-audio-of-mt8195 10803000.dsp: found sof_ext_man header type 2 
size 0x70
[   15.039665] sof-audio-of-mt8195 10803000.dsp: Firmware info: used compiler XCC 
12:0:8 <RI-2019.1-linux> used optimization flags -O2

...........

[   15.107660] sof-audio-of-mt8195 10803000.dsp: Firmware: DBG_ABI 5:3:0
[   15.292019] sof-audio-of-mt8195 10803000.dsp: booting DSP firmware
[   15.292025] sof-audio-of-mt8195 10803000.dsp: HIFIxDSP boot from base : 0x40000000
[   15.297257] sof-audio-of-mt8195 10803000.dsp: ipc rx: 0x70000000: FW_READY
[   15.363305] sof-audio-of-mt8195 10803000.dsp: DSP is ready 0x70000000 offset 
0x800000
[   15.363319] sof-audio-of-mt8195 10803000.dsp: Firmware info: version 2:0:0-df141
[   15.383651] sof-audio-of-mt8195 10803000.dsp: Firmware: ABI 3:21:0 Kernel ABI 3:23:0

............

[   16.336460] sof-audio-of-mt8195 10803000.dsp: loaded host PCM16P
[   16.336461] sof-audio-of-mt8195 10803000.dsp:  config: periods snk 2 src 0 fmt 0
[   16.336466] sof-audio-of-mt8195 10803000.dsp: ipc tx: 0x30100000: GLB_TPLG_MSG: 
PIPE_NEW
[   16.336603] sof-audio-of-mt8195 10803000.dsp: widget PIPELINE.4.AFE3.IN setup 
complete
[   16.336607] sof-audio-of-mt8195 10803000.dsp: ipc tx: 0x30010000: GLB_TPLG_MSG: 
COMP_NEW
[   16.336663] sof-audio-of-mt8195 10803000.dsp: ipc tx error for 0x30010000 
(msg/reply size: 96/20): -22
[   16.336665] sof-audio-of-mt8195 10803000.dsp: Failed to setup widget AFE3.IN
[   16.336670] sof-audio-of-mt8195 10803000.dsp: ipc tx: 0x30110000: GLB_TPLG_MSG: 
PIPE_FREE
[   16.336778] sof-audio-of-mt8195 10803000.dsp: widget PIPELINE.4.AFE3.IN freed
[   16.336887] sof-audio-of-mt8195 10803000.dsp: error: tplg component load failed -22
[   16.336899] sof-audio-of-mt8195 10803000.dsp: error: failed to load DSP topology -22
[   16.336900] sof-audio-of-mt8195 10803000.dsp: ASoC: error at 
snd_soc_component_probe on 10803000.dsp: -22
[   16.336983] mt8195_mt6359 mt8195-sound: ASoC: failed to instantiate card -22
[   16.340339] mt8195_mt6359: probe of mt8195-sound failed with error -22
