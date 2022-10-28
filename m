Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9CA611AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJ1TM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJ1TMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:12:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A86236412
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:12:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i21so9211163edj.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUVwjtsAbEyzghccJECNwNsjlSoqmLTE2vHEiHldKUM=;
        b=CkF81J/bLhvEkbgXDZGNJrKhZjbpw+En5vy4szWyGlma2xmTKHj5xj9sZzF5Q8OWsc
         X/636m+maiTax3O8F/vnzePPJ+ep/UPQtYyXQRhxy6oRL6BaETpoXRxf1ljWNYZh6CFK
         2wAcy6JjIS5d4JaN4blaIfzXY3ksGwPhPrE44iAXEbyBqBdiN7EXrHJE2AoMGpw++KaB
         ATi151tirBbCWy7f+OYD6hoPFbYlqeZBf02NlIlvuyWBxXIZXdrJzn/df1+qIyPZGP8+
         pgMCUhO/un3a41nf6CmoyGdHEpDTI6gAQY9WE+vGWvxYZs1bZScdTCWZPL4EIgdetta/
         kW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUVwjtsAbEyzghccJECNwNsjlSoqmLTE2vHEiHldKUM=;
        b=KspzyQCycXMTVMF09nOTtZWfE2FIBqCS+w7N+5QX9D752pl5cJEBVhxPfZafncPDb3
         +Sent+7GHSqwmVcdPq8jLucFwEyly+SmrDKTpEbUY8KE4Wje8q+wNoav0ZBfhz+YN2Ke
         5XxKUPRiWvha5n/r56On+nXnazI4Q3/XKC4OUPJnnpyX4y3YKOYrw/cQGnPuaTZ/WS8N
         0incKRX+vj6Ptns/GAGbUyTVND1UhDbJoZUIj9rCxtZ5FL0mBpHZLo4XCZDxLFbrnKD2
         JtYgDUoARIfzl1XijmZXJSHYWTV8J4mkft0wmN/GZ2xoNvR1+W8TMo+YrkM2CPgUVEgL
         HrzQ==
X-Gm-Message-State: ACrzQf1I37uC44+3AVZOnPSlMSdMihFEjzd9eqRoJ5qUcsn1fhScbHp0
        T5v1DozAZUuViIMO+ZtgdC7KSw==
X-Google-Smtp-Source: AMsMyM73CJQV9riRlOH59LzJeHaMT4ntFQfG7aPZVrY8/uEhUdNtkiyoiLeQF8sy6jwfL8NE7PaAfg==
X-Received: by 2002:a05:6402:847:b0:453:943b:bf4 with SMTP id b7-20020a056402084700b00453943b0bf4mr886550edz.301.1666984369908;
        Fri, 28 Oct 2022 12:12:49 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b00770812e2394sm2512302ejc.160.2022.10.28.12.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:12:49 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/4] iommu/exynos: Fix retval on getting clocks in probe
Date:   Fri, 28 Oct 2022 21:12:41 +0200
Message-Id: <20221028191243.31721-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221028191243.31721-1-semen.protsenko@linaro.org>
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch reports next warning for clock getting code in probe
function:

    WARNING: ENOSYS means 'invalid syscall nr' and nothing else

Replace it with -ENOINT to make checkpatch happy.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 45fd4850bacb..0d150b383d04 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -689,7 +689,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	if (!data->clk && (!data->aclk || !data->pclk)) {
 		dev_err(dev, "Failed to get device clock(s)!\n");
-		return -ENOSYS;
+		return -ENOENT;
 	}
 
 	data->clk_master = devm_clk_get(dev, "master");
-- 
2.35.1

