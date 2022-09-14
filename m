Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9F15B8AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiINOr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiINOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:47:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3122272FD8;
        Wed, 14 Sep 2022 07:47:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gh9so35317695ejc.8;
        Wed, 14 Sep 2022 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ezcKyjQey00m/zcYeoKkPoL5W+jceK+n2B8j+yODyx4=;
        b=fhgMK4z6YDV157dbHHvzgw0yHO9rCqHI00yDfXWp5AMlD8/vlQb+FGd7zqdtRq3Ur2
         YusYiVFuGOVWOEZk3fsOhw6OyLCu731CwvOav21Eb89J6z80AuvCZeX2Z+cxj/rCt7Ve
         sTT8YapEyokfpnJwS3dsp0lbI8ga2Up6V99raRBVe4M3dWnBT2fE8yRV+e366CLPN06k
         regN9BD0XKOBq7TlrzJtRGA0v52cko+eDla2AMtpRnKuU0Zi5rDz+Qk9IfYmaw24e/g/
         /b1k6ZnCRCmUSylEr1/V7vpdAJBUqntbGO+Xn91a74HhiS1eTAl97kG4ko1jwtjiqzs+
         HMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ezcKyjQey00m/zcYeoKkPoL5W+jceK+n2B8j+yODyx4=;
        b=BmLI7Zsu3OeUw+C4H3RJzEmzW8RoRqnwL0o9YAhUrmsgIv4i4FPZz8dpIALc4+Kkcp
         2K/xd8bWiuWPFqzWN6AlrlccqoEe3mLk2Gpqmc39TFhdaFukRa6lF5qXhWjDCG/ZFGNL
         HYMzd2KM9Mm713GkYDSEH7TdiGa8EihPtEpZp6mal6G8aKju5JdI+Dhnu0H5mp9XJfcH
         3BtMpZkcAFfQqhs6LeRxVT5vmj5yo5VyFctWIMp8fWOOPINTJZ3cNh9uH/PkCrVGKxUF
         IzYCXqsMsJH7fbjRaSAHP65WJns//fjunC4nvfVJojlYlAAoAT5kRPQQIMPxKJf/IAiB
         tRsQ==
X-Gm-Message-State: ACgBeo3y1Fs/m6Clm3qEIn5M0VDhvHGg+clxyibpYmuN8RjKfaj0PBX5
        RONYmE4K0yDpKv8LfNSRVfE=
X-Google-Smtp-Source: AA6agR64/vR14k8oAfXTsKMrgGKHvakepBr2paxUYWJNmMYJQAnBQPs9MTGKVy7lpX/mG94AVOMgjQ==
X-Received: by 2002:a17:907:2c4b:b0:77e:2c09:4111 with SMTP id hf11-20020a1709072c4b00b0077e2c094111mr10172304ejc.21.1663166871651;
        Wed, 14 Sep 2022 07:47:51 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id 6-20020a170906300600b0073ae9ba9ba8sm7601484ejz.3.2022.09.14.07.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:47:51 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 2/2] clk: qcom: kpss-xcc: convert to parent data API
Date:   Wed, 14 Sep 2022 16:47:43 +0200
Message-Id: <20220914144743.17369-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914144743.17369-1-ansuelsmth@gmail.com>
References: <20220914144743.17369-1-ansuelsmth@gmail.com>
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

Convert the driver to parent data API. From the Documentation pll8_vote
and pxo should be declared in the DTS so fw_name can be used instead of
parent_names. .name is changed to the legacy pxo_board following how
it's declared in other drivers.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
v2:
- Change .name from pxo to pxo_board following other driver

 drivers/clk/qcom/kpss-xcc.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/qcom/kpss-xcc.c b/drivers/clk/qcom/kpss-xcc.c
index 88d4b33ac0cc..b1b370274ec4 100644
--- a/drivers/clk/qcom/kpss-xcc.c
+++ b/drivers/clk/qcom/kpss-xcc.c
@@ -12,9 +12,9 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 
-static const char *aux_parents[] = {
-	"pll8_vote",
-	"pxo",
+static const struct clk_parent_data aux_parents[] = {
+	{ .fw_name = "pll8_vote", .name = "pll8_vote" },
+	{ .fw_name = "pxo", .name = "pxo_board" },
 };
 
 static const u32 aux_parent_map[] = {
@@ -32,8 +32,8 @@ MODULE_DEVICE_TABLE(of, kpss_xcc_match_table);
 static int kpss_xcc_driver_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id;
-	struct clk *clk;
 	void __iomem *base;
+	struct clk_hw *hw;
 	const char *name;
 
 	id = of_match_device(kpss_xcc_match_table, &pdev->dev);
@@ -55,24 +55,16 @@ static int kpss_xcc_driver_probe(struct platform_device *pdev)
 		base += 0x28;
 	}
 
-	clk = clk_register_mux_table(&pdev->dev, name, aux_parents,
-				     ARRAY_SIZE(aux_parents), 0, base, 0, 0x3,
-				     0, aux_parent_map, NULL);
+	hw = devm_clk_hw_register_mux_parent_data_table(&pdev->dev, name, aux_parents,
+							ARRAY_SIZE(aux_parents), 0,
+							base, 0, 0x3,
+							0, aux_parent_map, NULL);
 
-	platform_set_drvdata(pdev, clk);
-
-	return PTR_ERR_OR_ZERO(clk);
-}
-
-static int kpss_xcc_driver_remove(struct platform_device *pdev)
-{
-	clk_unregister_mux(platform_get_drvdata(pdev));
-	return 0;
+	return PTR_ERR_OR_ZERO(hw);
 }
 
 static struct platform_driver kpss_xcc_driver = {
 	.probe = kpss_xcc_driver_probe,
-	.remove = kpss_xcc_driver_remove,
 	.driver = {
 		.name = "kpss-xcc",
 		.of_match_table = kpss_xcc_match_table,
-- 
2.37.2

