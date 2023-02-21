Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8502569DBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjBUI2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjBUI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:28:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08900233EA;
        Tue, 21 Feb 2023 00:28:46 -0800 (PST)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35A9666021BD;
        Tue, 21 Feb 2023 08:28:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676968125;
        bh=qvlPvbGuS79LYZs3TMErx3YgQ/aZCqV4xqqYZO7kqnM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZcTrCmVC/tO+2g+9Z06OVyUlnLUbNCJzXA/O231hNqMjB/Vi0fUawgwSI8FLuJE8w
         qSqow9BjZNHGa1s8YmU7Z9alJbNaYnNUi9aarl8a9qymLFnIMLrh6Iv7pqYQKrBNtZ
         uqLZE66RmhLKOfCRf2yVwMK8p3zT59YeXW2rs6L9Ldpvau5FSv6gEcFO+g0tw08N6X
         ISPbZee+G46kMWTrnTelGhCF6A0JFfBxov+Ga9QULxoWLMVgETY5VtSSniLifJuuVo
         TB8d+HPSlt20XjOdDFOpTL1CyUdlley5f0N9hwUW1DHdJ7b3rffd1BryIHp8k+YQIo
         S+4vUh/HTkB6w==
Message-ID: <09bf8e07-6275-654f-4a70-d46b54e9b853@collabora.com>
Date:   Tue, 21 Feb 2023 08:28:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 3/4] ALSA: cs35l41: Add shared boost feature
To:     David Rhodes <drhodes@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230210091942.10866-1-lucas.tanure@collabora.com>
 <20230210091942.10866-4-lucas.tanure@collabora.com>
 <20230210134341.GF68926@ediswmail.ad.cirrus.com>
 <cfacc3d6-2daa-6aa3-ba19-281b7e48bb47@collabora.com>
 <20230211170638.GG68926@ediswmail.ad.cirrus.com>
 <1e3ef067-9b39-dc19-5fbc-75436c67f206@collabora.com>
 <d86d989b-0d82-74b3-a5da-9972324e9477@opensource.cirrus.com>
Content-Language: en-US
From:   Lucas Tanure <lucas.tanure@collabora.com>
In-Reply-To: <d86d989b-0d82-74b3-a5da-9972324e9477@opensource.cirrus.com>
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

On 20-02-2023 19:25, David Rhodes wrote:
> 
> On 2/12/23 03:28, Lucas Tanure wrote:
>> On 11-02-2023 17:06, Charles Keepax wrote:
>>> On Fri, Feb 10, 2023 at 02:39:56PM +0000, Lucas Tanure wrote:
>>>> On 10-02-2023 13:43, Charles Keepax wrote:
>>>>> On Fri, Feb 10, 2023 at 09:19:41AM +0000, Lucas Tanure wrote:
>>>>>> + {CS35L41_MDSYNC_EN,        0x00001000},
>>>>> David's internal patch appears to set 0x3000 on the active side,
>>>>> not sure where that difference snuck in, or which is the correct
>>>>> value. Your settings appear to make logical sense to me though, TX
>>>>> on the active side, RX on the passive side.
>>>> And as the patch sets TX and RX in the same chip I changed to follow
>>>> the documentation.
>>>
>>> Yeah I mean I suspect this is sensible, unless there is some
>>> reason the controller side also needs to have RX enabled. Perhaps
>>> for feedback or something from the passive side, but I imagine
>>> this is just a typo in the original patch.
>>
>> Ok, but the other side doesn't have both RX and TX enabled.
>> If the active side needed RX to receive information for the other 
>> side, the passive one would need TX enabled too.
>> So if a feedback is necessary, both channels on both sides would be 
>> enabled, not one channel in one side and both on the other.
>>
> Both amps need to transmit their boost targets to the MDSYNC bus. The 
> active amp needs to receive the combined boost target from the MDSYNC 
> bus. That is why the active amp should enable both RX and TX, and the 
> passive amp only needs to enable TX. It is not simply a unidirectional 
> flow of data from one amp to the other.
> 
> Sorry if the documentation has been mismatched or confusing at times. 
> It's taken me a while to gather the right understanding of how this all 
> works.
> 
> 
> On 2/10/23 03:19, Lucas Tanure wrote:
>> +      Shared boost allows two amplifiers to share a single boost circuit by
>> +      communicating on the MDSYNC bus. The passive amplifier does not control
>> +      the boost and receives data from the active amplifier. GPIO1 should be
> 
> Not quite correct. I would suggest: "Shared boost allows two amplifiers 
> to share a single boost circuit by communicating on the MDSYNC bus. The 
> active amplifier controls the boost circuit using combined data from 
> both amplifiers."
Ok

> 
> 
> On 2/10/23 08:39, Lucas Tanure wrote:
>>
>> This write here is to select the boost control source, which for the 
>> active should be "Class H tracking value". 
> 
> Active should use the MDSYNC value. Otherwise it will not provide boost 
> to the passive amp when there is only audio on the passive amp's channel.
David can you confirm that both sides should use MDSYNC for boost 
control source?


> 
> 
> I believe there is another change needed for the Deck, to handle the 
> 'legacy' property names instead of bst-type?
I am working with valve to update their bios.

> 
> Other than the changes needed to the reg_sequences this looks good.
> 
> 
> Thanks,
> 
> David
> 

