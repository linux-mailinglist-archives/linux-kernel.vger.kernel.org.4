Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A5C67956A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjAXKiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjAXKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:38:02 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD8A41B50
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:37:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z5so13412510wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cq6ayhJIiujuCk7dC1Dlzy/ufBwMT4etpRQGBEg7fw=;
        b=DLrzKI+hCbokwD2fwMQtd3TC+VEXzPFfCFKtTj0ef//D21zlqQXJqJBmvSMkrycn7g
         Yehr+ppyackumlQ2kZYRaOHQGv2NwmShbNfd+GC6tFK91fg/zPY4Saq59g7/IqlQRHZw
         goueE3fLTkbG/NUuvGzE/WEAgFJwU2xGbc+Nrxvp6UHSt4l1llQeuM1VUK7Pu4qUraml
         RrmE70S6ZmO0+DIrG0FL/zqG9IOt3QtyZldonScrXeZV8TNG+rWWwMiWtu53f1VNVILc
         9fIxZ+NnlfR8bLuQoSobntsJzqss9hxpqqNgF/ZmPAobvsvMXblnylkyn4ivsYBpDwtQ
         eGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cq6ayhJIiujuCk7dC1Dlzy/ufBwMT4etpRQGBEg7fw=;
        b=R/+xsvvKrpUd088j7o1E2jECaUVED5JDs/EtT35iVVSJtNgiKUzErj8PvU+UhjlePY
         i8QnCCTvp2VJDDYs1CyzR4Zvhe+SMpRX2wDMwmO6dWp3+Yec5Swdumc4iptdIr5CyWwa
         IwzGUoLrv0EQiuuURrFQpcB4klUJdONy+cFi7Evbs06ND8z1GAr5c7rQ7KHP5HMWpNtO
         fPIx9kelr78XWbDjFftRrOM/SlBwGBSwv6lzkATZZndn/Z71BRRD/UaZ98TOs1WHoJYk
         9lAMGEo5LsyOB1g+c5YqkP8k0z/GvxmbWG2j3GWQDI3g7BPUe/Sx4fcCGFCNYuMzHtaS
         UI7w==
X-Gm-Message-State: AFqh2kpcU2WZjcMroCN2lQbM9eDoOwwySoWjYbUq75WxNe9z3a/x8jmK
        3SiQKOCV0u7IqhU5zHtsJiU7HRJhrWwmSid+
X-Google-Smtp-Source: AMrXdXuzQ/c997mVqB2Kwg5p+g5vYhXX8C6p8cM+GEtoyt8uzs1al2TGxLuJeEaN4QTPjYMPgLV7NQ==
X-Received: by 2002:a05:6000:a03:b0:2bd:e036:6b1a with SMTP id co3-20020a0560000a0300b002bde0366b1amr27524136wrb.64.1674556602173;
        Tue, 24 Jan 2023 02:36:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x4-20020adff644000000b002bdeb0cf706sm1559196wrp.65.2023.01.24.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:36:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Correct inaccuracies in Exynos5420 and Exynos5800 device trees
Date:   Tue, 24 Jan 2023 11:36:37 +0100
Message-Id: <167455658659.245058.7412257727955360080.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230121201844.46872-1-markuss.broks@gmail.com>
References: <20230121201844.46872-1-markuss.broks@gmail.com>
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

On Sat, 21 Jan 2023 22:18:41 +0200, Markuss Broks wrote:
> Use the proper compatibles for the DSI host controller and MIPI
> video phy, as the current ones are not compatible with the hardware.
> 
> While this fixes the kernel panic while trying to use DSI, I was still
> unsuccessful to consistently produce image that isn't noise on S6E3FA2
> panel of Samsung Galaxy S5. It seems to only work sometimes.
> 
> [...]

Applied, thanks!

[1/2] arm: dts: exynos5420: Use Exynos5420 compatible for the MIPI video phy
      https://git.kernel.org/krzk/linux/c/bf5de14225625627a35d1acb6739068fc126326f
[2/2] arm: dts: exynos5800: Use Exynos5422 compatible for the DSI controller
      https://git.kernel.org/krzk/linux/c/234b8dac096d74e330ed1266956c756efddf3676

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
