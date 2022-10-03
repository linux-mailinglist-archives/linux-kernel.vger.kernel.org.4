Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF945F2FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiJCL3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJCL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:28:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE25E2A94E;
        Mon,  3 Oct 2022 04:28:58 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C30BE6601F8A;
        Mon,  3 Oct 2022 12:28:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664796537;
        bh=a5oSX0ceJpHAh8O/8zS5a5WFF20/Wc0S1JUkk7Q60Uc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j6Zb8obh981BH2ZWyV2nXwoQFshP0kUo/hvK0kMKL509IYXvn1LSnOA6vVaccvzKn
         zislmLYKBKSeAqSBZovh2CaPLkkqdaT5GLLAwlitTDz9Ltd56kR/qJ1wAEKsfDX/LX
         8CA3rxjUt4ZLYcVQL75whDVnk4cGVs2v9lGDx+/yt157aQVZRGS7Fa0Cj/lqF+ln1Z
         UBtbAeqrWrc6x1t+parm7XLfXq6i/tCM+du1J7dTFnpStRVb+OjMAPOl2+3Ygf67d6
         XpwVKOFwOz7jhXKPs5U/pwhv26unBJE/WMJ7WKC2V+Ty9c25HkvGQ0YPQzzj6GGfUl
         69TJO6kmEIaPQ==
Message-ID: <26ca8837-6cdd-2523-014d-8651ba48862a@collabora.com>
Date:   Mon, 3 Oct 2022 13:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] reset: mediatek: Move mediatek system clock reset to
 reset folder
To:     Stephen Boyd <sboyd@kernel.org>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de
Cc:     runyang.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, nfraprado@collabora.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220929121031.17523-1-rex-bc.chen@mediatek.com>
 <17c5cc9c-50ea-aeac-04e0-20b6c093c7ec@collabora.com>
 <20220930185953.41810C433C1@smtp.kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220930185953.41810C433C1@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/09/22 20:59, Stephen Boyd ha scritto:
> Quoting AngeloGioacchino Del Regno (2022-09-29 05:50:38)
>> I've just analyzed this idea a bit more, and there's the outcome.
>>
>> This driver would be fine, if some MediaTek SoCs weren't shipped with
>> a bootloader that supports only very small kernels... because then, if
>> the reset controller is not available at boot time, it's unlikely that
>> you can probe the eMMC or the uSD, so it won't be possible to actually
>> compile this driver as a module and load it afterwards.
>>
>> Please don't misunderstand me: I like the idea of having the MediaTek
>> SoC sysclk reset controller as a ... reset controller driver but, to
>> make that work, one fundamental issue must be solved...
>>
>> If the kernel is configured for, let's say, MT2701 and MT2712, we're
>> always building in reset controller support for MT7622, 7629, 8135, 8173,
>> 8183, 8186, 8192, 8195 - and this list will grow with MT8188, and others.
>>
>> Obviously, it's useless to have support for, say, MT7622, if the MT7622
>> system clock controllers aren't built-in, nor modules.
>>
>> So, to make this idea to work, we have to find a way to:
>> 1. Build in support only for the required SoC(s)
> 
> Use Kconfig
> 
>> 2. Put the reset index mapping arrays in SoC-specific files, or this
>>      single file driver will see an exponential growth.
> 
> Split the reset driver into different files compiled for different SoCs
> based on the SoC Kconfig made in step 1.
> 
>>
>> Wrapping it up - as the driver is right now - we're losing flexibility:
>> we need to maintain the current flexibility while keeping the improvements
>> that are made with this proposal.
>>
>> Ideas?
>>
> 
> It should work and your concerns are alleviated?

With this solution, my concerns are practically solved.

Regards,
Angelo
