Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE268F1B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjBHPMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjBHPMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:12:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2224D30D4;
        Wed,  8 Feb 2023 07:11:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B54511477;
        Wed,  8 Feb 2023 07:12:35 -0800 (PST)
Received: from [10.57.12.246] (unknown [10.57.12.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D28A33F8C6;
        Wed,  8 Feb 2023 07:11:49 -0800 (PST)
Message-ID: <7e08656f-4908-43e3-57d6-2928b1eb12d5@arm.com>
Date:   Wed, 8 Feb 2023 15:11:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/9] Panfrost: Improve and add MediaTek SoCs support
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tomeu.vizoso@collabora.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 10:37, AngeloGioacchino Del Regno wrote:
> This series adds support for new MediaTek SoCs (MT8186/MT8192/MT8195)
> and improves MT8183 support: since the mtk-regulator-coupler driver
> was picked, it is now useless for Panfrost to look for, and manage,
> two regulators (GPU Vcore and GPU SRAM) on MediaTek;

Yay! ;) I never did like Panfrost dealing with two regulators.

> The aforementioned driver will take care of keeping the voltage
> relation (/constraints) of the two regulators on its own when a
> voltage change request is sent to the Vcore, solving the old time
> issue with not working DVFS on Panfrost+MediaTek (due to devfreq
> supporting only single regulator).
> 
> In the specific case of MT8183, in order to not break the ABI, it
> was necessary to add a new compatible for enabling DVFS.

It's a shame to need a new compatible, but it seems sensible to me.

For the panfrost changes:

Reviewed-by: Steven Price <steven.price@arm.com>

I'll let others comment on the DT binding changes.

Thanks,

Steve

> Alyssa Rosenzweig (3):
>   drm/panfrost: Increase MAX_PM_DOMAINS to 5
>   drm/panfrost: Add the MT8192 GPU ID
>   drm/panfrost: Add mediatek,mt8192-mali compatible
> 
> AngeloGioacchino Del Regno (6):
>   dt-bindings: gpu: mali-bifrost: Don't allow sram-supply by default
>   dt-bindings: gpu: mali-bifrost: Allow up to 5 power domains for MT8192
>   dt-bindings: gpu: mali-bifrost: Add compatible for MT8195 SoC
>   dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
>   dt-bindings: gpu: mali-bifrost: Add a compatible for MediaTek MT8186
>   drm/panfrost: Add new compatible for Mali on the MT8183 SoC
> 
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 68 +++++++++++++++++--
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c       | 28 ++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c       |  8 +++
>  4 files changed, 99 insertions(+), 7 deletions(-)
> 

