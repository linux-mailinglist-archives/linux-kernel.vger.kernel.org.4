Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8860074E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJQHIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiJQHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:08:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51BE222B1;
        Mon, 17 Oct 2022 00:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 971B8B80F6F;
        Mon, 17 Oct 2022 07:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78F8C433D6;
        Mon, 17 Oct 2022 07:08:31 +0000 (UTC)
Message-ID: <11db8299-cb75-dd97-11bd-3f269a8434cf@xs4all.nl>
Date:   Mon, 17 Oct 2022 09:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [V17,0/15] Enable jpeg enc & dec multi-hardwares for MT8195
Content-Language: en-US
To:     "kyrie.wu" <kyrie.wu@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
References: <20220929090817.24272-1-irui.wang@mediatek.com>
 <81fb2973c0376c988cf2f6550da24b533e341092.camel@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <81fb2973c0376c988cf2f6550da24b533e341092.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Irui,

On 10/14/22 11:26, kyrie.wu wrote:
> On Thu, 2022-09-29 at 17:08 +0800, Irui Wang wrote:
>> From: kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
> 
> Dear Hans,
> 
> Do you have any comments about the series patches?

None :-)

It's all in this pull request:

https://patchwork.linuxtv.org/project/linux-media/patch/50618425-5159-4077-3d3b-6938c86ca474@xs4all.nl/

Now that rc1 has been released by Linus I expect this PR to be merged by the end of this week
(depending on Mauro's schedule).

Regards,

	Hans

> 
> Thanks.
> 
> Regards,
> Kyrie.
>>
>> This series adds support for multi hardwares jpeg enc & dec,
>> by first adding use of_platform_populate to manage each hardware
>> information:interrupt, clock, register bases and power.
>> Secondly add jpeg enc & dec work queue to deal with the encoding
>> or decoding requests of multi-hardwares at the same time.
>> Lastly, add output picture reorder function interface to
>> eliminate the out of order images.
>>
>> This series has been tested with MT8195 Gstreamer.
>> Encoding and decoding worked for this chip.
>>
>> Patches 1 Adds jpeg encoder dt-bindings for mt8195
>>
>> Patches 2 jpeg encoder builds two module for using Multi-HW,
>> export some functions to make them visible by other modules.
>>
>> Patches 3 use devm_of_platform_populate to manage multi-hardware.
>>
>> Patch 4 add jpeg encoding timeout function to judge hardware timeout.
>>
>> Patch 5 add encoding work queue to deal with multi-hardware encoding
>> at the same time.
>>
>> Patch 6 add output picture reorder function to jpgenc order images.
>>
>> Patch 7 add stop cmd function to deal with jpgenc EOS operation.
>>
>> Patch 8 Adds jpeg decoder dt-bindings for mt8195
>>
>> Patches 9 jpeg decoder builds three module for using Multi-HW,
>> export some functions to make them visible by other modules.
>>
>> Patch 10 use of_platform_populate to manage multi-hardware.
>>
>> Patch 11 add jpeg decoding timeout function to judge hardware
>> timeout.
>>
>> Patch 12 add decoding work queue to deal with multi-hardware decoding
>> at the same time.
>>
>> Patch 13 add output picture reorder function to jpgdec order images.
>>
>> Patch 14 refactor jpegdec func interface for HW working.
>>
>> Patch 15 add stop cmd function to deal with jpgdec EOS operation.
>>
>> ---
>> This series patches dependent on:
>> media_stage tree:
>> [1]
>>
> https://git.linuxtv.org/media_stage.git/commit/?id=b3627647f9ea7473d10fb08a95fd7c4133a17ca4
>>
>> patch1 new jpegdec dt-bindings included files
>> [2] MM IOMMU binding:
>>
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220217113453.13658-2-yong.wu@mediatek.com/
>>
>> [3] MT8195 power domain:
>>
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=580579
>>
>> Changes compared with v16:
>> - some modifications for patch v16's review comments.
>>
>> Changes compared with v15:
>> - some modifications for patch v15's review comments.
>>
>> Changes compared with v14:
>> - some modifications for patch v14's review comments.
>>
>> Changes compared with v13:
>> - some modifications for patch v13's review comments.
>> - fix kernel robot check errors.
>> - fix kernel-doc check warns.
>> - fix sparse check warns.
>> - combine jpeg encoder series with decoder series into
>>   one single series.
>>
>> Changes compared with v12:
>> - some modifications for patch v12's review comments.
>>
>> Changes compared with v11:
>> - some modifications for patch v11's review comments.
>> - fix yaml file check errors.
>>
>> Changes compared with v10:
>> - some modifications for patch v10's review comments.
>> - fix Gstreamer test errors.
>>
>> Changes compared with v9:
>> - some modifications for patch v9's review comments.
>>
>> Changes compared with v8:
>> - some modifications for patch v8's review comments.
>> - add stop cmd function.
>>
>> Changes compared with v7:
>> - some modifications for patch v6's review comments.
>>
>> Changes compared with v6:
>> - new yaml file for mt8195 jpeg encoder.
>> - some modifications for patch v5's review comments.
>>
>> Changes compared with v5:
>> - use of_platform_populate to replace component framework to
>>   manage multi-hardware in patch 2.
>>
>> Changes compared with v4:
>> - No change compaered with v4
>>
>> Changes compared with v3:
>> - Structure patches for consistency, non-backward
>>   compatible and do not break any existing functionality
>>
>> Changes compared with v2:
>> - Split the last two patches into several patches
>>   to enhance readability
>> - Correct some syntax errors
>> - Explain why the component framework is used
>>
>> Changes compared with v1:
>> - Add jpeg encoder dt-bindings for MT8195
>> - Use component framework to manage jpegenc HW
>> - Add jpegenc output pic reorder function interface
>>
>> kyrie wu (15):
>>   dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
>>   mtk-jpegenc: export jpeg encoder functions
>>   mtk-jpegenc: support jpegenc multi-hardware
>>   mtk-jpegenc: add jpegenc timeout func interface
>>   mtk-jpegenc: add jpeg encode worker interface
>>   mtk-jpegenc: add output pic reorder interface
>>   mtk-jpegenc: add stop cmd interface for jpgenc
>>   dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
>>   media: mtk-jpegdec: export jpeg decoder functions
>>   media: mtk-jpegdec: support jpegdec multi-hardware
>>   media: mtk-jpegdec: add jpegdec timeout func interface
>>   media: mtk-jpegdec: add jpeg decode worker interface
>>   media: mtk-jpegdec: add output pic reorder interface
>>   media: mtk-jpegdec: refactor jpegdec func interface
>>   mtk-jpegdec: add stop cmd interface for jpgdec
>>
>>  .../media/mediatek,mt8195-jpegdec.yaml        | 168 ++++++
>>  .../media/mediatek,mt8195-jpegenc.yaml        | 147 ++++++
>>  drivers/media/platform/mediatek/jpeg/Makefile |  14 +-
>>  .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 490
>> ++++++++++++++++--
>>  .../platform/mediatek/jpeg/mtk_jpeg_core.h    | 169 +++++-
>>  .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 315 ++++++++++-
>>  .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |   6 +-
>>  .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h |   1 +
>>  .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 255 +++++++++
>>  9 files changed, 1482 insertions(+), 83 deletions(-)
>>  create mode 100644
>> Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
>>  create mode 100644
>> Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
>>
> 
