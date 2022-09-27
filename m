Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90B55EBCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiI0IP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiI0IPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:15:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B66CAFAC6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:12:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c192-20020a1c35c9000000b003b51339d350so6513292wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=ZWYEuc1YfYOK9SsTFoMGj0wBsGs5m9ZmF0vJ407XFBM=;
        b=ge+r2o1aLvQ3NraoYpGfE9LaaLj8GTbgeo8UCuCv7CTBVGwwNBSx4nXgAizxZ7ALxV
         6LJuCbJlRGPTcOpi+KMQ2oShJHhJlMRCQLJwQt++Hgo7lY+JGn/e01GF7BonGw0v9/ee
         EnQ/s8lQRWhUPGTF8JXv7UmvjjmZi+yYXOZ7gHxBjZgQQpWLBjObA0YkNb5dLxgXzOsL
         X0FZFUwrW57Uj+Sy6iX2SpAhn9G/8wDq/T5gvHSE7yzpPQsQeT867lVvpLXn4MgfY6BP
         vZ9IxV9m01PBy4/BT3aW5haLcKpE5XIJGZ7k0fj0q8QE4qW3JWkwxxW7NkrbZZc9jkOz
         eOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZWYEuc1YfYOK9SsTFoMGj0wBsGs5m9ZmF0vJ407XFBM=;
        b=7CXvb8d6t2MIjc+Pos90aqo+USyD8qVSHBDf7RYJstaXot+MvQWXL0nkRCGOKA2k//
         iuqR1u42+PRC35oQ2uG02taW2vO0UGN+2WJd07eKZ0kDRK9lM6l6fihXKUUYR7dPrRgJ
         h8HsqmCrmLafxdB0N9bSKFTWy9DQ8ybueFw9ZnC1f35fbZkqFc6+5gTs22FESVqqKff+
         nqhUZntOLANHeCeOso91Tmypoglo7D28yjM6pjfRpirDXi/ERhW+TYMh6/hHg9oZ+Fp0
         O2CVGxnyw/jUbGAUj1Qx+aIAyjyrsoxKjy6jlaKlyztV/S1oyk1qd3xp8N89r96Xg3Hx
         A+yQ==
X-Gm-Message-State: ACrzQf0K+nD5a+s9TxwROy82WY14FwUg5mQdifh67rOb4QJ7kX7I4z1R
        o5V4+i5CUcHFM3a/cNSjrQ77QbioqH+kRw==
X-Google-Smtp-Source: AMsMyM5fZUz2xa/hcrWWxqrOvsBz+AH+lsifruKQKHHg23rc/e8c/HXHXvB4Vt/cvu1g/rxAAWCE/w==
X-Received: by 2002:a05:600c:3cd:b0:3b4:8372:294c with SMTP id z13-20020a05600c03cd00b003b48372294cmr1656061wmd.191.1664266370088;
        Tue, 27 Sep 2022 01:12:50 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id f10-20020adff58a000000b002285f73f11dsm1298734wro.81.2022.09.27.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 01:12:49 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org, kernel@puri.sm,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, stable@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH v2 RESEND] input: keyboard: snvs_pwrkey: Fix
 SNVS_HPVIDR1 register address
In-Reply-To: <4599101.ElGaqSPkdT@pliszka>
References: <4599101.ElGaqSPkdT@pliszka>
Date:   Tue, 27 Sep 2022 10:12:48 +0200
Message-ID: <878rm5nslb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:25, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm> wrote:

> Both i.MX6 and i.MX8 reference manuals list 0xBF8 as SNVS_HPVIDR1
> (chapters 57.9 and 6.4.5 respectively).
>
> Without this, trying to read the revision number results in 0 on
> all revisions, causing the i.MX6 quirk to apply on all platforms,
> which in turn causes the driver to synthesise power button release
> events instead of passing the real one as they happen even on
> platforms like i.MX8 where that's not wanted.
>
> Fixes: 1a26c920717a ("Input: snvs_pwrkey - send key events for i.MX6 S, DL and Q")
> Cc: <stable@vger.kernel.org>
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Resent <20220321171755.656750-1-sebastian.krzyszkowiak@puri.sm>
> v2: augmented commit message; added cc: stable and tested-by
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 65286762b02a..ad8660be0127 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -20,7 +20,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  
> -#define SNVS_HPVIDR1_REG	0xF8
> +#define SNVS_HPVIDR1_REG	0xBF8
>  #define SNVS_LPSR_REG		0x4C	/* LP Status Register */
>  #define SNVS_LPCR_REG		0x38	/* LP Control Register */
>  #define SNVS_HPSR_REG		0x14
> -- 
> 2.35.1
