Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534FD734C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFSHpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSHpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:45:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5BB1;
        Mon, 19 Jun 2023 00:45:30 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E859E6606EAC;
        Mon, 19 Jun 2023 08:45:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687160729;
        bh=PUG5piy46+BtYUKqIE057P4sOhXAzTDm9lhm1PwoWoY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GGqRtKhW4JTknQ5gxd+v4wckj01dUHFUW/D+sKxscKEtYmWQbkXiunIs2qh+v+Zhd
         dcuWE4vDEjQjJaelk+7IgREEp2ZFdhfqTZtVJHgk5ClzG7Jvel9Uhh8xg9Q/edK9XA
         mEYgdCxOjqpyA7XFmmsXn+z26lg6lrRQkDEoVrCKWo0aJm5F4CBP4Gpr3BzGKSR1Db
         Wm1aFnS9KerDDF+f82XQAJoEbvHOzZw6jJIgYFL2fDzYd3QMM4YEtBWoOHquj8dtCE
         KbLlNwPdhdPdHwdbXyNM0+lLgm+qQbLvDA5iPXpPTe3Oog1hy1F9XSBQBjuFuX/2rJ
         4j+X8ySOP18nA==
Message-ID: <4736dabb-8585-3906-d6f1-165eff96eb26@collabora.com>
Date:   Mon, 19 Jun 2023 09:45:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] media: mediatek: vcodec: Read HW active status
 from clock
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230607205714.510012-1-nfraprado@collabora.com>
 <20230607205714.510012-4-nfraprado@collabora.com>
 <CAGXv+5HHARvkCYfjPjRKgyWuzv-Dt215z1=yA+_tw4hyasdGQA@mail.gmail.com>
 <f0018817-d47b-d772-ed9f-9126bf71a0d1@collabora.com>
 <83770481aa762b69738c27f9d9934dd9.sboyd@kernel.org>
 <90781ea3-d43a-6267-278c-184050fe456e@collabora.com>
 <d579dc00ed9877f9daf170134fe781e6.sboyd@kernel.org>
 <d2c11880-afc1-5c0b-229b-2a4080b22fba@collabora.com>
 <d97a0c8e7aeb4216b361839bc3c9bd54.sboyd@kernel.org>
 <76a641e6-64ef-a973-422c-de50d498e52f@collabora.com>
 <eee9a51a9fbe44f028ef33cd92c18a51.sboyd@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <eee9a51a9fbe44f028ef33cd92c18a51.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/06/23 19:40, Stephen Boyd ha scritto:
> Quoting AngeloGioacchino Del Regno (2023-06-15 00:30:56)
>> Il 15/06/23 02:40, Stephen Boyd ha scritto:
>>> Quoting AngeloGioacchino Del Regno (2023-06-14 01:13:43)
>>>> Il 12/06/23 21:19, Stephen Boyd ha scritto:
>>>>> Quoting AngeloGioacchino Del Regno (2023-06-09 00:42:13)
>>>>>> Il 09/06/23 01:56, Stephen Boyd ha scritto:
>>>>>>> Quoting AngeloGioacchino Del Regno (2023-06-08 02:01:58)
>>>>>>>> Il 08/06/23 10:12, Chen-Yu Tsai ha scritto:
>>>>>>>>> On Thu, Jun 8, 2023 at 4:57 AM Nícolas F. R. A. Prado
>>>>>>>>> <nfraprado@collabora.com> wrote:
>>>>>>
>>>>>> The firmware gives an indication of "boot done", but that's for the "core" part
>>>>>> of the vcodec... then it manages this clock internally to enable/disable the
>>>>>> "compute" IP of the decoder.
>>>>>>
>>>>>> As far as I know (and I've been researching about this) the firmware will not
>>>>>> give any "decoder powered, clocked - ready to get data" indication, and the
>>>>>> only way that we have to judge whether it is in this specific state or not is
>>>>>> to check if the "VDEC_ACTIVE" clock got enabled by the firmware.
>>>>>
>>>>> Is Linux ever going to use clk consumer APIs like clk_enable/clk_disable
>>>>> on this VDEC_ACTIVE clk? If the answer is no, then there isn't any
>>>>> reason to put it in the clk framework, and probably syscon is the way to
>>>>> go for now.
>>>>>
>>>>
>>>> Not for the current platform, but that may change in future SoCs... we're not sure.
>>>
>>> If you're not using the clk consumer APIs then it shouldn't be a clk.
>>>
>>>>
>>>>> Another approach could be to wait for some amount of time after telling
>>>>> firmware to power up and assume the hardware is active.
>>>>>
>>>>
>>>> That would be highly error prone though. Expecting that the HW is alive means that
>>>> we're 100% sure that both firmware and driver are doing the right thing at every
>>>> moment, which is something that we'd like to assume but, realistically, for safety
>>>> reasons we just don't.
>>>>
>>>> Should we anyway go for a syscon *now* and then change it to a clock later, if any
>>>> new platform needs this as a clock?
>>>
>>> Yeah. Or implement this as a power domain and have it read the register
>>> directly waiting to return from the power_on()?
>>
>> A power domain would force us to incorrectly describe the hardware in the bindings
>> though, I think... so, Nícolas, please, let's go for a syscon at this point, as it
> 
> You don't have to add the power domain in DT, do you? You can populate a
> power domain in software directly?
> 

Right. I didn't evaluate that possibility at all. Looks good!

>> really looks like being the only viable option.
>>
>> Stephen, many thanks for the valuable suggestions and the nice conversation.
>>
> 

