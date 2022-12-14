Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7564C5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiLNJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiLNJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:23:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5FF2126C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671009744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJA8KaJmqguWsbBtP1OTbaZFHL8G72b0y+LC80FABnI=;
        b=CBsvzkQ8HIojl+hHOQFr4NU9PPhoRuAfjksVnfn+SQKn3ROE71B3Hqmdzx1PuDmk58uCyo
        aQizTVsUcqfSQYTCsfPxUbY0Tt0ViHiHSHqEii9yFlB/M9H7DOk2K+D+KTpyDQobDPH+xE
        Gt/rxNpDAvrO9TXxq6scj51122kC03I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-HllTniFxMRCGWDJW7mVh0g-1; Wed, 14 Dec 2022 04:22:23 -0500
X-MC-Unique: HllTniFxMRCGWDJW7mVh0g-1
Received: by mail-ej1-f69.google.com with SMTP id sh37-20020a1709076ea500b007c09b177cd1so10967101ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJA8KaJmqguWsbBtP1OTbaZFHL8G72b0y+LC80FABnI=;
        b=O/mRUa4GIWEBhjqjgg7CANecYxEloXeoDbkhKapwCr2YDcgZvGafazg8vG1El/I7/Y
         R8YvfgTAS7x0mYaD6dyQ6eVPeDe64VjfZgiDjlFx9O+pVawrZSLK1I/yV2GG5ZECGhmW
         aXWk07rB+teqWCosZqdmWZb/EA6+ARsBt+91a/hkqYSiHPZqXuI9fiLFy6SrnqZyGri7
         3yHrCM+KrVNsr3aGmhMMD3jQ76Bhee1WV8x2vNsG7isv2CGS6d+EjiKOTLe0PXB4yWGh
         Z+22wZHtjiz8CeyuSYEIXE/0iVwoyjYYq0vYw5y7Bzn3lehC3kLfc6oPrPLhfeLdrgmg
         ID6Q==
X-Gm-Message-State: ANoB5pmBVswQpa+acMNEGpmks0bcuhINHugEehoeOMQrw63eSkbd03d/
        7xmGEXXawVpGr6yVqLgwegG8KDTwRS8EW93Zr6OSPpwFwmEOXgKgQdnYUt9ewmF4HlP79f/kAbw
        RZxHA/Y1pki5HNXrnTLAsDofL
X-Received: by 2002:a17:907:c295:b0:78d:f455:c398 with SMTP id tk21-20020a170907c29500b0078df455c398mr8937696ejc.62.1671009742253;
        Wed, 14 Dec 2022 01:22:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf55pRMSkg7vndNUAyVDFqiXwmly2aKwf0IOJCjfqzW8uBYez/RUVRYofeA9A7gOSbPQnwSPCw==
X-Received: by 2002:a17:907:c295:b0:78d:f455:c398 with SMTP id tk21-20020a170907c29500b0078df455c398mr8937684ejc.62.1671009742098;
        Wed, 14 Dec 2022 01:22:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id bq19-20020a170906d0d300b007bf5250b515sm5580443ejb.29.2022.12.14.01.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:22:21 -0800 (PST)
Message-ID: <278b0d08-967d-527e-7d29-58126ef906d4@redhat.com>
Date:   Wed, 14 Dec 2022 10:22:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] Add HP Stream 8 to bytcr_rt5640.c
Content-Language: en-US, nl
To:     Moises Cardona <moisesmcardona@gmail.com>,
        cezary.rojewski@intel.com
Cc:     pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, oder_chiou@realtek.com, akihiko.odaki@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20221213173550.1567875-1-moisesmcardona@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221213173550.1567875-1-moisesmcardona@gmail.com>
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

Hello Moises,

On 12/13/22 18:35, Moises Cardona wrote:
> The HP Stream 8 tablet is identical to the HP Stream 7 in terms of the PCB,
> with the exception of the added SIM Card Slot. 
> Therefore, I'm submitting this patch which properly initializes the audio 
> and enables the headphone jack to work, just like it does in the 
> HP Stream 7.
> 
> Signed-off-by: Moises Cardona <moisesmcardona@gmail.com>

Thank you for your patch.

According to this review:

http://techlife101.com/hp-stream-8-review/

The Stream 8 has 2 speakers, so you should drop the
BYT_RT5640_MONO_SPEAKER part so that both speakers
will be used.

Regards,

Hans



> ---
>  sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index fb9d9e271845..1d964b1ceff4 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -796,6 +796,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>  					BYT_RT5640_SSP0_AIF1 |
>  					BYT_RT5640_MCLK_EN),
>  	},
> +	{	/* HP Stream 8 */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Stream 8 Tablet"),
> +		},
> +		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
> +					BYT_RT5640_MONO_SPEAKER |
> +					BYT_RT5640_JD_NOT_INV |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>  	{	/* I.T.Works TW891 */
>  		.matches = {
>  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),

