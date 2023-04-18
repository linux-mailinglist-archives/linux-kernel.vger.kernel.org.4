Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17356E5D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjDRJZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjDRJZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:25:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595494681;
        Tue, 18 Apr 2023 02:25:52 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CAF09660323E;
        Tue, 18 Apr 2023 10:25:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681809950;
        bh=WjDT+ciRzblDEja9H9yUPX/ktIWhUcxaLuEthRRfGXE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DC7iYPraYsiDHayMU8h93EvVtgSQ+ZQfP/cUQ0Sw++EnXyR4tvD9ViXnVnMly25wd
         hFZaoDm/LvTL6kmJbnOLnKloLUo8uAGyuZTW8EOq/YVFJnGD+XVUKozZnWf1WzNoZP
         QqDPDj5xXcyoVSwX3qt+kG26OC66DEtNjwLSDDaYMLd/XGr/Xh6tgX79eN7zLrInGa
         5HZPwJkjBCA9K3+sdG+bVqeOQXpLCAMq9LtKCCLgIhdO2Xgpiu7UHSZ/WqF3p2odxw
         wZHd/dphuiD6WPrKjLeWxulqroQdhhNLxCn9kOulH6WOmNXXKt1oLFva3npuDOHh1H
         Wn9W2Ebhun/9w==
Message-ID: <a7ed8963-4669-be63-0769-50a2641242c7@collabora.com>
Date:   Tue, 18 Apr 2023 11:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/2] thermal: mediatek: use devm_of_iomap to avoid
 resource leak in mtk_thermal_probe
Content-Language: en-US
To:     Kang Chen <void0red@hust.edu.cn>, error27@gmail.com
Cc:     amitk@kernel.org, bchihi@baylibre.com, daniel.lezcano@linaro.org,
        daniel@makrotopia.org, dzm91@hust.edu.cn, henry.yen@mediatek.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org,
        rui.zhang@intel.com, void0red@gmail.com
References: <48ae0e2e-257d-4ad2-afbc-2eb4b48e516b@kili.mountain>
 <20230417125533.3142236-1-void0red@hust.edu.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417125533.3142236-1-void0red@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/04/23 14:55, Kang Chen ha scritto:
> Smatch reports:
> 1. mtk_thermal_probe() warn: 'apmixed_base' from of_iomap() not released.
> 2. mtk_thermal_probe() warn: 'auxadc_base' from of_iomap() not released.
> 
> The original code forgets to release iomap resource when handling errors,
> fix it by switch to devm_of_iomap.
> 
> Fixes: 89945047b166 ("thermal: mediatek: Add tsensor support for V2 thermal system")
> Signed-off-by: Kang Chen <void0red@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

Good job!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


