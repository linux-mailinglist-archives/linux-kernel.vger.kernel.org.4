Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775C86B7AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjCMOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjCMOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:49:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A9952F4C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:49:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r15so22559611edq.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678718967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRrfTafHWOPP66W8TWUXdxmmbu6jMm7VMDj6nUG7ys4=;
        b=LG0k31CJgvMHMlq4P+CQ2qKIuXZrlrQV5ay5JHyTcqsv1U4I0IVwOI+kJ0gG43tYIh
         8z9pUzjKdFQAhBsP17vHEwTI4PMsSPDr0OCL6DBlg9RDWUAaG/1zX01zZyLHPVMeQYBO
         A8o0dtdbNfYSnUNDg4Mz4ukS7/tjlWTfF/xNnuRCQVHXq6MXFg/RzWsY6Axz4Ywoo4lY
         EAyO9cAEzEm4lWa6DjlGwUtf0Cvq0P8XhdsIiI1VUfVryljG67iuJwLLylbX8iahtiSr
         bNEdU3D8x4S1Vz40aggwX76fj197Ez8OMvSiAscVMyg0bkYcqaErm+D+DeZ64WcgHDme
         mkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRrfTafHWOPP66W8TWUXdxmmbu6jMm7VMDj6nUG7ys4=;
        b=SlTDFEhT7xMcVMPr+KhguxCW988cMN3R+vuZCp22dpSokojBtYXSa54tBB+Rr57orF
         CbYW/7tRUeI6Zyo5U9XimLHGkpRZ3mnWr1VUodNBUUDCg8s8hodKPcbylFeguNZBbnHG
         j/7GDgXlOzCPhsAgxELvZtd3Y3+wFMUhTT0ZxwhW18ORbLVuSfqiVILpdM+B67O5fJ4c
         iWhw9Kil1sIzSmiNzunwQgneNn0tyl0iTsJR9HeMCzgoNWwedDXhvmQqh5ZNnNyneIH1
         SawseZmjM4/03OoPw8FUq9y6XznWujF9a3EfZ7ton0ze099aHeaU3ph1hcVBE+5ODzwL
         YITw==
X-Gm-Message-State: AO0yUKXnKBpNr2c8YnGx++DgkaAilr2V6cYRvkRTX5vMi8bfxpvYaH35
        +UBVdqDVPdm5ieDPva8kFN2Kug==
X-Google-Smtp-Source: AK7set+cQ4mBC92YPiOegc4OLk3m20RbbZ06et+PI1QN/7HBBjX6pWVLLsOyyMTqgiUmJTWuotc1Iw==
X-Received: by 2002:a17:906:9243:b0:923:6558:84fb with SMTP id c3-20020a170906924300b00923655884fbmr6476822ejx.3.1678718967422;
        Mon, 13 Mar 2023 07:49:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:69db:4882:d071:27c4])
        by smtp.gmail.com with ESMTPSA id ia17-20020a170907a07100b0092153c6b549sm3030164ejc.22.2023.03.13.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:49:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 02/10] media: samsung: exynos4-is: do not require pinctrl
Date:   Mon, 13 Mar 2023 15:49:08 +0100
Message-Id: <20230313144916.511884-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313144916.511884-1-krzysztof.kozlowski@linaro.org>
References: <20230313144916.511884-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

Driver does not handle pin configuration switching and several DTS
provide empty pinctrl property, just to satisfy the driver's requirement
for it.  Drop requirement for pinctrl property as it is really optional.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch
---
 drivers/media/platform/samsung/exynos4-is/media-dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
index 98a60f01129d..22baa429ed5d 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
@@ -1470,10 +1470,8 @@ static int fimc_md_probe(struct platform_device *pdev)
 		goto err_v4l2dev;
 
 	pinctrl = devm_pinctrl_get(dev);
-	if (IS_ERR(pinctrl)) {
-		ret = dev_err_probe(dev, PTR_ERR(pinctrl), "Failed to get pinctrl\n");
-		goto err_clk;
-	}
+	if (IS_ERR(pinctrl))
+		dev_dbg(dev, "Failed to get pinctrl: %pe\n", pinctrl);
 
 	platform_set_drvdata(pdev, fmd);
 
-- 
2.34.1

