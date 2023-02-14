Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EC06967A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjBNPLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBNPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:11:04 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BD517176;
        Tue, 14 Feb 2023 07:11:03 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-16346330067so19388231fac.3;
        Tue, 14 Feb 2023 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ida91kgTKO9jfUfX2DgG1TJn0IEk9lbU/+sk8fvVqNw=;
        b=dpTdlVPGkTf842HTKLgjCsO+7vDrUBQyDEbsSfOuLPgihocIL1j+NCmYG5+5nHadvV
         QFi38NRV30+PNJztyrENZqMNlJPRDcmqZJBw9X8tCv8lESIKzWKCQgDRGIXaP7pjSNip
         WT4DbTEOIGV+pgI6Vf/IYLaBQ6kkkjTW6PozYqY8pQWQF7H+TovbJW8qLe33wryIGY7M
         Atayt8TirDrOIhgnUdYjbamZdLo+dixdKN/wYt5UfNkbm5Gf2RO3fiuLl2NFRhslekX4
         mcLhYQrMLxArfhN3m6hfmRMELu4ePsxQt8PdQq651ggi5NaS0JVxaKKffcEEdJg/V5i1
         zi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ida91kgTKO9jfUfX2DgG1TJn0IEk9lbU/+sk8fvVqNw=;
        b=zgJm6abL/bG5riTOMzEu1OkOPzGuGV0EbMioCudkn13nStz/A7SfZbYD2vED8QE4Pk
         bKfEag8hUsZn1tGyzUrVysfuaciHgzwy5CHBpleBmkdcn8zu2gv/eW/pIzHSocUYqzU4
         24Jf8BsaO07SwvCyVl8t4VuOEmaxS18EN6U0z2xo0Qmk/ny1PYD2mznOThtgFw8YqDop
         64jYyoJCW+J68dUo3RmqBB9B6Yo+jDs+Is9HzV+BfxDLYonUkNrLFy9yNcwEWpeJhnbU
         evC2v4/h3qODKY1gdY2MXNiQu7HFPB+mKS55DGkUUgKSJe/M/G49lReZOdDaOXOwyisR
         mmBA==
X-Gm-Message-State: AO0yUKUEPdkiRB3jIjc+Pp+qykGmtVQdaDxnLi5vV15nL5jtwZ6uUmRg
        t5l2gAImgdFPQdpTVYo7g1w=
X-Google-Smtp-Source: AK7set9VLMcsf4Rg3VJCQ18mUZZg8AiqZzXbhwqL0hhrI8nR/wzCg8vgIGY3LjJm9gmswI9CL+FTNw==
X-Received: by 2002:a05:6871:438a:b0:16d:e0a0:5f31 with SMTP id lv10-20020a056871438a00b0016de0a05f31mr6451003oab.11.1676387462846;
        Tue, 14 Feb 2023 07:11:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14-20020a4a88ce000000b005177c244f31sm5971286ooh.41.2023.02.14.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:11:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 14 Feb 2023 07:11:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 2/5] mips: dts: ralink: mt7621: rename watchdog node
 from 'wdt' into 'watchdog'
Message-ID: <20230214151101.GB742354@roeck-us.net>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-3-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230214103936.1061078-3-sergio.paracuellos@gmail.com>
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

On Tue, Feb 14, 2023 at 11:39:33AM +0100, Sergio Paracuellos wrote:
> Watchdog nodes must use 'watchdog' for node name. When a 'make dtbs_check'
> is performed the following warning appears:
> 
> wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-f])?$'
> 
> Fix this warning up properly renaming the node into 'watchdog'.
> 
> Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Note that we can not apply this and the next patch of the series
through the watchdog tree since it crosses a maintainer boundary.

Guenter

> ---
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
> index 5ca40fd21662..ac818fd721ae 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -70,7 +70,7 @@ sysc: syscon@0 {
>  					     "250m", "270m";
>  		};
>  
> -		wdt: wdt@100 {
> +		wdt: watchdog@100 {
>  			compatible = "mediatek,mt7621-wdt";
>  			reg = <0x100 0x100>;
>  		};
> -- 
> 2.25.1
> 
