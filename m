Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3445BB9CE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 20:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIQSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 14:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIQSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 14:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D332610F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663437635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgKYNIVGHgBOnvrxN4mdypOW9y4btqV8BpaMbCRfOfQ=;
        b=RGLS/fCyFgEy42n9pWopShVLU1oYxgyixVHGwYVd9k2/8pvAMdlSco5hn0dpasPugRHOQZ
        OT5PRvNrvx+6W0Fso1e/SBS41N5T1A3ui0FN5o8Qvgpk/fKzUCm04B0tXAJXT4M+9GbSM6
        G+7++TjfaH6Kt7ujDd0LHcQalMcDphM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-dSRkXIbTM2WcMBKuy2G5Bw-1; Sat, 17 Sep 2022 14:00:31 -0400
X-MC-Unique: dSRkXIbTM2WcMBKuy2G5Bw-1
Received: by mail-ed1-f69.google.com with SMTP id e15-20020a056402190f00b0044f41e776a0so17138450edz.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 11:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JgKYNIVGHgBOnvrxN4mdypOW9y4btqV8BpaMbCRfOfQ=;
        b=tLE1PnzFeOz0aZm58jhrDmc2iwyiEMn8ijKp7e3tGhn+2PbjWSF1WSnPfo490PuN7B
         IrzdZh8Q/ooOhsdPz7k8/xgUBCdkxwjaO4Y3EXCpgeC35Ess/kH0KQdJDsIBTGVhYsae
         q8fo25owiXohnjB2FpRq/X7HyMDVOZgPf7P3QqaKWFzG7i5FD9GaQrMt6OqOXjrRDA2B
         EKQY/Uy2e5REASeoqYoChR2MJZ5gZ/NKdzkC2VNbYN5eSYCoQqVrg7M79Ku3MhpqDfSR
         laUeQexvXHTCqIAI1wAf1JC1XlvtdIlegYdl1cEHTLUW4ZE8V1IsKyWK6WfJBBTE+T6B
         HSHQ==
X-Gm-Message-State: ACrzQf2UfmnaWC/OSN0uG1jFmScG/+otHnUFd0yp2/MXsO1PFTlZEqFy
        hQipUEmISCJROtNC4Cw4d8akFKmJg3IDHsKn0AaDVXiW3hjv+a8HIqEhZQFkuixFrLiuay+/YV5
        jmym2fJDBXQjMpklKp2E4U5Jr
X-Received: by 2002:a17:907:6093:b0:780:7671:2c97 with SMTP id ht19-20020a170907609300b0078076712c97mr7395618ejc.8.1663437630813;
        Sat, 17 Sep 2022 11:00:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5h86bQDJL4fYqYdDnP4hpCMXC7RFEqgLZ2bqYMWLCyEFoUeiqC+9aCPZXcQITcOoPsX3cV3A==
X-Received: by 2002:a17:907:6093:b0:780:7671:2c97 with SMTP id ht19-20020a170907609300b0078076712c97mr7395605ejc.8.1663437630619;
        Sat, 17 Sep 2022 11:00:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b0077ce503bd77sm9933293eje.129.2022.09.17.11.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 11:00:29 -0700 (PDT)
Message-ID: <b245787a-38fa-4202-cc7a-8fe18bc2308d@redhat.com>
Date:   Sat, 17 Sep 2022 20:00:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: drm: panel-orientation-quirks: Add quirk for Aya Neo Air
Content-Language: en-US
To:     Maccraft123 <maccraft123mc@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220825191946.1678798-1-maccraft123mc@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220825191946.1678798-1-maccraft123mc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/25/22 21:19, Maccraft123 wrote:
> From: Maya Matuszczyk <maccraft123mc@gmail.com>
> 
> Yet another x86 gaming handheld.
> 
> This one has many SKUs with quite a few of DMI strings,
> so let's just use a catchall, just as with Aya Neo Next.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>

Thanks, I have pushed this out to drm-misc-next now.

Note for future drm_panel_orientation_quirks.c patches please Cc me,
I am not subscribed to dri-devel.

Regards,

Hans


> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index fc1728d46ac2..0b011b615495 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -103,6 +103,12 @@ static const struct drm_dmi_panel_orientation_data lcd800x1280_rightside_up = {
>  	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
>  };
>  
> +static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftside_up = {
> +	.width = 1080,
> +	.height = 1920,
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
> +};
> +
>  static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
>  	.width = 1200,
>  	.height = 1920,
> @@ -152,6 +158,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYA NEO 2021"),
>  		},
>  		.driver_data = (void *)&lcd800x1280_rightside_up,
> +	}, {	/* AYA NEO AIR */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
> +		  DMI_MATCH(DMI_BOARD_NAME, "AIR"),
> +		},
> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
>  	}, {	/* AYA NEO NEXT */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),

