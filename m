Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA57318C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344823AbjFOMQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344769AbjFOMO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:14:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C6273D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30fcde6a73cso2429567f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686831287; x=1689423287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1Ok1IYka1vb/vM8tvKH2bExKZHEfvi4JId7lcZB7pk=;
        b=gAgptQQkN2VQMGqYucwCcq099iIQmqKdEKk0oI1NCGMtDGyG5stsnWMwiF+Uhnj95/
         Q/gf8LCRofwFp0Tj02+rMuFYaXEuq/VhCDDSP2rPIuAG+BLee13gjgZuFIN/p3Aqb6MT
         7xQyVyP+9X7Z0kFKdisFayRD1TOqPnV8I1VoUDR2cDY7464JGJg5hlI6yqGt75VunKch
         azWuFAda8f323ROYHTHy2piFvp5aG/G6xIUk8N8+X6Hao/lwT5xiKyK7H4aTVtJHcl79
         XMuGjxt3F3ujjQQ1oQb7+/ePdnOulMbTvYJKE3zBbW7nKK/hDYUFvFtmp1gsgxmiUPfu
         5xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831287; x=1689423287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1Ok1IYka1vb/vM8tvKH2bExKZHEfvi4JId7lcZB7pk=;
        b=V6FtX13DjswHes68uir26OuUV5m+XSuK2I7kaDaM8tWbxppqhKM13F5aNx2nGFKNBe
         rJoj0Uaizlz7Po08yYoIYLcQOrFeBlNQxGtM4hDus/ZBY3sL9GGyp1oFcHoalj377ufL
         LU5T8DJ3CaF9hlcF1caBABgBPNn5w0m6dTaPMDSOkmDpaEzw/Z8u4A7XpZd+VFYr8+r4
         N0T2MUQT7jAAnzvAFARLYeN8BEGzy5AukFz1tO7PoZCEyX1gtMa+oH+rdIbjYOxZ9DmX
         WFo0N8Eqwa9/uSA5VJff2z/qIiy2xika8iPL24cxeRK47uzs47L3SQJvqUjDqrNC2VIW
         hEdw==
X-Gm-Message-State: AC+VfDw0VXTOOmKqlv8HzujmQXS3U5BY1ZzVYtKvqdHu7BRqLm1qtlv0
        Qi66wH+djIKXmLXTsP0afrvlbQ==
X-Google-Smtp-Source: ACHHUZ4r1A3qaTK5WSf+N6NhTfrUIoixv+YgCS9FosZwGOvt8xYnavFbEe9tPLw5/qL92M2SWSYV4Q==
X-Received: by 2002:adf:ec0f:0:b0:30f:cc8f:e48c with SMTP id x15-20020adfec0f000000b0030fcc8fe48cmr4937374wrn.25.1686831286752;
        Thu, 15 Jun 2023 05:14:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2ad4:65a7:d9f3:a64e])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b003047ea78b42sm20918012wrq.43.2023.06.15.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:14:46 -0700 (PDT)
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2 10/23] net: stmmac: dwmac-qcom-ethqos: add a newline between headers
Date:   Thu, 15 Jun 2023 14:14:06 +0200
Message-Id: <20230615121419.175862-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615121419.175862-1-brgl@bgdev.pl>
References: <20230615121419.175862-1-brgl@bgdev.pl>
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

Typically we use a newline between global and local headers so add it
here as well.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index b66d64d138cb..e3a9b785334d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -7,6 +7,7 @@
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 #include <linux/property.h>
+
 #include "stmmac.h"
 #include "stmmac_platform.h"
 
-- 
2.39.2

