Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0F6BFBA3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCRQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCRQn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65B420696
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679157790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qTmKzr5kfPBVHTLN+KCKhuoURqJ1d0K8awn1mb6e78=;
        b=OWYA3Bk4RGX/MMSh0FERwqO0I8RoOdlVZhkQCjcxRTOhLbSJZ5nNM4TeXvXB1zwnToQaEY
        NIbQ16IJGNkDTesYZiWsh9Ct/kHa5Dl/4RQSCZFS1wYU/SmEbtQopezBfLwZMxljjsgUk3
        JosUvHp5WDsyyc/MsizDdhHgCHyRvR8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-OHAoC4JYNQiox7Gs1gwoxw-1; Sat, 18 Mar 2023 12:43:08 -0400
X-MC-Unique: OHAoC4JYNQiox7Gs1gwoxw-1
Received: by mail-ed1-f70.google.com with SMTP id r19-20020a50aad3000000b005002e950cd3so11939492edc.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 09:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679157787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qTmKzr5kfPBVHTLN+KCKhuoURqJ1d0K8awn1mb6e78=;
        b=xpZ5KGs0f8tuPhkaS0o/dsLZdne6ij8J0MBjsyp2IC1AvYazQAlKaSMTChRjYRCy9r
         YGXLqSbRAc+C7LDW6lw2JDIDa2X2mYeWNaBTWQXAKjIOPbm9KF2XEbmyeVpOGp/g3nL+
         JdVKdLHJGrB6SYovlS5RmlOH33XcyUiIVxZEq/A9P/TCSX0bGQdXCYAQeUR6wkYQaapp
         fQTMnp0Jr6HCuKuMlPVeACeT3Ru9zwDl7+bO4Wb7Jti7mP6NN2pa/EJkA+YElckAGvFZ
         cxkuU//1UylPqtQJmZhZzCUd355Y4R1CS4kTGsu+xb5HGLArdiMvO8mdk1EPJ8gJCxZi
         KZ4Q==
X-Gm-Message-State: AO0yUKXyNz+uG1EZ5+n1O50Wl4FSczrdpbYHCqDQKlLb333j3/yS7geG
        lT1p5dqYdBwNmN3/jTZWaD1r0IHgO9nfiyPOSGZKCcJ9FDd6z+uUIfEok89GNmgpMoO2xY05qaC
        nRb8wa/8UVxda42l4i4CEa7Vc
X-Received: by 2002:a05:6402:b2e:b0:4f9:9e56:84bf with SMTP id bo14-20020a0564020b2e00b004f99e5684bfmr6788128edb.10.1679157787629;
        Sat, 18 Mar 2023 09:43:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set89AlppMDrfR/43PIUExvhvMG/jKnG4vsy7XxhESBrvrhiSghtoTblYJc/00XHsLaWp7oYEPw==
X-Received: by 2002:a05:6402:b2e:b0:4f9:9e56:84bf with SMTP id bo14-20020a0564020b2e00b004f99e5684bfmr6788116edb.10.1679157787375;
        Sat, 18 Mar 2023 09:43:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x93-20020a50bae6000000b004fbf6b35a56sm2564415ede.76.2023.03.18.09.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 09:43:06 -0700 (PDT)
Message-ID: <49d10207-6f31-f1a1-90f1-7f8df5a83ee2@redhat.com>
Date:   Sat, 18 Mar 2023 17:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Input: focaltech - use explicitly signed char type
Content-Language: en-US, nl
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Cc:     stable@vger.kernel.org, regressions@leemhuis.info,
        barry@messagefor.me.uk
References: <e20db4c4-b2a8-bc88-232f-d1213733d20c@leemhuis.info>
 <20230318133010.1285202-1-Jason@zx2c4.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230318133010.1285202-1-Jason@zx2c4.com>
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

On 3/18/23 14:30, Jason A. Donenfeld wrote:
> The recent change of -funsigned-char causes additions of negative
> numbers to become additions of large positive numbers, leading to wrong
> calculations of mouse movement. Change these casts to be explictly
> signed, to take into account negative offsets.
> 
> Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
> Cc: stable@vger.kernel.org
> Cc: regressions@leemhuis.info
> Cc: barry@messagefor.me.uk
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Wrote this patch from my phone, untested, so it would be nice if
> somebody with hardware could confirm it works.

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
>  drivers/input/mouse/focaltech.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
> index 6fd5fff0cbff..3dbad0d8e8c9 100644
> --- a/drivers/input/mouse/focaltech.c
> +++ b/drivers/input/mouse/focaltech.c
> @@ -202,8 +202,8 @@ static void focaltech_process_rel_packet(struct psmouse *psmouse,
>  	state->pressed = packet[0] >> 7;
>  	finger1 = ((packet[0] >> 4) & 0x7) - 1;
>  	if (finger1 < FOC_MAX_FINGERS) {
> -		state->fingers[finger1].x += (char)packet[1];
> -		state->fingers[finger1].y += (char)packet[2];
> +		state->fingers[finger1].x += (signed char)packet[1];
> +		state->fingers[finger1].y += (signed char)packet[2];
>  	} else {
>  		psmouse_err(psmouse, "First finger in rel packet invalid: %d\n",
>  			    finger1);
> @@ -218,8 +218,8 @@ static void focaltech_process_rel_packet(struct psmouse *psmouse,
>  	 */
>  	finger2 = ((packet[3] >> 4) & 0x7) - 1;
>  	if (finger2 < FOC_MAX_FINGERS) {
> -		state->fingers[finger2].x += (char)packet[4];
> -		state->fingers[finger2].y += (char)packet[5];
> +		state->fingers[finger2].x += (signed char)packet[4];
> +		state->fingers[finger2].y += (signed char)packet[5];
>  	}
>  }
>  

