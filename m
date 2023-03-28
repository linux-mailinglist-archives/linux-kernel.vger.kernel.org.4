Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDBE6CBC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjC1KQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjC1KQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D79644A7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679998506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVTl6Zqhno+wxlfGSCgUpjuBfnVHjRtvpGdjuseKXvQ=;
        b=SRpCRuRSjXgfYtIqToZU/8owbMpY5ASv/QdkJBsA+6aOvuo4zpj0OO1d+eiy0bqDv3gAS2
        AAph/GgIZ96xVmm0lyyaFIIM1t3gTpOMU2/DGOaBfRoE1kVl/IwyyHbRBBlBZkkBXeeHVR
        OVUp8S+o1ytrwL6KdGPDdofsrQsTcWo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-tTbnLsE7NVy8HBQCb373sg-1; Tue, 28 Mar 2023 06:15:05 -0400
X-MC-Unique: tTbnLsE7NVy8HBQCb373sg-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a0564020e8b00b004e59d4722a3so16747942eda.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVTl6Zqhno+wxlfGSCgUpjuBfnVHjRtvpGdjuseKXvQ=;
        b=uJkA4zICxY83huiVjgGPNJ0fb2Yqf1r2o3YV5LpviHZPAGwieYxcPKhaawfcCydU21
         rcSEU8KBWrwx7FkKYZvU2RG4grk4S0YR6ffzVfWMZd2twq3opbFSHxM6/jlZfw6IudEc
         6dZmiCOX7DJzZ2QyrYGpI7qffbTGv90bff1+6sp+FZyVk/B3VM5CBZXAAmyLDCcZQyg3
         NjdM870TSwQe9YfHYMdjVNeLH6nB+qy7gH3YIMaITsnZyJVT700WDw/LTi2qmUmYBl5B
         9LuH6pN67BEfxcRjUVhX2CvGJchVwbxweMJ536yja4LVnwqAmUYxJ6vg1/O0KsFPzzS9
         hrCg==
X-Gm-Message-State: AAQBX9fscIGWJdtVQulgSFTLhg80Ufc40BMIpT1Z1b2j6WEROmN3FhpM
        qKwV6QYs1LyXPBvcExgGYpd3zUuKGSXG+9ixts7uXXLdeNhlguGFt5rKRrF/88AJZtiZhxzVYgJ
        XfLLey3tWT2gSviY1HUzVZLtuUj2gX5uF
X-Received: by 2002:a05:6402:31e2:b0:4fc:c6fe:1d3a with SMTP id dy2-20020a05640231e200b004fcc6fe1d3amr15738426edb.22.1679998504512;
        Tue, 28 Mar 2023 03:15:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350YAjL4A52eBRX9X9NGG7KuyR3mYs6dt88IHCIOn5pHRYMcQvxffUNRTHX2vlt4kPN8bsRrd/w==
X-Received: by 2002:a05:6402:31e2:b0:4fc:c6fe:1d3a with SMTP id dy2-20020a05640231e200b004fcc6fe1d3amr15738413edb.22.1679998504260;
        Tue, 28 Mar 2023 03:15:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090671d600b0093348be32cfsm13232182ejk.90.2023.03.28.03.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 03:15:03 -0700 (PDT)
Message-ID: <ae65a407-9c39-c48a-0cb9-44b3eacda410@redhat.com>
Date:   Tue, 28 Mar 2023 12:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ASoC: es8316: Handle optional IRQ assignment
Content-Language: en-US, nl
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230328094901.50763-1-cristian.ciocaltea@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230328094901.50763-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/28/23 11:49, Cristian Ciocaltea wrote:
> The driver is able to work fine without relying on a mandatory interrupt
> being assigned to the I2C device. This is only needed when making use of
> the jack-detect support.
> 
> However, the following warning message is always emitted when there is
> no such interrupt available:
> 
>   es8316 0-0011: Failed to get IRQ 0: -22
> 
> Do not attempt to request an IRQ if it is not available/valid. This also
> ensures the rather misleading message is not displayed anymore.
> 
> Also note the IRQ validation relies on commit dab472eb931bc291 ("i2c /
> ACPI: Use 0 to indicate that device does not have interrupt assigned").
> 
> Fixes: 822257661031 ("ASoC: es8316: Add jack-detect support")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  sound/soc/codecs/es8316.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
> index 056c3082fe02..f7d7a9c91e04 100644
> --- a/sound/soc/codecs/es8316.c
> +++ b/sound/soc/codecs/es8316.c
> @@ -842,12 +842,14 @@ static int es8316_i2c_probe(struct i2c_client *i2c_client)
>  	es8316->irq = i2c_client->irq;
>  	mutex_init(&es8316->lock);
>  
> -	ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
> -					"es8316", es8316);
> -	if (ret) {
> -		dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
> -		es8316->irq = -ENXIO;
> +	if (es8316->irq > 0) {
> +		ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
> +						IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +						"es8316", es8316);
> +		if (ret) {
> +			dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
> +			es8316->irq = -ENXIO;
> +		}
>  	}
>  
>  	return devm_snd_soc_register_component(&i2c_client->dev,

