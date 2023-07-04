Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6529A747711
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjGDQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGDQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:42:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DA31710;
        Tue,  4 Jul 2023 09:42:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6a0e36d42so70563701fa.0;
        Tue, 04 Jul 2023 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688488932; x=1691080932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzU070hbK1FElWT7EUzEAp3muC4IoMd2UxaR356EEfE=;
        b=M7430e9/s0MrEcwW/eCffTM7rJLCy/EhaiyYU9P8R9kz7bltGuIE9xWFLmB4oc3ZHp
         9dcY64QPYblnB3cBqc2VSFHo7MT4t3vFOOcFfw0uPVO2aRWUR+nSUa83CBZrGAlEkduL
         95wz4qzhu8uaIiQvZNlWkbGpaXCde8OiX49qwtUpUJ1W/0JaRziAdYMgb0ChCLK/Awos
         tnDFPU+AfHwFPc7vMD2BPNKvmjF+3zT2uvXKfjYKMaCAcB+AqXLDe1W/pIbPvmawkm7o
         uPQjztKwehYrAEy2L9ui2CQwUk4UeQiB+QfaK6wFbnVtRrZn33HGXekUMfnJcW6BccG9
         lbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488932; x=1691080932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzU070hbK1FElWT7EUzEAp3muC4IoMd2UxaR356EEfE=;
        b=hDdWsL5+z4rr8PSLSS8rqPBCZHrC/PWyzXTsDZpcm0Ggwgd5YJH1xwi48adCtl7bWx
         m+BS6mPVFiPPzHkrUOz5bumODksQ+nF86kMVr3YXjr5xKWWeU2ZKIPZkffw9oPX5jHo6
         sAZMOv/W7TIBQkEVUEbv5VtK0F1jx/AeHSFil2V3b6r+xk4L3D99Y2fMRdKvq1P60Cl2
         eEDWg37bB7fhKI8OQKQPmUBDjcTNjun7xH7jROTBva06QOsANsiCg+gawumCVS373xEV
         dTWxmVY2PAqe7hCIHjZBDtBmyK4OaXKHmy49onp3rHawnw0CyonBkcgUTAZ8xkI8nmLy
         BnMw==
X-Gm-Message-State: AC+VfDx0jbuSfNOeDermx2Qs9p2a6unp/EhPGuaa1bhpdqGW72NsZy5p
        inJqA9GoNxmycLst0uiSBjo=
X-Google-Smtp-Source: ACHHUZ4ngiwOkMysm/pxe567oRbv4EKi8pMbQ4YroPRp1YYtpas/KFuYcoMcmwcTYKF9ejO1jhg7WQ==
X-Received: by 2002:a2e:a453:0:b0:2b6:a570:1d5 with SMTP id v19-20020a2ea453000000b002b6a57001d5mr6742975ljn.10.1688488932161;
        Tue, 04 Jul 2023 09:42:12 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id u15-20020a2e2e0f000000b002b6eb5db863sm1181920lju.43.2023.07.04.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:42:11 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        map220v <map220v300@gmail.com>,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 3/7] soc: qcom: socinfo: Add SoC ID for SM7125
Date:   Tue,  4 Jul 2023 18:31:56 +0200
Message-ID: <20230704163848.169853-5-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704163848.169853-2-davidwronek@gmail.com>
References: <20230704163848.169853-2-davidwronek@gmail.com>
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

From: map220v <map220v300@gmail.com>

Add the SoC ID entry for Qualcomm SM7125.

Signed-off-by: map220v <map220v300@gmail.com>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 4d49945b3a35..785b88e2da54 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -371,6 +371,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SDA429W) },
 	{ qcom_board_id(SM8350) },
 	{ qcom_board_id(QCM2290) },
+	{ qcom_board_id(SM7125) },
 	{ qcom_board_id(SM6115) },
 	{ qcom_board_id(IPQ5010) },
 	{ qcom_board_id(IPQ5018) },
-- 
2.41.0

