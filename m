Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27455715A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjE3J2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjE3J1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9BAD9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685438722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGFdC+Cr7aKjAl09TH5gAS+8YxPdVhcFSlEZ7wtzGTo=;
        b=OZohiWF3dHisbx1uZQqPCD5/IXOBPtLNFiPA5WFSPG2OzAzr8YfpkMmSlUOaXaC2/6JhZ+
        kJdccbosV9h6+74Sqp5m1x44qv6FyN8brvCYRE3VDrlVa2qcy4GBMB+fXJJBL0/ek42CM7
        nJ2S3k/RSFOcPwwdmvFG4WzC6RiqTAA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-0_gLDks5NVe_vrtYma0wAg-1; Tue, 30 May 2023 05:25:21 -0400
X-MC-Unique: 0_gLDks5NVe_vrtYma0wAg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-514777266a3so3283033a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685438720; x=1688030720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGFdC+Cr7aKjAl09TH5gAS+8YxPdVhcFSlEZ7wtzGTo=;
        b=PQRrhWIKbo+00y3T9fxK2mqzla/u54pePfoy10Z80/hXjHfzDiFt2Ij9EWRbBZS5iw
         dFGpJ29YiaqIbhS63LtbQoUdPlQBStq1jww71hxo7yHkDcXwyySNyxhrRfE/vasPeUjh
         DvC7A6wPsST+05mqa5iVorFqPQQeB60om1cEKcwzxLE8tsUcXHvn/RmApp5eyKuvej+f
         6UEg8CSgTfSvik7u4YrCYAsXG+cxlaqMe5tihx6LqQ9r9XrDh2a9YCguhNZgIrX+XkWf
         3V2YlvgfVM1qaspSQfvgPcRPoLnGh2OGALaBz7lI+/L84dKDJglqJHhzblBbBJpYvQYQ
         R3OQ==
X-Gm-Message-State: AC+VfDyGiOHmcWnsmcLq4rOXwT2Jokp0bmVhg7i+4ERAxv2XRDMV5CT2
        VkSNcTQoUGYfTvluC0p+qNUIc4pTrOIB2Haubsh2f0xmjI6+imfwvWUqlQMZk7jhVhPcKduFKj/
        sPsxYjfn9tptgG3XjiM7zq58y
X-Received: by 2002:aa7:d586:0:b0:508:3b1f:e6b5 with SMTP id r6-20020aa7d586000000b005083b1fe6b5mr1131319edq.15.1685438720208;
        Tue, 30 May 2023 02:25:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ511i+IlMrjdQEJaICGOkr307RIVrnzNJvm1eJGPS5QvRTCkjJO0Vsv78u0FAcgUlNcYeeTIg==
X-Received: by 2002:aa7:d586:0:b0:508:3b1f:e6b5 with SMTP id r6-20020aa7d586000000b005083b1fe6b5mr1131312edq.15.1685438720035;
        Tue, 30 May 2023 02:25:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ca28-20020aa7cd7c000000b0050bc6d0e880sm4100809edb.61.2023.05.30.02.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 02:25:19 -0700 (PDT)
Message-ID: <1cd0a13e-1842-2e1c-524b-e9580ea48b52@redhat.com>
Date:   Tue, 30 May 2023 11:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] platform/surface: aggregator_tabletsw: Add support
 for book mode
Content-Language: en-US, nl
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525213218.2797480-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230525213218.2797480-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/25/23 23:32, Maximilian Luz wrote:
> Surface devices with a type-cover have an additional "book" mode. This
> mode is activated when the device is oriented in portrait mode and the
> type-cover is in an open position (including completely folded back;
> unlike in landscape orientation there are no special modes for any of
> the intermediate positions).
> 
> Currently, this mode is unsupported by the tablet switch driver, leading
> to an error message (see individual commits for the exact messages).
> Since the keyboard and touchpad input gets deactivated in this mode, map
> it to tablet-mode.
> 
> I've split this change into two patches, one for each of the subsystems
> (KIP and POS). This a) allows proper attribution via the "Fixes" tag and
> b) with that should allow them to be backported fairly easily.

Thank you for your patch series, I've applied this series
to my fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

I will include this series in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans






> Maximilian Luz (2):
>   platform/surface: aggregator_tabletsw: Add support for book mode in
>     KIP subsystem
>   platform/surface: aggregator_tabletsw: Add support for book mode in
>     POS subsystem
> 
>  drivers/platform/surface/surface_aggregator_tabletsw.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

