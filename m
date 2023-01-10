Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE88663CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbjAJJ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbjAJJZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:25:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D3F4FD71;
        Tue, 10 Jan 2023 01:25:42 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ACF636602D72;
        Tue, 10 Jan 2023 09:25:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673342740;
        bh=UO/47Pe7uv3EMf4vDnz2gYTwAoNr+ErQMvPz7A28Qro=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VMh/LVWlQDpZIehojvWLiTiuVARsqOLpghrySs8Xusy9wQ9h/aDe1042fpaEuCbGx
         BPKM2r7wR+BKb5Ada4Pbz8msKEgDQeKWCXMdQN5UWvJbgq/ccE5zqnQfqR5pl6S5wJ
         Y0ZLm0vcXcTdh2nOYe8qrJx+kBqkQPHgAkcfxUAQFp/WrhGCMdlz2D+07bWB6I5Qac
         s1Yw6/MO1LkC3jRwkURMuWirpVNbjEx5xYQWxFYYr5fB/BIJcjel8o+OMZ63wfxnMP
         aEWnvm0hEEzl0M2Un2/k0Xn3ybdhdQns3o/E4oDF/lk9nH1CBnYqehnGilEM5zJZTo
         91UckWqMKkZqg==
Message-ID: <e71a66ca-553b-3d8c-cbc1-3c2a8f4a22c2@collabora.com>
Date:   Tue, 10 Jan 2023 10:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] ASoC: SOF: mediatek: Support mt8188 platform
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Dan Carpenter <error27@gmail.com>,
        YC Hung <yc.hung@mediatek.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230110084312.12953-1-tinghan.shen@mediatek.com>
 <20230110084312.12953-3-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230110084312.12953-3-tinghan.shen@mediatek.com>
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

Il 10/01/23 09:43, Tinghan Shen ha scritto:
> Add support of SOF on MediaTek MT8188 SoC.
> MT8188 ADSP integrates with a single core Cadence HiFi-5 DSP.
> The IPC communication between AP and DSP is based on shared DRAM and
> mailbox interrupt.
> 
> The change in the mt8186.h is compatible on both mt8186 and
> mt8188. The register controls booting the DSP core with the
> default address or the user specified address. Both mt8186
> and mt8188 should boot with the user specified boot in the driver.
> The usage of the register is the same on both SoC, but the
> control bit is different on mt8186 and mt8188, which is bit 1 on mt8186
> and bit 0 on mt8188. Configure the redundant bit has noside effect
> on both SoCs.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


