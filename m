Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFAF67FE42
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 11:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjA2Kkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 05:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjA2Kkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 05:40:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29432196A
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:40:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d14so8619246wrr.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKh+XybqNbJwTS+RVODYj3gQs42RNsq1kxtqGoR4Kjk=;
        b=TDnhKPPsYH68DdPdxnsqSr8n2hNmvFXcfEVfz3DRssMOaF1ISTuReRrEw0vxsvr2JS
         QXA48RrhxZuBSBI1o3SchuI6LsmRZVnke1HqdIn0Z7En2J+FBoPKeF4JcZquIZGUzLEC
         lIlMIBv+hVLzyDeEJdUGeuzzxma3mPSJuzWm+PJw9Db2V7nYarrCQeIzyGVIqt/PzVrv
         cenwFGpTCk9C9+uuZq/emINhDuabB9r4zNvOzSYQUzLxMbNAInKLVhaKVSlDirmYE1KQ
         ENtjpbASmu2zAK//iJ9i2Xjgfv5JtiFMAilSyWVqySPuTz1O+/U92/s3ceH4yKziOaOg
         muiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKh+XybqNbJwTS+RVODYj3gQs42RNsq1kxtqGoR4Kjk=;
        b=ByXstYFBEaDo8JIru+PKQjYgRlzlLLH0rvaR9pdUdNKo3L1Rk2ttPgTUtkhd7ltE9z
         bAgnl8ruJdyqquiZnPkO4Pr3sABmj+ycoBdW1agaOJEam9raaXd+9fiRnVgwKyNomYLg
         CoGNpjSmyE76hmZwGwZjH0H2Ltr3eapYug1oawJRQ3d2sZyHQ0g1tU2hVGDpGjZMAO8d
         kg3aSvmu7q/marG7ejIAxR7xkbNifNxM1JRr9+ZcLbU5Fi2OAAJSVvg3ZLGaAA77Ztdu
         0JzFwynKqFQhP41tpsl3C/qK/Z3OafXzTUIix53UPWlocC9Savv/7AF51KSO/Skq6R2u
         KoFA==
X-Gm-Message-State: AO0yUKXhMDiqMkusAQsdLBONSh/o3pNYFqDkt00F5hrjrB4gjWKlZ0T+
        RhIHMwiMAfWKv9b0XYqJj0UIow==
X-Google-Smtp-Source: AK7set8aaEjSgjREY25nSXIG/U6o5JXvwCrhED8l4ohr7GN6TUNZeYgiRV5y6JEEVt4naNnwzQSrZg==
X-Received: by 2002:adf:eb04:0:b0:2bf:bc75:1730 with SMTP id s4-20020adfeb04000000b002bfbc751730mr12200577wrn.70.1674988844225;
        Sun, 29 Jan 2023 02:40:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000180200b002bfb5618ee7sm8803443wrh.91.2023.01.29.02.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 02:40:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     replicant@osuosl.org, ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        phone-devel@vger.kernel.org, Henrik Grimler <henrik@grimler.se>
Subject: Re: (subset) [PATCH 1/8] dt-bindings: soc: samsung: exynos-pmu: allow phys as child
Date:   Sun, 29 Jan 2023 11:40:39 +0100
Message-Id: <167498882911.7239.17446486264996020803.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127194057.186458-2-krzysztof.kozlowski@linaro.org>
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org> <20230127194057.186458-2-krzysztof.kozlowski@linaro.org>
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

On Fri, 27 Jan 2023 20:40:50 +0100, Krzysztof Kozlowski wrote:
> The MIPI and DisplayPort phys are actually part of the Power Management
> Unit system controller, thus allow them as its children, instead of
> specifying as separate device nodes with syscon phandle.
> 
> 

Applied, thanks!

[1/8] dt-bindings: soc: samsung: exynos-pmu: allow phys as child
      https://git.kernel.org/krzk/linux/c/fe6a952b567f6a771d087d2e969914f31574d6ab

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
