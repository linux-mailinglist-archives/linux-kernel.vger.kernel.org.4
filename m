Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1799D739777
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFVGaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVGaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:30:19 -0400
Received: from smtpng1.i.mail.ru (smtpng1.i.mail.ru [94.100.181.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FF6199B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=3FGTaC6K/NFfUNL8PLCH7DO8xw20xS+mYBro3gsoPbM=;
        t=1687415415;x=1687505415; 
        b=fHypRKstO2rU7xokQ9rrZqDkkd2bGCD2X3yTyM9fTbtyNgCEemciU9/J5SlfDSI9lMdAKKPkVh6yuB7hpxmccIriM9xLbwl8dF/hkl7Og1yaxSg7rhOjIyWhhag2o/KjrZp6lcuNqi1DBCMahyID3dsud+rSZ0XrM2KQFkZ88WMGGkasCYCRdrCwM9nsv96Qubi3ChO3KMWPuo+fyUvEaWWIfHwRAk4EC4hlg5s16GVwcGi53h1KVJ6lNYFdDWFRGSc3pTtbgxIUPQqhITtADP4lEatiw60+JknJsZvwrby/qEguhZJICyqYTAjpCPH+58gJlHQxI2zVVa35jVcyqg==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qCDpb-00005j-8u; Thu, 22 Jun 2023 09:30:12 +0300
Message-ID: <45c62cab-a779-e843-9f98-a0d14d2bc97b@inbox.ru>
Date:   Thu, 22 Jun 2023 09:30:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] ASoC: codecs: max98090: Allow dsp_a mode
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
References: <20230621115328.156457-1-fido_max@inbox.ru>
 <3805dc65-113f-453a-90a9-2ae6204004ba@sirena.org.uk>
 <e6be75f6-054f-6c3b-00b4-a5e112bcefc3@inbox.ru>
 <b763d08e-f751-480c-96b6-339a53856768@sirena.org.uk>
 <ed9606a4-4be6-7403-6e32-1c045ac0bdf6@inbox.ru>
 <adbe1b82-9478-4462-ace9-968723a6ce3f@sirena.org.uk>
 <0ada8334-4006-438f-8461-5c4c8e13f65d@inbox.ru>
 <c054b036-d5fd-482b-adc4-913edbcd007c@sirena.org.uk>
 <08fb24b9-ab7d-da27-5ab7-e1d3270c8b43@inbox.ru>
 <b83bf5c9-5998-4683-8f28-1eff432742ed@sirena.org.uk>
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <b83bf5c9-5998-4683-8f28-1eff432742ed@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtpng1.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDC5BACE53C59198470BA2B0E86AC3ED26E182A05F538085040D3F6310D864BF15DA0B26DB8FD81A6B9EC225F296CC7A0E3FF745A73D065D8BC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A3589DC202DD7369EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063745476ED688D943148638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D895CDFF3EE515D565BD09ED9F9360DF866F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE74F330F0740BBDD1F9FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18CB629EEF1311BF91D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B5F22DA640E95B789A471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C468D16C903838CAB43847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A53DE6B35F26F4283D711EDF93985658556150D91D5E08810DF87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B35CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34CC972AA0E2E780C476C1E509B6607834BDD63EDAF0E17BC297CBD7956EB80C8AD6D151E477532E2A1D7E09C32AA3244C29CA0A78F1CB1061C60AEDFAA0F3C17C8A6D4CC6FBFAC25140799AC538031D0DB6C6411D86935C892AB2189BCAD71E73D640157F23F2FFE137E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB41c+mu8Ac9iayBvkF8qCQ==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986BD96E781C3C62A48AF3162B3DCF41C84598CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.06.2023 23:46, Mark Brown wrote:
>> Ok. How about that:
>> ---
>>   sound/soc/codecs/max98090.c | 52 ++++++++++++++++++++-----------------
>>   sound/soc/codecs/max98090.h |  2 ++
>>   2 files changed, 30 insertions(+), 24 deletions(-)
> 
> That looks plausible, yes.
> 
> I do note that the driver ignores tdm_width (and the entire TDM
> configuration) when configuring BCLK, I guess it only works in clock
> consumer mode for TDM?  If that's the case there should really be some
> validation, and there should probably be a check for slot width being 16
> since that looks like the only thing supported.  Those were already
> broken though.

Yep, tdm_width is not used in the driver and I can drop it. We already 
have slot_width validation in set_tdm_slot(), so only 16 is allowed. I 
didn't check/use clock provider mode. But it looks fine for me. 
set_fmt() just sets frame width here: 32 - by default, 48/64 - 3/4 slots 
if configured. We also check slots count in set_tdm_slots(). It will 
work for I2S/TDM.
