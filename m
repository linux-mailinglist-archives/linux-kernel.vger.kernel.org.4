Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE1E71FD68
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjFBJPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjFBJPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:15:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1612E18C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:15:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so2573717a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685697312; x=1688289312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLdU4Q8ozDdxq74yNihKW+OJlWWA0/2lZXXu2wMUGK0=;
        b=hoTFOaLz93wlq05dLe0Yk0a+roPiXut39EDht3/CVz2w1euedsX2QEBsuiqI4vt0UO
         ia91d0+VlCHK26rzDq4b5PC48HtoK98XO156DGHthjoL1MF8r6a5oF7UgCNpJKebuzqj
         XOLWdPu8Ei1fqkt9r0vqIvn22QUkP29U7TNNUbw8t7M4oP0HJGLRE9yZlbwDjFEjuKgq
         YRYCpUO+WBo/k09VH3awCcm8eWT2zFjk6ElB8XvXFNQTtii76845VRF1Nc8ZMV4qYxpA
         nDqMVLsSnnJSKrjvpV03rHVv5u+p+/5+nThy/XuYR9ka+6KpoqbulEWzXJfLeIsyRx1m
         ULHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697312; x=1688289312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLdU4Q8ozDdxq74yNihKW+OJlWWA0/2lZXXu2wMUGK0=;
        b=SNLc9CkEl7JuRErazlmYYibM9fQcpcHbySQXI0jJtMhWg08MHXQT+QTq+fgqfE++Qo
         a+L1fVS8AC1yYrPKfE5XxULtuDbFAbmqW9wGoUDBJZKBW+dcAnA1LJittZN1/WNioLMw
         UYZs3q8Zgdif9nLStWMY2nY1zsbftWyqT5/lODoO8fYgb/OogdnOn8w3sduTyJ89czmj
         yDtXnlJJBHT2t/ComZv+T77/CRTveAHDVWkl5ZHMwj0ZSYl/1A+JJhrwdMhJxcTPeXjB
         3jH/uh+uqso+r4y1WcXssgLCwuvy213FcNIu14chqOYEcQ/r6JB9alyvjNwXmJTvkJwA
         DPwA==
X-Gm-Message-State: AC+VfDxCllYr2yFwirLw7XD4hNTJbajOZ9aHeAzsF9QVMdxKqINFZMY+
        fov3URQDGqNjKBGRjfp2pUed9Q==
X-Google-Smtp-Source: ACHHUZ46P9H+JJXIA3e7YoKj3JBcYOwil7LjToqG+b/wH8fdOhwkND9umKE0x7FpXb0LBZM1aiRffA==
X-Received: by 2002:a17:907:d88:b0:96a:43b9:95b1 with SMTP id go8-20020a1709070d8800b0096a43b995b1mr11242892ejc.59.1685697312691;
        Fri, 02 Jun 2023 02:15:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906240d00b0094e597f0e4dsm514255eja.121.2023.06.02.02.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:15:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, replicant@osuosl.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [GIT PULL 3/3] ARM: samsung: soc for v6.5
Date:   Fri,  2 Jun 2023 11:15:01 +0200
Message-Id: <20230602091501.15178-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602091501.15178-1-krzysztof.kozlowski@linaro.org>
References: <20230602091501.15178-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-6.5

for you to fetch changes up to ca027ae58eaab3632966158ce440a7f50da52bef:

  ARM: s3c: Switch i2c drivers back to use .probe() (2023-05-30 09:40:37 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v6.5

1. Re-introduce Exynos4212 which was removed because of lack of upstream
   users.  Artur Weber adds now Samsung Galaxy Tab3 with Exynos4212.

2. Minor cleanups.

----------------------------------------------------------------
Artur Weber (1):
      ARM: exynos: Re-introduce Exynos4212 support

Lukas Bulwahn (1):
      ARM: s3c: remove obsolete config S3C64XX_SETUP_IDE

Uwe Kleine-König (1):
      ARM: s3c: Switch i2c drivers back to use .probe()

 arch/arm/mach-exynos/Kconfig             | 5 +++++
 arch/arm/mach-exynos/common.h            | 8 ++++++++
 arch/arm/mach-exynos/exynos.c            | 2 ++
 arch/arm/mach-exynos/firmware.c          | 8 +++++++-
 arch/arm/mach-exynos/pm.c                | 2 +-
 arch/arm/mach-exynos/suspend.c           | 4 ++++
 arch/arm/mach-s3c/Kconfig.s3c64xx        | 6 ------
 arch/arm/mach-s3c/mach-crag6410-module.c | 2 +-
 8 files changed, 28 insertions(+), 9 deletions(-)
