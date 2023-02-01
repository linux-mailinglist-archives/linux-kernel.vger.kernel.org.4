Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9115686672
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjBANNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjBANNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:13:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80ED37B75
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:13:12 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D899C6602EC6;
        Wed,  1 Feb 2023 13:13:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675257190;
        bh=f7vElBbzhtAES5v+6NQeQ2fY8DILnjp5rWlWuotQaUs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mOtEYVLCXZWTgOJkflsxN+jkXJGnvNtnvMdhUBZE4fseeSA5yDx1WR6LrAybtHZct
         l5+RrS8NVbKNpRnh5M7znPvpyl6682XGs56ouhI0dSbWKeIZKA0NjOi5fJPjjZDP+7
         bCy63avgsSr2FJ/kK8u9tqm1/sNrMYZbwRnO+Btl5w36JUB1mTQctUgkgpF5SKRYSx
         wTCP9Ek6tvNpuEY7bZUExjTIu7xIu/3+30lsu6gLv0UUnnU7Dm/4AHZiHTULDEzoEa
         FJaJciV1GPEEFmUjJDo4UDsDVbCPKSQHmfLr6gURMSoNsmUgSUS38h9tOU6gZMrncQ
         vWx6pQnGjiSWQ==
Message-ID: <ea37d824-5bfa-9e6c-a007-c5b794cd44e3@collabora.com>
Date:   Wed, 1 Feb 2023 14:13:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] arm64: defconfig: Enable DMA_RESTRICTED_POOL
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230130200820.82084-1-nfraprado@collabora.com>
 <20230130200820.82084-2-nfraprado@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230130200820.82084-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/01/23 21:08, Nícolas F. R. A. Prado ha scritto:
> Enable support for restricted DMA pools which provide a level of DMA
> memory protection on systems with limited hardware protection
> capabilities, such as those lacking an IOMMU.
> 
> For instance, mt8192-asurada-spherion makes use of this to provide a
> restricted DMA region for WiFi since its MT7921E WiFi card is connected
> through PCIe, and the MT8192 SoC doesn't have an IOMMU context for the
> PCIe controller.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

On MT8173 Elm, MT8192 Spherion, MT8195 Tomato:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


