Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16F4639D48
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiK0V0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiK0V00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:26:26 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B27F5B9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:26:25 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id j2so8598320ljg.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpYPbhCIxdq9zb9RtQtEbIq7/DCEPoj36+5WZRRtCkY=;
        b=AX0vLsCbgw8p+0tT8lQ3aebcqI+FvAoUVjgtrVuGupxDFsTrtFE3MWdXFgWYDWsgPD
         wIMhMd0j04AuW1HwiDxn8pIjBnxbCGGNtg9TKZMxn1Yb1yykMODR3yudB/Nt803NaQ2t
         p71Ulqlf4Fp7fI0aZ03mW59okyZM5xXSGKtZqLLX7N7YUTfaZ6Vz57olyVJMYRaV0oOu
         Vn9Q2ivM6biaQAK3RKTE3O0gWfNVXgibtqON2rmgLTM4AivWjwJy1UJJbwiHMVZ26Jlr
         Y/AaMGpNqIh2nLbCGezR/Jw2axTCYx506Ofn1I8q1c+8rzmpbDuqY+wfTyWrcliug0aH
         M2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpYPbhCIxdq9zb9RtQtEbIq7/DCEPoj36+5WZRRtCkY=;
        b=lh6EcgPYyxY1c+4+2jtIz1VKMQbe9LjcP2vTyaMWgp91fwDGmvcMa/drcGS1RrCffG
         kMpRZXPewbZmkxj/TGexoepkefFqDnzOK0kpjwYakolDyNQz2zgHeAis7EuobrUzf6Rf
         faQTifijY7sndjH/axmhvPL5zcRdaqdsQEkWfYprApqO24D+pILTeNUsKiRxkis7Wz9O
         NDawMOX8SBa4Sd6OmpokAk8Nd5yQ4XzJljWVHkadj0wNLp2quyL/x3F/w6rUenZIATQP
         5ySsMAEEcIv4pGjbzRPn+Wydqghzr/aGPfQscaldFyHBHy/K6YzSbjtmfZ80nvyGHel/
         rD1A==
X-Gm-Message-State: ANoB5pnyGFWaVAeWT2m9dETNJXQRMb6tZHEhPkIca4E5uwXsESc/xKog
        U1r4dUYaGgrXrCeT2VEbE/+HoKlfCG89Nz7u
X-Google-Smtp-Source: AA0mqf6Dg324ZZZEmjiJ2EXuM/mufU09uLC8mRgyCZS6eiLXXVFdX65fVC8xggbEcd3AtxwOKKW+vA==
X-Received: by 2002:a2e:a224:0:b0:277:309:f1ad with SMTP id i4-20020a2ea224000000b002770309f1admr9712153ljm.244.1669584383311;
        Sun, 27 Nov 2022 13:26:23 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 4-20020ac25f04000000b004b4b90a6992sm1074361lfq.95.2022.11.27.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 13:26:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arjun K V <arjun.kv@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH v4 0/2] arm64: dts: [exynos|fsd]: Update cache properties
Date:   Sun, 27 Nov 2022 22:26:21 +0100
Message-Id: <166958437707.66932.13795451978278069331.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123092449.88097-1-pierre.gondois@arm.com>
References: <20221123092449.88097-1-pierre.gondois@arm.com>
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

On Wed, 23 Nov 2022 10:24:43 +0100, Pierre Gondois wrote:
> v1:
>  - exynos: [1]
>  - fds: [2]
> v2:
>   No change.
>  - exynos: [3]
>  - fds: [4]
> v3:
>  - Update commit header for fsd platform. [5]
> v4:
>  - Update commit header for fsd platform.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: exynos: Update cache properties
      https://git.kernel.org/krzk/linux/c/784287950d8613132d3c3fd502906ba844d63166
[2/2] arm64: dts: fsd: Update cache properties
      https://git.kernel.org/krzk/linux/c/bf2ae716bc4a442e6e8270c18fd29441c031ace8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
