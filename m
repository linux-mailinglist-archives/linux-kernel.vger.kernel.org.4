Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82894658527
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiL1RNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiL1RNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:13:41 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF9D9C;
        Wed, 28 Dec 2022 09:13:40 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s186so15277639oia.5;
        Wed, 28 Dec 2022 09:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDlPIvmC/xt4kOuFbtfg47oovpRetVp1HhNleVf2U20=;
        b=HkpHVoA9bjYBGT+pPqxgFKNizPh7KPCxXgX5Bih0D0qvtDLLRbCPvX7YquAgwnHSXI
         kzBAouVNedTEHK8SPme0QzuOhdcGM1P3psT6KKKfiGWSxiLY9gFHmSJLenyDl58kFa2u
         xwGXitPs3VgzK/xxWzPChS6W12UXKEBZ10vE3a9JCzaLuzSdWkqwTbM5s/uxdU2m0Krk
         evE3VnfSWiLbFxJqBibliTae7V7huJ3/g0gy1OjbiExHd7D5jWn/a5/mP1OhlQvCvW4t
         BVygOf6/FzSEVyhMV9DI1ZvHidvR+RhJIC/0sF+l7NviBWloOfl7tcmWPiYjYVmX6PAq
         FH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDlPIvmC/xt4kOuFbtfg47oovpRetVp1HhNleVf2U20=;
        b=f1jO2kXA9SMgBp8Xs2OnCOEa1O44npF0/YJSfiKNx95uKZWE7BmXrWh934/EljTEXc
         IqvesVZfRK2yVFz2YKPb0VVS0RqwGwfcdLsCGaaGN+TcZ1bCkrXSm2ZxEHP6o0Ub1FB8
         rtgue2jS5Lbq9rkhp8OfAYBlrLn6nM+8b6kmuxptkgsS76WMcZig81HdMEwwq3VP/IGO
         3p04aCcyg4lxgUlWPFkv4H+/n+JORYYc8LPPQzUSrFimAWIKx2+TfQgbc2S1yKMQpQCX
         Poc9U5BL+lwo+Dg6/b7t1Wj7FxtQSOGwsMA3XDPZuiyswbKCwreXGJpyWzFgLOzEUoiF
         5p3A==
X-Gm-Message-State: AFqh2koQquidZJEE+W74RGv9hN5MpBEGzqH7qDmAJdJ6pK5P4+22aX2X
        y/CX8sv7kMWlBZYhB1kPmqw=
X-Google-Smtp-Source: AMrXdXvDdhLjT76F1Ootk40zJcQRcgv3CJHuy3vUYeYJRrik+XXpr9zTYkmxE833f773U4IVK55CDg==
X-Received: by 2002:a05:6808:18c:b0:360:e6ba:eb0d with SMTP id w12-20020a056808018c00b00360e6baeb0dmr11396746oic.13.1672247620287;
        Wed, 28 Dec 2022 09:13:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bk10-20020a0568081a0a00b0035c422bb303sm7195761oib.19.2022.12.28.09.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 09:13:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 09:13:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/6] ABI: sysfs-class-hwmon: add a description for
 fanY_fault
Message-ID: <20221228171338.GA2575581@roeck-us.net>
References: <20221130200846.4226-1-nick.hawkins@hpe.com>
 <20221130200846.4226-3-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130200846.4226-3-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 02:08:42PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Document existing fanY_fault attribute.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

Applied to hwmon-next; no need to resend.

Guenter

> ---
>  Documentation/ABI/testing/sysfs-class-hwmon | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
> index 7271781a23b2..638f4c6d4ec7 100644
> --- a/Documentation/ABI/testing/sysfs-class-hwmon
> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
> @@ -276,6 +276,15 @@ Description:
>  
>  		RW
>  
> +What:		/sys/class/hwmon/hwmonX/fanY_fault
> +Description:
> +		Reports if a fan has reported failure.
> +
> +		- 1: Failed
> +		- 0: Ok
> +
> +		RO
> +
>  What:		/sys/class/hwmon/hwmonX/pwmY
>  Description:
>  		Pulse width modulation fan control.
