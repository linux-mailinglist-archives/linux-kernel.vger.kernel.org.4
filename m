Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18B36B701E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCMH1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCMH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:27:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0780C42BDA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:27:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so13551363edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678692448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqXrSEYEnOGs+7zjB19U4pVgASpkaJmTga+BJT3kdYw=;
        b=J/zN/dlv6cASiruI728zbuCboF3BEauY0zD5g1ksjTxLowdHiUVQaAG8w603onN1W0
         Ns3WKOq43o1KhTdX/PLOgd7lupAnwFf40a42TRfWF0wtxIAhvFM1t8Ml69ssajygSvaf
         EhqM5f9m2CL9Ana5ME+MBNFxyDbb+LgOqmAN+5LPX1M4M+HCOOOZ1PzSOj0DkjWU4DGP
         Ew1sG0SoHYfe0x4wqlfAXTEHVGxHVQDYuts515CpmLDsm0QfX11KWlvnCNiyajPN85N5
         HcLrPxzGGB8lEJjA74cWXbFsPhYyF/ebk6OsNSfo7eBNBN2QwMkePWZ5pE7kZKdvh9Ym
         1ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678692448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqXrSEYEnOGs+7zjB19U4pVgASpkaJmTga+BJT3kdYw=;
        b=f6rDBhC8yn4Ng2vGC7ciQyy9h0rxEnP1AqWbgREP4lSAxQ5SnGmaVhdlS+qtc3tneS
         59SgZzLzzsgmPrasGlFk1w7DA9IzaslB8Xz4RKdEvC6XmThmbPCAv+aSQrM6j6fN84Re
         vD0bPp9DO5kBAlrTJuHoFhBM/+kV0aBDwd1HhxxKVtXC7u2SliT9dpqDvrehHHtw+sMO
         Bm5uPLVOrkwVUg89KmuhXHNglnS3V+wr9TP+AIusQnHHpNO4Z99m4QCLaPacIswmN8dO
         9Kqiz70CD6aLmY/13jkek3gA1dkzFXE3PrAMvejJlfhzWM9+0bTYuoiLZSdllUCDg29a
         x04w==
X-Gm-Message-State: AO0yUKXwBWxQkkoNO96L96/AN18NmUHOKZE+BlTwRWs9saVLh6qlOc5s
        UTSao0IizkY18qOpLKgErcpWwQ==
X-Google-Smtp-Source: AK7set+mILk3GDAjNqNzhNgHCuP2FV50D2pZG5Nd5tpVt7Pp744ywc67cAjVNeGP4uZfkFw/oEjv3A==
X-Received: by 2002:a05:6402:1295:b0:4bc:edde:150d with SMTP id w21-20020a056402129500b004bcedde150dmr9545646edv.0.1678692448562;
        Mon, 13 Mar 2023 00:27:28 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id i19-20020a50d753000000b004af6e957b22sm2503373edj.6.2023.03.13.00.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 00:27:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        David Virag <virag.david003@gmail.com>
Subject: Re: (subset) [PATCH 4/7] clk: samsung: exynos850: Make PMU_ALIVE_PCLK critical
Date:   Mon, 13 Mar 2023 08:27:25 +0100
Message-Id: <167869244317.12007.11459097567814063144.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308233822.31180-5-semen.protsenko@linaro.org>
References: <20230308233822.31180-1-semen.protsenko@linaro.org> <20230308233822.31180-5-semen.protsenko@linaro.org>
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

On Wed, 8 Mar 2023 17:38:19 -0600, Sam Protsenko wrote:
> PMU_ALIVE_PCLK is needed for PMU registers access, and it must be always
> running, as not only the kernel accesses PMU registers. Make it critical
> to ensure that.
> 
> 

Applied, thanks!

[4/7] clk: samsung: exynos850: Make PMU_ALIVE_PCLK critical
      https://git.kernel.org/krzk/linux/c/babb3e6a8a8e5a61a65d4463610108808139b23e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
