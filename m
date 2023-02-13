Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF769536F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBMVzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjBMVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:55:05 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4096E222ED
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:55:04 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s11so7138753edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKAZgUcGAsaoUrTcrozzl66DRQFN/kA73HojvdU9gsg=;
        b=szI7X+aMLGgxPmWUyoGnyXn4Yt1POMEP3p3aGLtUiGc5iphf+mRgubAJfWazo/wDaU
         8DFT9D300PJEfNjz3vZxyG1juL6h63NYIjQQvkeeXCNxaa+zHaLMX2v+po918HiaiXyX
         t2cEaWP67YWuZT/O8CRGk7Eo5KleivU2DHxkMyb3BDlYOyFf3E382OdItG+/BFcxZR3c
         3DR0+/Er7CNTgK9buimgwUvQXJ9bmQ0LSxzg0vHb0WmPa3x3w/uaHfR3XD1zjRVHFNpF
         BCQJaP8eP4tKyohoBMX50Tq1akPjS3kLvhIplq0LPgxNHwKMSOu/OVXosK/+6HS3yZKf
         WOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKAZgUcGAsaoUrTcrozzl66DRQFN/kA73HojvdU9gsg=;
        b=TvNqUqq+yLcibHDpyYJ9cqYdNeBmwMJ8NPnLG9193t3kQiz2t0sSflluCskcyNA8kZ
         XxJOtIl27ME/oSfho0nr71I6s3r5VBH5vTQO3PKpcG4zdknh+qCrwjkOLRrC3lqgxTEy
         /GlbZ9FVwuNTQDMCJg43fdqdDBVA+PjDy+sZBz/OnqlniwoMJ+/jgMgdSZZD+p2Kh8ET
         jrNT0lvpU0t5zPRK5bNOxrrXDq1oTdG5kjSWMOxM7An0oC2/m2KJUk2TreYtKSfQGTCj
         VVG+GQpf7wB31e25BBgJlOQWCNQ0BOEeO02uwvNPT+hXXXGI8AjtGUutImulZPW+GWOB
         7Idg==
X-Gm-Message-State: AO0yUKVqZc6Nd0pSUEUizBwMYKlJ77lwMeN3fWDb6GoUrJxymL40OJHm
        Ko5sS85lqTNrMtltI9oGTKbykw==
X-Google-Smtp-Source: AK7set+XiO3jhyEoqEcNDS8/GqYdwfxwar+RJoB/bnqwf9vqOyws+WWcliUiOPxv2CKvSL/BLfifxQ==
X-Received: by 2002:a05:6402:320a:b0:4ab:1db8:df45 with SMTP id g10-20020a056402320a00b004ab1db8df45mr10635503eda.8.1676325302829;
        Mon, 13 Feb 2023 13:55:02 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id v1-20020a50a441000000b004aab66d34c7sm7264837edb.7.2023.02.13.13.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 13:55:02 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: socinfo: Add some PMICs
Date:   Mon, 13 Feb 2023 22:55:00 +0100
Message-Id: <20230213215500.2131511-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some missing PMICs based on the _SUBTYPE defines in
include/soc/qcom/qcom-spmi-pmic.h

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index e9012ca1a87b..b9d58b6ed6b4 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -109,15 +109,20 @@ static const char *const pmic_models[] = {
 	[32] = "PM8150B",
 	[33] = "PMK8002",
 	[36] = "PM8009",
+	[37] = "PMI632",
 	[38] = "PM8150C",
+	[40] = "PM6150",
 	[41] = "SMB2351",
+	[44] = "PM8008",
 	[45] = "PM6125",
+	[46] = "PM7250B",
 	[47] = "PMK8350",
 	[48] = "PM8350",
 	[49] = "PM8350C",
 	[50] = "PM8350B",
 	[51] = "PMR735A",
 	[52] = "PMR735B",
+	[55] = "PM2250",
 	[58] = "PM8450",
 	[65] = "PM8010",
 };
-- 
2.39.1

