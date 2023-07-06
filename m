Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61F749C46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjGFMoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjGFMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:44:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B721BDC;
        Thu,  6 Jul 2023 05:44:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51de841a727so973164a12.3;
        Thu, 06 Jul 2023 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688647437; x=1691239437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcIHaSKrR4JjJODseymsMqDO3fa+MLFhDB6UjbjUTpo=;
        b=VKy43Yn+75e3xp+itIn/OCxheIGOyy3Pcph+MtgDPjaTZi+ivzO67Y+qUKBnkbC+3t
         9XmLG11B5mdwEIYJjvFwgb1KiVr8SGLVWqzZ47lGjSBEREplgigythQht/BIcZhVSgPZ
         0X9NMcBzIaL37a7evoRvImTRsohJsmEyZlbzJHMzd8GlvQYF0/ay2M7dwkCzMGdcOP7U
         CfNuvAR6qm5xWnrne1tSh1vcG0Jrnwc4NG3EJwthivfwn/uYJskO4n8so6GnXEVVYhNi
         L/SAqpnIEwxNYSF4gkWMsF/7f2dDR+p7+LHKATf4L+Ydf70hgcU4z0LVSN6yAZ9MLaW2
         9XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688647437; x=1691239437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcIHaSKrR4JjJODseymsMqDO3fa+MLFhDB6UjbjUTpo=;
        b=bDvU3n2SetkvGIs0bBJS/j5kU9PwqMF1nRzJN69xv+Av/zGCycnl9tI3XjJNS4t03I
         Nc6nem8hAJeDyp1OpsD6Vap0ZpOlGW3DiVXao+j4cm9uCsc5eAQB23J7kMq/KFhtFAv4
         svtThJjQXYE93k23b+8d6PwT6LzKn8XUoALasbF03083mz2SJsqH0QKlvw6bJ7+PKXhg
         90eDLyk8ZDLXaA2QJVL8TDbLWd0/VMV9lJ2rcFvkuUd0O2lzhoQvD47Gokvrw9aOetUM
         ehMZwd5QlRqhR2NipcUDOhObb8AtGGiEG2dYSFquUxqMy3L66gF6pt5zlVXRPOWWksUs
         qkLw==
X-Gm-Message-State: ABy/qLbyZDY2akT9KtN9Pixiax7AFPH9MHhIJKUFVYM2wWFl3u9BHfT2
        4neB7tc73tzgKZr/lJ2L7ew=
X-Google-Smtp-Source: APBJJlH3opFDdnvkrdFGf3Db3SeZIHatbH1fnNmGhn0z769Jj3H55xMu9R4yTldNCq+xsW7Mv6vAUQ==
X-Received: by 2002:a17:906:4307:b0:992:c5ad:18bc with SMTP id j7-20020a170906430700b00992c5ad18bcmr1211526ejm.70.1688647437130;
        Thu, 06 Jul 2023 05:43:57 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ipbcc3a9b0.dynamic.kabel-deutschland.de. [188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id w14-20020a170906b18e00b00992ca779f42sm775915ejy.97.2023.07.06.05.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:43:56 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v2 6/7] arm64: dts: qcom: Add SM7125 device tree
Date:   Thu,  6 Jul 2023 14:40:25 +0200
Message-ID: <20230706124339.134272-7-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706124339.134272-1-davidwronek@gmail.com>
References: <20230706124339.134272-1-davidwronek@gmail.com>
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

The Snapdragon 720G (sm7125) is software-wise very similar to the
Snapdragon 7c with minor differences in clock speeds and as added here,
it uses the Kryo 465 instead of Kryo 468.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm7125.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm7125.dtsi b/arch/arm64/boot/dts/qcom/sm7125.dtsi
new file mode 100644
index 000000000000..12dd72859a43
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm7125.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#include "sc7180.dtsi"
+
+/* SM7125 uses Kryo 465 instead of Kryo 468 */
+&CPU0 { compatible = "qcom,kryo465"; };
+&CPU1 { compatible = "qcom,kryo465"; };
+&CPU2 { compatible = "qcom,kryo465"; };
+&CPU3 { compatible = "qcom,kryo465"; };
+&CPU4 { compatible = "qcom,kryo465"; };
+&CPU5 { compatible = "qcom,kryo465"; };
+&CPU6 { compatible = "qcom,kryo465"; };
+&CPU7 { compatible = "qcom,kryo465"; };
-- 
2.41.0

