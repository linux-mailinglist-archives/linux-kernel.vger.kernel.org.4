Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5963965473C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiLVUhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLVUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:36:49 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF26320BC6;
        Thu, 22 Dec 2022 12:36:47 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4978E1F8D5;
        Thu, 22 Dec 2022 21:36:45 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm64: dts: qcom: sm6125-seine: Configure regulators and enable SD Card
Date:   Thu, 22 Dec 2022 21:36:31 +0100
Message-Id: <20221222203636.250190-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure regulators on Sony's SM6125-backed seine platform, and provide
these regulators to existing (SDHCI 1 / HS USB2 PHY) nodes so that they
can cast their votes despite being left enabled by the bootloader.

In addition this allows us to enable the SD Card slot on SDHCI 2, which
would not function without turning on the necessary regulators (i.e.
these were /not/ left enabled by the BL, for good reason).

Depends on:
- SM6125 APPS SMMU: https://lore.kernel.org/linux-arm-msm/20221222193254.126925-1-marijn.suijten@somainline.org/T/#u
- SM6125 GPI DMA: https://lore.kernel.org/linux-arm-msm/20221222194600.139854-1-marijn.suijten@somainline.org/T/#u
- SM6125 QUPs, SPI and I2C: https://lore.kernel.org/linux-arm-msm/20221216233408.1283581-1-marijn.suijten@somainline.org/T/#u

(To prevent DTS conflicts with the &qupv3_id_0 node override right above
&rpm_requests.)

Marijn Suijten (5):
  arm64: dts: qcom: sm6125-seine: Configure PM6125 regulators
  arm64: dts: qcom: sm6125-seine: Provide regulators to HS USB2 PHY
  arm64: dts: qcom: sm6125-seine: Provide regulators to SDHCI 1
  arm64: dts: qcom: sm6125-seine: Configure SD Card slot on SDHCI 2
  arm64: dts: qcom: sm6125-seine: Lock eMMC and SD Card IDs via aliases

 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)

--
2.39.0

