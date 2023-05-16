Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA5070542C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjEPQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjEPQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:39:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3778A79
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso25405715a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684255177; x=1686847177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYH27XjeByMK147O7l5iWiBLALAwyIk0Kk8rARgu2BU=;
        b=MtTMNLgm2QTYIu7HCda+89OLhNeGmL5ToN09y1hcPblTMYTB3Y9wHefXmJONXlV4He
         BeuB+V4hBZcS9EIl/iyFn4OgXCB2r/qUWQN5a3uKMVQfjvsecooPesl9/nvJhOmNAP0J
         UmzzqbPoAc/9Ar1Ri6oyy16k5sV/si7wEqeMoZ3+GTxrhhKG0QGH8tkxa8K/oh/0+7l0
         reFHQsMDA0veVe4Q2DCXyJmQK+qaWndYfmrMSy15HfPS01A3cg1yCP6nqqwHK0Qytfml
         iFNnwGsjb4gthyZXbIiRPToB3nhPe6mNFGAYCXrFHLcCSZTYuzOtnomJxw81yp9TB3eo
         vkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255177; x=1686847177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYH27XjeByMK147O7l5iWiBLALAwyIk0Kk8rARgu2BU=;
        b=Q0yGERXLDzYoU+mfmMvd8BmJDzaRfdNVy89C5K7XgidezM7FNfC+4FO6R5fNpFoaYi
         RtzcBUDzF8j6yq6WMjXpbIDsdopIZgCMgX9Ke9DzSQiCT5xnNom2X8laDBnr4i8d6AwU
         7YqQePpJL1TZzGo650NLRq91Y6V8kO7SYK537FOV2lBjHy/9iHXz0DXia/4WEYtw9qyO
         WJFJoIzvmlE0QQGlbupaxMm4ke2hs7as51jGlO87zk/Q116ry2BqcKV4r/Ds3ecfv9me
         SjE1fdnP9QMEi8+hkqs53pMofGkBTWVvONwoWyEm3JgywvU8MBKyn1aFYVZdrpVdYpah
         2gew==
X-Gm-Message-State: AC+VfDyIXOiVbE94nV4vIghhmyrkkPRrFlFUKKrRC+AK1kfA/ZUaKNdG
        xA+aN2O/3sKsPye2yvEuX+P+Lg==
X-Google-Smtp-Source: ACHHUZ4g5SxFQ9h3D+IzT6shAa8NQEGXekqqXEMXi7KjElkQ2E6HrXamAtp8Axzj9JIoh6WZPzJKog==
X-Received: by 2002:a05:6402:1b0c:b0:510:885a:b4da with SMTP id by12-20020a0564021b0c00b00510885ab4damr1846682edb.19.1684255177697;
        Tue, 16 May 2023 09:39:37 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id d4-20020aa7c1c4000000b00504a356b149sm8278191edp.25.2023.05.16.09.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:39:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: en7523: add missing cache properties
Date:   Tue, 16 May 2023 18:39:27 +0200
Message-Id: <168425511041.243008.18082332917063303146.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230423150824.118430-1-krzysztof.kozlowski@linaro.org>
References: <20230423150824.118430-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Apr 2023 17:08:24 +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified and cache-level properties to fix warnings like:
> 
>   en7523-evb.dtb: l2-cache0: 'cache-level' is a required property
>   en7523-evb.dtb: l2-cache0: 'cache-unified' is a required property
> 
> 
> [...]

Applied, thanks!

Please let me know if this should go through any other tree.

[1/1] ARM: dts: en7523: add missing cache properties
      https://git.kernel.org/krzk/linux-dt/c/21f475946d89911e31bccd02f8a7ce40b8f52a70

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
