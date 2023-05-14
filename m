Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9CC701F7F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjENUW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENUWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082810DE
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684095702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1tAC8MrLbkSD9UVPWiYzK6fj9aylD3GhGT6+jdvsKI=;
        b=AdpAFW3RcEmLixoNSGpZQZOSrjeo/bEcaQPIyNMA3/N7GTp5S2oX3vAW635rHs6g7GwcNA
        vDA3OonUvHr9/5clTl2PHICwfzAQtLMwaWB3DerjZpwN8xoiE0p/ApKQ4/O6fFFjohhK8A
        9vgH8kDUMU109dULWNeBKLIRuTn2JlQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-UcLLmZ8hM4O82vkGw7QZsA-1; Sun, 14 May 2023 16:21:41 -0400
X-MC-Unique: UcLLmZ8hM4O82vkGw7QZsA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-96ae3faf801so162586866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684095700; x=1686687700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1tAC8MrLbkSD9UVPWiYzK6fj9aylD3GhGT6+jdvsKI=;
        b=H7k6zr9DlP6S39lC4rOff5S4dTnEOI7laYypDNMbNsuYzkN6to6A1AtEF1/faax1Ns
         PIQvSlOiZixU9EJ2nLYhnmQ7wozmOzhfnX9JuLfx1OLVKJ9fNNJKR37lzV3/KSgAc93q
         sTO4Rm9oPUEWKZEFGndHtPEaMlRtD4E2eMfiVfz4QxcTyB1K0n0QxYFH9h9DMVSv5Swl
         EHphb7UIu19epj4C+zOLrRNejAQV6dlBdW+s/EEGRSGdjjJRPbgAkWjahNxFIR9ohPfz
         sKjl+NDot8G5GAbWCbl3sX8zEhJ62Rfq+SmcAV3fa4zaCeo1uYbUNbK9qSHvWakuV55y
         oYhw==
X-Gm-Message-State: AC+VfDw70fnLfTJVCk8zwYcyOY/HffBLc8iKJNw6QVCQqSAHZOgygxqt
        M00Gnqnzx8sTlCPq4vmfvxFhz/rOG1YNdi/lR+yaSBj25VFeaWT5VVwdwoYltOJkUv3M9Zv2VLw
        r2YI4zSJFmIRByFt4rBd8Tk8q
X-Received: by 2002:a17:907:9444:b0:969:e304:7a22 with SMTP id dl4-20020a170907944400b00969e3047a22mr18377129ejc.18.1684095700408;
        Sun, 14 May 2023 13:21:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZObfspH4sKNLtf9/QPLqcX34mz9nMa9vg+VBtS3wSkEN7xRGjSLO74RXlp3y46c6bNe2RSg==
X-Received: by 2002:a17:907:9444:b0:969:e304:7a22 with SMTP id dl4-20020a170907944400b00969e3047a22mr18377118ejc.18.1684095700154;
        Sun, 14 May 2023 13:21:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hs32-20020a1709073ea000b009534211cc97sm8534633ejc.159.2023.05.14.13.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 13:21:39 -0700 (PDT)
Message-ID: <eca4b75a-3a1d-1039-1f5d-b974a920745d@redhat.com>
Date:   Sun, 14 May 2023 22:21:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/4] x86-android-tablets: convert to using GPIO references
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512001815.591817-1-dmitry.torokhov@gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230512001815.591817-1-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 5/12/23 02:18, Dmitry Torokhov wrote:
> Hi Hans,
> 
> This series came about because now software nodes can be used to
> describe GPIOs (via PROPERTY_ENTRY_GPIO() macros) and I would like to
> eventually get rid of gpio_keys_platform_data structure.
> 
> So while I was doing the conversions from GPIO_LOOKUP() tables for
> gpio_keys devices I decided to convert the rest of them as well. Maybe
> some time in the future we can drop support for GPIO_LOOKUP() and rely
> on device properties exclusively.
> 
> This is completely untested.

Thank you for your work on this. I have hw to test this.

But it seems that you have based this on an older tree,
in 6.4-rc1 the x86-android-tablets code has been split
over multiple files in their own subdir because it was
becoming unyielding.

Can you please rebase this on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

?

Regards,

Hans





> Dmitry Torokhov (4):
>   platform/x86: x86-android-tablets: convert Goodix devices to GPIO references
>   platform/x86: x86-android-tablets: convert int3496 devices to GPIO references
>   platform/x86: x86-android-tablets: convert wm1502 devices to GPIO references
>   platform/x86: x86-android-tablets: convert gpio_keys devices to GPIO references
> 
>  drivers/platform/x86/x86-android-tablets.c | 355 ++++++++++++---------
>  1 file changed, 201 insertions(+), 154 deletions(-)
> 

