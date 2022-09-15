Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF15B9608
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIOIQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIOIQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:16:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0382D09;
        Thu, 15 Sep 2022 01:16:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CCFFD6601FC5;
        Thu, 15 Sep 2022 09:16:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663229770;
        bh=jG7FbbSpDpjfBhvgNQJmxohmPC6bnCqOuzP6c9bEsX4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EtG05uRRIpF2YqFiJoQMKjqbXAsvCCkWiP2lWX/In1m9YclZdd5XfTiM1okErNCN/
         zJKJvAu/dJUk8bkpdriYRMwjdJahpvU4D9Z85lMdQvj6rtYT9ZjGHkmz+pkUfEwvOs
         +aZPyYhpfR8m3WUYJ8rhzT82uttvj9iM73Eob18YsDiCMk0T1YxlnPbF6rmIe7ne3F
         tbJGMzskrpYv55bsF3AVGvgVUSOpC21rNGEJHB+lpuNUaInxqTBFrgrsSyD7v9Oms5
         3n7ZAd0uPMfJHEzu+OUNv+AGbf27cNG8bTi7TrFXhO8qyd4+HV/56BPX/K+nXHCvDz
         KUIjJQEAKFWbA==
Message-ID: <7cc06fa1-0ac1-3194-d90a-0a11bd4612f2@collabora.com>
Date:   Thu, 15 Sep 2022 10:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [V14,0/15] Enable jpeg enc & dec multi-hardwares for MT8195
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        "kyrie.wu" <kyrie.wu@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        nicolas.dufresne@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com
References: <20220915064337.2686-1-irui.wang@mediatek.com>
 <63cbb922a0b5df6af660919727ad9246142f75bf.camel@mediatek.com>
 <96d148dc-6525-9977-c1a9-2b1affa889e7@xs4all.nl>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <96d148dc-6525-9977-c1a9-2b1affa889e7@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/22 09:41, Hans Verkuil ha scritto:
> Hi Irui,
> 
> On 9/15/22 08:21, kyrie.wu wrote:
>> On Thu, 2022-09-15 at 14:43 +0800, Irui Wang wrote:
>>> From: kyrie wu <kyrie.wu@mediatek.com>
>>>
>>> This series adds support for multi hardwares jpeg enc & dec,
>>> by first adding use of_platform_populate to manage each hardware
>>> information:interrupt, clock, register bases and power.
>>> Secondly add jpeg enc & dec work queue to deal with the encoding
>>> or decoding requests of multi-hardwares at the same time.
>>> Lastly, add output picture reorder function interface to
>>> eliminate the out of order images.
>>>
>>> This series has been tested with MT8195 Gstreamer.
>>> Encoding and decoding worked for this chip.
>>
>> Hi Hans,
>>
>> I'm terrible sorry for that I didn't notice you picked all
>> patches series includes jpeg enc + dec.
>> Please overlook the V14 and I will send a new series to fix
>> kernel-doc warns.
> 
> No, I didn't pick it up. The branch Angelo pointed to is just the branch I used to 
> compile test your series, I haven't posted a PR for it.
> 
> Next week I'll try again with v14 to check if it passes all my compile tests, and 
> if OK, then I'll post a PR.
> 
> Patches are picked up if I post a PR and they are marked as 'Under Review' in 
> patchwork. When Mauro merges them in our tree, then the state goes to 'Accepted'.
> 

Sorry for the confusion.

Regards,
Angelo

> Regards,
> 
>      Hans
> 
>>
>> Thanks.
>>
>> Regards,
>> Kyrie.
>>>
>>> Patches 1 Adds jpeg encoder dt-bindings for mt8195
>>>
>>> Patches 2 jpeg encoder builds two module for using Multi-HW,
>>> export some functions to make them visible by other modules.
>>>
>>> Patches 3 use devm_of_platform_populate to manage multi-hardware.
>>>
>>> Patch 4 add jpeg encoding timeout function to judge hardware timeout.
>>>
>>> Patch 5 add encoding work queue to deal with multi-hardware encoding
>>> at the same time.
>>>
>>> Patch 6 add output picture reorder function to order images.
>>>
>>> Patch 7 add stop cmd function to deal with EOS operation.
>>>
>>> Patch 8 Adds jpeg decoder dt-bindings for mt8195
>>>
>>> Patches 9 jpeg decoder builds three module for using Multi-HW,
>>> export some functions to make them visible by other modules.
>>>
>>> Patch 10 use of_platform_populate to manage multi-hardware.
>>>
>>> Patch 11 add jpeg decoding timeout function to judge hardware
>>> timeout.
>>>
>>> Patch 12 add decoding work queue to deal with multi-hardware decoding
>>> at the same time.
>>>
>>> Patch 13 add output picture reorder function to order images.
>>>
>>> Patch 14 refactor jpegdec func interface for HW working.
>>>
>>> Patch 15 add stop cmd function to deal with EOS operation.
>>>
>>> ---
>>> This series patches dependent on:
>>> media_stage tree:
>>> [1]
>>>
>> https://git.linuxtv.org/media_stage.git/commit/?id=b3627647f9ea7473d10fb08a95fd7c4133a17ca4
>>>
>>> patch1 new jpegdec dt-bindings included files
>>> [2] MM IOMMU binding:
>>>
>> https://patchwork.kernel.org/project/linux-mediatek/patch/20220217113453.13658-2-yong.wu@mediatek.com/
>>>
>>> [3] MT8195 power domain:
>>>
>> https://patchwork.kernel.org/project/linux-mediatek/list/?series=580579
>>>
>>> Changes compared with v13:
>>> - some modifications for patch v13's review comments.
>>> - fix kernel robot check errors.
>>> - fix kernel-doc check warns.
>>> - fix sparse check warns.
>>> - combine jpeg encoder series with decoder series into
>>>    one single series.
>>>
>>> Changes compared with v12:
>>> - some modifications for patch v12's review comments.
>>>
>>> Changes compared with v11:
>>> - some modifications for patch v11's review comments.
>>> - fix yaml file check errors.
>>>
>>> Changes compared with v10:
>>> - some modifications for patch v10's review comments.
>>> - fix Gstreamer test errors.
>>>
>>> Changes compared with v9:
>>> - some modifications for patch v9's review comments.
>>>
>>> Changes compared with v8:
>>> - some modifications for patch v8's review comments.
>>> - add stop cmd function.
>>>
>>> Changes compared with v7:
>>> - some modifications for patch v6's review comments.
>>>
>>> Changes compared with v6:
>>> - new yaml file for mt8195 jpeg encoder.
>>> - some modifications for patch v5's review comments.
>>>
>>> Changes compared with v5:
>>> - use of_platform_populate to replace component framework to
>>>    manage multi-hardware in patch 2.
>>>
>>> Changes compared with v4:
>>> - No change compaered with v4
>>>
>>> Changes compared with v3:
>>> - Structure patches for consistency, non-backward
>>>    compatible and do not break any existing functionality
>>>
>>> Changes compared with v2:
>>> - Split the last two patches into several patches
>>>    to enhance readability
>>> - Correct some syntax errors
>>> - Explain why the component framework is used
>>>
>>> Changes compared with v1:
>>> - Add jpeg encoder dt-bindings for MT8195
>>> - Use component framework to manage jpegenc HW
>>> - Add jpegenc output pic reorder function interface
>>>
>>> kyrie wu (15):
>>>    dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
>>>    mtk-jpegenc: export jpeg encoder functions
>>>    mtk-jpegenc: support jpegenc multi-hardware
>>>    mtk-jpegenc: add jpegenc timeout func interface
>>>    mtk-jpegenc: add jpeg encode worker interface
>>>    mtk-jpegenc: add output pic reorder interface
>>>    mtk-jpegenc: add stop cmd interface for jpgenc
>>>    dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
>>>    media: mtk-jpegdec: export jpeg decoder functions
>>>    media: mtk-jpegdec: support jpegdec multi-hardware
>>>    media: mtk-jpegdec: add jpegdec timeout func interface
>>>    media: mtk-jpegdec: add jpeg decode worker interface
>>>    media: mtk-jpegdec: add output pic reorder interface
>>>    media: mtk-jpegdec: refactor jpegdec func interface
>>>    mtk-jpegdec: add stop cmd interface for jpgdec
>>>
>>>   .../media/mediatek,mt8195-jpegdec.yaml        | 169 ++++++
>>>   .../media/mediatek,mt8195-jpegenc.yaml        | 147 ++++++
>>>   drivers/media/platform/mediatek/jpeg/Makefile |  14 +-
>>>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 490
>>> ++++++++++++++++--
>>>   .../platform/mediatek/jpeg/mtk_jpeg_core.h    | 169 +++++-
>>>   .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 315 ++++++++++-
>>>   .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |   6 +-
>>>   .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h |   1 +
>>>   .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 255 +++++++++
>>>   9 files changed, 1483 insertions(+), 83 deletions(-)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
>>>   create mode 100644
>>> Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
>>>
>>

