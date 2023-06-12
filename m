Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445F372BC88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjFLJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjFLJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:29:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB81FDE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so29832035e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561879; x=1689153879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9517L+m6kHVlackMfaxSN+CNphejP2hqUH4D90m9Olw=;
        b=niV8zcJpx+FM/U+qoIxdAubWZD03pWCf8LOroYc/q2tXxGMobXAhRDTkiRBScpbEha
         nmxGS6K4K+sMXcJWCBnsRrq2MLQI+me1BzhofFvIbxfFBqtqVfBnlU9NnJ+S/3YdL81N
         /pMUKBNVFHGFG4pB4KMmO0Tm3YSZ/mtio9kHJMTOzA12sEv0MYYTtbBZ0g1XISkS4YXu
         HIpSDd0gsNCx9eAULp0cL5z0caPJYHrM67slR1Ji1AyGcoXvSRtRttHMVkb6nWUiHY1I
         3Vr6JmgkhnmHSgmjDaKJSXOBVvR+k1fRIz9MfUkxMIHyJffKzIcI+Zs0Ptrp3HHe31Zi
         31rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561879; x=1689153879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9517L+m6kHVlackMfaxSN+CNphejP2hqUH4D90m9Olw=;
        b=bTY4vNOMa/5Zt0lWihQUP/YGO66litqjcZCEg68dSi2XE1iGoygeCoXYAoWNIaGo5K
         jFWskrAbRhx6DEsXwAAytUyxnAvRtF4vX3TnpBIzcNAvXKwc6VIc6TKcEdVbYiywgwDf
         k9CLNYFXps7muE2AblBE38f32Cn0f8+WEy+KeXhHGx2QUKAsVROE+lH1i9srtfkh4Bwv
         bKUyFhCDA3h1d6fzZFJxwHzq6DVp4achVi0on/C/spO0/72kpKwp2Hzkyzo5p44B+vRU
         O3okT6LpoMfCMYjK8uX9/SxCPtgIFmll9gQHUS6FjoNRVhXCO9Xw4ZeDow8VdzhV5I5t
         5Cyg==
X-Gm-Message-State: AC+VfDwaVMQyuN1CLnsa2F9YCcrfyWz2DL7wg9/sJug7csrrQ+SaMpZ2
        rpHqieZsU1oQ3+5wgR0bmN6yZg==
X-Google-Smtp-Source: ACHHUZ7OmuBoNhbMPtzJgMKKXL9pAuDmUXCPSMeBXS0fx0sGH2DzxWk99X8iZUVMp3kJqiLAHi07Gg==
X-Received: by 2002:a7b:c84c:0:b0:3f7:33cf:707b with SMTP id c12-20020a7bc84c000000b003f733cf707bmr6349917wml.1.1686561879026;
        Mon, 12 Jun 2023 02:24:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:24:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 09/26] net: stmmac: dwmac-qcom-ethqos: add missing include
Date:   Mon, 12 Jun 2023 11:23:38 +0200
Message-Id: <20230612092355.87937-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612092355.87937-1-brgl@bgdev.pl>
References: <20230612092355.87937-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

device_get_phy_mode() is declared in linux/property.h but this header
is not included.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index e19d142630d3..ecb94e5388c7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -6,6 +6,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
+#include <linux/property.h>
 #include "stmmac.h"
 #include "stmmac_platform.h"
 
-- 
2.39.2

