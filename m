Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70534709F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjESS3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjESS27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:28:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EF21A1;
        Fri, 19 May 2023 11:28:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96aae59bbd6so678884066b.3;
        Fri, 19 May 2023 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684520937; x=1687112937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WlvvDrxI+8RIoRlqGPQtu1ddIFRRsxtK/LYB4K1t6K8=;
        b=N/cEBGaYZ08QnrzSQmmg9MF9G6mNibaGTIF7Xyf/hkjz3yE2Jp11UAx2+rYdMN4gDM
         jkUycYMykO5k8VLewS95pKAjkBEAWqww4BnjEU/vH6puyWuva4MM7LyvbnEpJ8eaa9DI
         7b8rK+zVTZuz5jBnVmRwO+CMGdZR891zOaQL9kOwypl6IVIUoRpHqlCCDQ/3KBqo0aXo
         7QLRuNHpPAer+F2uh/9hOcbeMj9RhQ4vnPsuE+cYMWOMxhNLM5Acor/2tCQS8ofXjFq7
         rlvX+uOiOaAGj5hhApAKpNOmvVDmAi/amGY7RIS8L7IawZjiZ1SFdU9oaou36teJVhOI
         2wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684520937; x=1687112937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlvvDrxI+8RIoRlqGPQtu1ddIFRRsxtK/LYB4K1t6K8=;
        b=OVUXXj26+P1JPxCHLRiY0eaUlyffA2hNo73DozavFpU/nHIMKccmQ+oo10VREDs8Lq
         4K5mSZioTBsL6vZGnfbtBNovE1AL8CgOXEbp2KGXm27+OenLUrzUbwwh2dwk/1D9h2H4
         /xZxaSWN3Msaq9Yullt376WBpqEwpwLU1yHm2Y/sXrWnI00osmdZ8MGR4QzBg0Q6J5Im
         dt99ojBeGMTMmatPJAooLHQuKiGPbKM5TipIfqLz7MSEtmfBHp58QhtpXfuJc9FQajEb
         K6o+3oWkNsDcs22h9K7FcMwWNq+ttvVWHyO1k59m8ETKrdcuZsuBU63R+67PI8iJtjFR
         fQ5Q==
X-Gm-Message-State: AC+VfDzRAs8CXcN9+l4ifR/B88TUD3QEUfob2b9a07Ou2uvt2h0f6lSK
        kQP2/QbD2qkr3Sh9AU/C2mk=
X-Google-Smtp-Source: ACHHUZ4R5YD3cMgV+tRC5UioVf2DwYIMuBKxYzGkAv6uLyu7ptlFV1obSOW7EKeU7d++ICsSSTMLXg==
X-Received: by 2002:a17:907:72c5:b0:96f:5f44:ea02 with SMTP id du5-20020a17090772c500b0096f5f44ea02mr2615072ejc.8.1684520936856;
        Fri, 19 May 2023 11:28:56 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id u27-20020a170906069b00b0094f7744d135sm2597897ejb.78.2023.05.19.11.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 11:28:56 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH] media: Revert "media: exynos4-is: Remove dependency on obsolete SoC support"
Date:   Fri, 19 May 2023 20:28:53 +0200
Message-Id: <20230519182853.3836-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

Support for the Exynos4212 SoC was originally dropped as there were
no boards using it. We will be adding a device that uses it, so add
it back.

This reverts commit 2d41a0c9ae51ac363d107f2510022106e7234b33.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
This patch has been split off from the following series:
"[PATCH v3 00/13] Re-introduce Exynos4212 support and add Samsung
Galaxy Tab 3 8.0 boards"
https://lore.kernel.org/all/20230501195525.6268-1-aweber.kernel@gmail.com/
---
 drivers/media/platform/samsung/exynos4-is/Kconfig     | 2 +-
 drivers/media/platform/samsung/exynos4-is/fimc-core.c | 2 +-
 drivers/media/platform/samsung/exynos4-is/fimc-lite.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/Kconfig b/drivers/media/platform/samsung/exynos4-is/Kconfig
index da33faa7132e..7f9ba053dd8e 100644
--- a/drivers/media/platform/samsung/exynos4-is/Kconfig
+++ b/drivers/media/platform/samsung/exynos4-is/Kconfig
@@ -47,7 +47,7 @@ config VIDEO_S5P_MIPI_CSIS
 config VIDEO_EXYNOS_FIMC_LITE
 	tristate "EXYNOS FIMC-LITE camera interface driver"
 	depends on I2C
-	depends on SOC_EXYNOS4412 || SOC_EXYNOS5250 || COMPILE_TEST
+	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250 || COMPILE_TEST
 	depends on HAS_DMA
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEO_EXYNOS4_IS_COMMON
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index a2034ade8b9e..976b4f747ad4 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -1128,7 +1128,7 @@ static const struct fimc_drvdata fimc_drvdata_exynos4210 = {
 	.out_buf_count	= 32,
 };
 
-/* EXYNOS4412 */
+/* EXYNOS4212, EXYNOS4412 */
 static const struct fimc_drvdata fimc_drvdata_exynos4x12 = {
 	.num_entities	= 4,
 	.lclk_frequency	= 166000000UL,
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
index 24b3dda26714..c3146ae08447 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
@@ -1621,7 +1621,7 @@ static const struct dev_pm_ops fimc_lite_pm_ops = {
 			   NULL)
 };
 
-/* EXYNOS4412 */
+/* EXYNOS4212, EXYNOS4412 */
 static struct flite_drvdata fimc_lite_drvdata_exynos4 = {
 	.max_width		= 8192,
 	.max_height		= 8192,

base-commit: a23a3041c733e068bed5ece88acb45fe0edf0413
-- 
2.40.1

