Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE70634448
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiKVTFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiKVTFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:05:19 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2812F8A142
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:05:16 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id s18so9130638qvo.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V113i9op2pduVlxmzasvaIEvnqTrh+10a7z1AWq+aEg=;
        b=DBN3eB8VZE6euKV0t6YywqYDdM8aZxRa6ITHKBt4yJZC3AJTs9exx/n7bFt9NNjUKr
         5CjoFGf2TLv9zR78cgumEbZbl8oR5DgMThLgtJ+KaaaS3gzcFVHTEufJFWw782w3jmc1
         /99JGLlaeNSdOl+n1kP9dtSZgkJV+TFm5U9I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V113i9op2pduVlxmzasvaIEvnqTrh+10a7z1AWq+aEg=;
        b=EFThtIzdqKQP6igH+R8GTHmQPB1WDz3UEWDnypdH+fe2LaPDeXhmrQ+ACBq4+/6eYY
         xEp7SfADdU2szs+US78tZoHASCpUmp9rjmaVY8AMA4qU8gjKqSU7EdLy/2X9qOHd+QjY
         py9LHDCHnlbFCyO3BuwHqXbQ7bmANGTuv+1N4igoO2h+aagpJRtJvgj+hnRuTWaj+mVP
         NtyqdmID2oHqBUnFyA0nKH18/q965GgyxyhWi4eZOgdEPGor5aktxN9k6jXL2aNa3hnV
         jnbZhcdi7Y+JVjbGcFL75c7Ob2ldJ7Jfdk8Iufpr74P4b+LrEwFK0t29acFBl3kisBoy
         JWvg==
X-Gm-Message-State: ANoB5pkhgpaFX9MmymT4dWEIDamRAJMgq+Fv9DQncyHg5aJkWqNx8q9P
        BusOR5tEB26aWj1Vp/uIyskSLipJmttZcTjZVnHsgl77TIw=
X-Google-Smtp-Source: AA0mqf4+8dUqlIgr/8H6RT8a2TGpmcGq48sFYZ4zLYA7vHnHmcToY6FLgEsJDVQJxOqoXpyoHy4JHeCWbd8mcGxWiSE=
X-Received: by 2002:ad4:4c03:0:b0:4bc:182e:78c2 with SMTP id
 bz3-20020ad44c03000000b004bc182e78c2mr4883234qvb.2.1669143915309; Tue, 22 Nov
 2022 11:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20221121201337.2772216-1-pmalani@chromium.org>
 <20221121201337.2772216-2-pmalani@chromium.org> <Y3ydPqkxxQCSGGp7@kuha.fi.intel.com>
In-Reply-To: <Y3ydPqkxxQCSGGp7@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 22 Nov 2022 11:05:04 -0800
Message-ID: <CACeCKaeCA3+0BVyUO72HvUbV7mcjEcGT4uXnA2X8=CUdjdtOuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: typec: Add helper to get partner device struct
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thanks for reviewing the patch.

On Tue, Nov 22, 2022 at 1:58 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Let's not loose the protection around these devices unless there is no
> other way, and in this case there is.
>
> Please just create a wrapper for usb_power_delivery_register() instead:
>
> struct usb_power_delivery *
> typec_partner_usb_power_delivery_register(struct typec_partner *partner,
>                                           struct usb_power_delivery_desc *desc)
> {
>         return usb_power_delivery_register(&partner->dev, desc);
> }
> EXPORT_SYMBOL_GPL(typec_partner_usb_power_delivery_register);

Sounds good. I'll send a v2 with the above change as patch 1 (instead
of the current patch 1).

I will list you as the "Suggested-by" tag (but please let me know if
you'd like attribution stated differently).

Thanks again!

-Prashant
