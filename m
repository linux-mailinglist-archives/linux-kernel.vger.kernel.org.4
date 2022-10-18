Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D815D602CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiJRNTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiJRNT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:19:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE73655F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:19:26 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o2so8542394qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pHiEMFfYao+vpXSzcw1Pyr5Zb1hstE5rItxZfxpi4Q=;
        b=NYi6NDnnA73hScjXrX/J/+AsYL8Y40X28MTeO2hJDsxxSm1wNdO+FdH4chdaxuSacS
         l1z1WDo6/nS7LpsELf+IynRlhYDLjEc84aNcJwFcdWGM2ln4OvZ2T+9gIxG7gDsgWBBU
         UQxyZ1a5zPGcl9+0Dkf8DfpFdiEePLaFx9EqwdyYFhvwa6vBz20UlQAq/Nwa4N/iahyG
         4vCmfh0zDkgaNUR/dELAslrL6PSti5EZ85M7QppecGgsQd3NdiOkJjVvSnJjYUfg3L1B
         s1rpsPXvm7IG1kHu0s3fW/qsZYTTj8PKbHOII1myZqwCi52DpblVjl5ra2i6eDKpJnuJ
         lYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pHiEMFfYao+vpXSzcw1Pyr5Zb1hstE5rItxZfxpi4Q=;
        b=gNJ+x9N+wOTvbSH1Y+qVXcw3wL0IUdKmYm73ofvx433StOuAJBY2+0cm+60BdJHZ6y
         YH/h0kGFxR5dj1xq/nu97VdlXhl2I4e9St/f9EW/vHpV8kuPU/zwkUdwwXilIaJrTZzY
         MAgl2I3ZoBJsBry+NzdBykbeR1N+dff6wd/2T3OhVZ0d37H8b/2ZUq8QeKorUv194WUf
         wLmZxuK4v5qfhLYM8I85lcXSD0YG591jBEZrRWPO0LZFDZs9m4zaSziQ7p6Oczu6PYaS
         NPS124ZlbS+dr794vqQaL1dFkzNRjiSKlS2eTljGXnXoBNJeUWtf1PVOZSV0VPnmZb7H
         owWw==
X-Gm-Message-State: ACrzQf2CgaT7uufWQi7VnQQbTGBkDpOtsccYPiPZ2WtZylgLJD9CbYPu
        Ob5UMpXtAwWMU4hMF0rssp7Mjg==
X-Google-Smtp-Source: AMsMyM4D7tu8vG7yq6HFiUpqmmutvXXMw5bAxoPEBAtdyVgzXpcN/wiY+KW8504fK1vupNWtM5BJ0g==
X-Received: by 2002:a05:620a:45a0:b0:6ee:e153:8d49 with SMTP id bp32-20020a05620a45a000b006eee1538d49mr1833526qkb.170.1666099165270;
        Tue, 18 Oct 2022 06:19:25 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a0bc600b006e6a7c2a269sm2527599qki.22.2022.10.18.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:19:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [RESEND PATCH] clk: samsung: exynos7885: Correct "div4" clock parents
Date:   Tue, 18 Oct 2022 09:19:12 -0400
Message-Id: <166609913433.8547.14138781440023077011.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013151341.151208-1-virag.david003@gmail.com>
References: <20221013151341.151208-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 17:13:40 +0200, David Virag wrote:
> "div4" DIVs which divide PLLs by 4 are actually dividing "div2" DIVs by
> 2 to achieve a by 4 division, thus their parents are the respective
> "div2" DIVs. These DIVs were mistakenly set to have the PLLs as parents.
> This leads to the kernel thinking "div4"s and everything under them run
> at 2x the clock speed. Fix this.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: samsung: exynos7885: Correct "div4" clock parents
      https://git.kernel.org/krzk/linux/c/ef80c95c29dc67c3034f32d93c41e2ede398e387

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
