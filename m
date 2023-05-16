Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14141705428
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjEPQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjEPQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:39:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1AB170D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so21755866a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684255176; x=1686847176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsG1D65AobRcncLFMTKfXIkn0KrEDupUvPckoELQCaU=;
        b=Bi/yWxO0eGb2nfaJ7d31x/mgL2giJMj/zu8Sk4K1ml6nQbVEdunKugZAY3VeNYLh+B
         ZtNvXj53udC6Z8JFvIJTBsqZs5x6uhDebF6oKI3UUzcG0vS2inZfR8zur/pbhoyKYW9Z
         8EaRmrAlHcSP7GR8crqreY/p8nWCnkyNMEi1zaRciN9Uxl6v4coJUpr/gN9+UYmsBLA1
         6diS/7UlMY5BLGWG7EHQtruP83PDo5l+eU22kj9/IPFjj1PkWiJ3wjkY9pzF9FlyeNyE
         vt2CE1q4mD9h6+d3R1r4wb2Utsa0eYbKKHYTrEXA7ILNfFkQ+Ra/oJ5VCmifm0WMvZhm
         iu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255176; x=1686847176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsG1D65AobRcncLFMTKfXIkn0KrEDupUvPckoELQCaU=;
        b=iBcEMvHAlnsOw78gDg8I7PORd682INiarK/w3e2HpV0BMsjmtQe/cDGCkO71M1LlOb
         xJpw1p0t4jONO+jSluEAzrXzkkaAKCdH5Vw42VN/RBt+uvVVICXJEPYgSxS28hQMZ8wr
         QGK8BD5ssp+FW8TRE/DbNlGDdZrP4NxR9U2WIUfXbBSM73RJDpu3LVbxyPOeSnrIB0hc
         qszzo7h0IeeZcCxoMoazhIDfCQ14vsHVwkWlifyMvhnUfRnRL32O5lB9kF7os2OCMqBo
         A3Pgjpiph21dxORMozunDDHioD+5M9bbno51sGiUZnlhWHdpUs86gOiKbISYCi5o/sHy
         Pc1w==
X-Gm-Message-State: AC+VfDywOm/DrgG2+kEz+GAoD5D/XQxzZEGz3sNn6GK3OxDGwRnHUBYE
        il2GhQmXXGA7tBvSYCnbUbFbhQ==
X-Google-Smtp-Source: ACHHUZ7Pf63noxYlCK5E/drytCmmDXYc0FWgQdApWK2ZpP815jpz0UIyofhU0dT+1o6Or7Np7NRRuQ==
X-Received: by 2002:a05:6402:202a:b0:508:5062:8d8c with SMTP id ay10-20020a056402202a00b0050850628d8cmr29601477edb.22.1684255176656;
        Tue, 16 May 2023 09:39:36 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id d4-20020aa7c1c4000000b00504a356b149sm8278191edp.25.2023.05.16.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:39:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: ti: add missing cache properties
Date:   Tue, 16 May 2023 18:39:26 +0200
Message-Id: <168425511044.243008.2148983708471957289.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421223143.115099-1-krzysztof.kozlowski@linaro.org>
References: <20230421223143.115099-1-krzysztof.kozlowski@linaro.org>
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


On Sat, 22 Apr 2023 00:31:43 +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified properties to fix warnings like:
> 
>   k3-am6528-iot2050-basic-pg2.dtb: l3-cache0: 'cache-unified' is a required property
> 
> 

Applied, thanks!

Please let me know if this should go through any other tree.

[1/1] arm64: dts: ti: add missing cache properties
      https://git.kernel.org/krzk/linux-dt/c/be9633397b9f268242724a0c763839579761ee60

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
