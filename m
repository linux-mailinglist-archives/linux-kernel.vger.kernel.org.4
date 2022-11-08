Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A022C62183F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiKHP27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiKHP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:28:58 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E999617A;
        Tue,  8 Nov 2022 07:28:56 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D8AE184F72;
        Tue,  8 Nov 2022 16:28:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667921334;
        bh=ynxbc+MKCLeWwRbrLNxyC55qaclB4jtg/aYQ5o2Qus0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Vj5vX/8z6GAYG4Gbp9pE6bV2u66FuorO5FcT4mzj/Y+t6tVekBYjMjMlEpnypjGi0
         hQTkJCcz+q6IWhDARns9vzfBSrZCsbrvyzPzyjC1gNKvms3/yaVldzCFhCptVlCWOD
         Fa/1M//h1HT6/pFzgEZRynlSV8EiDnH67mXd0j7NYyO/SYyGvG34wSLHeNzwnlaJPm
         3KssiGAfo3W2XeL4dMV93PMD50h6wEwzIzlDzR2jk33Sbmz4QnRrV1E3GlHzxPJhfy
         qdQCJV/8GbCRjZcheSTR74okbWjEv6dKZPD/2F+yLOf8KGKZVt0fnsOaCSGANPX86f
         cjgcqZmRJa4lA==
Message-ID: <230c26ea-f7c5-2688-16fd-e4a91f421833@denx.de>
Date:   Tue, 8 Nov 2022 16:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 00/16] STM32 configure UART nodes for DMA
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Erwan LE RAY <erwan.leray@foss.st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Amelie DELAUNAY <amelie.delaunay@st.com>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
 <cc7633c5-de5f-0abf-4ac8-64a74633dfcc@pengutronix.de>
 <f5aec360-c33c-0145-6596-541003e305b2@foss.st.com>
 <98823363-710c-6286-8e63-ba8e5dcadeba@foss.st.com>
 <20221108115916.hlmbvyrnmkxymeed@pengutronix.de>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221108115916.hlmbvyrnmkxymeed@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/22 12:59, Uwe Kleine-König wrote:
> On Fri, Feb 04, 2022 at 04:41:55PM +0100, Erwan LE RAY wrote:
>> On 2/4/22 2:22 PM, Alexandre TORGUE wrote:
>>> Hi Ahmad
>>>
>>> On 2/3/22 18:25, Ahmad Fatoum wrote:
>>>> Hello Erwan,
>>>>
>>>> On 03.02.22 18:10, Erwan Le Ray wrote:
>>>>> Add DMA configuration to UART nodes in stm32mp15x (SOC level) and
>>>>> remove it at board level to keep current PIO behavior when needed.
>>>>> For stm32-ed1 and stm32-dkx boards, UART4 (console) and UART7
>>>>> (no HW flow control pin available) are kept in PIO mode, while USART3
>>>>> is now configured in DMA mode.
>>>>> UART4 (console UART) has to be kept in irq mode, as DMA support for
>>>>> console has been removed from the driver by commit e359b4411c28
>>>>> ("serial: stm32: fix threaded interrupt handling").
>>>>
>>>> Do I understand correctly that your first patch breaks consoles of
>>>> most/all boards, because they will briefly use DMA, which is refused
>>>> by the stm32-usart driver and then you add a patch for each board
>>>> to fix that breakage?
>>>
>>> We have two solutions and both have pro/drawbacks. The first one (Erwan
>>> ones, can break the boot if the patch is taken "alone". Your proposition
>>> avoids this breakage but deletes a non define property (which is a bit
>>> weird). However I prefer to keep a functional behavior, and keep Ahmad
>>> proposition. Ahmad, just one question, dt-bindings check doesn't
>>> complain about it ?
>>>
>>> Cheers
>>> Alex
>>>
>>>>
>>>> Such intermittent breakage makes bisection a hassle. /delete-property/
>>>> is a no-op when the property doesn't exist, so you could move the first
>>>> patch to the very end to avoid intermittent breakage.
>>>>
>>>> I also think that the driver's behavior is a bit harsh. I think it would
>>>> be better for the UART driver to print a warning and fall back to
>>>> PIO for console instead of outright refusing and rendering the system
>>>> silent. That's not mutually exclusive with your patch series here,
>>>> of course.
>>>>
>>>> Cheers,
>>>> Ahmad
>>>>
>>
>> The driver implementation will consider the request to probe the UART
>> console in DMA mode as an error (-ENODEV), and will fallback this UART probe
>> in irq mode.
> 
>> Whatever the patch ordering, the boot will never be broken. The board dt
>> patches aim to get a "proper" implementation, but from functional
>> perspective the driver will manage a request to probe an UART console in DMA
>> mode as an error and fall it back in irq mode.
> 
> I didn't debug this further yet, but my machine (with an out-of-tree
> dts) fails to boot 6.1-rc4 without removing the dma properties from the
> console UART. This is a bug isn't it? The same dts created a working
> setup with stm32mp157.dtsi from 5.15 + kernel 5.15.
> 
> I can debug this further, but maybe you know off-hand what the problem
> is?

+CC Amelie, as this might be related to the DMA series that landed recently:

$ git log --oneline v5.18..v6.0 -- drivers/dma/stm32*
