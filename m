Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734746375C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKXKAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKXKAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:00:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C827342B;
        Thu, 24 Nov 2022 02:00:00 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A2226602B0C;
        Thu, 24 Nov 2022 09:59:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669283998;
        bh=48X8OTH7/cJ6CzdDW7GuIRWxszRUPEKFaWr6Rm9Yc2g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UYW5QHWhwBOR7p3o9u96XxSmWa8xr+p1ubdXEmrliSgtBIkDYi5jIPtiVA6RF6kaZ
         46VoFh+RSngStfA1rChmknARUMuJ1s4ze0Qks5JGNwao+G8EX1uHeaKbxXJtsgw64b
         wNKDpfR70/WEXO3FwQXMD3SRLvY/Gy31CVvIYJn1F5l0CDkQqnMEWxjDuIi6fy5CZf
         fxyE/QWo0U4YIiG51BVCWWkf+SaE8fbECIDpte7CC5KQcsJPfIHZVizGnrcSKTGgX5
         klrGuyATQddROqSwNPC3ywyIg7OgyLnUX21Oo6vN8U3pZSwOGx5d+gLkfzQuK1QW4W
         nHkZo1uPovCsg==
Message-ID: <9c4167ac-d962-17e0-6e9c-03656169f50b@collabora.com>
Date:   Thu, 24 Nov 2022 10:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/4] irqchip: irq-mtk-cirq: Move register offsets to
 const array
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221123112249.98281-1-angelogioacchino.delregno@collabora.com>
 <20221123112249.98281-4-angelogioacchino.delregno@collabora.com>
 <86fse9ok3y.wl-maz@kernel.org>
 <c8174977-2995-811a-83e2-9f941057acd8@collabora.com>
 <86cz9doctj.wl-maz@kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <86cz9doctj.wl-maz@kernel.org>
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

Il 23/11/22 17:28, Marc Zyngier ha scritto:
> On Wed, 23 Nov 2022 14:57:02 +0000,
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
>>
>>>> +					 enum mtk_cirq_reg_index idx,
>>>> +					 unsigned int cirq_num)
>>>
>>> What does cirq_num mean for registers that are not relative to an
>>> interrupt? Create a separate helper for those.
>>>
>> Means literally nothing, so yes I agree, but...
>>
>> ... mtk_cirq_irq_reg(), mtk_cirq_reg() feels too similar and may lead to
>> confusion while reading the code.
>>
>> Any advice about a possibly clear-er name?
> 
> I think the names are OK. Passing an interrupt number as a parameter
> is a good discriminant anyway.
> 
> Please wait for a few days before posting the next version though.
> 
> 	M.
> 

Let's go with these names then, thank you!

Regards,
Angelo
