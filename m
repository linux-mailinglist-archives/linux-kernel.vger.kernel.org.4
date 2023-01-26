Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0652967D95E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjAZXEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjAZXD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:03:58 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B665367
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:03:49 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r71so1205288iod.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60yxEW22hoAOOhOWGOTH5M2hZiABdMD97947KesUJto=;
        b=poqn1L3NeJ8Bshdxo0CekTCXbHJ2lRle49Zm7WY/4/v/A7MHCjEZ6WqbXd+6t3AS5S
         902/CCuzt+mjQoVQp5LdS19P/+RolWfy+KLlJCHv3pdk3bPDZu1/4hJmVYFqTE5cXLk9
         qk+37IWGdPc2PkyqNRd2ByMdns5+8IPtMlejGHaCL1MKhaW9yd7ZwKXo0P0qXf/m2Gb5
         3E+//uMPwO836UORt6QuNGLicUszWv0N6RUKnJfoCeh2kyz4niuVqrPzMUhpLnDhBFzd
         w3hrht37nPOEM9XR7dsT7+TThR6ZodoUNaS2oU04AWpLtvdVR0WAx/fUQpbqJvG7e4v1
         HlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60yxEW22hoAOOhOWGOTH5M2hZiABdMD97947KesUJto=;
        b=K1CB9Zxva+CJj9pXbsGy4gTBTs9v0UrgHFIjGOYm/NgZ4LHBJDshNKhGb2a2vZgvQR
         OrQwctznSyx7RakInUMCmVplJoRlGvAnsFS0OCLgSBmIP7L5HPgaPvotnDvHUXrbr/yB
         AJwanNfXIe0rjCGpntOCQzD6RRBO9eTpy4tjQtrPRytvO9Mt9aARcYIWz47vbf5VsA1R
         uolNeDkqDC7FLaWqePJ542HNnC/9LnDQS93tqeQbyHpfIAueBEVorxHtViHWvuqK3GYB
         6iEfopzYPhGz8JGmS1KAYZyN3UbfIR79MhyZusfdAJSRCoIgfwbDg9op6khAUOxKNO9I
         YNpA==
X-Gm-Message-State: AFqh2konBfSgcqhFrlJvJRWnZI1Bdi56EAxMc+4DIEwCbx1gU3AgTN5f
        DHLsp3X2x3WDXX/tB7UyfGgIyQ==
X-Google-Smtp-Source: AMrXdXuAuaDVbBJKaExmyvsT8vI+dU4w26RIO0s+cAnOk/hzXXDGbqW1tGqBiFkvX9ufmtw6RTWfKw==
X-Received: by 2002:a5e:cb42:0:b0:6df:e4f7:8c20 with SMTP id h2-20020a5ecb42000000b006dfe4f78c20mr28877020iok.14.1674774228807;
        Thu, 26 Jan 2023 15:03:48 -0800 (PST)
Received: from eriador.lumag.spb.ru ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id l4-20020a6bd104000000b006f8b7d869a0sm670924iob.1.2023.01.26.15.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 15:03:48 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/7] mailbox: qcom-apcs-ipc: enable APCS clock device for MSM8996
Date:   Fri, 27 Jan 2023 01:03:18 +0200
Message-Id: <20230126230319.3977109-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org>
References: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org>
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

MSM8996 also has the clock-related part of the APCS mailbox device.
Follow the usual pattern and create a child device to handle these
clocks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 0e9f9cba8668..bd61dacb44ba 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -42,7 +42,7 @@ static const struct qcom_apcs_ipc_data msm8994_apcs_data = {
 };
 
 static const struct qcom_apcs_ipc_data msm8996_apcs_data = {
-	.offset = 16, .clk_name = NULL
+	.offset = 16, .clk_name = "qcom-apcs-msm8996-clk"
 };
 
 static const struct qcom_apcs_ipc_data apps_shared_apcs_data = {
-- 
2.39.0

