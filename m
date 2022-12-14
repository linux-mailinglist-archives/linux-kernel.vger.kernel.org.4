Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC5B64CD33
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiLNPl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiLNPly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:41:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5757C2188B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671032471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XBd4ptJNbvgrkzTUuMXLg7l6NQuSyxEYYBB50Aa96E=;
        b=e19hr7O5n67jOtDOJo8eKq1JIcgrz15tFbAtV7vrKsjerPBZZbue5Kgrtaa0w0VvIKx3sc
        xPO+wLdXAEsEmky4iY649sqF5at0eFLY7PhrWYB+lvJ+qE10D6lK0JsWvBmUya4ZRAau0p
        X5MU6Mu/wZHdUmCwWztkzbRYDzqRsoE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-401-hV3i7dkyNdSUs6PrOxBSMA-1; Wed, 14 Dec 2022 10:41:09 -0500
X-MC-Unique: hV3i7dkyNdSUs6PrOxBSMA-1
Received: by mail-ej1-f70.google.com with SMTP id sg39-20020a170907a42700b007c19b10a747so2419593ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XBd4ptJNbvgrkzTUuMXLg7l6NQuSyxEYYBB50Aa96E=;
        b=S0IBcQvZLNTzpZey3++rSvZicNd2BAYffDcJoWrTqAIq4MRDRlcaqaD3c6v/gi4f4/
         YKa7XwJryFjZGQtTP1KzE9MmuQZOdE2SwRL+dXujNFFJ70fTH5d1g7JY+RLBHnlcSQol
         aox0rz0v6/739dz4qbXZXCE2wZig2tjgs2HG8NcZyPxLlIsVrIKzawTPHyO6eXC6rF8T
         BIUZl9WSHqSy9kWWz9JHmKSKM79ARYSQUpEP1dmIytdkGD/yRHUU45FvMqobfUBH/3jl
         0Cmb8zV0iaHNPlLuprRFZ+VP3Dtya/YRHoSQ+xB7kjtIUMRLkJW0ZHYy0Lv0WrC1bp76
         3vsQ==
X-Gm-Message-State: ANoB5plH47ztM56cgJCicNWb9D6rMrxpv03As6zMn0XLSYHfa5ztkZgx
        M1WUKoqyet9t4laO8fpHq1vtit06Zdcr3UE2rZezbuygp0icvfLtzhDsQ4dJpGpiei0Gdo0o24q
        x7U37/3ZjicSZcaBWbdem2/pL
X-Received: by 2002:a17:907:2137:b0:7c1:9041:8c5 with SMTP id qo23-20020a170907213700b007c1904108c5mr5712987ejb.41.1671032468689;
        Wed, 14 Dec 2022 07:41:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf50Yg1t+/0rBr+e+/ZnJM3sz1HziqrJ0rW9vdRAPMksDUv4cZG97eQGNn9vZPLbhZPznnhJYA==
X-Received: by 2002:a17:907:2137:b0:7c1:9041:8c5 with SMTP id qo23-20020a170907213700b007c1904108c5mr5712971ejb.41.1671032468479;
        Wed, 14 Dec 2022 07:41:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id lu19-20020a170906fad300b007c0cbdfba04sm5914743ejb.70.2022.12.14.07.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 07:41:07 -0800 (PST)
Message-ID: <725e80d6-73ab-d760-d49d-7cbc42dd442d@redhat.com>
Date:   Wed, 14 Dec 2022 16:41:07 +0100
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
References: <20221214120830.1572474-1-moisesmcardona@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221214120830.1572474-1-moisesmcardona@gmail.com>
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

On 12/14/22 13:08, Moises Cardona wrote:
> The bytcr_rt5640.c file already supports the HP Stream 7.
> 
> The HP Stream 8 is almost identical in terms of the hardware
> with the exception of it having stereo speakers, a SIM
> card slot and the obvious size difference.
> 
> 
> Signed-off-by Moises Cardona <moisesmcardona@gmail.com>

Thanks, this new version (which should have been marked as v2)
looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> ---
>  sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index fb9d9e271845..569d039d680b 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -796,6 +796,16 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>  					BYT_RT5640_SSP0_AIF1 |
>  					BYT_RT5640_MCLK_EN),
>  	},
> +	{	/* HP Stream 8 */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Stream 8 Tablet"),
> +		},
> +		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
> +					BYT_RT5640_JD_NOT_INV |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>  	{	/* I.T.Works TW891 */
>  		.matches = {
>  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),

