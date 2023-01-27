Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C8067EB0F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjA0QmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjA0Ql6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:41:58 -0500
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E697CC89
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:41:56 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 664B911E4;
        Fri, 27 Jan 2023 17:41:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 664B911E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1674837714; bh=72VCcJJxXXJ2bRu6xheDpCpxeIDPr4x7r7Bh9fqdkxo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qsE7WeDhAIYITdqIx4QhUbq4ukEd81gGTxkWg1gHEcz+MM2p8mXAQfT8rrss4d7h9
         il6oXy/w1cphUQ2yixydix3aek4tCPlzUOzZcVYBqmDVH1MupuJH8ydK42YwtKOcmH
         VHRs/5VZvRdjtNQ0qJtzKkbmKhBKAP/TLElU0uOw=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Fri, 27 Jan 2023 17:41:44 +0100 (CET)
Message-ID: <e9733e9a-ac70-846f-c3a2-f96a6787b9bc@perex.cz>
Date:   Fri, 27 Jan 2023 17:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/6] ASoC: amd: yc: Add a module parameter to influence
 pdm_gain
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20230127160134.2658-1-mario.limonciello@amd.com>
 <20230127160134.2658-3-mario.limonciello@amd.com>
 <2e9f4301-0211-04f5-5b38-caf2be9f4fd1@perex.cz>
 <MN0PR12MB61014C004C798F7DE8682AAFE2CC9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <MN0PR12MB61014C004C798F7DE8682AAFE2CC9@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 01. 23 17:25, Limonciello, Mario wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Jaroslav Kysela <perex@perex.cz>
>> Sent: Friday, January 27, 2023 10:23
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mukunda, Vijendar
>> <Vijendar.Mukunda@amd.com>; Saba Kareem, Syed
>> <Syed.SabaKareem@amd.com>; linux-kernel@vger.kernel.org
>> Cc: Pananchikkal, Renjith <Renjith.Pananchikkal@amd.com>; Mark Pearson
>> <mpearson@lenovo.com>; Liam Girdwood <lgirdwood@gmail.com>; Mark
>> Brown <broonie@kernel.org>; Takashi Iwai <tiwai@suse.com>; alsa-
>> devel@alsa-project.org
>> Subject: Re: [PATCH 2/6] ASoC: amd: yc: Add a module parameter to
>> influence pdm_gain
>>
>> On 27. 01. 23 17:01, Mario Limonciello wrote:
>>> In case of regressions for any users that the new pdm_gain value is
>>> too high and for additional debugging, introduce a module parameter
>>> that would let them configure it.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>    sound/soc/amd/yc/acp6x-pdm-dma.c | 7 ++++++-
>>>    sound/soc/amd/yc/acp6x.h         | 2 +-
>>>    2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> ...
>>
>>>    	pdm_ctrl = acp6x_readl(acp_base + ACP_WOV_MISC_CTRL);
>>> -	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
>>> +	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, pdm_gain);
>>
>> The bits should be zeroed (AND - &) before OR to make sure that the correct
>> value is written to the register. More related patches are affected.
> 
> I had consider this, but the hardware default at reset is 0x0.  Do you think it's
> still necessary for posterity?

You're using 0644 permissions for the module parameter, so the value can be 
changed by root using sysfs anytime (between SNDRV_PCM_TRIGGER calls).

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

