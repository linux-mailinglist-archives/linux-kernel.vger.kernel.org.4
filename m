Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5965689D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiL0I74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiL0I7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:59:54 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D964EF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:59:53 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id e13so10591499ljn.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMN5DjdXVGY4mvOE68Hle4bCHMTIkVTbibmpiWxbBPQ=;
        b=ggD/er6MwaOH37j0DKAjeXxjLtZEC2uHDCbUkkP6kVfzsvdd6YRr0q7qvFmpPBwbpd
         qY0s3Kww4Lc9H0uuXLmrNKxqu3R6V7t9OAUU16hoUTNaC2aRIEB1l608WcEiGMkmz6ZU
         2KNymXkyWVwamocPfDp4nfsR5/6sMl9rADzuHGhoBLsN6b2qOBvN/XIhp9n/nLiXFWmd
         JSxSqYf/cB8aJ9OdbECg2OhBDmyTmCIfP+uDsHCrCSPG6jNjUVMgPs9iyXAJY++EIXzm
         5bF8UJOmllK+Vduvl8hffWGnlHrnxJvaOV9IVS6MM54bH93ZOIhOme/O956KY3bF/t8z
         Zzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMN5DjdXVGY4mvOE68Hle4bCHMTIkVTbibmpiWxbBPQ=;
        b=mcZqTaxVJDgaUpUb3Xf1ECNHfqTgOVLF4fh64mxc7gqMuh1Wp5eTritMAjk69h2O5H
         CUqUC40tomebXihoXpdQ+zIbMbyPKhgr7kfXqYPl/Dzovkp6fWMs7GPMzSbVWL0XHu4N
         dGGo+TcANhsXaPpTG6rdvcge+pmy2v2yszqrByy8qzNKvF4PP2PJhNkNlqRSQeE4sG6f
         69kSkzsPUY4XN6gULv0iftK1ABGOgpRwMqCeT0ScUYuwYPw4C8ncNEp+sJe4hZDD8hPu
         ctO8nJRKVc4HK4Gp5iWeQp4SULacZm3LjmNROliRodnpo/R47Erq7NOiDFE7nnwWKqsO
         5L3w==
X-Gm-Message-State: AFqh2kruIX1EXFyivmao+cXmWsEu2EMzAJYLImHUj4e0NLUI0wAXQnPp
        +eSefqQrtT4r+lobj6v2UE6QrQ==
X-Google-Smtp-Source: AMrXdXuRHMgnHORnc3Fnac3XVuAfIt5LPsRpYo/4ITfkOWW6bErbWVwICQmRBtu1hQEgWrmv33NujA==
X-Received: by 2002:a2e:934c:0:b0:27f:b489:d8d4 with SMTP id m12-20020a2e934c000000b0027fb489d8d4mr3729494ljh.47.1672131591753;
        Tue, 27 Dec 2022 00:59:51 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c031200b0026bf0d71b1esm1534837ljp.93.2022.12.27.00.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 00:59:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        nicolas.ferre@microchip.com, mripard@kernel.org,
        alexandre.belloni@bootlin.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: mvebu-devbus: Fix missing clk_disable_unprepare in mvebu_devbus_probe()
Date:   Tue, 27 Dec 2022 09:59:43 +0100
Message-Id: <167213158106.15520.1724500353419940365.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221126044911.7226-1-cuigaosheng1@huawei.com>
References: <20221126044911.7226-1-cuigaosheng1@huawei.com>
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

On Sat, 26 Nov 2022 12:49:11 +0800, Gaosheng Cui wrote:
> The clk_disable_unprepare() should be called in the error handling
> of devbus_get_timing_params() and of_platform_populate(), fix it by
> replacing devm_clk_get and clk_prepare_enable by devm_clk_get_enabled.
> 
> 

Applied, thanks!

[1/1] memory: mvebu-devbus: Fix missing clk_disable_unprepare in mvebu_devbus_probe()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/cb8fd6f75775165390ededea8799b60d93d9fe3e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
