Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040D85B8849
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiINMc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiINMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:32:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA33736DC9;
        Wed, 14 Sep 2022 05:32:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c198so14749619pfc.13;
        Wed, 14 Sep 2022 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zV9/pNlaNjyK2el6e1fRNtIC3GGj80c975ZOZ3QDzu8=;
        b=fpjDhGArOd00NcVhciHxdWcYBZ4cGta3ByCHJ6wwiK3ZsL1+dcCyu5yaTH1dUc4RVo
         bJAnDB8HxETQ9AvtntRHw/L8aGAQ246/JDr48F+mINd4HtojNjF+yZIPFkU+dYFcKqY0
         Jf5j3C1jnmbM8ouqSc2jCK/3uhy5mmXq97F7C2TOEPcm3Qxqsr+PxcNWJ3PV7+Fb+A/D
         lC58rhZRnzuoPFbwrk73LpPxsSwoyW3nj+HyQK1OtHuXrnTjJSDRUWwRUZ6gBeEopqSV
         9DFSMcSYWp7Eui55jM/daGA9YXBP+W+QDIOb6uI73nTZj5sPTOBzbr15FvdYIScA9ruj
         JvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zV9/pNlaNjyK2el6e1fRNtIC3GGj80c975ZOZ3QDzu8=;
        b=zz5VBPffGjSIv98BwjwWsAjecsl+P9AR1kvo4Wes+ve9oNqaGOi4GGwBrgByEli869
         ItPUdCfU4KQr7lQYSxu467hginxxm399X52Q4FWEhj+aZ71ivir3AB7l4Pscl959loM9
         NvhucXda79bCeqIya592soc5P7Ue3oWsNQyo8kCQpms4UuC1/C7VmQEtrCXQLw+xivBz
         xMIpIneLUiQGz3U149KtgSPm535QQLgn+BRKBBHsAJlMM2rpNeMaUddm4BlGFp5oGeEB
         T/E0OjlilMtUDA/l6bRXtmE18dXpHFf0UL4Kpf8zYrd3f07NA6gMqVujRCYm3BW0Z3GI
         6knw==
X-Gm-Message-State: ACgBeo0WDN3/6B7ru9XesPyzUIR5Z0uYLYQxiFAxKOwDvZ2I/aRIqgLb
        9AanMf2lDgaoit/359hA+fo=
X-Google-Smtp-Source: AA6agR6tRNaPK5Q+XlGLTf7QBCvdF0OFTG9sr6Yo6lrI7k0fjU3OoTI+1Zk11+65m0d4cz9+PgI/zw==
X-Received: by 2002:a05:6a00:3492:b0:540:b30d:8396 with SMTP id cp18-20020a056a00349200b00540b30d8396mr29749270pfb.81.1663158775134;
        Wed, 14 Sep 2022 05:32:55 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2f68:fe7:a2e6:7595])
        by smtp.gmail.com with ESMTPSA id w17-20020a656951000000b00438b79c7049sm8341581pgq.42.2022.09.14.05.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:32:54 -0700 (PDT)
Date:   Wed, 14 Sep 2022 05:32:51 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, lee.jones@linaro.org,
        tony@atomide.com, afd@ti.com, khilman@baylibre.com,
        narmstrong@baylibre.com, msp@baylibre.com, j-keerthy@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v5 5/6] Input: Add tps65219 interrupt driven powerbutton
Message-ID: <YyHJ8yOF+ZhKbdlp@google.com>
References: <20220913121419.15420-1-jneanne@baylibre.com>
 <20220913121419.15420-6-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913121419.15420-6-jneanne@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Sep 13, 2022 at 02:14:18PM +0200, Jerome Neanne wrote:
> +	idev = devm_input_allocate_device(dev);
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	idev->name = pdev->name;
> +	snprintf(pwr->phys, sizeof(pwr->phys), "%s/input0",
> +		 pdev->name);
> +	idev->phys = pwr->phys;
> +	idev->dev.parent = dev;

This assignment is not needed given that devm_input_allocate_device()
is used. Otherwise:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge through MFD tree.

Thanks.

-- 
Dmitry
