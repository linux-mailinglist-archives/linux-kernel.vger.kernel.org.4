Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B066716B83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjE3RrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjE3RrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:47:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E9BB2;
        Tue, 30 May 2023 10:47:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so3519792b3a.3;
        Tue, 30 May 2023 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685468834; x=1688060834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KFcanc4CjzN6hzpjon4X1hruFFYHDR7ugE4zm99DHQ=;
        b=OdR4Y7H6Nx7sBNTAd11PEkft3yN3efyKaIhV51v9ftLHVjNGbfszMwZosHkg5dbvth
         fGKbqJWOkQEJBu9OgQv5/ubfry9JCPiWIKt6agjG7Z9uG13BkYg/lmLuPtIG+hdVAG/t
         WztyPKjFqolTIx3oqTGSy0hNZ+bgyO77i/EWyvAzYxdfOPWR07on947GOAxT3K1cYvcb
         dRauGNu4twfMxT+IxF3YuBxl3FxAjvRZnR2zhmO1CoAm7Y/bEdSRRZJFIh55JuuGY2HO
         NLZFONHUXgPe1Yd+JHK7+pyUnZAn8kTI1QC+L6ulzm5YhZyWROjecxT8gFsQvLpmTQwL
         jOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685468834; x=1688060834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KFcanc4CjzN6hzpjon4X1hruFFYHDR7ugE4zm99DHQ=;
        b=GsncgJ8SLyPCxvYEqb5ODhwfqwF65yYfU9CqayW6mzZEF+g2lCjX9W4opaZrjmQ8so
         REEWpqvefH1T8s52Dl9Jw1zKx/Poh3JIRC6iiKjgFWs6uTEx8/Z2hnJc/hnyT5foSC7V
         WIUpykHBpHCHlG75rgzTGn6k0WAGRYmLTwHspw/pTKphrkxPO55RkPwn1ptmH77y14HE
         6pJFOCpO5IUHilskTy/SxHyNN2vx/wWp3VqPlW7iigNZjqtOIc+ezg/B62U6cesIl19c
         61Kz+lLvro2UhdPW1+HmWXO6XEyNlDH//Y3i24GVGOU7R5Gdv1lgfSiVwS77XSkTurbv
         /9+w==
X-Gm-Message-State: AC+VfDy66KYeCdd3N667pwXkru2LGLsmVDwmk85bilzipetsMjktJJx3
        qcCmXPV6/P0dRZJpcu77HTI=
X-Google-Smtp-Source: ACHHUZ5H1oTyoutcnUo3XiPYYzwua35COz5cA3FRa6JU3oW4ADLdTbZES7lj7v/2W8drbB6s7qiXwA==
X-Received: by 2002:a17:903:24e:b0:1af:ff02:bc19 with SMTP id j14-20020a170903024e00b001afff02bc19mr3552294plh.26.1685468834029;
        Tue, 30 May 2023 10:47:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902b60400b001a6f7744a27sm10604029pls.87.2023.05.30.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:47:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 May 2023 10:47:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 7/7] dt-bindings: watchdog: restrict node name suffixes
Message-ID: <2aaba5d8-37ad-4086-a81d-0d3e78cf5664@roeck-us.net>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:48:51PM +0200, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to -N suffixes to decimal
> numbers.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/watchdog/watchdog.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> index 519b48889eb1..f0a584af1223 100644
> --- a/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> @@ -17,11 +17,11 @@ description: |
>  select:
>    properties:
>      $nodename:
> -      pattern: "^watchdog(@.*|-[0-9a-f])?$"
> +      pattern: "^watchdog(@.*|-([0-9]|[1-9][0-9]+))?$"
>  
>  properties:
>    $nodename:
> -    pattern: "^(timer|watchdog)(@.*|-[0-9a-f])?$"
> +    pattern: "^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$"
>  
>    timeout-sec:
>      description:
> -- 
> 2.34.1
> 
