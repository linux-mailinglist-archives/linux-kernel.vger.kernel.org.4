Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3388B5B6CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiIMMJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiIMMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:09:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A830A5F9B4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:08:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4649A6602002;
        Tue, 13 Sep 2022 13:08:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663070937;
        bh=ytNEmiOcTsgWo0PMOFDU/i6E5lJKDu8uqwY6x00ydfU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bFHlB0J2yobOwBvsWUUS07kgVmtwvhQ8i0BmdU0Mc14MRQ8k2mS60QKiOyPOT4BIm
         aZrp8CbbkzYxHPK2wQopWJ68KZ0ISvf8ddrLGwPNK4t7Ts336PtSjjQBmSDyZONOF8
         Wc+MYU+dWW0Wct9deGcnCiuAa1O3kXKQsBY4fh38B2f88+8SoVJHlQmI3Z1VmN0kYq
         9xSorSGxfXLbz3SXAjKJiZ55Hc6yT/JhjPAYyWLK+9LlwHhEmOssamkXBlXswm07dg
         PRNhCH/5FHNEIb3pY7pY5YNx7zwndByB4z+BDES0tryYxvo7WERu5BVyJY0+1C+WDX
         ydQ55sH6DQwdA==
Message-ID: <ca89b96f-cb17-e6b0-5dcd-fede79737770@collabora.com>
Date:   Tue, 13 Sep 2022 14:08:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] soc: mediatek: Introduce mediatek-regulator-coupler
 driver
Content-Language: en-US
To:     matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        alyssa.rosenzweig@collabora.com, nfraprado@collabora.com,
        dmitry.osipenko@collabora.com
References: <20220628120224.81180-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220628120224.81180-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/06/22 14:02, AngeloGioacchino Del Regno ha scritto:
> This driver currently deals with GPU-SRAM regulator coupling, ensuring
> that the SRAM voltage is always between a specific range of distance to
> the GPU voltage, depending on the SoC, necessary in order to achieve
> system stability across the full range of supported GPU frequencies.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Hello Matthias,

gentle ping for this one, as it has been tested for quite a while here,
on multiple MediaTek SoCs, and it's working as expected.

Can we get it upstream? Is there any blocker?

Cheers,
Angelo

> ---
> 
> Changes in v3:
>   - Added braces to else-if branch
> 
> Changes in v2:
>   - Added check for n_coupled
>   - Added check for vgpu to enforce attaching to vgpu<->sram coupling only
> 
> Context:
> This driver is one of the pieces of a bigger puzzle, aiming to finally
> enable Dynamic Voltage/Frequency Scaling for Mali GPUs found on MediaTek
> SoCs on the fully open source graphics stack (Panfrost driver).
> 
> No devicetree bindings are provided because this does not require any
> driver-specific binding at all.
> 
> Last but not least: it was chosen to have this driver enabled for
> ( ARCH_MEDIATEK && REGULATOR ) without really giving a free configuration
> choice because, once the DVFS mechanism will be fully working, using one
> of the listed MediaTek SoCs *without* this coupling mechanism *will* lead
> to unstabilities and system crashes.
> For COMPILE_TEST, choice is given for obvious reasons.
> 

