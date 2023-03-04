Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3010A6AA9D9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCDN1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCDN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:27:46 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128791CF49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 05:27:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d36so3867814lfv.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 05:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677936463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XgZ4hZqUy+tdTMafR0Y1NpglWZ1Uga2EatLNEtTwC9Q=;
        b=L3XkohyhqWwukysfGvq18Qbo7HlBdn9yyiJGEp66AYu+WhhTh+APIUjvZcd5TLhs4a
         p+oORRAdIc08RHTYBs75K6zJYKxAQcYM4+IeYvv12NiAri226p/PzobZlY6+bVs0YZSS
         VAo3Gfd2luL/gKYxI869wsBXNwxHPaa7asoEMdWMpB0FfJ0kq6PLd4M450jTk7Up8P8f
         blKX1DTnKYldTSFTb/im7wDu5k4GasIKBKVhxa0DvajyDteIwqTthwcMZ7lO4Z6Hhf+7
         pV3VMm1btZ4sOJVZuJUoSL9SXAEm5kQWy/ziKL3y2l7QsdE+BrBQB/aEJR2xO4klrQMO
         EtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgZ4hZqUy+tdTMafR0Y1NpglWZ1Uga2EatLNEtTwC9Q=;
        b=uQxtSUu9V5w28NKZ1ARLST/zThmzrmGwixX9USFGpjbAMYd3G2yolfdL+SHNbm1nv/
         QMrKqTgm3b/Q+TLsQFziR23bnXS3dS9f9QxEcy5ryhSouM9ci9gsDjSPzKiE4SD9bzMN
         l/7jRAKUfLtiWxNcJ1KiL3NtN5rsBY+aMGs9G6BuJGl2kwS14GVsv1y/J+fuI2FsRX9c
         EiOvcJkM2tdXcszbTQfiDr5WNFPe+Z8baTXz8kXQtmV3zafTjGejCCL41SKI+GiGURBq
         uOx0SyVZvPagQQgQD+mEntPGODi1CqwU+DYIaZd7/+LU2Ct1buyE+1cXuQrEFEAe+Yxh
         MPlw==
X-Gm-Message-State: AO0yUKUYmn6BvFFzm//ax5GWHGcTdzOTILgvO1xQyprcMfHE6SVOGarX
        8GWQR/pNA2lNByt7gHyXo0aq8w==
X-Google-Smtp-Source: AK7set96p3e5eNUS0iELkOj3cIo7vkqtrQ+7naW1utqtFe42t0csa80IFs8GW3hrAko3ZC0q7B0MjA==
X-Received: by 2002:ac2:5633:0:b0:4dd:9f86:859d with SMTP id b19-20020ac25633000000b004dd9f86859dmr1350094lff.13.1677936463369;
        Sat, 04 Mar 2023 05:27:43 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a19f50f000000b004e7fa99f2b5sm342975lfb.186.2023.03.04.05.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:27:42 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH RFT 00/20] SMD RPMCC sleep preparations
Date:   Sat, 04 Mar 2023 14:27:35 +0100
Message-Id: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEdHA2QC/x2NQQrCMBBFr1Jm7UCagqIH8ADiroikk6kdiGnI2
 CKU3t1B/up9eLwNlKuwwqXZoPIqKnM2aA8N0BTyi1GiMXjnO2fDz1yEsJY30VMTc8F4PIUQz2P
 nWg/mDUEZhxoyTWbmJSU7S+VRvv9QD7frHR77/gM5DpYNfQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677936461; l=2001;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XWLgT1bwHF7eV8z8nCWgSR4obUXZ6NlsDIoxUnshn8g=;
 b=ZpizBgFMCTab1JVuT1rFMghCLQTENq7h2AK8wg7kkO10M9OSJBsWi5jjB//iVCA1xdsfodARzfd5
 Bqdx4uysDag7+z4hjr582qNssUwRcnoLXuDe1Wd6c2ugkec298bi
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings support for a couple of things necessary for the full
system idle on SMD RPM SoCs, namely unused clk shutdown and keepalive
votes (permanent active votes that are required on certain clocks for the
platform to function).

Tested on MSM8996 and SM6375, does not seem to introduce any additional
regressions.

Keepalive clocks for other platforms were gathered by digging in old
downstream kernels, please give them a test.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (18):
      clk: qcom: smd-rpm: Add support for keepalive votes
      clk: qcom: smd-rpm: Add keepalive_clks for SM6375
      clk: qcom: smd-rpm: Add keepalive_clks for MSM8996
      clk: qcom: smd-rpm: Add keepalive_clks for MSM8909
      clk: qcom: smd-rpm: Add keepalive_clks for MSM8916
      clk: qcom: smd-rpm: Add keepalive_clks for MSM8936
      clk: qcom: smd-rpm: Add keepalive_clks for MSM8974
      clk: qcom: smd-rpm: Add keepalive_clks for MSM8976
      clk: qcom: smd-rpm: Add keepalive_clks for MSM8992
      clk: qcom: smd-rpm: Add keepalive_clks for MSM8994
      clk: qcom: smd-rpm: Add keepalive_clks for MSM8998
      clk: qcom: smd-rpm: Add keepalive_clks for SDM660
      clk: qcom: smd-rpm: Add keepalive_clks for MDM9607
      clk: qcom: smd-rpm: Add keepalive_clks for MSM8953
      clk: qcom: smd-rpm: Add keepalive_clks for SM6125
      clk: qcom: smd-rpm: Add keepalive_clks for SM6115
      clk: qcom: smd-rpm: Add keepalive_clks for QCM2290
      clk: qcom: smd-rpm: Add keepalive_clks for QCS404

Shawn Guo (2):
      clk: qcom: smd-rpm: Add .is_enabled hook
      clk: qcom: smd-rpm: Add .is_prepared hook

 drivers/clk/qcom/clk-smd-rpm.c | 85 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)
---
base-commit: 1acf39ef8f1425cd105f630dc2c7c1d8fff27ed1
change-id: 20230303-topic-rpmcc_sleep-d67aad9f3012

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

