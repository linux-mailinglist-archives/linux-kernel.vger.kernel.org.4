Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4BE704F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjEPNX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjEPNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:23:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157553AA2;
        Tue, 16 May 2023 06:23:57 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B97536603232;
        Tue, 16 May 2023 14:23:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684243435;
        bh=foW1kt1JaJSONbMV/WAPg236KARkkf+HweAeVo7iH3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fx2dxpK6g4uEwDVMTqdP1RirESsHS5dLWG1M9Cnmjks7UjrIugcMNC+bof40Zar8L
         GuS1lxWx4mSF59WVNnaWk315b8G5+a1p0sltV7TnE0vQEBFfBVZsMSZyN7QilnV1E5
         ukf8yX9w+wRoLeRGogBV8uFBNloM5rVu/r4aLX2yxj6uVAIdRUme1Du4Hubu5hMviq
         WyqFClCkEyJ3WZrgrkTEUR3yTIIVkvyTJeMC+1MhrYYF2Sbyc+/wvcx4CcINFEEnBG
         PH1ARNUUT8P62hXZ/1gHTf4O4h8uIrWiwjdWDcn1NXe89lbJ4FWRH0TanNjwpPikMZ
         pFTe8dju68oMQ==
Message-ID: <3cc683e7-28aa-7b6e-1499-3aca953294cc@collabora.com>
Date:   Tue, 16 May 2023 15:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/5] irqchip/gic-v3: Disable pseudo NMIs on Mediatek
 devices w/ firmware issues
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        wenst@chromium.org, yidilin@chromium.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, jwerner@chromium.org,
        Weiyi Lu <weiyi.lu@mediatek.com>, Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        linux-kernel@vger.kernel.org
References: <20230515131353.v2.cover@dianders>
 <20230515131353.v2.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230515131353.v2.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/05/23 22:13, Douglas Anderson ha scritto:
> Some Chromebooks with Mediatek SoCs have a problem where the firmware
> doesn't properly save/restore certain GICR registers. Newer
> Chromebooks should fix this issue and we may be able to do firmware
> updates for old Chromebooks. At the moment, the only known issue with
> these Chromebooks is that we can't enable "pseudo NMIs" since the
> priority register can be lost. Enabling "pseudo NMIs" on Chromebooks
> with the problematic firmware causes crashes and freezes.
> 
> Let's detect devices with this problem and then disable "pseudo NMIs"
> on them. We'll detect the problem by looking for the presence of the
> "mediatek,broken-save-restore-fw" property in the GIC device tree
> node. Any devices with fixed firmware will not have this property.
> 
> Our detection plan works because we never bake a Chromebook's device
> tree into firmware. Instead, device trees are always bundled with the
> kernel. We'll update the device trees of all affected Chromebooks and
> then we'll never enable "pseudo NMI" on a kernel that is bundled with
> old device trees. When a firmware update is shipped that fixes this
> issue it will know to patch the device tree to remove the property.
> 
> In order to make this work, the quick detection mechanism of the GICv3
> code is extended to be able to look for properties in addition to
> looking at "compatible".
> 
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I don't like firmware removing properties from my devicetrees and I'd like this
issue to get addressed in another way (use a scratch register? and check it in
Linux drivers to determine if the issue is not present: if scratch contains BIT(x),
do not parse the quirk) but that's a different discussion which is a bit out of
context for this patch, so:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

