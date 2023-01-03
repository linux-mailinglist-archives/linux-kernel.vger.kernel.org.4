Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1829465C8FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbjACVgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjACVgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:36:12 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42F31112;
        Tue,  3 Jan 2023 13:36:09 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1433ef3b61fso38258445fac.10;
        Tue, 03 Jan 2023 13:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNUKxvrHmcIA89tmaFwCfLMzI7iP8jQKEoV7Sjy4mpw=;
        b=qkkDWQE2iuKR6V2q8puC6QQ1JkkAuMlQfV82w7KE+o3ub1x0WBJYkL3+DYTN/ADave
         9dqttdRGRrzlWbH9p6GKYGVQjcL/H3jmm6PlTfWlYbY+EGBp0l/C8rqlJlrtHePGkshx
         UnzMdnpR1UAiOQckh/ZTQN3KYQVURvQsCabddCco13B+XGmasfTDurLy76JWIhYULXac
         SF36nWS36b2QvUEuNCrR1mrrWXG0L7Q32xVBKrTNpLrOrfoHJprAI9Z8zzlPn1NM4zvX
         PKZNgIPCfq1srf1gsT1wrLV4pqMJyEIH9Kb92vuq/h99qkMaUGIuuQWHNzU/EGR1FINi
         xI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNUKxvrHmcIA89tmaFwCfLMzI7iP8jQKEoV7Sjy4mpw=;
        b=rC6toxAXKDjv9wiMsVZVgcI1NuEO+anBxaVShs9STYC1j3z0lE0rMpYRJLB1ubRn2x
         Lj8L5YSNLoNSdu7lOUwENKeOeEvkGOeKJqdo+20AChT4h5Ou9ga9D0rP7FPoo422L07W
         gp8FJY82Z1Fl0GTF4clhLZxoUe+4VS6OIXih2GclWYXq3ux6dA6vweqOsEfFtWibZyjt
         B0kMMdXsmpe4mje4dcp2nWSLilcuYemd9b3YFiUGtxy/7ddtUqPK+TIcJGbQd/pGyShl
         vNNnc14sn+UlWrHNF2YjhJw/LVU5hxlgBc0HgIzqhENbwGUStjz9TccCAeB9Sw0AqYwI
         l9Uw==
X-Gm-Message-State: AFqh2koYinq77s+W1TgBZuMhupDx29Rd6wVcDS1sq2AvgWtO7r0loYVe
        A63XPE2lk/lthJj3IwZatrQ=
X-Google-Smtp-Source: AMrXdXsiQhODPNOQiY3t4RUTcdLet7k6YGCoqyaS22wMtqPFUVzvxjEdtQpnGYsrJYPPsaLMzuT13g==
X-Received: by 2002:a05:6870:a1a8:b0:143:89ce:80ee with SMTP id a40-20020a056870a1a800b0014389ce80eemr23687305oaf.20.1672781769263;
        Tue, 03 Jan 2023 13:36:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fp15-20020a056870658f00b0013ae39d0575sm14750693oab.15.2023.01.03.13.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:36:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:36:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 5/5] MAINTAINERS: add gxp fan controller and documents
Message-ID: <20230103213607.GA216349@roeck-us.net>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
 <20230103203654.59322-6-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103203654.59322-6-nick.hawkins@hpe.com>
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

On Tue, Jan 03, 2023 at 02:36:54PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add the gxp-fan-ctrl.c and gxp-fan-ctrl.rst in hwmon
> driver/documentation.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> Reviewed-by: Guenter Roek <linux@roek-us.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v4:
>  *No change
> v3:
>  *No change
> v2:
>  *Added missing gxp-fan-ctrl.yaml
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1daadaa4d48b..00b52be102d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2216,13 +2216,16 @@ ARM/HPE GXP ARCHITECTURE
>  M:	Jean-Marie Verdun <verdun@hpe.com>
>  M:	Nick Hawkins <nick.hawkins@hpe.com>
>  S:	Maintained
> +F:	Documentation/hwmon/gxp-fan-ctrl.rst
>  F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
> +F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
>  F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
>  F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
>  F:	arch/arm/boot/dts/hpe-bmc*
>  F:	arch/arm/boot/dts/hpe-gxp*
>  F:	arch/arm/mach-hpe/
>  F:	drivers/clocksource/timer-gxp.c
> +F:	drivers/hwmon/gxp-fan-ctrl.c
>  F:	drivers/spi/spi-gxp.c
>  F:	drivers/watchdog/gxp-wdt.c
>  
