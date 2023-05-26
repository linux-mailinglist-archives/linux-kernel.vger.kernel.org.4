Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378547124D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjEZKgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243209AbjEZKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:35:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9916E46
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:35:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30789a4c537so316000f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685097330; x=1687689330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBqku5q9vZ6Xc8ZaZQnGRftVBfKjrmfStPvoq/Z7tIE=;
        b=smTVu85CUKKohcCM2dZok368NM60if6zrxbJOJps1F1bJe9WsF6ZMP9AKyWLYKyR2c
         FvFdAH4nZbStiwbdSje5qJ62m1Kg2b5XtOu7XtCd5NmXXcQabQPO+bBUlJbDAK1z7uSi
         c353VExyqov5R5cn6Sj2mpS45ggaPoATZkdeeTuekTZgBC/BjYWo9DHcZ+4HVSbDqiXX
         8BU/BFg5PGdzFXmH1XmGKjC/gnKbdfO123jEYaGG1cVca4F7DZ0Fq2Wb0Lh3CM4IxQw/
         1NA5mnOjuuElJAuKP2duGE/NLnQUAi0z10IuuipjreNrATHcpQzAKrdG8p1P5UqgYqHg
         W4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685097330; x=1687689330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBqku5q9vZ6Xc8ZaZQnGRftVBfKjrmfStPvoq/Z7tIE=;
        b=J1fxOntTrJFrsliHv8hBow0QHUHTO/8OFWxYJM4wDwfAlJyTuqdgC8TMm0F7N2O6lC
         5FXubBhLnXazA9px22OLALHN13JE+1WgRyZFIgXCvDYAm5+fAIWI3VArAjEeGlzZoifj
         cvYDA+zoInGdg437scaZu4WF4cfA3pXuQDT20AOKUBacqzNk41m2N7Bnw/Oudy64gLRD
         ZFIQJaaKLOEoAc7wyOz0AgxEO0+SiPlPd5dKyLMokCTlyK6IVS4RVIytwwkX7s+NxK+a
         0ReraXHrCKKZM3W887wBeMbqA3vzz6GPit69NqsU4Aqo+Qzklf5kLo5oH4RPYnpP8ElT
         IM8Q==
X-Gm-Message-State: AC+VfDzsZFPV96A90P1S53rhuwGzk0H9aiD/HtoLljFTmRYiQhjzMFLB
        Dw0YNE1wpYOCzt9U2oBpsIrxwg==
X-Google-Smtp-Source: ACHHUZ6AYKcJLt+byatanAoL/NXFYaied7fayFtzagQ+4cmKoccBEbRSJIIocsCnjrEb67L30dbJDA==
X-Received: by 2002:a5d:6aca:0:b0:30a:dcb9:a0b9 with SMTP id u10-20020a5d6aca000000b0030adcb9a0b9mr429105wrw.46.1685097330287;
        Fri, 26 May 2023 03:35:30 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id b14-20020adff90e000000b00307972e46fasm4520818wrr.107.2023.05.26.03.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:35:29 -0700 (PDT)
Date:   Fri, 26 May 2023 11:35:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: backlight: lp855x: convert to YAML
 and modernize
Message-ID: <20230526103527.GD626291@aspen.lan>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
 <20230519180728.2281-2-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519180728.2281-2-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 08:07:25PM +0200, Artur Weber wrote:
> Notable changes:
> - ROM child nodes use dashes instead of underscores; the driver
>   reads all child nodes regardless of their names, so this doesn't
>   break ABI.
> - pwm-period argument is deprecated, as it effectively duplicates
>   the period value provided in pwms. The driver continues to accept
>   the property, so this should not break ABI.
>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
