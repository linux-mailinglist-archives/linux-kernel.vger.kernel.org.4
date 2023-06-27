Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604AC74035E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjF0SbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjF0SbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:31:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF72106
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:30:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso6592270e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687890655; x=1690482655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlJNXwesiBvinVlCm08BsBVW76YCVdXRX2U7PUbcI/o=;
        b=eldDyj+vrO8B1EHdlEMPLEOHFCl6Si0hRnQUWciBEd3htvn9vdm6kAyicutqD76S0g
         bGgWtm34+fKxqnz0FT5RSv1j8tOoh1DE8FEUBE6TFikADzN/k/qfb8gNg0eAAIqb0ols
         wsxmDPYyNPikkpL5q4J/wvHYv+azzdwd1FylVlMD+zCTEh7dMs/HtN1/Xfn73L67Yqqr
         0s8Mr8ib8dHxbk4xv9DFlSlIlbqop+IogDwUSJwaf/fLpuG1we7DVl7+BPSIWv+EhfQu
         rX76z9OPET8WM7HJQkiZ863JQtr3PP9YlzUOuKN4VBae/83/QllOXFzUv5dM9tQ6rfPc
         2QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890655; x=1690482655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlJNXwesiBvinVlCm08BsBVW76YCVdXRX2U7PUbcI/o=;
        b=VJWSOtR+iAxBkCNs9Ipex6qi2PrB1b9ngdfkGt4kZ4CyP/UDaG5Yn21/+ZksYLDXUY
         +oyAXOaYPksceJiKntYYdKrnGWAUPH3bdTDv2XOBihe8cP9QmOiRe6+vYRdZUECKP0FA
         yFITsaPP2EkR9mL06K3xmT0puslYVqzWl7ETFB3MNrm4j38pzMpABbtIMq5UvJ9XM6Cj
         7uGOwvr5ATaHIyWwBJ4YeKjmZi8X54ekCGImzuev0MVMYgp5Zb2MRYGQVlY+Cz2I4aS5
         TqYviJ6jugNP+1tRyuxIal2owOAqYXRewFDivf5JiLRgluH53LCDJzohUvMtFnrzzhFZ
         3VsQ==
X-Gm-Message-State: AC+VfDxdx3KB32i1ECEsrQXRzQHnXU1u5GFAjbSfXcyzQvB3cLfN/Xee
        e7c7fp//lT5PfHtsuuYSAJqO3w==
X-Google-Smtp-Source: ACHHUZ4FmTiVlBb6s2iYb8rw/PrKV2+x4L8lUJLEKXdVIPwYmJ8d6A/4Qw5G8r23xXlLiMWv+a/Clw==
X-Received: by 2002:a19:5e0b:0:b0:4f8:72fd:ed95 with SMTP id s11-20020a195e0b000000b004f872fded95mr13852593lfb.22.1687890655186;
        Tue, 27 Jun 2023 11:30:55 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id q16-20020ac25290000000b004f640b0fb04sm1605205lfm.212.2023.06.27.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:30:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 20:30:41 +0200
Subject: [PATCH v11 5/9] soc: qcom: cpr-common: Add support for flat fuse
 adjustment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v11-5-ba22b4daa5d6@linaro.org>
References: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687890646; l=2032;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PZkzlg9a1T62vJjNL6pym3+YcX1sRFAyVy3l058FxdA=;
 b=Jypq10op7Z+li1iCijvCe2nLKNbkLjsWKK5RAHWVm+FoT/8W3Lflq5ZzgQ9bTceYQ5dFZ+Mn3
 hR2F0M7g/scBQPRCt1AExVa6Pwry++CGbTcN+a6RIhxkdmuAJDiKrcT
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

CPR3 makes use of post-calculation flat value adjustments. Add the
necessary bits to the common functions to support it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate this patch out of a bigger one]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/cpr-common.c | 9 ++++++---
 drivers/soc/qcom/cpr-common.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/cpr-common.c b/drivers/soc/qcom/cpr-common.c
index ea85f6b4bef8..44c681bbbf13 100644
--- a/drivers/soc/qcom/cpr-common.c
+++ b/drivers/soc/qcom/cpr-common.c
@@ -49,7 +49,7 @@ int cpr_populate_ring_osc_idx(struct device *dev,
 EXPORT_SYMBOL_GPL(cpr_populate_ring_osc_idx);
 
 static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
-			    int step_volt, const char *init_v_efuse,
+			    int adj, int step_volt, const char *init_v_efuse,
 			    struct device *dev)
 {
 	int steps, uV;
@@ -67,6 +67,9 @@ static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
 
 	uV = ref_uV + steps * step_size_uV;
 
+	/* Apply open-loop fixed adjustments to fused values */
+	uV += adj;
+
 	return DIV_ROUND_UP(uV, step_volt) * step_volt;
 }
 
@@ -119,8 +122,8 @@ int cpr_populate_fuse_common(struct device *dev,
 
 	/* Populate uV */
 	uV = cpr_read_fuse_uV(init_v_width, init_v_step,
-			      fdata->ref_uV, step_volt,
-			      cpr_fuse->init_voltage, dev);
+			      fdata->ref_uV, fdata->volt_oloop_adjust,
+			      step_volt, cpr_fuse->init_voltage, dev);
 	if (uV < 0)
 		return uV;
 
diff --git a/drivers/soc/qcom/cpr-common.h b/drivers/soc/qcom/cpr-common.h
index 1f2ebf9394cf..0aa227617d2f 100644
--- a/drivers/soc/qcom/cpr-common.h
+++ b/drivers/soc/qcom/cpr-common.h
@@ -22,6 +22,7 @@ struct fuse_corner_data {
 	int ref_uV;
 	int max_uV;
 	int min_uV;
+	int volt_oloop_adjust;
 	int max_volt_scale;
 	int max_quot_scale;
 	/* fuse quot */

-- 
2.41.0

