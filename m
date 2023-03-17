Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661656BE992
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCQMpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCQMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:45:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF28A909F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:45:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o12so19819061edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679057139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNUx6NmU9vZIk5t3kL2stMiQn94hJ9T4laNaCYrljdo=;
        b=kyyRtRuugrOqI7ZhjjbW6di3tEIIXiBeqgJp/mWjLdjjJ8UVVwX648TTtEUGaV79F1
         Zg5sntrHeWjoKkmHt1TjLRgtoTp2CPQgx6q9xwlEQOCPujX19EvjwxGPlRjDNeMTZESS
         95bmTuhrS1/Sk9sPwmm0QMycsPXP2pL6by6Vm4Pf61NLdGIFRIDxy4txivsNxHYzr7yq
         ttxldATMRmZxZQJ3Q9fMEoz57auvcnYy5x+344SpYcdow8Yv3LzjCWhZ8nwyA5rf2ToF
         mw6zDIjCa+hB06qzbt3+VXLsrortorbrR3qSzqoAyVoATTaCwZJ/Dx/AiYNBpQJeSMwv
         zH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679057139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNUx6NmU9vZIk5t3kL2stMiQn94hJ9T4laNaCYrljdo=;
        b=OGn3q7+9M/Gv/Fp9kr5ee5YpzT5eQDa+k09VcaMvLd2rvQMjZbwxCk8RTNShwQKr8J
         jvCtiTVG8R9H/aDioMsJDh0ldM5YfRwjFVkMmTtEeM1A4DII61qoZ+s1XA2XbePQAOTf
         qyAynPhmeJSCFR7AbetpuPWU6dt+tP7cmckrkHvh876A1CoUF74r9fPQx2/HHo1Fn3jE
         QOtRoxhpXxm7fUHKjl1LS1vu/dvP2fpuMp0QsEE2L7YQFNe56m76dAg0D4QtRmstoZOx
         mKKATMP4p2kSWYjDP/45Izpl5wgIOjzNitUm/noCf/JdWK4lDwsSLBNjRtDisKQ0HoWS
         ptUw==
X-Gm-Message-State: AO0yUKULJAnp2JQFVJmJLq3zeIsDKs8xE76kZT8qHfyDL43p4YyIT6xV
        Jp9ld9WNz3Jui0eZ39SGD2/mlw==
X-Google-Smtp-Source: AK7set+8e4GUEhfFVhELM/7UtvIZCcHDuzN/lx9ayum4pr2NWqS4HYwQbH6HZE+jdKxUdvpzJ1pY2g==
X-Received: by 2002:a17:906:71d8:b0:878:7a0e:5730 with SMTP id i24-20020a17090671d800b008787a0e5730mr13994270ejk.56.1679057138958;
        Fri, 17 Mar 2023 05:45:38 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id lt11-20020a170906fa8b00b008e54ac90de1sm938522ejb.74.2023.03.17.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 05:45:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     virag.david003@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        phone-devel@vger.kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, m.szyprowski@samsung.com,
        Henrik Grimler <henrik@grimler.se>, alim.akhtar@samsung.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: add mmc aliases for Exynos devices
Date:   Fri, 17 Mar 2023 13:45:36 +0100
Message-Id: <167905713176.29125.2783264582338805395.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315212814.15908-1-henrik@grimler.se>
References: <20230315212814.15908-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 22:28:12 +0100, Henrik Grimler wrote:
> It is convenient to have fixed mmcblk numbering of the eMMC and sdcard
> so that assigned numbers will not change from boot-to-boot or
> depending on if storage devices are actually attached or not.
> 
> Also drop mshc aliases while we are at it and instead add mmc
> capabilities to the individual device trees (right now they are added
> depending on alias index).
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: exynos: drop mshc aliases
      https://git.kernel.org/krzk/linux/c/c04d7b263d3ff036ca124494c57011c1c274dbe6
[2/2] arm64: dts: exynos: add mmc aliases
      https://git.kernel.org/krzk/linux/c/5f67124757464d632f0e5288e0ba48e3ff5531a9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
