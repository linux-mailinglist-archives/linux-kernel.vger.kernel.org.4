Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D56FCD69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjEISKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjEISJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:09:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC214558D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:09:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so11248845a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683655789; x=1686247789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6Mk+624yxmJZhHaO1qWp2thr1eQhOU4HhCuia9Oec4=;
        b=gnn4JGqkuL8679yPpfpJdLY0T1E3exoerCewjeQWuzGfcaQBijpRSoJjdv7PKTg3Sy
         Mr499xZTPJvKc3McHFl/2hOG7VqPYfzv9aMhAh/UdAVJ0JbAQv/e6W1KlN6e5OZOc4JQ
         X9k9nod95QBEbjCPVdfD2pUVSLu1p6D2C+nB2wxq2S7lTXW5b4mmUtsFgfisFgbNP5kL
         VOKmBxCYBb+iZJtTaRMdF84Dl0G08u2Bd2c8IRTziwDnV4M1FEXFr7zztZGL0YkAxr/n
         qBRd95ga2VNqB4uS9X5fqnxSwIU3XxPet8Nkjfjqix6bUGegq85AY/8X/H9RDvpFIwdO
         iOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655789; x=1686247789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6Mk+624yxmJZhHaO1qWp2thr1eQhOU4HhCuia9Oec4=;
        b=LCEB51CO3TDsYcFyyC9+0GYzJ7wxWyb4osZlKCWjRgc60hHT7+cBlVyVZVNPLVKoWK
         6FRKmhTx0XtAD5y41bVk79lzre1sNEOocBwUbUUIvpcr+qc/5y+45ERX7ZagRQ7KGn4r
         coo2l2qdQxHceUPBa8JGI+6GMrqzuTukDh9OeSLG5YvwjDG8CfGxTKm1n5CaMcLokFM5
         Jvd+Hq9ALQqx5lx9VFauIEEJRFEyrYT8/OC6ZdmV/Z2CqCYpAvxQrYVwYkA7W7cBLXkw
         z2si4M6yfaxbGr6ReumWWuSoniNUqyYWQonGiEx3Ehp2WEcFgiqgxohEyXb2/e0UcDLW
         WsfA==
X-Gm-Message-State: AC+VfDwJ7t/PSQ26YILt6pgOlKEMEgc6aVvbn+Zetryemjdlo6ThPZxa
        yG0ogWkRXG/70TFPK1RUrBJNmg==
X-Google-Smtp-Source: ACHHUZ5Jg/H32sCIUzGZPIgCeMhANkCcCtIqqsjY4T3Eu0k8izMnFpTqj3Zeqww7zEiNewdh7JADeA==
X-Received: by 2002:aa7:dbca:0:b0:50b:d557:d446 with SMTP id v10-20020aa7dbca000000b0050bd557d446mr11080825edt.2.1683655789189;
        Tue, 09 May 2023 11:09:49 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id dy28-20020a05640231fc00b0050d8b5757d1sm1015286edb.54.2023.05.09.11.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:09:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v3 06/13] clk: samsung: Re-add support for Exynos4212 CPU clock
Date:   Tue,  9 May 2023 20:09:33 +0200
Message-Id: <168365575565.242810.17090653188259271875.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501195525.6268-7-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com> <20230501195525.6268-7-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Mon, 01 May 2023 21:55:18 +0200, Artur Weber wrote:
> Support for the Exynos4212 SoC was originally dropped as there were
> no boards using it. We will be adding a device that uses it, so add
> it back.
> 
> This reverts commit c9194fb623b0158029a268376df09fe28a2a2b05.
> 
> 
> [...]

Applied, thanks!

[06/13] clk: samsung: Re-add support for Exynos4212 CPU clock
        https://git.kernel.org/krzk/linux/c/40b4ffe5e921a8db911a7e5ffe3ad8da86ac0dfd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
