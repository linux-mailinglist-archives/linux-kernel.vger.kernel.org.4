Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D86520F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiLTMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLTMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:49:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9663420C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:49:19 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C12FC6602CAA;
        Tue, 20 Dec 2022 12:49:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671540558;
        bh=uGXlE36mRq/BYyoqodZ5pF44kBFR2pVAybg3QahvF7w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XViJ7ZV5NaLQlEGP8eaRIxYWLWtxf9gx24I/KKI7E04Ml0BoaLyPIc9cuERX1rvEl
         rISkZ1FATOKl2h4S36BBSDK5kYXakBZGizsfZwm3ixB86Xyxw/c4E6Ogw5hV+mRGPd
         KmiIQ/fIcx/q7PA8xu6lHjd4qMvmRvtztS1jsX57wLEV3puU6+EapWtXjk6/CimwgZ
         5FTvewz6h6VC+fAHTG0Xy1kVz2R8ShnQyAMgmtlmh5PtbiOsr4NKmOlFNQWklb7ox2
         cvkNPao1/LBEVKh/botVicByQ+E4yqU/i5rmvmn41kMV/1cwhRKQKRRTMw9CySuZTu
         FcETm8w4a2USQ==
Message-ID: <068c2537-2563-9e81-e92d-f1fa18a0206b@collabora.com>
Date:   Tue, 20 Dec 2022 13:49:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Enable the IRQ later
Content-Language: en-US
To:     =?UTF-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ribalda@chromium.org" <ribalda@chromium.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
References: <20221127-mtk-svs-v1-0-7a5819595838@chromium.org>
 <d683a2e7-b886-9bf6-27df-d8c67cedbbdd@collabora.com>
 <b8b14bcb-845f-aa18-f8aa-ad0bed9fb0bb@gmail.com>
 <52fb6ccf3fe1cb11f3e330ecc4d9c6cf1225c98a.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <52fb6ccf3fe1cb11f3e330ecc4d9c6cf1225c98a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/12/22 12:03, Roger Lu (陸瑞傑) ha scritto:
> Hi Matthias Sir,
> 
> After applying this patch, SVS probes fail as below on my MT8192 platform. If
> thing isn't too late, please do not merge this patch. I'll ask Ricardo how to
> reproduce this issue and give the correct solution. Thanks in advance.
> 
> #MT8192 platform SVS probe fail log
> [   10.209430]  SVSB_GPU_LOW: init02 completion timeout
> [   10.214402] mtk-svs 1100b000.svs: svs start fail: -16
> [   10.219479] mtk-svs: probe of 1100b000.svs failed with error -16
> 
> Hi Ricardo,
> 
> Could you share us how you reproduce this issue? I have MT8192 Chromebook and
> can give it a try to reproduce the issue you encountered. Thanks a lot.
> 

Boot a kernel with Kexec to reproduce.

Regards,
Angelo

> Sincerely,
> Roger Lu.
> 
> On Fri, 2022-12-16 at 13:47 +0100, Matthias Brugger wrote:
>>
>> On 30/11/2022 12:00, AngeloGioacchino Del Regno wrote:
>>> Il 27/11/22 21:22, Ricardo Ribalda ha scritto:
>>>> If the system does not come from reset (like when is booted via
>>>> kexec()), the peripheral might triger an IRQ before the data structures
>>>> are initialised.
>>>>
>>>> Fixes:
>>>>
>>>> [    0.227710] Unable to handle kernel NULL pointer dereference at
>>>> virtual
>>>> address 0000000000000f08
>>>> [    0.227913] Call trace:
>>>> [    0.227918]  svs_isr+0x8c/0x538
>>>>
>>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>>
>>> Reviewed-by: AngeloGioacchino Del Regno <
>>> angelogioacchino.delregno@collabora.com>
>>>
>>>
>>
>> Applied thanks!
>>


