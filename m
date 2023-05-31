Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B439718770
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjEaQdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjEaQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:33:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48A11F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:33:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af2451b3f1so66762531fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685550795; x=1688142795;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YJ6W2xZKjXLWjXyPLceQOWsxYMwSmn1mJP9tRNNRo4=;
        b=r09k19xteS1JYAOAOP5G1/xuItGfw1dTM8qf2qkF47cuooC/O73aDMUlMJoDztzKio
         fTWfNwFFOsjzu5mKyPCfdgjBB4kwE9Qnbp/BP5HgIitEbUO1AjYaJrP2RN2hPQ+Jtldg
         WDW/NdSLTGnfofCGF1PiI5imaUCu4DMsi8OGqVlUdG8Z4ZJPZO/97SqjW9A3hwgqIGtg
         mTJsCTaE3fh6Dpuqm8HJYK84hWjxe5g9AdcrulK95DHHxN6WvLh6hfUo0jAcsJPGKB+9
         Yj9IEP5kUisg5viyG/97tFtd9JFk2BBbMW7ZAQRGmAD1QvspUNHayOaB2Z70U4xpYA+R
         VaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685550795; x=1688142795;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YJ6W2xZKjXLWjXyPLceQOWsxYMwSmn1mJP9tRNNRo4=;
        b=XW25/U1o29ebWHrWsy9ILoGHtO1NoV8a2JjIyS6e3mLV6LG6ZOD09eYGvZBq7HSQU+
         wEi7skYe5J2V7DSNWqhS0Rrg6tS8yWs1kY6l1m8/ltNZ1rROn8/IpDQjpQ2kut9JdWpA
         dwi0+5McEJvbEW9JMT2XYIYknpCQiz1fjGagMSWyyuWhIh0UiUH5wQrhBAapeUiY/OeE
         mQAV99tta7b81ISXuFASxxLIJ6zOMOE2Z7YZKgS70j1LqUop83zfGhgqn4oXGYRHhEzo
         gOrn7nJdGUmeP5gdu72A26NZCEtOnbh+c3RMsmHCCl5oWhyEliH2tPikg1LrNV4v5JNL
         +B4g==
X-Gm-Message-State: AC+VfDyrdwfzMJ3ye9nbLG5yZRiesDQpV+HWEmzNILJaiET73MD09O6J
        VhndDa/jmdZbKFtq+WOKqDbcGA==
X-Google-Smtp-Source: ACHHUZ5VkEjBPw7jRUcJI+603ZHy5ss79uZmBxDYyS1FPQ0lexW2W3fJ0FR1LPt30delgRZM7e5RNA==
X-Received: by 2002:a2e:8782:0:b0:2ac:8efb:fc02 with SMTP id n2-20020a2e8782000000b002ac8efbfc02mr3033105lji.4.1685550795435;
        Wed, 31 May 2023 09:33:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e740f000000b002af0e9abaf6sm3354956ljc.131.2023.05.31.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 09:33:15 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 31 May 2023 18:33:03 +0200
Subject: [PATCH] soc: qcom: icc-bwmon: Fix MSM8998 count unit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-msm8998-bwmon-v1-1-454f9d550ee5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL52d2QC/x2NywrCMBAAf6Xs2YU0VZr6K+IhiatdaDYl6wtK/
 93F4wwMs4FSY1I4dxs0erNyFYP+0EGeozwI+WYM3vnBnYYen3XljEVLmKaA6VOqYIreBT/ScXQ
 EVqaohKlFybO18loWk2ujO3//q8t133/79iAxegAAAA==
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685550794; l=906;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=go8UW9ur+8RYar9jjvCnTAVEWNOpysVFLv9iAzF7uLE=;
 b=25S9ajGSv/UmiA7723m/2lJXOi18uwLF9riSdlYY4by/DdqmZpyoWm0E9XDe6+sW5hfWz13gR
 Vnyi2LUSANmCMS4dXsaztnWw5Pk8YlUb48uqPBk8sqrf3WiGuA+P2ko
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8998's BWMON counts in megabytes. Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index f65bfeca7ed6..40068a285913 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -806,7 +806,7 @@ static int bwmon_remove(struct platform_device *pdev)
 
 static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.sample_ms = 4,
-	.count_unit_kb = 64,
+	.count_unit_kb = 1024,
 	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
 	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
 	.default_lowbw_kbps = 0,

---
base-commit: d4cee89031c80066ec461bb77b5e13a4f37d5fd2
change-id: 20230531-topic-msm8998-bwmon-ba20827e470e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

