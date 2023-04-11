Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68E76DDC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjDKNra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDKNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:47:24 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D1CBB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:47:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a29so9308418ljq.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681220841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMpFnRGQLpD0/uI8QbJICzvLZYwTAUaXXk9QdFEBIQM=;
        b=Ih1pAVETpfX6vFjZzsrU0nhzd9ooOsv4UtGhKo1SJ6Wb6JpfMUiUXnjPv8nyHl3Lj0
         RGYILeR9gOPvstCnLS7AEkDv+HSTXSrCX4TOGAkF52s074/+NzvsrofUDJqCXaFC+Kj4
         /pI0SU/zWbwGfVanqnk8XLgfMoS3got5TfRnQ34NYJ1rYZzoYWjc5BKSiNMt9nlwFKfa
         +biZlJH3jPZWiRnXEDefTGSYlIaB5jxFM1/dxJmuHFbpySiblP+5gNwo/whO3O5DI9j9
         g4I1kZfgkEzmSJzsYaR+iCjHTzhxgrEDnUqtg9LLiiqbM1yOHjTGM/8mOkFO9ETPOh3Y
         BJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681220841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMpFnRGQLpD0/uI8QbJICzvLZYwTAUaXXk9QdFEBIQM=;
        b=NUS0g6jLNqcrpVASfFRxxhMUjsA6y/HTIIQPoKKfy6kMfjw6uyO6vh+mobSJZxFmOQ
         Lsa763OB9lGcdy6wLzk0trj8u8C7tDwm7PWxhpHPjBNX4ujR0Zl+yEpoCHPALC/EeiGc
         MfzjB+rXWT0rievZX70MZuQdTOePln+orlnTmWXZvvh3Z72uPy0Ecl09d3imCvq/odHw
         CgnYILPztzOGtpGpdiShoGaPuU03Vjk+NbrxUJdgwrpZIZ3D65JKCLpcG88HoVjw4dFi
         xVQ2/Px8CmOxzHcLT+dctbdryxgBdE+UAsSDsG/uVpVVrUcgWUk4Fz73BqbqIpdRCmlr
         Ra6g==
X-Gm-Message-State: AAQBX9chJ8Oq5D4FEZZ6m+3r2n6LvpaxWR3+4i1+8gj3a8mV74UR1gUR
        rJSYDWntkb6sGuPapvwiZ0Sv1Q==
X-Google-Smtp-Source: AKy350ZdFm6JWgIVntvxvvw0BYNveQRYcDbYv7tm8DTFsufdMyXUGH5TtnPH3MCU6j6pcULbMWXcHA==
X-Received: by 2002:a05:651c:86:b0:2a7:8544:1e71 with SMTP id 6-20020a05651c008600b002a785441e71mr1007719ljq.3.1681220841307;
        Tue, 11 Apr 2023 06:47:21 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id c10-20020a2e680a000000b002a77583b718sm1245887lja.12.2023.04.11.06.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:47:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Apr 2023 15:47:16 +0200
Subject: [PATCH v2 2/3] soc: qcom: rpmhpd: Add SA8155P power domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-hanaau-v2-2-fd3d70844b31@linaro.org>
References: <20230411-topic-hanaau-v2-0-fd3d70844b31@linaro.org>
In-Reply-To: <20230411-topic-hanaau-v2-0-fd3d70844b31@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681220837; l=1539;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=aleVgKoikHUj3PFLGGlVddGgNibZMFZrpZpiNyXETRk=;
 b=sTkfdoeJEh0DLv2zaqWJnb+oFxlftDT0WFj/i98DJa74JgErgzZhzI5waUUQ52rYEuoiWN5KaCsP
 L1IDuRb0DIARcCWp8ANRzoBTScTDCf/bC6qqT3HnqCeX9OgOhRMr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power domains exposed by RPMh in the Qualcomm SA8155P platform.
Turns out they differ from SM8150.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index f20e2a49a669..63c35a32065b 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -342,6 +342,21 @@ static const struct rpmhpd_desc sm8150_desc = {
 	.num_pds = ARRAY_SIZE(sm8150_rpmhpds),
 };
 
+static struct rpmhpd *sa8155p_rpmhpds[] = {
+	[SA8155P_CX] = &cx_w_mx_parent,
+	[SA8155P_CX_AO] = &cx_ao_w_mx_parent,
+	[SA8155P_EBI] = &ebi,
+	[SA8155P_GFX] = &gfx,
+	[SA8155P_MSS] = &mss,
+	[SA8155P_MX] = &mx,
+	[SA8155P_MX_AO] = &mx_ao,
+};
+
+static const struct rpmhpd_desc sa8155p_desc = {
+	.rpmhpds = sa8155p_rpmhpds,
+	.num_pds = ARRAY_SIZE(sa8155p_rpmhpds),
+};
+
 /* SM8250 RPMH powerdomains */
 static struct rpmhpd *sm8250_rpmhpds[] = {
 	[SM8250_CX] = &cx_w_mx_parent,
@@ -519,6 +534,7 @@ static const struct rpmhpd_desc sc8280xp_desc = {
 
 static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
+	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &sa8155p_desc },
 	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
 	{ .compatible = "qcom,sa8775p-rpmhpd", .data = &sa8775p_desc },
 	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },

-- 
2.40.0

