Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0867956C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjAXKiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjAXKiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:38:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F343447
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:37:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q5so8753834wrv.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozuy8c1uprzAYFuNopgrW2eAY/B5tIGZz6v2gE4dvkM=;
        b=qk4hiCl6a5gxx4NYtVXmwGE614aw/yJGlkAE0YFyMyBwpxP5uI5bkeYuLnUW3W2d+o
         +GfBpWZuCheRX/yRo8S9KPAUdRL3658Xb9iG6bsOplwHouq6QGZx21R31RoT5GmDZm2/
         5r10RjUgUY7gOhVZPeOE20CBb57XWMdtzXCz/F66ihzwcRffrL8C/4jMHAZjDHQZpMON
         Q5E9Zzk8W5yym22S3gjQx4oRJk7aXyGBit5PPu4RfbM060bnW9fzYjWW/WrEt+vOMuEb
         OYHa77qnkbWNEqGMdMghSYCsBd3Y/UNGYIcrW0FsKTIdKHxB5tIS5gJvY4oXGkTh67dZ
         Li0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozuy8c1uprzAYFuNopgrW2eAY/B5tIGZz6v2gE4dvkM=;
        b=TthX5o2hYkphAa/JfNdgx/Ul3EcRvjx4+HKaq+PYeguQvfXXQ5guKI6PYhYJbshbXb
         Rabu41u6HtCRF3M1aYI7MEmid+5sUFmM2bcTi16VS5UU9Yt448p51bKk+VYkILblhr1q
         quy6tnPwveTguPVhUv2kfQedqomQcRUAMF4H6qDPqCeaJRIbHlGiwwdWLqnj+dbT73WZ
         NB6KEuzGYEklPaUnUx4AT1cfSVMPoJEMMFved/m6f4V85lm9AJMW8D/vsJSGbYUzvUwK
         xUmpKcCKARscRFR1ILfFPJrUlnYhV3HnWTYycgcCa6dX/KFmNI9spnvqA3lmLPkd8vFd
         NIbQ==
X-Gm-Message-State: AFqh2kqd/NCe3mb668E7rLLRTRDfBkCtx0uXqhukHLKYkzmw0YwGNrlp
        ESk7JW7sjgza3Z0zhV0tFIIyU/3BCUlx0+s5
X-Google-Smtp-Source: AMrXdXvXUIP7k0jOS/1sd5MRA3PAUIs8khFM+PrSYZyQw40T+C544df9OdxD8I9cHl0tbKM2lxv0Og==
X-Received: by 2002:adf:e18c:0:b0:2be:493f:3b34 with SMTP id az12-20020adfe18c000000b002be493f3b34mr21537207wrb.26.1674556603612;
        Tue, 24 Jan 2023 02:36:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x4-20020adff644000000b002bdeb0cf706sm1559196wrp.65.2023.01.24.02.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:36:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add support for Samsung Galaxy S5 (Exynos)
Date:   Tue, 24 Jan 2023 11:36:38 +0100
Message-Id: <167455658659.245058.14105028305276435215.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123222329.13994-1-markuss.broks@gmail.com>
References: <20230123222329.13994-1-markuss.broks@gmail.com>
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

On Tue, 24 Jan 2023 00:23:26 +0200, Markuss Broks wrote:
> Samsung Galaxy S5 (Exynos) is a mobile phone released in 2014.
> It has an Exynos5422 platform. This version of Galaxy S5 is only
> capable of 3G communication using the Intel modem, while the
> LTE version of the device (klte) has a Qualcomm Snapdragon SoC.
> 
> Currently, internal eMMC, USB, regulators on a PMIC, and touchscreen
> are enabled in the device-tree.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: samsung: Add compatible for Samsung Galaxy S5 (SM-G900H)
      https://git.kernel.org/krzk/linux/c/5f8d9a0c2ee2d2fe2d59135261a0835a0a688fa5
[2/2] arm: dts: exynos5422: Add device-tree for Samsung Galaxy S5 (SM-G900H)
      https://git.kernel.org/krzk/linux/c/75b976c46cbe13dc8accc1173ceee6faddb83112

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
