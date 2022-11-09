Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F358622114
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiKIA4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiKIA4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:56:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F056E64A04;
        Tue,  8 Nov 2022 16:56:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k8so23583661wrh.1;
        Tue, 08 Nov 2022 16:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKH2DEqi/WyS0Gp7MHojWp9fGOlGca/3PwJ9fijM8Dk=;
        b=pTtMClNH8jy20JOf4U/hfeOySzhvVCYDFNWrt2iskys97oOlDpSL3jS0Ij1MEDp1Dq
         AFYLsQS0MFjkAEibTgI50uBBv4G3P2dPtQduu+c5cgfeyAs/uSpXJtT0VRYXdUuYc0T+
         TiOecp5zEu9sLpRW3tSmkfJj+YLo+YQKkvaPRj1lduQNs2fX5WEhpXSQ9FGCzIrKT4Wn
         UUEs7jOvBIuguOIfMnpExhacVwrWfFYpJazWlXXA1witjKlDIANDZOOK6/ZZCprolgoK
         eUpxCB4Iv1pOSVQV8qFw9Q++bZWbPuZ9tGZo9VQEV28OVT6M17ewYza2SKkpGP+ky1nb
         4YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKH2DEqi/WyS0Gp7MHojWp9fGOlGca/3PwJ9fijM8Dk=;
        b=ztbgS+dx2K82xZj77nKbgPEK0RNiSW2/0CTCZxYayY8M8Xto4ebuzeU9TDsnt6hjlO
         VOFcutxjY1u0A+kvNeWp7M3qkl8TlvFzbfccyBsCbfNEfehv8SUC7/Q2JLPH+HIxOBwN
         GVagQ+Kj1HqIuf9eadYknzMGN7YfPd8v+fRUAfMZRp98dQ9JEEa1YPuirIi6fGcRY6Ge
         UQn05Mq/k1BxvX64QB9qfKcCDUPGdGQV34wpg8fPudY85jQPjhGvecXt7OvM5zszfiHC
         4ywXzlSgmKPm8sXFXf2PRAgLz3BQWMnZbpp3FQesBFojQjZ5jSXgnbXbHIUPo6Y6lQXS
         e/fA==
X-Gm-Message-State: ACrzQf0m5Hlzpm6pVfZA2/6gji8lHyiiNE6x8RN/MDT1M7LGkxdhsf0y
        ig9pkKhUWC+mEPEZ7LGLCEI=
X-Google-Smtp-Source: AMsMyM6k9UPkLTa5uXTirLIQ9nXX6p7qlwmo8BsCDVd7veXcPJbWZrB4nVdvyyuQflKCmNI8bdLU6w==
X-Received: by 2002:a5d:6da1:0:b0:231:c189:e077 with SMTP id u1-20020a5d6da1000000b00231c189e077mr37567746wrs.114.1667955398428;
        Tue, 08 Nov 2022 16:56:38 -0800 (PST)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id z14-20020adff74e000000b0022cdb687bf9sm14130285wrp.0.2022.11.08.16.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:56:38 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 3/5] clk: qcom: krait-cc: handle secondary mux sourcing out of acpu_aux
Date:   Wed,  9 Nov 2022 01:56:29 +0100
Message-Id: <20221109005631.3189-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221109005631.3189-1-ansuelsmth@gmail.com>
References: <20221109005631.3189-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bootloader may leave the system in an even more undefined state
with the secondary mux of L2 or other cores sourcing out of the acpu_aux
parent. This results in the clk set to the PXO rate or a PLL8 rate.

The current logic to reset the mux and set them to a defined state only
handle if the mux are configured to source out of QSB. Change this and
force a new and defined state if the current clk is lower than the aux
rate. This way we can handle any wrong configuration where the mux is
sourcing out of QSB (rate 225MHz, currently set to a virtual rate of 1),
PXO rate (rate 25MHz) or PLL8 (needs to be configured to run at 384Mhz).

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 0e497e69e3e3..17bf39076830 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -383,8 +383,8 @@ static int krait_cc_probe(struct platform_device *pdev)
 	 */
 	cur_rate = clk_get_rate(l2_pri_mux_clk);
 	aux_rate = 384000000;
-	if (cur_rate == 1) {
-		pr_info("L2 @ QSB rate. Forcing new rate.\n");
+	if (cur_rate < aux_rate) {
+		pr_info("L2 @ Undefined rate. Forcing new rate.\n");
 		cur_rate = aux_rate;
 	}
 	clk_set_rate(l2_pri_mux_clk, aux_rate);
@@ -394,8 +394,8 @@ static int krait_cc_probe(struct platform_device *pdev)
 	for_each_possible_cpu(cpu) {
 		clk = clks[cpu];
 		cur_rate = clk_get_rate(clk);
-		if (cur_rate == 1) {
-			pr_info("CPU%d @ QSB rate. Forcing new rate.\n", cpu);
+		if (cur_rate < aux_rate) {
+			pr_info("CPU%d @ Undefined rate. Forcing new rate.\n", cpu);
 			cur_rate = aux_rate;
 		}
 
-- 
2.37.2

