Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C690730042
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbjFNNkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjFNNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:40:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E1171C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:40:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f6170b1486so8212111e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686750002; x=1689342002;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7UQguZQ8UjS/hKR0iZphdIhADu2Uf0Hjk36g5bpmli8=;
        b=LQin0HMDysZJ5YKUSLOnUZB1QGIYEALVSuW4Kdo9SVdMnU1bV54rsKGaJTSBtBGdd6
         ykn6nUkxiz/SfqH/GaPqQ9n2bFOPS9INB8gYn/lk80bZoAZrmD1wn9JAWDv6Gg5aq+3W
         6P/Q6RSDWj1WEPi8yo+IA6L4rB1g2b/xH3NpEIesnVurxUNnSdVYNRdnlyI4/KbrAUGk
         pKDLtsVlWT2plbWD/l6VoIcYM4G6F/ZBj5iwiiVZ7rBM1IjCAfIzDfJhcpTs974r3Ejp
         Mt90hhairpVxNUTw/RlL3E6ds6J+Nz2KQbaIdjShig/A+CIEkzQ/d9yq7IhDwbI8pyL8
         VeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750002; x=1689342002;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UQguZQ8UjS/hKR0iZphdIhADu2Uf0Hjk36g5bpmli8=;
        b=Lm1ZM5TBPcYln2akHqoMmwXc4dKkG6CYQlWxnqFLZ+4C9N540w5rLC46GZfd4qQt8d
         IF4OPK1+YJUxQyAsfLrHozdiyMb1naWrshLeu4k7wvZ6ADHpf9SCtgggjuNUH1s/wcql
         HCkiRPehMnahyW3+mhZO/mAaNYAOPuzMOdbB+SdQ4GoyJd2SICfiThL1hp/BOTMaIAC5
         9L4KLiz27kE6mm4OstAwNEPEvBY/pCeFF+eC6UqA3CXIVyhhxIAK+xBKtfyNgj/R5YFq
         XkFCxyLoixlqqXEyfpjz6wst8Z7mSbCpEHewl4LMTvq2tht/y3xZdICoooX+6t0MCFxO
         Sdbw==
X-Gm-Message-State: AC+VfDyInm2iFm+mXcaeclhTpcprSaPZzRGUxuYnUjFOKJdTMMc/4bIU
        iuKBJfwFRwFdb36IyFLLrCvZjw==
X-Google-Smtp-Source: ACHHUZ6fc1ctTbg4AhUfMK4jbQTSpQLFDRSpcv9Rt4tHyq1qLDyYC+h+zs0FhePajSkzHVn9tyBptg==
X-Received: by 2002:a05:6512:1095:b0:4f7:68fa:90f7 with SMTP id j21-20020a056512109500b004f768fa90f7mr460321lfg.32.1686750001903;
        Wed, 14 Jun 2023 06:40:01 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id y26-20020a19751a000000b004e90dee5469sm2124970lfe.157.2023.06.14.06.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:40:01 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 15:39:59 +0200
Subject: [PATCH RFC v2] soc: qcom: icc-bwmon: Set default thresholds
 dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230610-topic-bwmon_opp-v2-1-0d25c1ce7dca@linaro.org>
X-B4-Tracking: v=1; b=H4sIAC7DiWQC/3WNyw6CMBAAf8X07BpaBMWT/2GI6QvYBLvNFlFD+
 Hcrd48zyWQWkTyjT+KyWwT7GRNSyKD2O2EHHXoP6DILVaiyqGUBE0W0YF4PCneKEbqmqYxxTp6
 NE7kyOnkwrIMdchee45hlZN/he9vc2swDpon4s11n+bP/B7MECXUlVeVOx6bs7HXEoJkOxL1o1
 3X9AnAOZSPEAAAA
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686750000; l=5206;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fbPTDehvQFwJCmhSqjL7G8q7McSqpImwaP/i+H/emh4=;
 b=mI0bxrsx85e9YfYvgnCOZSwueVwAUbjAQomCRVbx6eb5NE7F6Xg9LPp14vi9DodKyjCQRS6fz
 TMVUkr5/k6PB4oTePOkJ5FIpsce0TfauRfm6pxm4DYwJlJcgIPyXPlM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use predefined initial threshold values. This works, but
does not really scale well with more and more SoCs gaining bwmon support,
as the necessary kickoff values may differ between platforms due to memory
type and/or controller setup.
All of the data we need for that is already provided in the device tree,
anyway.

Change the thresholds to:
* low = 0 (as we've been doing up until now)
* med = high = BW_MIN

Throughput going below the med threshold nudges bwmon into signaling
that we should slow down (e.g. if we inherited too high bandwidth
from the bootloader).

Throughput going above the high threshold nudges bwmon into signaling
that we should speed up so as not to choke the bus traffic due to
insufficient transfer rates.

F_MIN is a perfect initial value for both of these cases - if we go
above it (and there's a 99.99% chance it'll happen at boot time), we
should definitely make the memory go faster, whereas if we go below it,
we should slow down, no matter what performance state we were at before
(it's only possible for them to be >= FMIN).

This only changes the values programmed at probe time, as high and med
thresholds are updated at interrupt, also based on the OPP table from DT.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Drop now-merged dependency
- Drop div4 for the med value
- Better explain the reasoning in the commit message
- Link to v1: https://lore.kernel.org/r/20230610-topic-bwmon_opp-v1-1-65125d7493fc@linaro.org
---
 drivers/soc/qcom/icc-bwmon.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 40068a285913..8daf0eb03279 100644
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
+	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED], bw_low);
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
base-commit: b16049b21162bb649cdd8519642a35972b7910fe
change-id: 20230610-topic-bwmon_opp-f995bbdd18bd

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

