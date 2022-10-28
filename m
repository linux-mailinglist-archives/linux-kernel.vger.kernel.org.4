Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E4611724
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJ1QK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJ1QJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:09:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF1A224A85
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:07:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id v28so4963961pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOOeNwz1lHcYrYVw7YxVzbU02ivQx+BTv/5n41W3bX0=;
        b=TBwhRcOe7hVlwmqY6HUfGe6XCFoCRE1+KHVYm8ubTunpaq8IuWSDdHZb0mv7AKJ0pb
         6vqGCQEcYnmEH7blpAnG8YrWz/NCb05cw2LMNk4fISFhMogzeBzvbhplkPQ2zmmjWTYE
         DNuW5ykjw2/p1Z6y7Xp3DoQhat2+FvBfTxygO1qOR+N26sYyumfE9AsHNgN3/4BudxYx
         0DH+n2Uf9SF/Fgwh7/gu0zLI1Fj9hAv/bNvQfKQSGy8TK4Q/TDKr0bR8jxGrSja8hc3X
         knx5Se357JcvpcBS4oKAz/Zf7pdwvbG0P5HYMh+ZEgBQcq6ByJ1WblRdXzR4gSxjwMlk
         Jwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOOeNwz1lHcYrYVw7YxVzbU02ivQx+BTv/5n41W3bX0=;
        b=C9IFQoPsamKDN5ei7ipSz5y6EXhtPLuOphgRJwHx9fxFeRupUV7ohnjNm7i1TExAId
         ePhc7BpUBpikbhZ+uYTpHP0hXCWrQ9Ej/g5CbJ/Hq4QjQRjlZFAXUmTV7FWXP7mK3ODT
         E1Ilzy9cmuok9egWFIgaCCNeSC+FYksZrQvbkJd+kP35hzNrJV1knxaey1r0tjT2GM8Z
         5/v1eO2CZyRbLhRRIWDQkzSGzl87tgErYy8vj+/SERBGaBJTLyfww64AnaTcvFKChmld
         GBxz1WC8Dy/QZM/z0bUdrbEXQ9NpFbMeJAyv/yX4vNGbS8S0UzyHFsUZmHPJGdciDK43
         +bPA==
X-Gm-Message-State: ACrzQf0FrBOhBnEd6l+wYuT97ataLKbgP1p//yi4GuXolLqQ8Ieb9OAy
        8NKju0fjvrI7kRyUtwCE24SrmR86lC2jNw==
X-Google-Smtp-Source: AMsMyM4RcOrg2Q1kN+KY0hi/d1VbeCr4RdhBFV8N97v5IKoJxGQz8UMgUwHdhkR8Xx3H/wL+OZoRwg==
X-Received: by 2002:a05:6a00:847:b0:56c:b03f:8a1a with SMTP id q7-20020a056a00084700b0056cb03f8a1amr140694pfk.47.1666973261937;
        Fri, 28 Oct 2022 09:07:41 -0700 (PDT)
Received: from localhost.localdomain (118-167-210-30.dynamic-ip.hinet.net. [118.167.210.30])
        by smtp.gmail.com with ESMTPSA id b70-20020a621b49000000b0056abfa74eddsm3112071pfb.147.2022.10.28.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:07:41 -0700 (PDT)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v1 0/2] Modify documentation and machine driver for mt8186_rt1019_rt5682s sound card
Date:   Sat, 29 Oct 2022 00:07:31 +0800
Message-Id: <20221028160733.1390230-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1:
- Documentation: Add dmic-gpios optional prop for two DMICs case.
- dmic codec driver: 
  - "dmic-gpios" property is used for amixer control to switch
     the dmic signal source between the Front and Rear Dmic.

Thanks for the review!

Ajye Huang (2):
  ASoC: mediatek: dt-bindings: modify machine bindings for two MICs case
  ASoC: mediatek: mt8186-rt5682: Modify machine driver for two DMICs
    case

 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   |   6 +
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 104 +++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

-- 
2.25.1

