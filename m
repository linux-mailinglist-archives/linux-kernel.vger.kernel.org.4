Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C598667E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbjALTAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbjALS76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:59:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A14D1DF1D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673548603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akqXSxbWkkMs6QaYC0/F/LE3FUEcneDw1DnPUsgrw54=;
        b=dtFgguB546xLcfoIUToUTIJ16PQR2+6NZ2OrgiMqLiD8RZET6XiwBUX5r1x4InV0A3ZbrS
        hx375GM/pESk2r2yYj4tLLY7v/daKdmRxMPvyMg9fhA9D4/SDYAXM6KNTT8Z4Si7t9x+kq
        DCKnutVhZJo97nlXNLAml4LcWvT4XmQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-YPlRRemhPqukOtZhhseEzw-1; Thu, 12 Jan 2023 13:36:42 -0500
X-MC-Unique: YPlRRemhPqukOtZhhseEzw-1
Received: by mail-ed1-f70.google.com with SMTP id x13-20020a05640226cd00b0047ac11c9774so12891826edd.17
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akqXSxbWkkMs6QaYC0/F/LE3FUEcneDw1DnPUsgrw54=;
        b=3cwbHGeeqf35w5vpVRvB2/DzM8PcCdkrDJc21UBWTuF/2UoQLeJQja1CB+pzneADZ0
         RHjxbJvyeCdxqHapPEezmBlw2MHv5NGDcqbwVF0K1NMBEF6yOu0Q3bZyWs1r/YD5vgOn
         vF5Ga+LChYDDUQJLjDuWNHi8yzfIRky9lFLsJVWYAzsvjFZwZ7lD8Lg1Sqz3q/1Eaoh3
         kOzf7WajFGNRzvktul75mDalf59t3If3YE49QPWvxJyOrobYi/W7Ft6hQ7CuvTCkb/Yb
         K03MnA6+kf+JpOAUS1RPp+SVuiLhbDJAAl0T7fe0kmtKvC9ww5VW1gH6vwhQeJzmZeLa
         YnCg==
X-Gm-Message-State: AFqh2kr6Cu/3Dvs2jjJfwrO+PF8DcasJisgpLurZrJFSRPIOTkDR56GS
        cwzzQSf+fsPoCBj/LwLaS9GqcyH2wtRMNVtJLk6ppB+9n5iAZDkIH58fgxNZrXQgN8xGn9737ZQ
        74UgpCou3is/6Bry7ivcTnqK/
X-Received: by 2002:aa7:c951:0:b0:499:d374:e18b with SMTP id h17-20020aa7c951000000b00499d374e18bmr7812759edt.35.1673548601274;
        Thu, 12 Jan 2023 10:36:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuJ5Pr+YxfuIISPqeceagzX2eNYIOGjl0+m2T9ikfOu4DD4NOKmvc5O35jXaqAGKUkMmxuICg==
X-Received: by 2002:aa7:c951:0:b0:499:d374:e18b with SMTP id h17-20020aa7c951000000b00499d374e18bmr7812746edt.35.1673548601086;
        Thu, 12 Jan 2023 10:36:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id og5-20020a1709071dc500b0084d420503a3sm5946308ejc.178.2023.01.12.10.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 10:36:40 -0800 (PST)
Message-ID: <cc644ad3-1b12-5ecb-c8fa-8f7ab5d5b055@redhat.com>
Date:   Thu, 12 Jan 2023 19:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] platform/x86: asus-wmi: Fix issues on fanless device
Content-Language: en-US, nl
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        "Luke D. Jones" <luke@ljones.dev>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221221-asus-fan-v1-0-e07f3949725b@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221221-asus-fan-v1-0-e07f3949725b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 12/21/22 18:59, Thomas Weißschuh wrote:
> This series fixes issues experienced on a fanless ASUS VivoBook E410MA.
> 
> To: Corentin Chary <corentin.chary@gmail.com>
> To: Hans de Goede <hdegoede@redhat.com>
> To: Mark Gross <markgross@kernel.org>
> To: "Luke D. Jones" <luke@ljones.dev>
> Cc: acpi4asus-user@lists.sourceforge.net
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thank you for your patch series, I've applied this series
to my fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans





> 
> ---
> Thomas Weißschuh (3):
>       platform/x86: asus-wmi: Add quirk wmi_ignore_fan
>       platform/x86: asus-wmi: Ignore fan on E410MA
>       platform/x86: asus-wmi: Don't load fan curves without fan
> 
>  drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++++
>  drivers/platform/x86/asus-wmi.c    |  7 ++++++-
>  drivers/platform/x86/asus-wmi.h    |  1 +
>  3 files changed, 20 insertions(+), 1 deletion(-)
> ---
> base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> change-id: 20221221-asus-fan-9aeac7d59c6c
> 
> Best regards,

