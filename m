Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728106E213B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDNKsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:48:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4AE59C5;
        Fri, 14 Apr 2023 03:48:32 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4516766031C9;
        Fri, 14 Apr 2023 11:48:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681469303;
        bh=FylSFIVBnE7RXP+PfgYkJCcaPRTztLjwILG6wpZ/BJI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UWo5Cr6rDZb6UXxn1c6QDkxl9wIWtGPQLHecpLErzGMSW/rLafm9chY1DQnmoIMGs
         mZ2GeVL5CidyylhE9IjbRidVWkPbFCxkf2vqWTeTfheeHsv6/DJu9JizqbuKfPYwVn
         no5tVt4CEjnHDUiaidhbEgKcqnfTsR99dKJiDgnRNFbivJIe7X/L2E+GVomWh2F+YQ
         JCzw8msfQdsrDlwydHVaHsU0je0J7SKtykzZItKwVuDcEtyov2KoZZCb/LtUs0vJy8
         gj6FVTIQzoNtgbybuhAXQJlDmHsmGlt3jfYW98XrqcAlzWIZNFjqea5bIUOdaVLid8
         rXd9P/7vM5Cdg==
Message-ID: <a157c5e7-d90c-5b99-42bb-ae02b6677732@collabora.com>
Date:   Fri, 14 Apr 2023 12:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce
 GenieZone hypervisor support
Content-Language: en-US
To:     =?UTF-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "will@kernel.org" <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?UTF-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?UTF-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?UTF-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?UTF-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
 <20230413090735.4182-4-yi-de.wu@mediatek.com>
 <1aa701cc-92ca-71be-0663-df4bfae66c2f@linaro.org>
 <5c1d69c8-d973-fa7b-1f14-c72729ff5594@gmail.com>
 <533a1a9b653cf63f1e5df7f95d1b23902809561d.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <533a1a9b653cf63f1e5df7f95d1b23902809561d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/04/23 10:43, Yi-De Wu (吳一德) ha scritto:
> On Thu, 2023-04-13 at 19:08 +0200, Matthias Brugger wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> On 13/04/2023 14:55, Krzysztof Kozlowski wrote:
>>> On 13/04/2023 11:07, Yi-De Wu wrote:
>>>> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
>>>>
>>>> GenieZone is MediaTek proprietary hypervisor solution, and it is
>>>> running
>>>> in EL2 stand alone as a type-I hypervisor. This patch exports a
>>>> set of
>>>> ioctl interfaces for userspace VMM (e.g., crosvm) to operate
>>>> guest VMs
>>>> lifecycle (creation, running, and destroy) on GenieZone.
>>>>
>>>> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
>>>> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
>>>> ---
>>>>    arch/arm64/include/uapi/asm/gzvm_arch.h       |  79 ++++
>>>>    drivers/soc/mediatek/Kconfig                  |   2 +
>>>>    drivers/soc/mediatek/Makefile                 |   1 +
>>>>    drivers/soc/mediatek/virt/geniezone/Kconfig   |  17 +
>>>
>>> Hypervisor drivers do not go to soc. Stop shoving there everything
>>> from
>>> your downstream. Find appropriate directory, e.g. maybe
>>> drivers/virt.
>>
>> Acked, what is the reason you want to add this to drivers/soc instead
>> of
>> drivers/virt?
>>
>> Regards,
>> Matthias
>>
> Noted. We would take your advice and move it from
> drivers/soc/mediatek/virt to /drivers/virt on next version.
> 
> The reason we put it under our soc/ is that the drver is highly
> propietary for mediatek's product and for aarch64 only. Maybe it's not
> general enough to put in under /drivers/virt.

This is the same reason why mediatek-drm is in drivers/gpu/drm/ and the same why
mediatek-cpufreq is in drivers/cpufreq/.

I know that this is a MediaTek specific implementation, but it *is* a hypervisor
driver, hence it belongs to the hypervisor drivers folder.
It's not even granted that this will not support other MediaTek architectures in
the future, but that's not a discussion to do right here and right now, and it's
anyway irrelevant in this moment.

By the way, good job with upstreaming your drivers targeting MediaTek Android SW!
I'm enthusiast to see that.

Regards,
Angelo

