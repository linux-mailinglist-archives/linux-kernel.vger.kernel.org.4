Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD33715851
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjE3IWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjE3IWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:22:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CFFA8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:22:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so5232703a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685434965; x=1688026965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/06GITGnCR0InunQ97FoRRag82uonE7bPllWWYnN1M=;
        b=U1TazgPBw5tN1EoHoX2aYS+f7yuRJQmgbSX8Faf0Bl+3Aen9PgAwjj/0rmvY9/jx/V
         wxUIl2QoR9bQBNWCOFoGRZvur5o8ChrHMf5YTCBx7BSdQyb7i0mCLSc6Hvu1ROVnMOmR
         qVL+77W7bRowiTu0GS4l1gbrykcmPub1l5cyvgiwp9qlcZkVHMv2glUWHW3XveLtjIbM
         RzxBtF+OaPNpCMPPq8+YGn2mdyLtvUriEkuiTO9c+PqnSpUy80yLpaEWwgUBYIh2mEMA
         m4Bfen7IRj2WfC0fXuHiXESe875Pr9nt/Neqkv41FZRzwKmqOGNKNFZKnTyBMO1nZe9J
         lgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434965; x=1688026965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/06GITGnCR0InunQ97FoRRag82uonE7bPllWWYnN1M=;
        b=TuCDA3ogy4vmeFTN8q+5TR1ysN9BFNMXTQxwOYISPPbU+hwwraHVGsWbE6Y5ypMb4B
         WvibRGjlzuxbr4ZVqeqHiHiXP9s0+BoPd62x/UuxFXB5eMTDUV6vaYbPW1C7FYbYSZ5D
         xHIJ6s8OepEQk6O+TBfK9zIeMbBQQpdhvEJlIXbKjGYwfxwjeAJOXvG/aDaSBr6WHHYZ
         z/LXj3OTCcWouf6AmnAPG/8gnUGrtZOuTCv1HSZATRlLCk7s5Lao1GCt+0Z8Sgbu5aPf
         1Mv0/6HHNa3wGTSA7LmOF7wUcvgq2DLpEvHttsVhu6CRH5IVSRIK8oJtwaFTN8wvgfBZ
         39rg==
X-Gm-Message-State: AC+VfDzZNCwOByUUlr3MC/+I9MhijAEdnDJA9uJ9jlxPSgjrGLnEnBR7
        nQb+9mO68tzZbNBDCl8diML4Yg==
X-Google-Smtp-Source: ACHHUZ75GDAqupUSVPJ5Aas4ogi42LerslQkAQXJPqBERjGGYbWLC0fwnXvjKlihSB0tFyOdHnUbNQ==
X-Received: by 2002:a17:907:3da0:b0:974:1e0e:9bd3 with SMTP id he32-20020a1709073da000b009741e0e9bd3mr1622046ejc.23.1685434964999;
        Tue, 30 May 2023 01:22:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id cf6-20020a170906b2c600b0096f272206b3sm6949583ejb.125.2023.05.30.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:22:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Artur Weber <aweber.kernel@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 0/3] ARM: dts: samsung: Fix some typos in comments
Date:   Tue, 30 May 2023 10:22:36 +0200
Message-Id: <168543493680.14409.2040056469867223710.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519190625.7844-1-aweber.kernel@gmail.com>
References: <20230519190625.7844-1-aweber.kernel@gmail.com>
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


On Fri, 19 May 2023 21:06:22 +0200, Artur Weber wrote:
> Change 'specfic' to 'specific', 'optiosn' to 'options' and remove
> duplicated 'are listed' in DTSI heading comments. While we're at it,
> fix the s5pv210-pinctrl.dtsi header (seems like it was copied out of
> the main DTSI file and never changed to match the new contents).
> 
> This patch has been split off from a patch in a separate series:
> "[PATCH v3 11/13] ARM: dts: exynos: Fix some typos in comments"
> https://lore.kernel.org/all/20230501195525.6268-12-aweber.kernel@gmail.com/
> It has been split into 3 separate commits: one for Exynos chips,
> one for s3c64xx and one for s5pv210.
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: exynos: Fix some typos in comments
      https://git.kernel.org/krzk/linux/c/2f6905307a7bb998e819c03097f3cc54a51b015a
[2/3] ARM: dts: s3c64xx: Fix some typos in comments
      https://git.kernel.org/krzk/linux/c/316c31fba6eda4543d5e234b13d0c0605a83a643
[3/3] ARM: dts: s5pv210: Fix typo in comments, fix pinctrl header
      https://git.kernel.org/krzk/linux/c/6a988251c4e53da33107c1975f578904c0635b43

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
