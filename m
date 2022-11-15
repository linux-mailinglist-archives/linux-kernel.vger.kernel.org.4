Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2962946E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiKOJfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKOJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:35:45 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F5B10B58
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:35:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a29so23528383lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ6Oz0sLUjFX7pwq6JQ+9oBAMxDNq4ohGil/uu3b+jE=;
        b=FDjNKPXQhWpbc5h0A/hhim/Ps0oJjRZKZN7CUzZbshJ2CQzXoXA6GFrHjQU8nQok9+
         2JT6/9/wf5XTuZ0Hjs2msjSmpXXqLN5SGiaKe9qaIuHeKt0UETpBq4q6VH/+CQ7BGQSW
         HjjOnuec9xggd6oEvY++h+1OF+Oi6Rc6SM97oWoSH0le5a4QG0Gt8W0us5hJ7yvw5+U5
         Osiay8K8Uy7BD7IbrzL3tURMFHpx3JE0zo39ZcxcWrTQNdT26b+SsLHV6qYOTQrs4fYX
         VjuWKMA8/gq+nhjPKg/u3XOmchJWOq5BtyyS8/X1/Gkfuxg1Z4ATEA6spEbIQ5X5ogyc
         tKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZ6Oz0sLUjFX7pwq6JQ+9oBAMxDNq4ohGil/uu3b+jE=;
        b=Q14lndO4imJ9T9p9A6wV9I4EMO2XPIf71N+B9L8IWF+tZFIVdMHEo7xb0pMIRcny5M
         GGrmmroGt7aCfy80wfIRVa8iIRKZI2JWI9Fh5IrSJvhMoIjAGCYq0NOVjUaZHo0LXdnK
         qXqcTU6/apuxFX4utjaD7igzaJKv5NKH5UZCUDj17C9lOTIlHCUkl52FRVD4izKghByX
         VgcHyjpfeQv+hukMoI3c6TiEy80CcGo0qLtJvRRNie+zWEmMt5jWJq1fsAvoqyChmm0v
         xxIrjBLFxrVDRLYFPty4D4Yu58NpLS9HyxH8OtvNOpha7hbsgbl7AQj/PEKPCmhT1/3T
         hmqA==
X-Gm-Message-State: ANoB5pn5zWnbIrN1it2PF1/TgYkZgOaN98seuBCgtGQSMW7qTjdYrdT+
        8yJ+KKt9lqKDmyT19kzrPOo7ag==
X-Google-Smtp-Source: AA0mqf4f0lXKjEINfFwZBuMCFvAJLYZv9A+U/hJvSeVgjo2hNcPftEhehAL7kQxRJPvOb7ggd0vNuA==
X-Received: by 2002:a05:6512:3696:b0:4ad:5f5c:2b26 with SMTP id d22-20020a056512369600b004ad5f5c2b26mr4945691lfs.626.1668504943014;
        Tue, 15 Nov 2022 01:35:43 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e0c52000000b00277351f7145sm2332083ljd.105.2022.11.15.01.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:35:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aakarsh Jain <aakarsh.jain@samsung.com>,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        andi@etezian.org, smitha.t@samsung.com, jernej.skrabec@gmail.com,
        krzk+dt@kernel.org, alim.akhtar@samsung.com,
        m.szyprowski@samsung.com, dillon.minfei@gmail.com,
        ezequiel@vanguardiasur.com.ar, robh+dt@kernel.org,
        pankaj.dubey@samsung.com, benjamin.gaignard@collabora.com,
        andrzej.hajda@intel.com, aswani.reddy@samsung.com,
        mark.rutland@arm.com, stanimir.varbanov@linaro.org,
        hverkuil-cisco@xs4all.nl, mchehab@kernel.org,
        david.plowman@raspberrypi.com, krzysztof.kozlowski+dt@linaro.org
Subject: Re: (subset) [Patch v5 3/3] ARM: dts: exynos: Add new SoC specific compatible string for Exynos3250 SoC
Date:   Tue, 15 Nov 2022 10:35:40 +0100
Message-Id: <166850489230.15995.9764434606186169223.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114115024.69591-4-aakarsh.jain@samsung.com>
References: <20221114115024.69591-1-aakarsh.jain@samsung.com> <CGME20221114114412epcas5p43350b596e52a98eb69406574b4a16171@epcas5p4.samsung.com> <20221114115024.69591-4-aakarsh.jain@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 17:20:24 +0530, Aakarsh Jain wrote:
> Commit 752d3a23d1f68de ("ARM: dts: add MFC codec device node for
> exynos3250") which adds MFC codec device node for exynos3250 SoC.

This sentence ends prematurely. I don't know what you wanted to say here, so I
dropped it.

> Since exynos3250.dtsi and exynos5420.dtsi are using same compatible
> string as "samsung,mfc-v7" but their node properties are different.
> As both SoCs have MFC v7 hardware module but with different clock
> hierarchy and complexity.
> Add new compatible string followed by mfc-v7 fallback for Exynos3250
> SoC.
> 
> [...]

Applied with changes to commit msg, thanks!

[3/3] ARM: dts: exynos: Add new SoC specific compatible string for Exynos3250 SoC
      https://git.kernel.org/krzk/linux/c/c9259e0d224b15a734673200e0825fae5ea2ab1e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
