Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D908C71F13F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjFAR5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFAR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:57:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F761A6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:57:24 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4mXxqV4hJZvWO4mXxqrkEg; Thu, 01 Jun 2023 19:57:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685642237;
        bh=7vt9+fLVrJ0DcwYcq+OdF4MOQmmWuiozZXmgqPSyP9w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gaAu0HoiO+QyAxiOQKP1BGQtfBxDsExDWKFv/pCSfTswi3suLyp4hehNCsJ/IYNA3
         QRd9xIN3lFZ5Hx3jD2P/fMLcQZ/tCA5gW38G3WQTIH9Hq3ImmwQcLA+5Cu/eapwSPk
         ZmWmyQVIVw1HzA4efx2xUR1MGwImvTX0I807GB2gi4lunf5P7PwUv8nInUNPC50cC6
         uNjuq582gY1Hv1UqopuJ/Z4BNTKzRA14ktud2dFDNgLn0CCsm6YKmpp/bFdzDHAVct
         GYA6tk60qS2k9QWqzeTXZqjAmZ0JGuLxujS6ANiuETu+BnDEXeerlVv38k3P+fdxkK
         uiPwdXV7rtqbg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Jun 2023 19:57:17 +0200
X-ME-IP: 86.243.2.178
Message-ID: <f3aa01d9-7dc5-ded4-1a9a-07634afc0726@wanadoo.fr>
Date:   Thu, 1 Jun 2023 19:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: Use size_t for variable passed
 to kzalloc()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
References: <a311e4ae83406f714c9d1f7f2f857284265e581c.1685640591.git.christophe.jaillet@wanadoo.fr>
 <2720a80a-4496-0ba9-e545-046ed2529f7d@linux.intel.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <2720a80a-4496-0ba9-e545-046ed2529f7d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/06/2023 à 19:39, Pierre-Louis Bossart a écrit :
> 
> 
> On 6/1/23 12:30, Christophe JAILLET wrote:
>> struct_size() checks for overflow, but assigning its result to just a u32
>> may still overflow after a successful check.
>>
>> Use a size_t instead in order to be cleaner.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Based on analysis from Dan Carpenter on another patch (see [1]).
>>
>> [1]: https://lore.kernel.org/all/00e84595-e2c9-48ea-8737-18da34eaafbf@kili.mountain/
> 
> looks like there are similar cases of struct_size -> u32 conversions in
> other places:
> 
> struct snd_sof_control {
>      u32 size;	/* cdata size */
> 
> ipc3-topology.c:        scontrol->size = struct_size(cdata, chanv,
> scontrol->num_channels);
> ipc3-topology.c:        scontrol->size = struct_size(cdata, chanv,
> scontrol->num_channels);
> ipc4-topology.c:        scontrol->size = struct_size(control_data,
> chanv, scontrol->num_channels);

My coccinelle script does not handle such cases.

> 
> not sure how much of an issue this really is though?

I agree that in practice it should be safe as-is, but it can't hurt :).
I don't know this code well, but should [2] be part of the call chain, 
it is obvious that it CAN'T overflow.


I checked for places where such pattern occurs after Dan's comment on 
another patch. I'll see if I find better candidates.


CJ

[2]: 
https://elixir.bootlin.com/linux/v6.4-rc1/source/sound/soc/sof/topology.c#L1404

> 
>> ---
>>   sound/soc/sof/ipc4-topology.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
>> index db64e0cb8663..50faa4c88b97 100644
>> --- a/sound/soc/sof/ipc4-topology.c
>> +++ b/sound/soc/sof/ipc4-topology.c
>> @@ -881,7 +881,7 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
>>   	/* allocate memory for base config extension if needed */
>>   	if (process->init_config == SOF_IPC4_MODULE_INIT_CONFIG_TYPE_BASE_CFG_WITH_EXT) {
>>   		struct sof_ipc4_base_module_cfg_ext *base_cfg_ext;
>> -		u32 ext_size = struct_size(base_cfg_ext, pin_formats,
>> +		size_t ext_size = struct_size(base_cfg_ext, pin_formats,
>>   						swidget->num_input_pins + swidget->num_output_pins);
>>   
>>   		base_cfg_ext = kzalloc(ext_size, GFP_KERNEL);
> 

