Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5B2705189
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjEPPFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjEPPFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:05:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432A27699
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:05:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643a1656b79so10274207b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684249531; x=1686841531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Tk69piEZehakfGwQkU6K1Gxhofm6gj5FoUxxJ+kPXY=;
        b=bP3GrpcPfjNBk7Qsk/LbSdl3l/3ZxuLchlMgUJGN0o4YXwndKpmIZojFY/CTUtDIGR
         xb73/AHdtg1ajXvnzRe5ZNRb6FNWreWIGWep2+lkHSuaGhGYTHwNrFUof9yauxP5aicx
         Bdvrut7O1relZSspFc3SDu7H/7Mn8gP9F76jPwsnCQihwiZzECCCtfz9IFp9dcfZJLw6
         LPFWL5jIRIjyHejoCJNNoMuVcGCqlTQz4zAPVM69CwEp790iPNA/LYfmaOTCOKNzW3Mx
         QvHJyuY18IYtAP4er4A+CjpHwwlo5kDQRWqUEPIyklhH4n1khUM8F6d0BxZssRZiYF2Q
         xISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684249531; x=1686841531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Tk69piEZehakfGwQkU6K1Gxhofm6gj5FoUxxJ+kPXY=;
        b=Gxn4Laq0Wtc5amFOZL4QUNFZM8x/30G5oJ0UR/xI4pzvL/IsafUreuqgme7zWOB5zn
         8jZ6dfV/V4/pJ8OB1LOuY6MwGrZIEnuKMuLvmZJ9lSHm0tlJ2DrWKVIHlhWR44MVVXtZ
         s7P+yery2p0+A0zBImU4izINXj9TcjdaJOVY1oWyvW9d9Fe/yckHdmrfmLNsnQGW3ebs
         ALyE0Dl1PZ8YbeNQV+wKURdP/7tnalNVwtdjLhn9nHOumhCvgvqP36EdPCLpdEMKiOCS
         lKdAxnseN7o/NG6iuZoF5wBfsgxo10OaVtZXudCsXj7nfB7xUkN/8XgSWUzBia2uBAu4
         bWAQ==
X-Gm-Message-State: AC+VfDw3yxX6g1ujT/YKOiiOnXM84Fu7QAi9N+7oHFALGCNMj7eR6vvP
        JYAX6R7MSwkjuwAVuNWEyl7h+Q==
X-Google-Smtp-Source: ACHHUZ5Uo07ip94m8A4F6ZiYgZqe5DrESlk+jSBowuJvRUz6YM5eMTJ06NNsVaIeITxG0EDxXWeimA==
X-Received: by 2002:a05:6a00:2e1b:b0:63d:6744:8caf with SMTP id fc27-20020a056a002e1b00b0063d67448cafmr44506593pfb.26.1684249530715;
        Tue, 16 May 2023 08:05:30 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6bed:72cf:f5c9:ba94:6b85])
        by smtp.gmail.com with ESMTPSA id h1-20020a654801000000b005302682a668sm12817164pgs.17.2023.05.16.08.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 08:05:30 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v11 2/4] phy: qcom-qmp-usb: add support for updated qcm2290 / sm6115 binding
Date:   Tue, 16 May 2023 20:35:09 +0530
Message-Id: <20230516150511.2346357-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230516150511.2346357-1-bhupesh.sharma@linaro.org>
References: <20230516150511.2346357-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the new qcm2290 / sm6115 binding.

The USB QMP phy on these devices supports 2 lanes. Note that the
binding now does not describe every register subregion and instead
the driver holds the corresponding offsets.

While at it also include support for PCS_MISC region which was left
out earlier.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 6f2798bbe513..466f0a56c82e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1513,9 +1513,13 @@ static const struct qmp_phy_init_tbl sa8775p_usb3_uniphy_pcs_tbl[] = {
 struct qmp_usb_offsets {
 	u16 serdes;
 	u16 pcs;
+	u16 pcs_misc;
 	u16 pcs_usb;
 	u16 tx;
 	u16 rx;
+	/* for PHYs with >= 2 lanes */
+	u16 tx2;
+	u16 rx2;
 };
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
@@ -1668,6 +1672,16 @@ static const struct qmp_usb_offsets qmp_usb_offsets_ipq9574 = {
 	.rx		= 0x400,
 };
 
+static const struct qmp_usb_offsets qmp_usb_offsets_v3 = {
+	.serdes		= 0,
+	.pcs		= 0xc00,
+	.pcs_misc	= 0xa00,
+	.tx		= 0x200,
+	.rx		= 0x400,
+	.tx2		= 0x600,
+	.rx2		= 0x800,
+};
+
 static const struct qmp_usb_offsets qmp_usb_offsets_v5 = {
 	.serdes		= 0,
 	.pcs		= 0x0200,
@@ -2076,6 +2090,8 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
 static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
 	.lanes			= 2,
 
+	.offsets		= &qmp_usb_offsets_v3,
+
 	.serdes_tbl		= qcm2290_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
 	.tx_tbl			= qcm2290_usb3_tx_tbl,
@@ -2647,10 +2663,16 @@ static int qmp_usb_parse_dt(struct qmp_usb *qmp)
 
 	qmp->serdes = base + offs->serdes;
 	qmp->pcs = base + offs->pcs;
+	qmp->pcs_misc = base + offs->pcs_misc;
 	qmp->pcs_usb = base + offs->pcs_usb;
 	qmp->tx = base + offs->tx;
 	qmp->rx = base + offs->rx;
 
+	if (cfg->lanes >= 2) {
+		qmp->tx2 = base + offs->tx2;
+		qmp->rx2 = base + offs->rx2;
+	}
+
 	qmp->pipe_clk = devm_clk_get(dev, "pipe");
 	if (IS_ERR(qmp->pipe_clk)) {
 		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
-- 
2.38.1

