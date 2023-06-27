Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5143573FBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjF0MWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjF0MWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:22:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17FC12C;
        Tue, 27 Jun 2023 05:22:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa7512e599so54726745e9.2;
        Tue, 27 Jun 2023 05:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687868522; x=1690460522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yF+BfpyQkTKvNGNGOXI7AZCHasniunHH0XoTxKM2eq8=;
        b=CBrxuCRgD7PbRvizbCFCNZzvIz7k4lZsd1vCuP26T6NlsZzsi1FPX2wlFMMn0n8dCZ
         Jdn0CM3Zma9XG5W24lZ8oO/DaydxffbaoF2le8gapvO1HB82fpbc9izdctwUOhykU4mP
         vpmJRTBlcd0ZmuPX8ImgpDVYR7xL1CMR+I8Llqz/+DbCozJVcc6TFdDMRlsXr+DpZFEx
         JWrTWeEL0/mSZCvJEM/PIigYryl2nnEOZ3vZurGT6aamoUzZ5Bi9m/2bP/gxo7XDqWvc
         V/9a2efL5Ib2pB1q3YHiJvzmJi3BLgvkLWnpy36d2fO+m/M+lEcAeCEro2qMTyda53ib
         vjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687868522; x=1690460522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yF+BfpyQkTKvNGNGOXI7AZCHasniunHH0XoTxKM2eq8=;
        b=HGv9CpIk3RDLtqpIxuQ8e5QQjQBTUD61z52vXWREp6Jfx3JFpRFml+jHPCfxUNFIQJ
         izq63N+sjh4h7n9EOK0543ocWebV8f02lsX36CDurZopMRXzudAg+i6ek51Zd64xJLXh
         DEBXp2YWlErB6ff8w5RfWJHYqU3/pavIKtrUTyzB1HfaZQsljlkB+7sS14DfZ5x7NDRY
         Edn2dIQl58YHcpdc8Vp4WLf654Uw14yPoLqgGCjPi/1ldMjZsPyJbr6S/U+E6P6K6zPT
         7/pl6grA0xWbQ2fWHPjEt+AeFNcoVMe2gLRKtczYhznDNLUqrQMHCrUJcS+i1xlQ297X
         xayw==
X-Gm-Message-State: AC+VfDz1uA/X9QKHWNWLUCF77OgrVHYwIe1FzBsQWIhNdVS33YX66k5C
        bZaqdeg58V49mM0cnfmxayxzhRTLFJ9UVA==
X-Google-Smtp-Source: ACHHUZ49DxcpNNlfhj3ePNfadu6ido8FNLnvtMLuBvSnYoY/fd0GHnuYq858wJkQCKND8S21nh76vw==
X-Received: by 2002:a05:600c:c4:b0:3fa:71db:56ff with SMTP id u4-20020a05600c00c400b003fa71db56ffmr11465476wmm.40.1687868522215;
        Tue, 27 Jun 2023 05:22:02 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003fb9ebb6b88sm2297449wmj.39.2023.06.27.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:22:01 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal/drivers/k3_j72xx_bandgap: make read-only const arrays static
Date:   Tue, 27 Jun 2023 13:22:00 +0100
Message-Id: <20230627122200.722633-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the const arrays on the stack, instead make them static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 5be1f09eeb2c..2250f3eec93b 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -357,7 +357,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	struct err_values err_vals;
 	void __iomem *fuse_base;
 
-	const s64 golden_factors[] = {
+	static const s64 golden_factors[] = {
 		-490019999999999936,
 		3251200000000000,
 		-1705800000000,
@@ -365,7 +365,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		-92627,
 	};
 
-	const s64 pvt_wa_factors[] = {
+	static const s64 pvt_wa_factors[] = {
 		-415230000000000000,
 		3126600000000000,
 		-1157800000000,
-- 
2.39.2

