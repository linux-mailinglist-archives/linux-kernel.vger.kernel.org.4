Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C93A613753
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiJaNEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJaNER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:04:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6F3C1A;
        Mon, 31 Oct 2022 06:04:17 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B0F56602387;
        Mon, 31 Oct 2022 13:04:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667221455;
        bh=KCHuPKTLk6qo9M9z3GXMITfWQ2pzzdfAl6BTM/gh23U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HARtKsnYnMqNlcc2dyu0BDzN6Tn9Qly7xXEr7TJsgYY5UkU0mjrrAm+8EgKFb/Vql
         15tAlieqx8x5nykmWEbmfahVnIfJdSriYITTAOga2OY3/5BD6Rcjit8fxYgjXbY5TN
         jwQe1zmVSPJjQpNO+P+D/mI2HPAU+olno+JWObU/uMVnjx/WOBrTpa72vXg4fnD7Y8
         YX2jvL7xqAnkgYmX8k5WvhNQaGdOjenJyU6ZXgW+JvlhXIPY7+icX/rvDdRV8vMRIF
         JF1Ucbn8QrbAL03Y/+ZsowkU/cklR31yGU4XZebbGgaJtEazIMdd/D+nvIUak+vIcD
         Il1AWdIG2gr9Q==
Message-ID: <01f6923c-87ce-b7eb-7f6c-649a84baf556@collabora.com>
Date:   Mon, 31 Oct 2022 14:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] mmc: mtk-sd: add Inline Crypto Engine support
Content-Language: en-US
To:     =?UTF-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?= 
        <Mengqi.Zhang@mediatek.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20221017142007.5408-1-mengqi.zhang@mediatek.com>
 <20221017142007.5408-2-mengqi.zhang@mediatek.com>
 <438bf06d-c4f4-74b2-8903-e89dc52196a7@collabora.com>
 <b557604932edfcd9847f0f033f410b7a68c704dc.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b557604932edfcd9847f0f033f410b7a68c704dc.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/10/22 10:50, Mengqi Zhang (张梦琦) ha scritto:
> On Tue, 2022-10-18 at 11:50 +0200, AngeloGioacchino Del Regno wrote:
>> Il 17/10/22 16:20, Mengqi Zhang ha scritto:
>>> add crypto clock control and ungate it before CQHCI init.
>>>
>>> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
>>
>> Hello Mengqi,
>> I'm a bit surprised that enabling ICE only requires enabling a clock
>> as
>> on downstream code I see some SMC calls to
>> MTK_SIP_KERNEL_HW_FDE_MSDC_CTL.
>>
>> Can you please explain why SMC calls are not needed here?
>>
>> Thanks,
>> Angelo
>>
> 
> Hi Angelo,
> 
> There are many wrong quotes in previous reply, let me fix it here.
> 
> In some MTK SoC, we need set a encrypto enable bit
> MTK_SIP_KERNEL_HW_FDE_MSDC_CTL in secure world, so we use SMC call to
> finish it.
> But not every MTK SoC need to set this bit in secure world. This patch
> is for these SoCs.
> As for SMC call, we haven't found a proper way to deal with it, we'll
> do it later.
> 

Thanks for clarifying.
In that case, I'm a little worried about people trying to enable ICE on SoCs
that do require calling into TZ and getting a crash... but it's anyway out of
scope for this series, so:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


