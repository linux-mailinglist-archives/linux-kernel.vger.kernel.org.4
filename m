Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B0F72AB46
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjFJMCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFJMCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:02:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7BF0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 05:02:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1c5a6129eso29182931fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686398519; x=1688990519;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICTpWNTXd256PJ22KJ2Tpok44GO6Kto6M7oAb6M4VRk=;
        b=e+9dMaCa2iMooJskXtoQxVcTnQKzXjg8mmCuBbKLJc2bPn8wUwTs8C6s43zIyIHihS
         Ej/c+xqk3NfUt115MLOeiffpVwOI9v+ecgXAF6O6bTbrcAnMviZ64rMD/VOKmA8CVIfC
         RYmZn5ADgAFFG9itxlJoAWiW7VfyB0GVjc+Ri4ZXMaJS2EL7j36e0lSiTmZQpKtW0AAw
         1Y1sBYkhnLwT+GhLBbEzOA4Cnpk+s3bkkw7Ue6Qtbq2nkDZ6cFWigYyDnu87awk1/pCj
         3qdUqj7mqTdyvWrVF8Bj6Huplag6DjV5veIi52DslkI9zlasT+bLMKrCoX9FF85fmAL6
         8Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686398519; x=1688990519;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICTpWNTXd256PJ22KJ2Tpok44GO6Kto6M7oAb6M4VRk=;
        b=h+Ch/gVXHiHWgOahBbbEtx+teNIh9bOFWncI0RL+E+liPFPDK6VtuAgDqUWP7pJHEf
         aRMj+M0QzPQQ8n4kB1LstuUKwbQRy+/3W69/dUB8SSXBHZ9fxSPVpuilDYIB/yG0PEs9
         AOcXqAmv0fCpwjqdEDSpM2D4cYVNsNMZEVm0fVPziHGi8oVhTOVEr5eDNurHX0Kkmmrr
         Lntt+pDWRodGTbh3WWWZZ0S4aYomt/mrYFbaXwjwQJh+6gFL9Ejbs5WOhlRsIvGcXXuV
         JIBo+7tmrcRhTAMFDWh1v/rm5n1OZQwo4lnJTw6g3pGpJQaxKQXp36jkO/YtK8V9RGzs
         yvYA==
X-Gm-Message-State: AC+VfDxK9vLyLFAQRJ9ULHTE+Va4ZD7zBfJAQJ8VotUUIQyoNQIstOg3
        MdKIYeRWp/eTBpO/et+f3zY8aQ==
X-Google-Smtp-Source: ACHHUZ4qHcUw/iX8aJKQFQZYVE7Wuk2vZ7kGUBPovzUsVG/+K15XVf/+rbciYp3ssY2GI2Z5o5TWMg==
X-Received: by 2002:a2e:8553:0:b0:2ab:bd1:93da with SMTP id u19-20020a2e8553000000b002ab0bd193damr542143ljj.10.1686398518944;
        Sat, 10 Jun 2023 05:01:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m21-20020a2e9355000000b002b2075e21c4sm810548ljh.34.2023.06.10.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 05:01:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 10 Jun 2023 14:01:53 +0200
Subject: [PATCH RFC] soc: qcom: icc-bwmon: Set default thresholds
 dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230610-topic-bwmon_opp-v1-1-65125d7493fc@linaro.org>
X-B4-Tracking: v=1; b=H4sIADBmhGQC/x2N0QrCMAwAf2Xk2UC7oTh/RUSaNnOBmZZWnTD27
 wYf7+C4DRpX4QaXboPKH2mS1cAfOohz0AejJGPoXT+4k3f4ykUi0vrMes+l4DSOR6KU/JkSWEW
 hMVINGmfr9L0sJkvlSb7/zfW27z8KvvN5dgAAAA==
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686398518; l=4530;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=q3OEiKhtW0kY3jB6PwEccRcmYVrrM8XmY1nl92EsweY=;
 b=Twovgpjj0w5qdv34zWFSYaQn+L2Kne1B2l0Yd0a0rRyljhx9w0tU5ioYuiGLanS+qtuH3owZ6
 7EOozR3vaEGDVczhwnWJSrXNpCJI5w4VFSACYy9XEhAg4wJmeT56q6F
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

Currently we use predefined threshold values. This works, but does not
really scale well, as they may differ between SoCs due to LPDDR generation
and/or DDR controller setup. All of the data we need for that is already
provided in the device tree, anyway.

Change that to:
* 0 for low (as we've been doing up until now)
* BW_MIN/4 for mid
* BW_MIN for high

The mid value is chosen for a "low enough" bw to nudge bwmon into
slowing down if the bw starts too high from the bootloader.

The high value corresponds to the upper barrier which - when crossed -
raises an interrupt in the third zone, signaling a need for upping
the bw.

This only changes the values programmed at probe time, as high and med
thresholds are updated at interrupt, based on the OPP table from DT.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 40068a285913..99cbdb3cf531 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -165,9 +165,6 @@ enum bwmon_fields {
 struct icc_bwmon_data {
 	unsigned int sample_ms;
 	unsigned int count_unit_kb; /* kbytes */
-	unsigned int default_highbw_kbps;
-	unsigned int default_medbw_kbps;
-	unsigned int default_lowbw_kbps;
 	u8 zone1_thres_count;
 	u8 zone3_thres_count;
 	unsigned int quirks;
@@ -564,20 +561,21 @@ static void bwmon_set_threshold(struct icc_bwmon *bwmon,
 static void bwmon_start(struct icc_bwmon *bwmon)
 {
 	const struct icc_bwmon_data *data = bwmon->data;
+	u32 bw_low = 0;
 	int window;
 
+	/* No need to check for errors, as this must have succeeded before. */
+	dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_low, 0);
+
 	bwmon_clear_counters(bwmon, true);
 
 	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
 	/* Maximum sampling window: 0xffffff for v4 and 0xfffff for v5 */
 	regmap_field_write(bwmon->regs[F_SAMPLE_WINDOW], window);
 
-	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH],
-			    data->default_highbw_kbps);
-	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED],
-			    data->default_medbw_kbps);
-	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW],
-			    data->default_lowbw_kbps);
+	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH], bw_low);
+	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED], div_u64(bw_low, 4));
+	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW], 0);
 
 	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE0],
 			   BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT);
@@ -807,9 +805,6 @@ static int bwmon_remove(struct platform_device *pdev)
 static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.sample_ms = 4,
 	.count_unit_kb = 1024,
-	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
-	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
-	.default_lowbw_kbps = 0,
 	.zone1_thres_count = 16,
 	.zone3_thres_count = 1,
 	.quirks = BWMON_HAS_GLOBAL_IRQ,
@@ -822,9 +817,6 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
 static const struct icc_bwmon_data sdm845_cpu_bwmon_data = {
 	.sample_ms = 4,
 	.count_unit_kb = 64,
-	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
-	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
-	.default_lowbw_kbps = 0,
 	.zone1_thres_count = 16,
 	.zone3_thres_count = 1,
 	.quirks = BWMON_HAS_GLOBAL_IRQ,
@@ -835,9 +827,6 @@ static const struct icc_bwmon_data sdm845_cpu_bwmon_data = {
 static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
 	.sample_ms = 4,
 	.count_unit_kb = 1024,
-	.default_highbw_kbps = 800 * 1024, /* 800 MBps */
-	.default_medbw_kbps = 256 * 1024, /* 256 MBps */
-	.default_lowbw_kbps = 0,
 	.zone1_thres_count = 16,
 	.zone3_thres_count = 1,
 	.regmap_fields = sdm845_llcc_bwmon_reg_fields,
@@ -847,9 +836,6 @@ static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
 static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
 	.sample_ms = 4,
 	.count_unit_kb = 64,
-	.default_highbw_kbps = 800 * 1024, /* 800 MBps */
-	.default_medbw_kbps = 256 * 1024, /* 256 MBps */
-	.default_lowbw_kbps = 0,
 	.zone1_thres_count = 16,
 	.zone3_thres_count = 1,
 	.quirks = BWMON_NEEDS_FORCE_CLEAR,

---
base-commit: 49dd846128d56199db2e3bcfca42d87fbc82b212
change-id: 20230610-topic-bwmon_opp-f995bbdd18bd

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

