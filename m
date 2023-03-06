Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74256ABE76
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCFLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCFLj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:39:27 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591029423
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:39:23 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id a25so37442275edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678102763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzWGqAjLpHlD5u9jCAHG+a2PbEWqmZpag0JMmVH0IbQ=;
        b=i8hXqbKI/U0F9gdOtmUtiK/N5On7BfXK0q3TX/+n0ooQTDCLoftkzAu+ZYJIlGWAXZ
         LA3DhgOeIkx/4Ne0fDXzrCk3MsXepbwqhyB0Y3ZIqkZa6BBKZUvY5fqTna0G99v8YYYL
         Xr/Tb22i5suo7j8jSYlfSRzxZoqDQtO1Y2I9JlG696MYLI2H0fWjthTNAcoKMlJRZn85
         y0chlJ2hRuT+ytvlxtIPb5xH8R29AzUW+xYYtlkjELG4RarfpzqxH0pLlRN9IFGHcW5h
         iK/6bEv/oKK3se0hGd7eJQivdgZSuqwrE6ndvg+/y4Cw6t+dPgEPRbNpmwSJmvi6+YQC
         dGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678102763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzWGqAjLpHlD5u9jCAHG+a2PbEWqmZpag0JMmVH0IbQ=;
        b=hb8EAgDape1ffX35VA+ibvPCL7AOUi4T+lWe3o2w7mlLZBWQU/bNMw3MPrIn2SStai
         o6dgZKEw7cSzfe104faoJf7wpXWRnn18KZ+0SPENqSklTJpqAc7zukJYgfbjWZALBqyv
         GnUMv833HV36od/8cYyGOrwgMs9/tWcJZ0xn7woGIeTpE6Pb8bzQe/xOI/ONuVtEEi+k
         QdATS4UVVj39bJ0dX1jKGhgPTCGDsZ2MHurSgYDEMtaavzUGG5RrPvWPbvGbwmkjpNvs
         lhlkO1unMv/Zda64BycjG7r6hKuRP7QHLqY9T4xgxurwO6K+0iunZUl1Y+3ziUg12Vzb
         CEVQ==
X-Gm-Message-State: AO0yUKWSgHw3UvZID6rrmTqGX0ZVC5FAzWm1FAetI7o5O8GfL02KuY1T
        Vm6xeIw31jf+V2qah2DfPMjRPA==
X-Google-Smtp-Source: AK7set/fIAy5r7sbONvLExQKUO7U8NmLEBitXQ6a20ZCy6KaPV7F32QpdGzQxjxOW3bBkjExKFtH6Q==
X-Received: by 2002:a17:906:dac9:b0:8aa:c090:a9ef with SMTP id xi9-20020a170906dac900b008aac090a9efmr13185992ejb.55.1678102762984;
        Mon, 06 Mar 2023 03:39:22 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id ch10-20020a170906c2ca00b008cf8c6f5c43sm4411936ejb.83.2023.03.06.03.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 03:39:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Henrik Grimler <henrik@grimler.se>, phone-devel@vger.kernel.org,
        replicant@osuosl.org, ~postmarketos/upstreaming@lists.sr.ht,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
Subject: Re: (subset) [PATCH 6/8] ARM: dts: exynos: move DP and MIPI phys to PMU node in Exynos5420
Date:   Mon,  6 Mar 2023 12:39:10 +0100
Message-Id: <167810274096.82312.8759303246779473962.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127194057.186458-7-krzysztof.kozlowski@linaro.org>
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org> <20230127194057.186458-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 20:40:55 +0100, Krzysztof Kozlowski wrote:
> The DisplayPort and MIPI phys are actually part of the Power Management
> Unit system controller.  They do not have their own address space, thus
> keeping the nodes under soc causes warnings:
> 
>   exynos5420-smdk5420.dtb: soc: dp-video-phy: {'compatible': ['samsung,exynos5420-dp-video-phy'],
>     'samsung,pmu-syscon': [[11]], '#phy-cells': [[0]], 'phandle': [[16]]} should not be valid under {'type': 'object'}
> 
> [...]

Applied, thanks!

[6/8] ARM: dts: exynos: move DP and MIPI phys to PMU node in Exynos5420
      https://git.kernel.org/krzk/linux/c/972b567075845a55d525f1ed5d7cd7b6d524afdc

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
