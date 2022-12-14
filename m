Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC464CD36
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbiLNPnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:43:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D48222BF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671032558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQzHZwjuXupiqlJusdYzgBRFmDan+a9C8lcInQhXBVM=;
        b=L9rdWYUuWyAsojbfDi2YyoSIYOuWD2M4eF0FmJT9j+lOvLScZgJTL3MC6gBs7CkajxiFGE
        irA/zI85sEfojX3DwPKyP2x+z6ddlYOUNFhm3CzwSEujWuYGjci9+3ncAgegbKJeBK24QJ
        vjvfGcpamdWpaJEfDoKfibuz1gg3Lg4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-2sPc03NbMbiTOBQqW-HvXw-1; Wed, 14 Dec 2022 10:42:37 -0500
X-MC-Unique: 2sPc03NbMbiTOBQqW-HvXw-1
Received: by mail-ed1-f71.google.com with SMTP id x20-20020a05640226d400b0046cbe2b85caso9710029edd.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQzHZwjuXupiqlJusdYzgBRFmDan+a9C8lcInQhXBVM=;
        b=ITOQc7aEToxwof0HISYm8mXJKcUOi7eiZ2j32IzrzevvRZDcK6qewDmS1cM+18YKLQ
         MkR4mejPCXDJKBOpxjpAvsXDPZjfdHz59PfhMUxX+2rBHd+sKnjWMelj67y0kBpljRl2
         nGJrbS5MAWPif6DVEgx60RPe+PKegouk6IZjqXd08ECJxD1keaROjaUe/Taj8jcFI0n0
         u7xMmJMYbhzMEYKsvvjy24FFc5ujlLhmc/XtI5gjOGmclAMiezVKuw2GkzP5NHzuKCU+
         0Btjh3B4SykG35RNDUuBPOU2m3iNS5dNm5YA5JuMWT1YJNbGTu9iNAm1s3qDjNJWCCff
         Jfqw==
X-Gm-Message-State: ANoB5pmpnlsjPMOd08eWDJtdCX1+AeFI+cq+/4OY1JIV6pd4ZuWYnx78
        UkWbkKx2EBZWze8JLZ1nr56BNz5Lb2j+GAThCnZcAjmpLlPNkKpUYmYZtenaEHOsOvnkoVzod1I
        Uig8XeScUTzJoBefK9mLH8gWz
X-Received: by 2002:a17:907:90d8:b0:7c0:e302:b523 with SMTP id gk24-20020a17090790d800b007c0e302b523mr16515543ejb.59.1671032556383;
        Wed, 14 Dec 2022 07:42:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf63c7L8UGtfrL6TE+DGeYWq+KxeHIlGEceOMBDac035oAfK6UfailMlLf0IPYbKTOyjFxbIWg==
X-Received: by 2002:a17:907:90d8:b0:7c0:e302:b523 with SMTP id gk24-20020a17090790d800b007c0e302b523mr16515530ejb.59.1671032556231;
        Wed, 14 Dec 2022 07:42:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090676ca00b007c4ed5ced79sm888756ejn.73.2022.12.14.07.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 07:42:35 -0800 (PST)
Message-ID: <92358ff1-86ca-76b0-c4f3-3d4e0dddc80a@redhat.com>
Date:   Wed, 14 Dec 2022 16:42:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] Add HP Stream 8 to bytcr_rt5640.c
Content-Language: en-US, nl
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Moises Cardona <moisesmcardona@gmail.com>,
        cezary.rojewski@intel.com
Cc:     liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, oder_chiou@realtek.com, akihiko.odaki@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20221213173550.1567875-1-moisesmcardona@gmail.com>
 <08403fff-359b-b5f4-d039-18eeef660637@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <08403fff-359b-b5f4-d039-18eeef660637@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/13/22 20:04, Pierre-Louis Bossart wrote:
> 
> 
> On 12/13/22 11:35, Moises Cardona wrote:
>> The HP Stream 8 tablet is identical to the HP Stream 7 in terms of the PCB,
>> with the exception of the added SIM Card Slot. 
>> Therefore, I'm submitting this patch which properly initializes the audio 
>> and enables the headphone jack to work, just like it does in the 
>> HP Stream 7.
>>
>> Signed-off-by: Moises Cardona <moisesmcardona@gmail.com>
> 
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Note this is the old version which wrongly contains the
BYT_RT5640_MONO_SPEAKER flag.

Mark, please merge the new version (which unfortunately
was not marked as v2) which correctly drops
the BYT_RT5640_MONO_SPEAKER flag.

(this tablet has 2 speakers so it should not have the mono flag)

Regards,

Hans


> 
>> ---
>>  sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
>> index fb9d9e271845..1d964b1ceff4 100644
>> --- a/sound/soc/intel/boards/bytcr_rt5640.c
>> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
>> @@ -796,6 +796,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>>  					BYT_RT5640_SSP0_AIF1 |
>>  					BYT_RT5640_MCLK_EN),
>>  	},
>> +	{	/* HP Stream 8 */
>> +		.matches = {
>> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Stream 8 Tablet"),
>> +		},
>> +		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
>> +					BYT_RT5640_MONO_SPEAKER |
>> +					BYT_RT5640_JD_NOT_INV |
>> +					BYT_RT5640_SSP0_AIF1 |
>> +					BYT_RT5640_MCLK_EN),
>> +	},
>>  	{	/* I.T.Works TW891 */
>>  		.matches = {
>>  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
> 

