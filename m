Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887305BB85A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIQNEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiIQNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D972B33A1C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663419860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IB1HQdme8YEeD8Kj1n47Nas4fnkU0luDWqOLkZyPEI8=;
        b=UDhaA6vtQ241d/LQWj8VbVK/i9+dQ2HG3xygCnOYAVMFkrVCa8MTxp7XzOwfADKMWMDutn
        mvPWvgkjQbX6uXrScRvL71FZ/2qGjyKvBBNdPCJtUGLC0UC+Ljwy2Gqic058Qy3yrHDcrV
        /ce/ydkoqZapjQxhFz67WsbnNai/M1I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-C9JM6KSTMYG51bhfObb_kw-1; Sat, 17 Sep 2022 09:04:18 -0400
X-MC-Unique: C9JM6KSTMYG51bhfObb_kw-1
Received: by mail-ed1-f72.google.com with SMTP id b17-20020a056402351100b00453b19d9bd0so425360edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IB1HQdme8YEeD8Kj1n47Nas4fnkU0luDWqOLkZyPEI8=;
        b=SKacBA6s76i0ogcGeIWtJk1mA875gUX9C7/L1asBdBBBg+UQGcm7eM7QGplTeiYVsl
         7RHCZWzHHhUD+vkJQZP+vwsS0ZVbC4sgk9AII5EomspzmmwGr7LirijGI7rHB34ITHc3
         mD5O2LH8QuQ/iNiZDb56oEd2+iE/woCRBwWxlpEnTbeImBNPZfPptg0hiVlbuYrVmXkH
         OFQarLDCAVbmK9PzBh/eIKAoF9pq3RR2X72tP2tfmc9BjCD8ARZRlMkn8rwI97DFRR0J
         iM/XzjOvYXmOLuPMO2VUvV2Dlc0woAI7XtAFeBV6LtZK50ZMuSW4/MLcFvx62xAwCgKM
         LozQ==
X-Gm-Message-State: ACrzQf3qXGOnAAzyWxNHPX88Biwb8IsTHHVh8y1qSq3Q0daAMZoHONeC
        /Jn0boie9yVKI6tjllY4d+CE7bAfUy6OKk6kFX1wEoSRJbl+wpztSFvOUepfVgSOcOZCGBRLxvA
        h8Hnn75WJEFl+cRir7vYVn4wd
X-Received: by 2002:a17:907:2bdd:b0:77d:e0f3:81e5 with SMTP id gv29-20020a1709072bdd00b0077de0f381e5mr6715850ejc.328.1663419857336;
        Sat, 17 Sep 2022 06:04:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5DA5wCcsH5iDV6cyNETXig/uwsG/BWf9W8xSsm4akO2vs30QZ2677QvL2RXV5XAdhbL/QNsA==
X-Received: by 2002:a17:907:2bdd:b0:77d:e0f3:81e5 with SMTP id gv29-20020a1709072bdd00b0077de0f381e5mr6715837ejc.328.1663419857180;
        Sat, 17 Sep 2022 06:04:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090609c200b0071cbc7487e1sm12079684eje.69.2022.09.17.06.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 06:04:16 -0700 (PDT)
Message-ID: <4e145e1d-db9a-0edb-cdd4-1da3e02131fd@redhat.com>
Date:   Sat, 17 Sep 2022 15:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirk for Anbernic
 Win600
Content-Language: en-US
To:     Maccraft123 <maccraft123mc@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220803182402.1217293-1-maccraft123mc@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220803182402.1217293-1-maccraft123mc@gmail.com>
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

On 8/3/22 20:24, Maccraft123 wrote:
> From: Maya Matuszczyk <maccraft123mc@gmail.com>
> 
> This device is another x86 gaming handheld, and as (hopefully) there is
> only one set of DMI IDs it's using DMI_EXACT_MATCH
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>

Thanks I have added this patch to my local drm-misc-next branch.

I will push this out to the official drm-misc-next branch after
running some local tests.

(unfortunately it is too late now to push this to drm-misc-fixes
for this cycle, sorry).

Regards,

Hans



> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index d4e0f2e85548..a8681610ede7 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -128,6 +128,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "One S1003"),
>  		},
>  		.driver_data = (void *)&lcd800x1280_rightside_up,
> +	}, {	/* Anbernic Win600 */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Anbernic"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Win600"),
> +		},
> +		.driver_data = (void *)&lcd720x1280_rightside_up,
>  	}, {	/* Asus T100HA */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),

