Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FD6B1423
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCHVgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCHVgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:36:15 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE8D309C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:35:55 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i9so23108028lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTT9T3ZA8o58JTVSfKP4mFmGSY9L0FD5ME/SSc1VeoA=;
        b=vDB0yPgjLPPWoTfMKifxuDN4HA99g3FORK5nE8C+hMr23QT6TbTSkc93JcR4QJQJXo
         xMy6pMK1XQF3QCwSt20pIVEDfCojiR89iEAfcYrCoNfxoA2Uds6l16egXmaVEZ+qhrHx
         HeLIVr09bSo/s5T8qCGIG0x1ySnvTj8lGAd0Gp9lBbmMab/qKlDDMXFQdnyHph5PvSli
         2BqFj9mx9yUF55GRgi98PM//GKYe2jAFboQxvgxSfESsP+VeA9+9oAEl38SywOZXP94i
         r+RWaDCKPwmI/Fr7Kj5qVV9gAehpAJ34H73pcqSAyzzog0lvH6Nq2G9m3vXy17xE9AJs
         Tocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTT9T3ZA8o58JTVSfKP4mFmGSY9L0FD5ME/SSc1VeoA=;
        b=RKK6OuTZlZNykwMXC1/kDVZFgGhVrVtfpln+E2y3eZFvihmaPq73KjddgtOeubw8G1
         x3pRTAk5wSgiE30BDUGX6jx/xYVwYPkN/VzRNXSnsBoXzpOYdlLvAzJPx2geNH1zTkol
         uoa5Jr2pVZJI8OkHONzBp2jxLPpTE6mhPkdD936Dt4AavLxAGzNqiYt9wuoo9SB6jaCx
         yGh48Db2aBlETy43Lyp8R63IS0ILukWYoX0qIyCUvSPISQ6SbBPHeJJQkq0p/t39katS
         MSY0Rbd8467kLW/xp59xm5KxzpNY17qXBbPaXTAETEjKviftAgn8S15yxlPlpQI7/+rj
         frgQ==
X-Gm-Message-State: AO0yUKXVU3F4G0VGxRfyN4I7thW9b0g5MAUajqCCdL46Bu7Ok9Ittg32
        qF4VrGJvcyYKPiaPW4viVLnxEw==
X-Google-Smtp-Source: AK7set9HYpOkHj7Fa1MNXJxiUAjYPFfn9R/0Dc3fBPzXsZzKXqsMs8IROFf/vCb2Cd1Pzk6nAUyhdw==
X-Received: by 2002:ac2:599b:0:b0:4dd:98c6:ee1 with SMTP id w27-20020ac2599b000000b004dd98c60ee1mr5249370lfn.61.1678311353641;
        Wed, 08 Mar 2023 13:35:53 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u7-20020ac243c7000000b004dc4d26c324sm2467479lfl.143.2023.03.08.13.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:35:52 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:35:26 +0100
Subject: [PATCH RFT v2 10/14] clk: qcom: smd-rpm: Introduce
 DEFINE_CLK_SMD_RPM_BUS_KEEPALIVE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v2-10-ae80a325fe94@linaro.org>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311334; l=1045;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nCVLU2bNG/XRlQstVOXJbHVfkx/oThdOe+b2OVKuu+k=;
 b=B6Pkn3UBt2p7iNXjBVL9wZ8vkQaA5HPLUlt+T/OKBYmMnH6RlhWe8h/cFssu4XFxmJLlBJ7CH7O2
 xSMGSQqQB2wzWwXbOGfExpBIxd25+iI8Q6c3zWdHhSZstBUckuKw
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting keepalive clocks which can never be shut off
(as the platform would fall apart otherwise), add a macro for defining
such clocks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index d89918f9ae60..8e25b3d7d30c 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -127,6 +127,11 @@
 		_name##_clk, _name##_a_clk, QCOM_SMD_RPM_BUS_CLK, r_id,	      \
 		QCOM_RPM_SMD_KEY_RATE, 0)
 
+#define DEFINE_CLK_SMD_RPM_BUS_KEEP_ALIVE(_name, r_id)			      \
+		__DEFINE_CLK_SMD_RPM_AO_PREFIX(bus_##r_id##_,		      \
+		_name##_clk, _name##_a_keep_alive_clk, QCOM_SMD_RPM_BUS_CLK,  \
+		r_id, QCOM_RPM_SMD_KEY_RATE, CLK_IS_CRITICAL, true)
+
 #define DEFINE_CLK_SMD_RPM_CLK_SRC(_name, type, r_id)			      \
 		__DEFINE_CLK_SMD_RPM(					      \
 		_name##_clk_src, _name##_a_clk_src,			      \

-- 
2.39.2

