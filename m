Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1216F2600
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjD2Tdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjD2Tdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:33:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C91736;
        Sat, 29 Apr 2023 12:33:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f109b1808so215544666b.1;
        Sat, 29 Apr 2023 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682796820; x=1685388820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXhVO/i0hJaCRyrMGjBs/PM0aiWNkiTpYURGrr9pZYw=;
        b=frA0FDuOMvft8dLnUqCuV2fokNbq1THAbUwXJYlUB/Pr9xWDXyyeVe/9lags1fih7p
         SVluEohG3xoyYAiGjs3WTyb3lewfj3eENnJGZNfXwhXmtbOD5oEjc7qZp/6zr/SNE2Zu
         G3ASxz5I195D/SVhLBkCR6EgpT8fxEFoQtkZJc96awGIRIRMXmTIh89FWSv/eklXxR/n
         T9euKFu2VmijFinsGFNau0zQ8penyriYs86M70IyPrZRd5T5HCl/pgNndxANHxQa10IW
         R8lO4rFw9SnwgFbCIsazzCKH9CcoM+DD0mVOPuDIrdjeyDEbsRJBVmlW/uxjMX+0DnoQ
         2n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682796820; x=1685388820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXhVO/i0hJaCRyrMGjBs/PM0aiWNkiTpYURGrr9pZYw=;
        b=ALQPBfVfDZIuU8qbALVyKZX2sYOe/tA7AXX5w6MCmjABcfNdAooTir5ABPMhhC3XMg
         maqGO6Oq5Ltx6ipNNGByT5/7WZ/qU69XsjUtRzBQlW4mFgk9FoVFBM8BIH3TeStKgHp6
         8JjpIb73wlQaPyGP3EBJoqXh22Fwn0uCNYxx71WZJzX7cPwcRzA3wyMFyXqGiZ7KNarb
         CxbbByauHm1AAHNWMiCOCc+QlMCGrS07/liPvtsbs+DRTKdwUeZGlkW7x539UibbKLM9
         s+h+H87WLlYpHr/v7DlcWb84YyEAbfC1a6QjHqVN9a9e07p0JAk9rAIZiz1P+Jn+6xuL
         fh5A==
X-Gm-Message-State: AC+VfDyPFJP9c3oZFaFgqYn+uMAGxr70VtASROeWLKFfdFboqAmKmz7Z
        nqgzSUwOn0p1G1NQvYLArlw=
X-Google-Smtp-Source: ACHHUZ7BWGI8rLe5x0BUt+Yr/8oSqfbiNT3Bm4U06az1jdxvtchZYzahk8Bfbz0DqDy/tCMwtFtgYw==
X-Received: by 2002:a17:907:a08a:b0:94e:61d3:d13b with SMTP id hu10-20020a170907a08a00b0094e61d3d13bmr9459107ejc.75.1682796820035;
        Sat, 29 Apr 2023 12:33:40 -0700 (PDT)
Received: from fedora.. ([188.252.220.213])
        by smtp.googlemail.com with ESMTPSA id q19-20020a1709060f9300b0094f1fe1696bsm12832126ejj.216.2023.04.29.12.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 12:33:39 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] soc: qcom: socinfo: Add IDs for IPQ5018 family
Date:   Sat, 29 Apr 2023 21:33:36 +0200
Message-Id: <20230429193336.600629-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230429193336.600629-1-robimarko@gmail.com>
References: <20230429193336.600629-1-robimarko@gmail.com>
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

Add SOC IDs for the IPQ5018 family.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/soc/qcom/socinfo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index c2e4a57dd666..c61a93b4dcaf 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -434,6 +434,9 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SM8350) },
 	{ qcom_board_id(QCM2290) },
 	{ qcom_board_id(SM6115) },
+	{ qcom_board_id(IPQ5010) },
+	{ qcom_board_id(IPQ5018) },
+	{ qcom_board_id(IPQ5028) },
 	{ qcom_board_id(SC8280XP) },
 	{ qcom_board_id(IPQ6005) },
 	{ qcom_board_id(QRB5165) },
@@ -447,6 +450,9 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id_named(SM8450_3, "SM8450") },
 	{ qcom_board_id(SC7280) },
 	{ qcom_board_id(SC7180P) },
+	{ qcom_board_id(IPQ5000) },
+	{ qcom_board_id(IPQ0509) },
+	{ qcom_board_id(IPQ0518) },
 	{ qcom_board_id(SM6375) },
 	{ qcom_board_id(IPQ9514) },
 	{ qcom_board_id(IPQ9550) },
@@ -454,6 +460,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ9570) },
 	{ qcom_board_id(IPQ9574) },
 	{ qcom_board_id(SM8550) },
+	{ qcom_board_id(IPQ5016) },
 	{ qcom_board_id(IPQ9510) },
 	{ qcom_board_id(QRB4210) },
 	{ qcom_board_id(QRB2210) },
@@ -461,6 +468,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(QRU1000) },
 	{ qcom_board_id(QDU1000) },
 	{ qcom_board_id(QDU1010) },
+	{ qcom_board_id(IPQ5019) },
 	{ qcom_board_id(QRU1032) },
 	{ qcom_board_id(QRU1052) },
 	{ qcom_board_id(QRU1062) },
-- 
2.40.1

