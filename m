Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA7733E29
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjFQFIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjFQFIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:08:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059CC19BB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 22:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7hf5/V1+7qv/OVN9FVB5EfsnRiw5saIpK4oYVVac1Aw=; b=sbKTvkdWKTASdSCVFWD6nn16dc
        CHkSGhjkW+NujzLO1cALnOJGX6AJ7GK3XjCKihAUMDhJAStz9m6kmysroB5uoBlG0RwIzcwJXimuT
        D7lpogjh9SsgtzLK6sT1ATw2xz1gdZoeDI5pewZZJqVDZV0ruqWEYkXdAIqqiwe0Vh3rCTF82kzj4
        P/9bt6H8rayv2wKfCVuEsHmmnN+mPuevsVmnLJCej/op3kGH+yVeVGyEKyuSeWDGDjlrPLhH7F4rn
        AKA3AkQM/paqDt7sw26TkTdFi9K8yVZlg/0CUA2s81NOXrcWYa4dIS4UsRKnV16guTrS0Yo4/m5SH
        3i7Q/lxA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qAOB2-002kjp-2b;
        Sat, 17 Jun 2023 05:08:44 +0000
Message-ID: <20042da0-3b00-5c33-6f22-23b48a1f236c@infradead.org>
Date:   Fri, 16 Jun 2023 22:08:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 RESEND] ASoC: fsl MPC52xx drivers require PPC_BESTCOMM
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
References: <20230521225702.1608-1-rdunlap@infradead.org>
 <71922379-ee3d-9d6d-33dd-edcf8ef7508e@infradead.org>
In-Reply-To: <71922379-ee3d-9d6d-33dd-edcf8ef7508e@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Liam,

On 5/30/23 16:38, Randy Dunlap wrote:
> Hello maintainers,
> 
> I am still seeing these build errors on linux-next-20230530.
> 
> Is there a problem with the patch?
> Thanks.
> 

I am still seeing build errors on linux-next-20230615.

Is there a problem with the patch?

Can it be applied/merged?

Thanks.

> On 5/21/23 15:57, Randy Dunlap wrote:
>> Both SND_MPC52xx_SOC_PCM030 and SND_MPC52xx_SOC_EFIKA select
>> SND_SOC_MPC5200_AC97. The latter symbol depends on PPC_BESTCOMM,
>> so the 2 former symbols should also depend on PPC_BESTCOMM since
>> "select" does not follow any dependency chains.
>>
>> This prevents a kconfig warning and build errors:
>>
>> WARNING: unmet direct dependencies detected for SND_SOC_MPC5200_AC97
>>   Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_MPC52xx [=y] && PPC_BESTCOMM [=n]
>>   Selected by [m]:
>>   - SND_MPC52xx_SOC_PCM030 [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_MPC5200_SIMPLE [=y]
>>   - SND_MPC52xx_SOC_EFIKA [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_EFIKA [=y]
>>
>> ERROR: modpost: "mpc5200_audio_dma_destroy" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
>> ERROR: modpost: "mpc5200_audio_dma_create" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
>>
>> Fixes: 40d9ec14e7e1 ("ASoC: remove BROKEN from Efika and pcm030 fabric drivers")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Liam Girdwood <lgirdwood@gmail.com>
>> Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
>> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
>> Cc: alsa-devel@alsa-project.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> ---
>> v2: use correct email address for Mark Brown.
>>
>>  sound/soc/fsl/Kconfig |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff -- a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
>> --- a/sound/soc/fsl/Kconfig
>> +++ b/sound/soc/fsl/Kconfig
>> @@ -243,7 +243,7 @@ config SND_SOC_MPC5200_AC97
>>  
>>  config SND_MPC52xx_SOC_PCM030
>>  	tristate "SoC AC97 Audio support for Phytec pcm030 and WM9712"
>> -	depends on PPC_MPC5200_SIMPLE
>> +	depends on PPC_MPC5200_SIMPLE && PPC_BESTCOMM
>>  	select SND_SOC_MPC5200_AC97
>>  	select SND_SOC_WM9712
>>  	help
>> @@ -252,7 +252,7 @@ config SND_MPC52xx_SOC_PCM030
>>  
>>  config SND_MPC52xx_SOC_EFIKA
>>  	tristate "SoC AC97 Audio support for bbplan Efika and STAC9766"
>> -	depends on PPC_EFIKA
>> +	depends on PPC_EFIKA && PPC_BESTCOMM
>>  	select SND_SOC_MPC5200_AC97
>>  	select SND_SOC_STAC9766
>>  	help
> 

-- 
~Randy
