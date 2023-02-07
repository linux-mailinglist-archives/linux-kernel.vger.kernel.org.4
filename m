Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70268DE06
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjBGQes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjBGQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:34:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077536448;
        Tue,  7 Feb 2023 08:34:45 -0800 (PST)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 37CA1660208D;
        Tue,  7 Feb 2023 16:34:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675787684;
        bh=Ju9beePp7bAYEhek0mXetGx1R+Zbuu/Si/5uQYOpoYQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=edQKC4NEPBgk6xe98pLs1bQKH/mVHP9YXgIKmxRpaFkpenX2o/OQ+p83JRoc98JIu
         s5vkVGN/Q3Tj2Or/cTy3yxAjr10QlhINvyc333vtYnB+y3Z03j7M4sXTRDKyRSzUVv
         aDl6VlVamlv+1h1kaKIG3iQ6WuDLUB+HFyMuKki0rCv1/uYtizueGxxXRamCI1/6gO
         hP+dQq9wfMXVMCXavKYoqjuNhUlyqAMuQunVAjhnIBanTd/hpxLc0jIYcElCHEHib8
         ZWl2KyMZDKnwX/WX6495BOgPIhDt+1fAtjnQVrZNkwwaRB81ApYUv/r14QG5jwblfb
         6qDOxL8gzupbw==
Message-ID: <4efe9796-6d3e-09d1-d5f7-cfb25a439061@collabora.com>
Date:   Tue, 7 Feb 2023 16:34:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] Documentation: cs35l41: Shared boost properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230207104021.2842-1-lucas.tanure@collabora.com>
 <20230207104021.2842-3-lucas.tanure@collabora.com>
 <44faeca1-94c9-4423-d87a-03d80e286812@linaro.org>
 <e7257f9a-86c5-74e8-c538-6f6d2ba13274@collabora.com>
 <44c7274f-8a5e-0235-413a-6c3260018601@linaro.org>
From:   Lucas Tanure <lucas.tanure@collabora.com>
In-Reply-To: <44c7274f-8a5e-0235-413a-6c3260018601@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-2023 16:13, Krzysztof Kozlowski wrote:
> On 07/02/2023 16:46, Lucas Tanure wrote:
>>>> +      Shared boost allows two amplifiers to share a single boost circuit by
>>>> +      communicating on the MDSYNC bus. The passive amplifier does not control
>>>> +      the boost and receives data from the active amplifier. GPIO1 should be
>>>> +      configured for Sync when shared boost is used. Shared boost is not
>>>> +      compatible with External boost. Active amplifier requires
>>>> +      boost-peak-milliamp, boost-ind-nanohenry and boost-cap-microfarad.
>>>>          0 = Internal Boost
>>>>          1 = External Boost
>>>> +      2 = Reserved
>>>
>>> How binding can be reserved? For what and why? Drop. 2 is shared active,
>>> 3 is shared passive.
>> 2 Is shared boost without VSPK switch, a mode not supported for new
>> system designs. But there is laptops using it, so we need to keep
>> supporting in the driver.
> 
> That's not the answer. 2 is nothing here, so it cannot be reserved.
> Aren't you mixing now some register value with bindings?
> 
> Best regards,
> Krzysztof
> 
> 
I have added a new patch with propper documentation.
And I would like to use 3 and 4 for shared boost as 
CS35L41_EXT_BOOST_NO_VSPK_SWITCH already exist as 2 and is used in the 
current driver.
The laptop that uses CS35L41_EXT_BOOST_NO_VSPK_SWITCH doesn't have the 
property "cirrus,boost-type", but to make everything consistent I would 
prefer to use 3 and 4 for the new boost types.
Is that ok with you?

Thanks
Lucas
