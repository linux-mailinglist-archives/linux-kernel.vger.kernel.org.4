Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B365B080
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjABLXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjABLXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:23:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F6660D4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:23:31 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d4so18046882wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=He1UhKwO5iA0CtVhb4Fm4ggBLsoDYLxYgG6at6pHejY=;
        b=ktn30PEaToI3GtkcPsPn8hZkhbVAJ0eyWsFqxgWtVvujmRLgU1oxkyUoA5Vn0rwhNP
         kz4oTxksemVadkI1MVeT/3/LF6x03HvoyHOUlWq3aKcWbwbVoE3lfeyE3jq7lDXmD5Jo
         BufRX80Zi/Tkjtt++75X+U79A80ubvLYzQtdOpSpxBzJ8h8na7gHeOWFlYf3DTof0P9Y
         np3y8DckOrVRiLMUaIeDL5v06VfzobkFY7f7DU5SJKAUsTJ5N+dqzVbH6VqYPfD2GfYg
         ztc0uVA+TOiG8qnQz0UgB560SwiJJNfJHD65KvFMpwH2vdd0ajn8EYoiXAcVsNS+AwY8
         2e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=He1UhKwO5iA0CtVhb4Fm4ggBLsoDYLxYgG6at6pHejY=;
        b=1eHfjTJIu1FUaHldYI6b80W4U+YUHiw4vs6qq4KNSABMZhLeh+7vi7uSvpB1PTCH7O
         DTg5dmVYFmzhnYPRNPWPC041x5EuknFTDMmYsvZCaQaXquwqpYv3qMEXgxAgLMRBWWBp
         UpeT91Vzvo3nEWKOHlS3XCMfcYDIDIIjmeWRdCBsB7NqCmg7bHVy7lkbiaovNqvjAA+q
         sN7aQ9JOctCfFUNdSonIwooa7MbY680Q7+quXeJhsY+vjPLHnnwzAOCtsnvDVGzaZrcY
         gM0VOz4FcJKMbklMG+M4cTzm06SVg9WqT8u4hvCGR5GkXp32Foa7Bu52mgLKHtaujYOe
         ddBA==
X-Gm-Message-State: AFqh2kpcj94FAfazy1lek6Xkq07C7qjpa0ssjs2zomOO43T3xn5MNkyC
        yO6GmwIe26JVLW3aVF2H1lYfFg==
X-Google-Smtp-Source: AMrXdXuD+54sTdkbtzGXQeStL4I1NB/gu8n1pv4Sv8qbfcT17ZmiI/I83+LSm9wC1ismvoADdTLHlQ==
X-Received: by 2002:a05:6000:818:b0:271:16e6:3d54 with SMTP id bt24-20020a056000081800b0027116e63d54mr23860090wrb.70.1672658610460;
        Mon, 02 Jan 2023 03:23:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003d9780466b0sm32777404wmq.31.2023.01.02.03.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 03:23:29 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 02 Jan 2023 12:23:20 +0100
Subject: [PATCH] regulator: qcom-rpmh: PM8550 ldo11 regulator is an nldo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230102-topic-sm8550-upstream-fixes-reg-l11b-nldo-v1-1-d97def246338@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKi+smMC/w3MUQrDIAwA0KuUfC8Q7YSx2xjN2oDVYtoxKL37/
 Hw/7wKTrmLwni7o8lXTVgfcY4K0xroIah4GT34mRx6PtmtC214hEJ67HV3ihh/9iWGXBYtzjLXk
 hvzM4hPPIRPD+DiaIPdY0zrGepZy339kyXfkgAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the definition of the PM8550 ldo11 regulator matching it's
capabilities since this LDO is designed to work between 1,2V and 1,5V.

Fixes: e6e3776d682d ("regulator: qcom-rpmh: Add support for PM8550 regulators")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 43b5b9377714..ae6021390143 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1016,7 +1016,7 @@ static const struct rpmh_vreg_init_data pm8550_vreg_data[] = {
 	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv, "vdd-l8-l9"),
 	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,    "vdd-l8-l9"),
 	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,    "vdd-l1-l4-l10"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,    "vdd-l11"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo,    "vdd-l11"),
 	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo,    "vdd-l12"),
 	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,    "vdd-l2-l13-l14"),
 	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo,    "vdd-l2-l13-l14"),

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230102-topic-sm8550-upstream-fixes-reg-l11b-nldo-b4de2cb35d0b

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
