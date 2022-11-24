Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9740637895
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKXMIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiKXMH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:07:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED610ED73E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669291546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7LQd7RRPNUeESAr+1LKMJrjT4VQDOqKGjXqPqUPd5c=;
        b=LDq0zFBBARvSTN8XKShhAvho03MgaqSquh7Q6aWmRhCqD64y/ed1WAFVVXjEJm1yhPHoCx
        NtpTDPt5xSp/IlpUZ6SOj2v6JgowSKDBc4QRzdNlRD50GLMCLtSW4AhUeIu7f9dYIdO+fi
        qbP4jZHyZ1E7ZEc2L2fbLfhgWJ5UR1c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-IeaTbViAMI2oE3R_SppxJg-1; Thu, 24 Nov 2022 07:05:45 -0500
X-MC-Unique: IeaTbViAMI2oE3R_SppxJg-1
Received: by mail-ed1-f69.google.com with SMTP id e15-20020a056402190f00b00461b0576620so855860edz.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7LQd7RRPNUeESAr+1LKMJrjT4VQDOqKGjXqPqUPd5c=;
        b=noYF6/8Yax5/3pUdCKYBQVya4ZCCM5NQA4RvjT56FZvkW/tL7iw4p+hACjx0Knl5ES
         B31mGWUOQMBx99P4zu3IqlauxkDvZeJ+8+WKk+2l3SXhASbPdhRahvO52p8mKZrH2NDD
         xDBRkwiKjqc55gPnBRgxGlZ1hIUuCryBlQo9Gv+kGfZ5ukpfWqc7fuVkIZf8HQizzHwM
         aHs1ZNH16agOG8MP4cE4vPLBfwg35gmx6HGRgyIjhW9Y0JQR+0hlRYweT0S65pLcm8Az
         N75nYbinGTxqmJylReaFG4W/gO8KmqLWDwXHcZD7eKHeDQJcA7dLXmxjDSVHVg4xHlr7
         9aaA==
X-Gm-Message-State: ANoB5pmh87ETs0B0Ff1qCT93ZPuzME94+SzyCXIgaG68/wAGBG4bTX6E
        H6vbAwbBxEMVGCSBMz0d69AvpC7/6MiCjDCTvnVEpp4mUe3ECN9Ia/1GqfVeD5nglWC49fZzUSC
        j4hdROvpFlPmpSLf+0iNIAUE0
X-Received: by 2002:a17:906:850d:b0:7ae:21bc:89f0 with SMTP id i13-20020a170906850d00b007ae21bc89f0mr27278515ejx.132.1669291543985;
        Thu, 24 Nov 2022 04:05:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6g9TJYi8s+6j8RI3ddhpDUwVfztYD6fUpPOggYB3f55bxdVlHPVJ4aBETtbEQU7Xvh6Rkc6Q==
X-Received: by 2002:a17:906:850d:b0:7ae:21bc:89f0 with SMTP id i13-20020a170906850d00b007ae21bc89f0mr27278494ejx.132.1669291543758;
        Thu, 24 Nov 2022 04:05:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id gc34-20020a1709072b2200b00772061034dbsm342285ejc.182.2022.11.24.04.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 04:05:43 -0800 (PST)
Message-ID: <b1aae548-e18c-9b81-4d00-0a41b23c19e4@redhat.com>
Date:   Thu, 24 Nov 2022 13:05:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 2/2] ALSA: hda: cs35l41: Use ACPI_COMPANION to read
 acpi properties
Content-Language: en-US, nl
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20221124110718.3925934-1-sbinding@opensource.cirrus.com>
 <20221124110718.3925934-3-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221124110718.3925934-3-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/24/22 12:07, Stefan Binding wrote:
> Currently the driver finds the acpi_device used to read certain
> properties using the HID, however, this is not necessary, as the
> acpi_device can be obtained from the device itself.
> 
> With the ACPI_COMPANION correctly set, we can also simplify how
> we obtain the reset gpio.

Typically when you write "also do ..." in a commit message
that is a hint to yourself that it might be better to split
the commit into 2 commits which each do only 1 thing, for easier
review. But e.g. also to easier see what is going on if a bisect
points out the commit as being the first bad one.

So once the issues with patch 1/2 are resolved, please consider
splitting this patch into 2 smaller patches.

Regards,

Hans


> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  sound/pci/hda/cs35l41_hda.c | 50 ++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 29 deletions(-)
> 
> diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
> index e5f0549bf06d..50cbbcce4946 100644
> --- a/sound/pci/hda/cs35l41_hda.c
> +++ b/sound/pci/hda/cs35l41_hda.c
> @@ -1214,16 +1214,15 @@ static int cs35l41_get_speaker_id(struct device *dev, int amp_index,
>   * And devm functions expect that the device requesting the resource has the correct
>   * fwnode.
>   */
> -static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
> -			       const char *hid)
> +static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, int id, const char *hid)
>  {
>  	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
>  
>  	/* check I2C address to assign the index */
>  	cs35l41->index = id == 0x40 ? 0 : 1;
>  	cs35l41->channel_index = 0;
> -	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
> -	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
> +	cs35l41->reset_gpio = gpiod_get_index(cs35l41->dev, NULL, 0, GPIOD_OUT_HIGH);
> +	cs35l41->speaker_id = cs35l41_get_speaker_id(cs35l41->dev, 0, 0, 2);
>  	hw_cfg->spk_pos = cs35l41->index;
>  	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
>  	hw_cfg->gpio2.valid = true;
> @@ -1255,39 +1254,36 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
>  	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
>  	u32 values[HDA_MAX_COMPONENTS];
>  	struct acpi_device *adev;
> -	struct device *physdev;
> +
>  	const char *sub;
>  	char *property;
>  	size_t nval;
>  	int i, ret;
>  
> -	adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
> +	adev = ACPI_COMPANION(cs35l41->dev);
>  	if (!adev) {
> -		dev_err(cs35l41->dev, "Failed to find an ACPI device for %s\n", hid);
> +		dev_err(cs35l41->dev, "Failed to find an ACPI device for %s\n",
> +			dev_name(cs35l41->dev));
>  		return -ENODEV;
>  	}
>  
> -	physdev = get_device(acpi_get_first_physical_node(adev));
> -	acpi_dev_put(adev);
> -
> -	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
> +	sub = acpi_get_subsystem_id(ACPI_HANDLE(cs35l41->dev));
>  	if (IS_ERR(sub))
>  		sub = NULL;
>  	cs35l41->acpi_subsystem_id = sub;
>  
>  	property = "cirrus,dev-index";
> -	ret = device_property_count_u32(physdev, property);
> -	if (ret <= 0) {
> -		ret = cs35l41_no_acpi_dsd(cs35l41, physdev, id, hid);
> -		goto err_put_physdev;
> -	}
> +	ret = device_property_count_u32(cs35l41->dev, property);
> +	if (ret <= 0)
> +		return cs35l41_no_acpi_dsd(cs35l41, id, hid);
> +
>  	if (ret > ARRAY_SIZE(values)) {
>  		ret = -EINVAL;
>  		goto err;
>  	}
>  	nval = ret;
>  
> -	ret = device_property_read_u32_array(physdev, property, values, nval);
> +	ret = device_property_read_u32_array(cs35l41->dev, property, values, nval);
>  	if (ret)
>  		goto err;
>  
> @@ -1307,11 +1303,10 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
>  	/* To use the same release code for all laptop variants we can't use devm_ version of
>  	 * gpiod_get here, as CLSA010* don't have a fully functional bios with an _DSD node
>  	 */
> -	cs35l41->reset_gpio = fwnode_gpiod_get_index(acpi_fwnode_handle(adev), "reset", cs35l41->index,
> -						     GPIOD_OUT_LOW, "cs35l41-reset");
> +	cs35l41->reset_gpio = gpiod_get_index(cs35l41->dev, "reset", cs35l41->index, GPIOD_OUT_LOW);
>  
>  	property = "cirrus,speaker-position";
> -	ret = device_property_read_u32_array(physdev, property, values, nval);
> +	ret = device_property_read_u32_array(cs35l41->dev, property, values, nval);
>  	if (ret)
>  		goto err;
>  	hw_cfg->spk_pos = values[cs35l41->index];
> @@ -1322,41 +1317,41 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
>  			cs35l41->channel_index++;
>  
>  	property = "cirrus,gpio1-func";
> -	ret = device_property_read_u32_array(physdev, property, values, nval);
> +	ret = device_property_read_u32_array(cs35l41->dev, property, values, nval);
>  	if (ret)
>  		goto err;
>  	hw_cfg->gpio1.func = values[cs35l41->index];
>  	hw_cfg->gpio1.valid = true;
>  
>  	property = "cirrus,gpio2-func";
> -	ret = device_property_read_u32_array(physdev, property, values, nval);
> +	ret = device_property_read_u32_array(cs35l41->dev, property, values, nval);
>  	if (ret)
>  		goto err;
>  	hw_cfg->gpio2.func = values[cs35l41->index];
>  	hw_cfg->gpio2.valid = true;
>  
>  	property = "cirrus,boost-peak-milliamp";
> -	ret = device_property_read_u32_array(physdev, property, values, nval);
> +	ret = device_property_read_u32_array(cs35l41->dev, property, values, nval);
>  	if (ret == 0)
>  		hw_cfg->bst_ipk = values[cs35l41->index];
>  	else
>  		hw_cfg->bst_ipk = -1;
>  
>  	property = "cirrus,boost-ind-nanohenry";
> -	ret = device_property_read_u32_array(physdev, property, values, nval);
> +	ret = device_property_read_u32_array(cs35l41->dev, property, values, nval);
>  	if (ret == 0)
>  		hw_cfg->bst_ind = values[cs35l41->index];
>  	else
>  		hw_cfg->bst_ind = -1;
>  
>  	property = "cirrus,boost-cap-microfarad";
> -	ret = device_property_read_u32_array(physdev, property, values, nval);
> +	ret = device_property_read_u32_array(cs35l41->dev, property, values, nval);
>  	if (ret == 0)
>  		hw_cfg->bst_cap = values[cs35l41->index];
>  	else
>  		hw_cfg->bst_cap = -1;
>  
> -	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, cs35l41->index, nval, -1);
> +	cs35l41->speaker_id = cs35l41_get_speaker_id(cs35l41->dev, cs35l41->index, nval, -1);
>  
>  	if (hw_cfg->bst_ind > 0 || hw_cfg->bst_cap > 0 || hw_cfg->bst_ipk > 0)
>  		hw_cfg->bst_type = CS35L41_INT_BOOST;
> @@ -1364,14 +1359,11 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
>  		hw_cfg->bst_type = CS35L41_EXT_BOOST;
>  
>  	hw_cfg->valid = true;
> -	put_device(physdev);
>  
>  	return 0;
>  
>  err:
>  	dev_err(cs35l41->dev, "Failed property %s: %d\n", property, ret);
> -err_put_physdev:
> -	put_device(physdev);
>  
>  	return ret;
>  }

