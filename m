Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208F26ABE75
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCFLji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCFLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:39:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A850728D11
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:39:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g3so37301556eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678102761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOwpkhY0VMzGqwYvvdIIY+PDDP+eSachjPL5/6vvxwc=;
        b=uHGGjWaLwwtd1qnco3tAffq4+y4t/BBWgWyqTg8tohKtzY+MKYR41mDbatfLhGkPWJ
         X2Z/pRrbMHS95UNiZegynAI1GEndlXPgaMaoQI9CPO7Ftln7OReiHnVjuVt8OG3XTNOx
         X8N+dGEHyMc9/ESqPkkUyUhkF7Xx50SAjCZJmu9sAUnsLVr/N2KvXjXXhlF7T/g9VZir
         fUR9a4YLJldfvwQfz6zIvd+kyOpHoWJq6hC5pKMtpeJErjlP/FWNH/w/bQFjg66S+dRg
         27DWdFsHJ/7cF0JDJq8/7KP/1XRyyxTYxfeMztO7dZx8R3RIPPu+qXStvgKgtpieKodf
         jwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678102761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOwpkhY0VMzGqwYvvdIIY+PDDP+eSachjPL5/6vvxwc=;
        b=sqayN6XixkFX4Zk8NKAO3MsCA9av5WibDCoV3jgB8/vSOW6ya8faL0ihmkwVRJag4G
         x9O+tYTokvG5fVVS2/IGDTtNUDsuBEmKg1Hdrb+6V36YCfr0/nVYyRXfasbt5L2WYD2n
         ZuIaceGbHy/u6O5vktB+4iC0+I5YQHZWdLUfFLuG3L2c1Uhf6gB4+WJe+Dw7BxnjEVYc
         TIhz79iFJVrmUlFBtXircOKGBg9ggqDmd6A9GJR9ycUw/NJJUOon5Ltxn0WXMdHaEEic
         BH+b91bPj/fcNz9t8sFUsQCM9jYbB2GsOC03Wd5szjwzwuC/bzwcIhjYN6o0nhyVwx/8
         ujEA==
X-Gm-Message-State: AO0yUKVH0V13eHc0s1oz63tZpVFAhuM2gIUBq24UyPXieRbS/zOvFvc4
        OJG5cqnafoeZRu4zIR6PV+iqRA==
X-Google-Smtp-Source: AK7set+2d8kZqPdKpXeq5pwga95WBNECs47qUaTLd/DZCBqEalqOpBwXh1rtQBno91qttDxdOmfW9A==
X-Received: by 2002:a17:906:dac9:b0:8d9:8f8f:d542 with SMTP id xi9-20020a170906dac900b008d98f8fd542mr11381523ejb.32.1678102761141;
        Mon, 06 Mar 2023 03:39:21 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id ch10-20020a170906c2ca00b008cf8c6f5c43sm4411936ejb.83.2023.03.06.03.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 03:39:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Randy Li <ayaka@soulik.info>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        - <patches@opensource.cirrus.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        alsa-devel@alsa-project.org
Cc:     stable@vger.kernel.org
Subject: Re: (subset) [PATCH 3/3] ARM: dts: exynos: fix WM8960 clock name in Itop Elite
Date:   Mon,  6 Mar 2023 12:39:09 +0100
Message-Id: <167810274095.82312.7597082551301229104.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217150627.779764-3-krzysztof.kozlowski@linaro.org>
References: <20230217150627.779764-1-krzysztof.kozlowski@linaro.org> <20230217150627.779764-3-krzysztof.kozlowski@linaro.org>
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

On Fri, 17 Feb 2023 16:06:27 +0100, Krzysztof Kozlowski wrote:
> The WM8960 Linux driver expects the clock to be named "mclk".  Otherwise
> the clock will be ignored and not prepared/enabled by the driver.
> 
> 

Applied, thanks!

[3/3] ARM: dts: exynos: fix WM8960 clock name in Itop Elite
      https://git.kernel.org/krzk/linux/c/6c950c20da38debf1ed531e0b972bd8b53d1c11f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
