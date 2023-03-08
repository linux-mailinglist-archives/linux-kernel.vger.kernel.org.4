Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50AA6B10EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCHSVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCHSVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:21:05 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7428FBAD24;
        Wed,  8 Mar 2023 10:21:04 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-176d93cd0daso10238842fac.4;
        Wed, 08 Mar 2023 10:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678299664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wR0AfJcsLAOUlEMSX8ruTYQWGoFoowLSM3k3TJ/818=;
        b=byijo6EjlWbP3k7n46FwrUzAJOM+WXSTOPbD/icC1w/z28jeIRrkRc9JPVz0kwK1Jl
         gluNyL3sANHMxjxHcaNvWttyOYxDgOLmowylStg/Hde5AThhGxDnFVhpbwpfZ7YZtRHN
         wuGRIPFLDnv3xujoYcM7SuzdiYSafwT4Elj3GxBY/TdbdocfY++3yK3dnbIGnBLS53br
         VMWyOAUudsNbMVDyszO9cLSpHKY5zBQnDrjVHikgfDgOoKXcBRPYxXxo0MbrJTsJn70o
         afQduk90PbFqrMi6a/c34NyAbPp2U6fhVFRHx6aBF4zIPVpmO1qpbw4z2I38bS0NANY+
         jymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678299664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wR0AfJcsLAOUlEMSX8ruTYQWGoFoowLSM3k3TJ/818=;
        b=nzJgASzBjVLeaBnkvlrVFbEZFGEQ/2qu3Nug9ogQqvsLREoal1oNzor3+aYrhYT68D
         HqI0EPwuoIN+I7IsEUrs3yIcl8QzyEVvtssdyF2ctphaxNrwRFmhPMVxSozQ5FutJU0p
         asfGNMXzsN9VWeZih3lmBvWxnsdiAxmaj09GWgZZK4b2nbu9jBQm0NfP582lmrNoPdAU
         rVjDLOjwA8XEXrrl+hkWuWP6GG49q7qWBGT5rT9WquJWsw5I0J0gqOysuebLK52zEeFm
         FNWXasze+XUOy60vOy49C4mQUMHRgXRxacZFWxS6Ya9sPsl7HNfbprqyfq5zy5duWuaX
         LSjA==
X-Gm-Message-State: AO0yUKUiTEhO/r0ADoCSKSpiznOCzZJQrdWMyapxP5UwtKjfHJYFvK3N
        JPKaAVFNuu0IeSer0d2yIks=
X-Google-Smtp-Source: AK7set97zqhU/ekFhxyZa194OvBZeInVE7UVZOGK9JCx7rFMnfd8qSlI+x9FBmKURHwz+r3wPpt+Gg==
X-Received: by 2002:a05:6870:d0c6:b0:163:36d5:35e2 with SMTP id k6-20020a056870d0c600b0016336d535e2mr11008699oaa.22.1678299663754;
        Wed, 08 Mar 2023 10:21:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q10-20020a4adc4a000000b0051ff8fe948esm6384417oov.1.2023.03.08.10.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:21:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 8 Mar 2023 10:21:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Tessler <jrt@google.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joshua Pius <joshuapius@google.com>
Subject: Re: [PATCH v2] media: cec: i2c: ch7322: Drop of_match_ptr
Message-ID: <776ddcd1-9f41-4b6e-882a-dc5e7abadc66@roeck-us.net>
References: <20230215214724.3798917-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215214724.3798917-1-linux@roeck-us.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 01:47:24PM -0800, Guenter Roeck wrote:
> The driver does not instantiate on ACPI based systems if OF is disabled.
> Fix the problem by dropping of_match_ptr.
> 

This patch has still not been applied, so ... ping ...

Is there anything else I need to do to get it applied ?

Thanks,
Guenter

> Cc: Joshua Pius <joshuapius@google.com>
> Tested-by: Joshua Pius <joshuapius@google.com>
> Fixes: 21b9a47e0ec7 ("media: cec: i2c: ch7322: Add ch7322 CEC controller driver")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Added Joshua's Tested-by: tag
> 
>  drivers/media/cec/i2c/ch7322.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/cec/i2c/ch7322.c b/drivers/media/cec/i2c/ch7322.c
> index 34fad7123704..3c6e6496a001 100644
> --- a/drivers/media/cec/i2c/ch7322.c
> +++ b/drivers/media/cec/i2c/ch7322.c
> @@ -589,7 +589,7 @@ MODULE_DEVICE_TABLE(of, ch7322_of_match);
>  static struct i2c_driver ch7322_i2c_driver = {
>  	.driver = {
>  		.name = "ch7322",
> -		.of_match_table = of_match_ptr(ch7322_of_match),
> +		.of_match_table = ch7322_of_match,
>  	},
>  	.probe_new	= ch7322_probe,
>  	.remove		= ch7322_remove,
> -- 
> 2.39.1
> 
