Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF767064FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjEQKTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEQKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C8435A8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684318695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VO8kS0tlMDmjStKGPZ02CpcX5eueZJZ6rX71I8VGfNg=;
        b=ThL9vhalYBBO8id+jor9ijxVM9+9kZbJ7pyZR/o3FuOkSZt1ZnjLvFP3PnFlFzwgEDpv7+
        eSLhI5ZndePkUJ5/Vyr4SB0T77G2Ujf0GgpjuswcDVvugZ4l8ERpZnZKBMdwS5yWW4S+gv
        S93HbnkdnV1GcBjid1hKYdWRt7VqX7A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-QEqQKo-NO0i_-s9H8Xtj5Q-1; Wed, 17 May 2023 06:18:14 -0400
X-MC-Unique: QEqQKo-NO0i_-s9H8Xtj5Q-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50de84a3861so609865a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684318693; x=1686910693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VO8kS0tlMDmjStKGPZ02CpcX5eueZJZ6rX71I8VGfNg=;
        b=Gh3GdE8ycFsJMkm1AFDwB3XTzjVHJXidpvlMIMpvfB9iZsl4BsKm1XVsILfvn9DwAP
         yuuzthHYnhD4XDVWihSu0Rr5BsCsrH0rgnQ5N0r5jv8Pu3Qu5JNvqNUF9XCsgGbSSFtp
         8/Fv7gK3cJBCKD37k3GGZn8sEGc4DWlqS1KoeY+B9S8ofgFP0I+ODdPajXonSVyojF4k
         GeJYdrICpZZlrlDlBL7y9JSXREuKzJkPSyN8j5sszE6kdmDgqWWJl40D9GSvecQT8vpw
         u6LY7F0W7NQxxi9lpvY7EYMxBe+wlpkTbep2O4bGCb3j9cXO2k5YIr96ihmtX4R7TdxN
         G5Dg==
X-Gm-Message-State: AC+VfDwjAuutHQl/kZ/YdzL3r5MrvxpgeLPDkdeCMsFzHCNHPVXfT8Rn
        62Vw+849VDWyfHwPoDkg61fe5AMGp7xx7YCPo0fmcY7xxGHT/ADv0m76K9h1GTPeYsLWSKVEpce
        oYZNMTNV7QWyqduBeypLlon+c
X-Received: by 2002:aa7:d8c7:0:b0:50b:c4fb:770f with SMTP id k7-20020aa7d8c7000000b0050bc4fb770fmr1555034eds.34.1684318693040;
        Wed, 17 May 2023 03:18:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4N949aPI7PbDK1bzrwrLZKfDGBjlleUFDD3GoCm+EHJRnE4sQd5PiK68L7e9P5jJuHW2iMPQ==
X-Received: by 2002:aa7:d8c7:0:b0:50b:c4fb:770f with SMTP id k7-20020aa7d8c7000000b0050bc4fb770fmr1555016eds.34.1684318692692;
        Wed, 17 May 2023 03:18:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t21-20020aa7d715000000b0050bc041d2a8sm8956601edq.15.2023.05.17.03.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 03:18:12 -0700 (PDT)
Message-ID: <b3175daa-956b-9311-d209-e5837dd3de2e@redhat.com>
Date:   Wed, 17 May 2023 12:18:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm: panel-orientation-quirks: Change Air's quirk to
 support Air Plus
Content-Language: en-US, nl
To:     Maya Matuszczyk <maccraft123mc@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230515184843.1552612-1-maccraft123mc@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230515184843.1552612-1-maccraft123mc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/15/23 20:48, Maya Matuszczyk wrote:
> It turned out that Aya Neo Air Plus had a different board name than
> expected.
> This patch changes Aya Neo Air's quirk to account for that, as both
> devices share "Air" in DMI product name.
> 
> Tested on Air claiming to be an Air Pro, and on Air Plus.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I have just pushed this to drm-misc-fixes, so it should get
send to Linus with the next drm-fixes pull-req.

Regards,

Hans




> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index b1a38e6ce2f8..0cb646cb04ee 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -179,7 +179,7 @@ static const struct dmi_system_id orientation_data[] = {
>  	}, {	/* AYA NEO AIR */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
> -		  DMI_MATCH(DMI_BOARD_NAME, "AIR"),
> +		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
>  		},
>  		.driver_data = (void *)&lcd1080x1920_leftside_up,
>  	}, {	/* AYA NEO NEXT */

