Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B4F60F6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiJ0MLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJ0MLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:11:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104B4D0CE6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:11:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z14so1818908wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3b8progjf6nTjlRNKVhfA6lVwhcFNvYGUFDNCKIgOA=;
        b=hzJqchdz1nxotUABi97SVc6OkYYXbmXSBzNSLO4BfJWSlQ4E/TmdwAKsz5Y2AD2OYC
         tuKmAdi7p9QjnjlY0bKS/VQzsLIb9FARhep7ETn0SVYxRexqgpn9jhEyusubgxgaL1dy
         1fpOJUmwJlblJ+qKKfUHeBPhe8sCps2EGGtrTaoAT78+ZJhJRhePoMFPsqplGwCFABm6
         x9guCDmak8TBfzmnyofI7noqI9/yBqNquKt+lzSBkye+s+bRcIDx0iuza+OA4qpaawMJ
         ujGVCW3rJCAwVV9H6MieBouzPIbJyJgMpSpVtRRqi0X3RdzANId093CK5DhTMukf5s9M
         UMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3b8progjf6nTjlRNKVhfA6lVwhcFNvYGUFDNCKIgOA=;
        b=wCahtvJ1LtkJfwtnSOQiiIhpChYvxZrgAqt9YokKz828bXhebBZuc2VKIEIXRe5Bcv
         6xEn1q6z/hx8hSD46vt5DdScwc6pmVdYjSWMFPLcPVQqlOZM6h1NqFZU7H1gMN/XChKa
         Zw25XeRVUm9VDxkrclYl1LOcqOfcgg5p3L4Kyv5VefSP4PVQIKptNL7pVM+C6u9cdG/u
         DU9HP2IaNJTFcSXDl/eN7nOhEIjzZlbMiifuZGj9CQ+2DB50PYspuLC+TwnmrqXPAsDD
         CkirCF1PWkDsNBb+mzJNGyWn5bH2bbFqwEPLfZCZxSAwF5hW6e6dnmhv0Qgf5obSTMBc
         iqZA==
X-Gm-Message-State: ACrzQf10OIo/pu3iSa1SW4Dkqi59OP3o1NKplGj5dRDXNiwY6lStjcLR
        d6t48Ydn4zw94fYtCgBYDeilWw==
X-Google-Smtp-Source: AMsMyM5rJoSQ6ICEDwXJ+doDHBP8h+Yz7A7uzCo72oHXSiDM3V7WEN6+2va2BAcuQ3qE+wUjWjLM7A==
X-Received: by 2002:a5d:4944:0:b0:236:7f32:1ad5 with SMTP id r4-20020a5d4944000000b002367f321ad5mr8985028wrs.377.1666872705548;
        Thu, 27 Oct 2022 05:11:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bw28-20020a0560001f9c00b0022cd27bc8c1sm1414312wrb.9.2022.10.27.05.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:11:45 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 27 Oct 2022 14:11:43 +0200
Subject: [PATCH] spi: meson-spicc: fix do_div build error on non-arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221027-b4-spicc-burst-delay-fix-v1-0-5a6e9a88e54c@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes :
error: passing argument 1 of '__div64_32' from incompatible pointer type

By passing an uint64_t as first variable to do_div().

Fixes: 04694e50020b ("spi: meson-spicc: move wait completion in driver to take bursts delay in account")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Neil Armstrong <narmstrong@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-meson-spicc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 52bffab18329..1b4195c54ee2 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -387,7 +387,7 @@ static int meson_spicc_transfer_one(struct spi_master *master,
 				    struct spi_transfer *xfer)
 {
 	struct meson_spicc_device *spicc = spi_master_get_devdata(master);
-	unsigned long timeout;
+	uint64_t timeout;
 
 	/* Store current transfer */
 	spicc->xfer = xfer;

---
base-commit: 574f97ab96d6b153407161746bc127564e998b4f
change-id: 20221027-b4-spicc-burst-delay-fix-a03004454876

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
